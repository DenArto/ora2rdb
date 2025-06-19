package ru.redsoft.ora2rdb;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ParserTest {

    static String startDirPath = "src/test/resources/scripts/";
    static ArrayList<String> testSuite = new ArrayList<String>();
    static ArrayList<String> ignoreSuite = new ArrayList<String>();


    static void checkValid(ArrayList<String> input) throws IOException {
        for (String arg : input)
            if (!Files.exists(Paths.get(startDirPath + arg.replaceAll("/$", ""))))
                throw new IOException("Directory not found: " + arg);
    }

    static ArrayList<String> getParameters(String key) throws IOException {
        ArrayList<String> result = new ArrayList<String>();
        Arrays.stream(System.getProperty(key, "").split(","))
                .forEach(arg -> {
                    arg = arg.replace(" ", "");
                    if (!arg.isEmpty() && !arg.endsWith("/")) {
                        arg = arg.concat("/");
                    }
                    result.add(arg);
                });
        checkValid(result);
        return result;
    }

    @BeforeAll
    static void initialiseSuite() throws IOException {
        testSuite = getParameters("testSuite");
        ignoreSuite = getParameters("ignoreSuite");
    }

    static boolean ignored(String inputFile) {

        return ignoreSuite.stream()
                .filter(e -> !e.isEmpty())
                .filter(e -> Files.isDirectory(Paths.get(startDirPath + e)))
                .anyMatch(inputFile::contains);
    }

    private List<String> readFile(String path) throws IOException {
        return Files.readAllLines(Path.of(startDirPath + path), StandardCharsets.UTF_8);
    }

    private String joinStringListWithSystemLineSeparator(List<String> stringList){
        StringBuilder stringBuilder = new StringBuilder();
        int lastListIndex = stringList.size() - 1;
        String systemSeparator = System.lineSeparator();
        for (String line : stringList) {
            stringBuilder.append(line.replace("\r", "").replace("\n", ""));
            if (!line.equals(stringList.get(lastListIndex)))
                stringBuilder.append(systemSeparator);
        }
        return stringBuilder.toString();
    }

    private String removeWhitespaceInStringList(List<String> stringList) {
        StringBuilder stringBuilder = new StringBuilder();
        for (String line : stringList) {
            stringBuilder.append(line
                    .replaceAll("\\s+", ""));
        }
        return stringBuilder.toString();
    }




    void testForDevelopers(String inputFile) throws IOException {
        final Path outFile = Paths.get(System.getProperty("java.io.tmpdir"), "out.sql");
        Files.writeString(outFile, "Output will not be generated");
        String expectedFile = inputFile.replace(".sql", "_expected.sql");
        Path inputFilePath = Paths.get(startDirPath + inputFile);
        try {
            Ora2rdb.main(new String[]{inputFilePath.toAbsolutePath().toString(), "-o", outFile.toAbsolutePath().toString()});
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        List<String> expectedList = readFile(expectedFile);
        List<String> actualList = Files.readAllLines(outFile, StandardCharsets.UTF_8);

        String ignoreFormatExpected = removeWhitespaceInStringList(expectedList);
        String ignoreFormatActual = removeWhitespaceInStringList(actualList);
        if(!ignoreFormatExpected.equals(ignoreFormatActual)) {
            String expected = joinStringListWithSystemLineSeparator(expectedList);
            String actual = joinStringListWithSystemLineSeparator(actualList);
            assertEquals(expected, actual);
        }
    }

    void test(String inputFile) throws Exception {
        final Path outFile = Paths.get(System.getProperty("java.io.tmpdir"), "out.sql");
        Files.writeString(outFile, "Output will not be generated");
        String expectedFile = inputFile.replace(".sql", "_expected.sql");
        Path inputFilePath = Paths.get(startDirPath + inputFile);
        try {
            Ora2rdb.main(new String[]{inputFilePath.toAbsolutePath().toString(), "-o", outFile.toAbsolutePath().toString()});
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        List<String> expected = readFile(expectedFile);
        List<String> actual = Files.readAllLines(outFile, StandardCharsets.UTF_8);

        String ignoreFormatExpected = removeWhitespaceInStringList(expected);
        String ignoreFormatActual = removeWhitespaceInStringList(actual);

        if(!ignoreFormatExpected.equals(ignoreFormatActual)) {
            ProcessBuilder processBuilder = new ProcessBuilder("python3",
                    "src/test/resources/main.py",
                    "-n",
                    startDirPath + expectedFile,
                    outFile.toAbsolutePath().toString());
            processBuilder.redirectErrorStream(true);

            Process process;
            try {
                process = processBuilder.start();

                BufferedReader subProcessInputReader = new BufferedReader(new InputStreamReader(process.getInputStream()));

                final StringBuilder difference = new StringBuilder();
                String line;
                while ((line = subProcessInputReader.readLine()) != null) {
                    difference.append(line);
                    difference.append(System.lineSeparator());
                }

                process.waitFor();
                String infoStr = "+++ actual\n" +
                        "--- expected\n" +
                        "+ \n\n";
                assertEquals(infoStr, difference.toString());
            } catch (IOException | InterruptedException e) {
                throw new IOException(e);
            }
        }
    }

    static Stream<String> argsProviderFactory() throws IOException {
        ArrayList<String> fileNameArray = new ArrayList<>();
        for (String arg : testSuite) {
            try {
                Files.walk(Paths.get(startDirPath + arg), Integer.MAX_VALUE)
                        .filter(e -> e.toString().contains(".sql"))
                        .filter(e -> !ignored(e.toString()))
                        .filter(e -> !Files.isDirectory(e) && !e.toString().contains("_expected.sql"))
                        .collect(Collectors.toCollection(LinkedList::new))
                        .descendingIterator()
                        .forEachRemaining(path -> {
                            fileNameArray.add(path.toString().replace(startDirPath, ""));
                        });
            } catch (IOException e) {
                throw new IOException("directory not found: " + arg);
            }
        }
        return fileNameArray.stream();
    }

    @ParameterizedTest(name = "{arguments}")
    @MethodSource("argsProviderFactory")
    void testAllScripts(String argument) throws Exception {
        test(argument);
    }


}