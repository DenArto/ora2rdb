package ru.redsoft.ora2rdb;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.*;

public class SqlCodeParser {
    BlockType type = BlockType.UNKNOWN;
    List<String> sqlQueries = new ArrayList<>();
    StringBuilder currentBlock = new StringBuilder();
    List<String> splittedInput = new ArrayList<>();
    ArrayDeque<Integer> beginEndQueue = new ArrayDeque<>();
    Map<Integer, List<String>> blocksInPackage = new HashMap<>();
    Integer beginEndCount = Integer.MIN_VALUE;
    Integer startOfPackage = -1;
    Integer endOfPackage = -1;
    Integer startOfPackageBody = -1;
    Integer endOfPackageBody = -1;
    Integer indexOfPackageBlock = -1;
    boolean inCaseStatement = false;
    boolean insidePackage = false;
    private static final Set<Character> ALLOWED_CHARACTERS;

    static {
        ALLOWED_CHARACTERS = new HashSet<>();
        Collections.addAll(ALLOWED_CHARACTERS,
                '+', ':', '=', '>', '%', '\'', '.', '|', '/', '*', '(', ')', ',', '<', '>', '"', '^', '!', '~', ';', '-');

        String[] multiCharElements = {":=", "=>", "||", "**", "<<", ">>", "/*", "*/", "..", "<>", "!=", "~=", "^=", "<=", ">=", "--"};
        for (String element : multiCharElements) {
            for (char c : element.toCharArray()) {
                ALLOWED_CHARACTERS.add(c);
            }
        }
    }

    private final static String whiteSpaceRegex = "[\\s\\n]+";
    private final static String endCaseRegex = "(?i)(?s).*?END\\s*CASE.*?";
    private final static String endIfLoopRegex = "(?i)(?s).*?END\\s*(LOOP|IF).*?";
    private final static String createFunctionRegex = "(?i)(?s)create\\s*(or\\s*replace\\s*)?\\s*(EDITIONABLE|NONEDITIONABLE)?\\s*function.*?";
    private final static String createProcedureTriggerRegex = "(?i)(?s)create\\s*(or\\s*replace\\s*)?\\s*(EDITIONING|EDITIONABLE|NONEDITIONABLE)?\\s*(procedure|trigger).*?";
    private final static String createPackageRegex = "(?i)(?s)create\\s*(or\\s*replace\\s*)?\\s*(EDITIONABLE|NONEDITIONABLE)?\\s*package.*?";
    private final static String createTypeBodyRegex = "(?i)(?s)create\\s*(or\\s*replace\\s*)?type\\s*body.*?";
    private final static String pragmaDeclarationRegex = "(?i)(?s)\\n*\\s*PRAGMA\\s*\\n*(SERIALLY_REUSABLE|AUTONOMOUS_TRANSACTION|EXCEPTION_INIT|INLINE|RESTRICT_REFERENCES).*?";

    List<String> splitMetadataIntoBlocks(InputStream inputStream) {
        splittedInput = fromStreamToString(inputStream);
        for (int i = 0; i < splittedInput.size(); i++) {
            if (splittedInput.get(i).isEmpty()) {
                continue;
            }
            if (checkIfQuoteOrCommentOrWhiteSpace(splittedInput.get(i))) {
                currentBlock.append(splittedInput.get(i));
                continue;
            }
            if (checkIfInsidePackage(i)) {
                i = endOfPackage;
                startOfPackage = endOfPackage = startOfPackageBody = endOfPackageBody = indexOfPackageBlock = -1;
                continue;
            }

            if (type == BlockType.UNKNOWN) {
                if (!insidePackage)
                    type = findTheTypeOfBlock(i);
                else
                    type = findTheTypeOfBlockInsidePackage(i);
            }

            switch (type) {
                case PACKAGE:
                case TYPE_BODY:
                    i = packageTypeParser(i);
                    break;
                case ANONYMOUS_BLOCK:
                case FUNCTION_AND_PROCEDURE_AND_TRIGGER:
                    i = functionProcedureTriggerDeclareParser(i);
                    break;
                case SIMPLE_COMMAND:
                case SIMPLE_COMMAND_INSIDE_PACKAGE:
                    i = simpleBlockParser(i);
                    break;
            }
        }

        if (currentBlock.length() != 0) {
            sqlQueries.add(currentBlock.toString());
        }


        return sqlQueries;
    }

    private int simpleBlockParser(int id) {
        BlockType currentType;
        if (type == BlockType.SIMPLE_COMMAND)
            currentType = findTheTypeOfBlock(id);
        else
            currentType = findTheTypeOfBlockInsidePackage(id);
        if (type != currentType) {
            sqlQueries.add(currentBlock.toString());
            currentBlock.setLength(0);
            id--;
        } else if (splittedInput.get(id).endsWith(";") || splittedInput.get(id).equalsIgnoreCase("/")) {
            currentBlock.append(splittedInput.get(id));
            sqlQueries.add(currentBlock.toString());
            currentBlock.setLength(0);
            type = BlockType.UNKNOWN;
        } else {
            currentBlock.append(splittedInput.get(id));
        }
        return id;
    }

    private boolean isWordValid(String inputWord, String pattern) {
        String word = inputWord.toUpperCase();
        int firstIndex = word.indexOf(pattern);
        if (firstIndex == -1 || word.indexOf(pattern, firstIndex + pattern.length()) != -1) {
            return false;
        }
        Set<Character> allowedCharacters = new HashSet<>(ALLOWED_CHARACTERS);
        for (char c : pattern.toCharArray()) {
            allowedCharacters.add(c);
        }
        for (char c : word.toCharArray()) {
            if (!allowedCharacters.contains(c)) {
                return false;
            }
        }
        return true;
    }

    private boolean checkIfQuoteOrCommentOrWhiteSpace(String el) {
        return el.startsWith("'") || el.startsWith("--") || el.startsWith("/*") || el.matches(whiteSpaceRegex);
    }

    private boolean checkIfInsidePackage(int id) {
        if (id == endOfPackageBody) {
            insidePackage = false;
            sqlQueries.add(currentBlock.toString());
            currentBlock.setLength(0);
            type = BlockType.UNKNOWN;
            List<String> blocks = new ArrayList<>();
            for (int i = indexOfPackageBlock + 1; i < sqlQueries.size(); i++) {
                blocks.add(sqlQueries.get(i));
            }

            for (int i = startOfPackage; i <= startOfPackageBody; i++) {
                currentBlock.append(splittedInput.get(i));
            }
            blocks.add(currentBlock.toString());
            currentBlock.setLength(0);
            for (int i = endOfPackageBody; i <= endOfPackage; i++) {
                currentBlock.append(splittedInput.get(i));
            }
            blocks.add(currentBlock.toString());
            currentBlock.setLength(0);

            blocksInPackage.put(indexOfPackageBlock, blocks);
            ListIterator<String> iterator = sqlQueries.listIterator(sqlQueries.size());
            while (iterator.hasPrevious()) {
                int index = iterator.previousIndex();
                if (index > indexOfPackageBlock) {
                    iterator.previous();
                    iterator.remove();
                } else {
                    iterator.previous();
                }
            }
            return true;
        }
        return false;
    }

    private String getTextToParse(int start, int end) {
        StringBuilder command = new StringBuilder();
        start = Math.max(start, 0);
        end = Math.min(end, splittedInput.size() - 1);
        while (start <= end) {
            if (!checkIfQuoteOrCommentOrWhiteSpace(splittedInput.get(start))) {
                command.append(splittedInput.get(start));
            } else {
                if (end < splittedInput.size() - 1)
                    end++;
            }
            start++;
        }
        return command.toString();
    }

    private BlockType findTheTypeOfBlock(int id) {
        String command = getTextToParse(id, id + 10);
        if (command.matches(createProcedureTriggerRegex) || command.matches(createFunctionRegex)) {
            type = BlockType.FUNCTION_AND_PROCEDURE_AND_TRIGGER;
            return type;
        }
        if (isWordValid(splittedInput.get(id), "DECLARE")) {
            type = BlockType.ANONYMOUS_BLOCK;
            beginEndQueue.addLast(beginEndCount);
            beginEndCount = 0;
            return type;
        }
        if (isWordValid(splittedInput.get(id), "BEGIN")) {
            type = BlockType.ANONYMOUS_BLOCK;
            beginEndQueue.addLast(beginEndCount);
            beginEndCount = 0;
            return type;
        }
        if (command.matches(createPackageRegex)) {
            startOfPackage = id;
            type = BlockType.PACKAGE;
            return type;
        }
        if (command.matches(createTypeBodyRegex)) {
            type = BlockType.TYPE_BODY;
            return type;
        }
        type = BlockType.SIMPLE_COMMAND;
        return type;
    }

    private BlockType findTheTypeOfBlockInsidePackage(int id) {
        if (isNestedBlock(splittedInput.get(id))) {
            if (checkIfSimpleFunctionProcedure(id)) {
                type = BlockType.SIMPLE_COMMAND_INSIDE_PACKAGE;
            } else
                type = BlockType.FUNCTION_AND_PROCEDURE_AND_TRIGGER;
            return type;
        }
        type = BlockType.SIMPLE_COMMAND_INSIDE_PACKAGE;
        return type;
    }

    private boolean checkIfSimpleFunctionProcedure(int id) {
        for (int i = id; i < splittedInput.size(); i++) {
            if (checkIfQuoteOrCommentOrWhiteSpace(splittedInput.get(i))) {
                continue;
            }
            if (splittedInput.get(i).contains(";") || splittedInput.get(i).contains("/")) {
                return true;
            }
            if (isWordValid(splittedInput.get(i), "IS") || isWordValid(splittedInput.get(i), "AS")) {
                return false;
            }
        }
        return false;

    }

    private int functionProcedureTriggerDeclareParser(int id) {
        currentBlock.append(splittedInput.get(id));
        if (isWordValid(splittedInput.get(id), "BEGIN") || isWordValid(splittedInput.get(id), "CASE")) {
            String string = getTextToParse(id - 2, id);
            if (!(string.matches(endCaseRegex))) {
                beginEndCount = (beginEndCount == Integer.MIN_VALUE) ? 1 : beginEndCount + 1;
                if (isWordValid(splittedInput.get(id), "CASE"))
                    inCaseStatement = true;
            }
        }
        if (isWordValid(splittedInput.get(id), "END")) {
            String string = getTextToParse(id, id + 2);
            if (!(string.matches(endIfLoopRegex))) {
                beginEndCount = (beginEndCount == Integer.MIN_VALUE) ? -1 : beginEndCount - 1;
                if (inCaseStatement)
                    inCaseStatement = false;
                else {
                    if (beginEndCount == 0) {
                        beginEndCount = beginEndQueue.pollLast();
                        if (beginEndCount == null)
                            beginEndCount = Integer.MIN_VALUE;
                        if (beginEndCount == Integer.MIN_VALUE) {
                            if (!(splittedInput.get(id).contains(";"))) {
                                while (id < splittedInput.size() - 1) {
                                    id += 1;
                                    currentBlock.append(splittedInput.get(id));
                                    if (splittedInput.get(id).contains(";")) {
                                        break;
                                    }
                                }
                            }
                            sqlQueries.add(currentBlock.toString());
                            currentBlock.setLength(0);
                            type = BlockType.UNKNOWN;
                        }
                    }
                }
            }
        }
        if (isNestedBlock(splittedInput.get(id).toUpperCase())) {
            beginEndQueue.addLast(beginEndCount);
            beginEndCount = 0;
        }
        return id;
    }

    private int packageTypeParser(int id) {
        if (isWordValid(splittedInput.get(id), "BEGIN") || isWordValid(splittedInput.get(id), "CASE")) {
            String string = getTextToParse(id - 2, id);
            if (!(string.matches(endCaseRegex))) {
                beginEndCount = (beginEndCount == Integer.MIN_VALUE) ? 1 : beginEndCount + 1;
            }
        }
        if (isWordValid(splittedInput.get(id), "END")) {
            String string = getTextToParse(id, id + 2);
            if (!(string.matches(endIfLoopRegex))) {
                beginEndCount = (beginEndCount == Integer.MIN_VALUE) ? -1 : beginEndCount - 1;
            }
        }

        currentBlock.append(splittedInput.get(id));
        if (beginEndCount == -1) {
            beginEndCount = Integer.MIN_VALUE;
            if (!(splittedInput.get(id).contains(";"))) {
                while (id <= splittedInput.size() - 1) {
                    id += 1;
                    currentBlock.append(splittedInput.get(id));
                    if (splittedInput.get(id).contains(";")) {
                        break;
                    }
                }
            }
            sqlQueries.add(currentBlock.toString());
            currentBlock.setLength(0);
            if (type == BlockType.PACKAGE) {
                indexOfPackageBlock = sqlQueries.size() - 1;
                endOfPackage = id;
                findStartEndOfPackageBody(startOfPackage, endOfPackage);
                type = BlockType.UNKNOWN;
                insidePackage = true;
                return startOfPackageBody;
            }
            type = BlockType.UNKNOWN;
        }
        return id;
    }

    private void findStartEndOfPackageBody(int start, int end) {
        for (int i = start; i <= end; i++) {
            if (!checkIfQuoteOrCommentOrWhiteSpace(splittedInput.get(i)))
                if (isWordValid(splittedInput.get(i), "IS") || isWordValid(splittedInput.get(i), "AS")) {
                    startOfPackageBody = i;
                    break;
                }
        }
        for (int i = end; i >= start; i--) {
            if (!checkIfQuoteOrCommentOrWhiteSpace(splittedInput.get(i)))
                if (isWordValid(splittedInput.get(i), "END")) {
                    endOfPackageBody = i;
                    break;
                }
        }
    }

    private boolean isNestedBlock(String str) {
        return "FUNCTION".equalsIgnoreCase(str) || "PROCEDURE".equalsIgnoreCase(str) || "TRIGGER".equalsIgnoreCase(str);
    }

    private List<String> fromStreamToString(InputStream is) {
        StringBuilder result = new StringBuilder();
//        List<String> words = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.isEmpty()) {
                    result.append('\n');
                    continue;
                }
                String[] lines = line.split("\\r?\\n");
                for (String l : lines ) {
                    if (!l.isEmpty())
                        result.append(l);
                    result.append('\n');
                }
            }
        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
        if (result.length() > 0 && result.charAt(result.length() - 1) == '\n') {
            result.deleteCharAt(result.length() - 1);
        }
        return fromStringToSeparateWords(result.toString());
    }

    private List<String> fromStringToSeparateWords(String result) {
        List<String> words = new ArrayList<>();
            StringBuilder currentWord = new StringBuilder();
            boolean inSingleQuotes = false;
            boolean inDoubleQuotes = false;
            boolean inSingleLineComment = false;
            int multiLineCommentDepth = 0;

            char[] chars = result.toCharArray();
            int i = 0;

            while (i < chars.length) {
                char c = chars[i];

                if (c == '/' && i + 1 < chars.length && chars[i + 1] == '*') {
                    if (currentWord.length() > 0 && multiLineCommentDepth == 0) {
                        words.add(currentWord.toString());
                        currentWord.setLength(0);
                    }
                    multiLineCommentDepth++;
                    currentWord.append("/*");
                    i += 2;
                    continue;
                }

                if (multiLineCommentDepth > 0) {
                    currentWord.append(c);
                    if (c == '*' && i + 1 < chars.length && chars[i + 1] == '/') {
                        multiLineCommentDepth--;
                        currentWord.append('/');
                        i += 2;
                        if (multiLineCommentDepth == 0) {
                            words.add("/*" + currentWord.toString().replace("/*", "").replace("*/", "") + "*/");
                            currentWord.setLength(0);
                        }
                        continue;
                    }
                    i++;
                    continue;
                }

                if (c == '-' && i + 1 < chars.length && chars[i + 1] == '-') {
                    if (currentWord.length() > 0) {
                        words.add(currentWord.toString());
                        currentWord.setLength(0);
                    }
                    inSingleLineComment = true;
                    currentWord.append("--");
                    i += 2;
                    continue;
                }

                if (inSingleLineComment) {
                    currentWord.append(c);
                    if (c == '\n') {
                        inSingleLineComment = false;
                        words.add(currentWord.toString());
                        currentWord.setLength(0);
                    }
                    i++;
                    continue;
                }

                if (c == '\'') {
                    if (currentWord.length() > 0 && !inSingleQuotes) {
                        words.add(currentWord.toString());
                        currentWord.setLength(0);
                    }
                    inSingleQuotes = !inSingleQuotes;
                    currentWord.append(c);
                    i++;
                    continue;
                }

                if (c == '"') {
                    if (currentWord.length() > 0 && !inDoubleQuotes) {
                        words.add(currentWord.toString());
                        currentWord.setLength(0);
                    }
                    inDoubleQuotes = !inDoubleQuotes;
                    currentWord.append(c);
                    i++;
                    continue;
                }

                if (inSingleQuotes || inDoubleQuotes) {
                    currentWord.append(c);
                    i++;
                    continue;
                }

                if (Character.isWhitespace(c) || c == ';' || c == '/') {
                    if (currentWord.length() > 0) {
                        words.add(currentWord.toString());
                        currentWord.setLength(0);
                    }
                    words.add(String.valueOf(c));
                } else {
                    currentWord.append(c);
                }

                i++;
            }

            if (currentWord.length() > 0) {
                words.add(currentWord.toString());
            }
        return words;
    }

    public Map<Integer, List<String>> getBlocksInPackage() {
        return blocksInPackage;
    }

    public String[] findLastIndexOfEndSubstring(String input) {
        String[] patterns = {" END ", " END;", " end ", " end;"};
        int lastIndex = -1;

        for (String pattern : patterns) {
            int index = input.lastIndexOf(pattern);
            if (index > lastIndex) {
                lastIndex = index;
            }
        }

        if (lastIndex != -1) {
            String firstPart = input.substring(0, lastIndex);
            String secondPart = input.substring(lastIndex);
            return new String[]{firstPart, secondPart};
        } else {
            return new String[]{input, ""};
        }
    }

    public boolean checkIfPragmaDeclaration(String inputBlock) {
        StringBuilder pragmaDecl = new StringBuilder();
        for (String word : fromStringToSeparateWords(inputBlock)){
            if (!checkIfQuoteOrCommentOrWhiteSpace(word)){
                pragmaDecl.append(word);
            }
        }
        return pragmaDecl.toString().matches(pragmaDeclarationRegex);
    }
}
