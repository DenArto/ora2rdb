package ru.redsoft.ora2rdb;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.*;

public class SqlCodeParser {
    List<String> sqlQueries = new ArrayList<>();
    StringBuilder currentBlock = new StringBuilder();
    List<String> splittedInput = new ArrayList<>();
    Map<Integer, List<String>> blocksInPackage = new HashMap<>();
    /*Integer beginEndCount = Integer.MIN_VALUE;
    Integer startOfPackage = -1;
    Integer endOfPackage = -1;
    Integer startOfPackageBody = -1;
    Integer endOfPackageBody = -1;
    Integer indexOfPackageBlock = -1;
    boolean inCaseStatement = false;
    boolean insidePackage = false;*/
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


    List<String> splitMetadataIntoBlocks(InputStream inputStream) {
        splittedInput = fromStreamToString(inputStream);
        String triggerDDLEvent;
        for (int i = 0; i < splittedInput.size(); i++) {
            if (splittedInput.get(i).isEmpty()) {
                continue;
            }
            if (checkIfQuoteOrCommentOrWhiteSpace(splittedInput.get(i))) {
                currentBlock.append(splittedInput.get(i));
                continue;
            }

            if ((isWordValid(splittedInput.get(i), "CREATE")) || isWordValid(splittedInput.get(i), "ALTER")) {
                triggerDDLEvent = getTextToParse(i, i + 6).toUpperCase();
                if (triggerDDLEvent.matches(createDDLTriggerRegex) || triggerDDLEvent.matches(alterDDLTriggerRegex)) {
                    currentBlock.append(splittedInput.get(i));
                    continue;
                }
                sqlQueries.add(currentBlock.toString());
                currentBlock.setLength(0);
                currentBlock.append(splittedInput.get(i));
                continue;
            }

            currentBlock.append(splittedInput.get(i));

        }

        if (currentBlock.length() != 0) {
            sqlQueries.add(currentBlock.toString());
        }


        return sqlQueries;
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
        return el.startsWith("'") || el.startsWith("--") || el.startsWith("/*") || el.matches(whiteSpaceRegex);
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

    public Map<Integer, List<String>> getBlocksInPackage() {
        return blocksInPackage;
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
