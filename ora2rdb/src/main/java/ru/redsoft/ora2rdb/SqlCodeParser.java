package ru.redsoft.ora2rdb;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.*;

public class SqlCodeParser {
    List<String> sqlQueries = new ArrayList<>();
    StringBuilder currentBlock = new StringBuilder();
    List<String> splitInput = new ArrayList<>();

    Map<String, List<String>> blocksInPackageBody = new HashMap<>();
    StringBuilder currentBlockInsidePackage = new StringBuilder();
    Map<Integer, String> packageBlockNumber = new HashMap<>();  // Integer - number of block in sqlQueries, String - name of package

    Map<String, List<String>> packageDeclaration = new HashMap<>();

    boolean insidePackageDeclaration = false;
    boolean insidePackageBody = false;

    String currentPackageName = null;
    String currentPackageBodyName = null;
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
    private final static String createDDLTriggerRegex = "(?i)(?s)(create\\s*or\\s*(ALTER|ANALYZE|ASSOCIATE STATISTICS|AUDIT|COMMENT|DISASSOCIATE STATISTICS|DROP|GRANT|NOAUDIT|RENAME|REVOKE|TRUNCATE|DDL).*?)|(create\\s*on.*?)";
    private final static String alterDDLTriggerRegex = "(?i)(?s)(alter\\s*or\\s*(CREATE|ANALYZE|ASSOCIATE STATISTICS|AUDIT|COMMENT|DISASSOCIATE STATISTICS|DROP|GRANT|NOAUDIT|RENAME|REVOKE|TRUNCATE|DDL).*?)|(alter\\s*on.*?)";
    private final static String createPackageBodyNotPackageRegex = "(?i)(?s)create\\s*(or\\s*replace\\s*)?\\s*(EDITIONABLE|NONEDITIONABLE)?\\s*package\\s*body.*?";
    private final static String createPackageRegex = "(?i)(?s)create\\s*(or\\s*replace\\s*)?\\s*(EDITIONABLE|NONEDITIONABLE)?\\s*package.*?";

    List<String> splitMetadataIntoBlocks(InputStream inputStream) {
        splitInput = fromStreamToString(inputStream);
        String stringToParse;
        for (int i = 0; i < splitInput.size(); i++) {
            if (splitInput.get(i).isEmpty()) {
                continue;
            }
            if (checkIfQuoteOrCommentOrWhiteSpace(splitInput.get(i))) {
                currentBlock.append(splitInput.get(i));
                if (insidePackageBody)
                    currentBlockInsidePackage.append(splitInput.get(i));
                continue;
            }

            if (isWordValid(splitInput.get(i), "CREATE") || isWordValid(splitInput.get(i), "ALTER")) {
                stringToParse = getTextToParse(i, i + 6).toUpperCase();
                if (stringToParse.matches(createDDLTriggerRegex) || stringToParse.matches(alterDDLTriggerRegex)) {
                    currentBlock.append(splitInput.get(i));
                    continue;
                }

                // grant create or grant alter
                String grantRegex = getTextToParseReverse(i - 1, i);
                if (grantRegex.matches("(?i)(?s)grant\\s*(create|alter).*?")) {
                    currentBlock.append(splitInput.get(i));
                    continue;
                }

                currentPackageName = null;
                if (stringToParse.matches(createPackageRegex))
                    insidePackageDeclaration = !stringToParse.contains("BODY");

                if (insidePackageBody) {
                    if (blocksInPackageBody.containsKey(currentPackageBodyName))
                        blocksInPackageBody.get(currentPackageBodyName).add(currentBlockInsidePackage.toString());
                    currentPackageBodyName = null;
                    currentBlockInsidePackage = new StringBuilder();
                }
                insidePackageBody = stringToParse.matches(createPackageBodyNotPackageRegex);
                if (insidePackageBody)
                    currentBlockInsidePackage.append(splitInput.get(i));

                sqlQueries.add(currentBlock.toString());
                currentBlock.setLength(0);
                currentBlock.append(splitInput.get(i));
                continue;
            }


            if (insidePackageDeclaration) {
                if (isWordValid(splitInput.get(i), "IS") || isWordValid(splitInput.get(i), "AS")) {
                    if (currentPackageName == null) {
                        currentPackageName = findPreviousWord(i);
                        if (currentPackageName != null)
                            packageDeclaration.put(currentPackageName, new ArrayList<>());
                    }
                }

                if (isWordValid(splitInput.get(i), "FUNCTION") || isWordValid(splitInput.get(i), "PROCEDURE")) {
                    if (currentPackageName != null) {
                        packageDeclaration.get(currentPackageName).add(findNextWord(i));
                    }
                }
            }

            currentBlock.append(splitInput.get(i));

            if (insidePackageBody) {
                if (isWordValid(splitInput.get(i), "IS") || isWordValid(splitInput.get(i), "AS")) {
                    if (currentPackageBodyName == null) {
                        currentPackageBodyName = findPreviousWord(i);
                        if (currentPackageBodyName != null) {
                            currentBlockInsidePackage.append(splitInput.get(i));
                            if (blocksInPackageBody.containsKey(currentPackageBodyName)) {
                                blocksInPackageBody.get(currentPackageBodyName).clear();
                                updatePackageBlockNumber(currentPackageBodyName);
                            }
                            blocksInPackageBody.computeIfAbsent(currentPackageBodyName, k -> new ArrayList<>()).add(currentBlockInsidePackage.toString());

                            packageBlockNumber.put(sqlQueries.size(), currentPackageBodyName);
                        }
                        currentBlockInsidePackage.setLength(0);
                        continue;
                    }
                }
                if (isWordValid(splitInput.get(i), "FUNCTION") || isWordValid(splitInput.get(i), "PROCEDURE")) {
                    String functionProcedureName = findNextWord(i);
                    if (packageDeclaration.containsKey(currentPackageBodyName))
                        if (packageDeclaration.get(currentPackageBodyName).contains(functionProcedureName)) {
                            blocksInPackageBody.computeIfAbsent(currentPackageBodyName, k -> new ArrayList<>()).add(currentBlockInsidePackage.toString());
                            currentBlockInsidePackage.setLength(0);
                        }
                }
                currentBlockInsidePackage.append(splitInput.get(i));
            }

        }

        if (currentBlock.length() != 0) {
            sqlQueries.add(currentBlock.toString());
        }
        if (currentBlockInsidePackage.length() != 0)
            blocksInPackageBody.computeIfAbsent(currentPackageBodyName, k -> new ArrayList<>()).add(currentBlockInsidePackage.toString());


        return sqlQueries;
    }

    private void updatePackageBlockNumber(String currentPackageBodyName) {
        packageBlockNumber.entrySet().removeIf(entry -> entry.getValue().equals(currentPackageBodyName));
    }

    private String findPreviousWord(int id) {
        while (id > 0) {
            id--;
            if (checkIfQuoteOrCommentOrWhiteSpace(splitInput.get(id))) {
                continue;
            }
            return splitInput.get(id).toUpperCase();
        }
        return null;
    }

    private String findNextWord(int id) {
        while (id < splitInput.size()) {
            id++;
            if (checkIfQuoteOrCommentOrWhiteSpace(splitInput.get(id))) {
                continue;
            }
            return splitInput.get(id).toUpperCase();
        }
        return null;
    }

    private boolean isWordValid(String inputWord, String pattern) {
        String word = inputWord.toUpperCase();
        int firstIndex = word.indexOf(pattern);
        if (firstIndex == -1 || word.indexOf(pattern, firstIndex + pattern.length()) != -1) {
            return false;
        }
        Set<Character> allowedCharacters = new HashSet<>(ALLOWED_CHARACTERS);

        char[] patternToChar = pattern.toCharArray();
        int j = 0;
        int limitJ = pattern.length();
        for (int i = 0; i < word.length(); i++) {
            if (j >= limitJ && allowedCharacters.contains(word.charAt(i)))
                continue;
            else if ((j >= limitJ && !allowedCharacters.contains(word.charAt(i))))
                return false;
            if (word.charAt(i) != patternToChar[j]) {
                if (!allowedCharacters.contains(word.charAt(i)))
                    return false;
            } else {
                j++;
            }
        }
        return true;
    }

    private boolean checkIfQuoteOrCommentOrWhiteSpace(String el) {
        return el.startsWith("'") || el.startsWith("--") || el.startsWith("/*") || el.matches(whiteSpaceRegex)
                || el.isEmpty();
    }

    private String getTextToParse(int start, int end) {
        StringBuilder command = new StringBuilder();
        start = Math.max(start, 0);
        end = Math.min(end, splitInput.size() - 1);
        while (start <= end) {
            if (!checkIfQuoteOrCommentOrWhiteSpace(splitInput.get(start))) {
                command.append(splitInput.get(start));
            } else {
                if (end < splitInput.size() - 1)
                    end++;
            }
            start++;
        }
        return command.toString();
    }

    private String getTextToParseReverse(int start, int end) {
        StringBuilder command = new StringBuilder();
        start = Math.max(start, 0);
        end = Math.min(end, splitInput.size() - 1);
        while (start <= end) {
            if (!checkIfQuoteOrCommentOrWhiteSpace(splitInput.get(end))) {
                command.insert(0, splitInput.get(end));
            } else {
                if (start > 0)
                    start--;
            }
            end--;
        }
        return command.toString();
    }


    private List<String> fromStreamToString(InputStream is) {
        StringBuilder result = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.isEmpty()) {
                    result.append('\n');
                    continue;
                }
                String[] lines = line.split("\\r?\\n");
                for (String l : lines) {
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
                if (!inSingleQuotes) { // открывающая кавычка
                    words.add(currentWord.toString());
                    currentWord.setLength(0);
                    currentWord.append(c);
                    inSingleQuotes = true;
                } else { // закрывающая кавычка
                    currentWord.append(c);
                    words.add(currentWord.toString());
                    currentWord.setLength(0);
                    inSingleQuotes = false;
                }
                i++;
                continue;
            }

            if (c == '"') {
                if (!inDoubleQuotes) { // открывающая кавычка
                    words.add(currentWord.toString());
                    currentWord.setLength(0);
                    currentWord.append(c);
                    inDoubleQuotes = true;
                } else { // закрывающая кавычка
                    currentWord.append(c);
                    words.add(currentWord.toString());
                    currentWord.setLength(0);
                    inDoubleQuotes = false;
                }
                i++;
                continue;
            }

            if (inSingleQuotes || inDoubleQuotes) {
                currentWord.append(c);
                i++;
                continue;
            }

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

    public Map<String, List<String>> getBlocksInPackageBody() {
        return blocksInPackageBody;
    }

    public Map<Integer, String> getPackageBlockNumber() {
        return packageBlockNumber;
    }

    /*public String[] findLastIndexOfEndSubstring(String input) {
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
    }*/
}
