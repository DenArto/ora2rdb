package ru.redsoft.ora2rdb;

import java.io.*;
import java.util.*;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import ru.redsoft.ora2rdb.comments.*;

public class Ora2rdb {
    public static boolean reorder = false;
    public static boolean statistic = false;
    public static boolean stdout = true;
    private static StringBuilder errors = new StringBuilder();
    private static StringBuilder exceptions = new StringBuilder();
    private static StringBuilder scriptAfterConversion = new StringBuilder();
    private static List<String> blocksAfterScan = new ArrayList<>();
    private static InputStream inputStream;
    private static PrintStream printStream;
    private static String outputFile;
    static TokenStreamRewriter rewriter;
    private static CommonTokenStream tokens;
    final static String errorMessage = "Found error(s) in file while parsing\n";
    final static String exceptionMessage = "Found exception(s) during the conversion. Please contact to fix it\n";
    private static ParserRuleContext currentTree;

    static String stripQuotes(String str) {
        if (str.startsWith("\""))
            return str.substring(1, str.length() - 1);
        else
            return str;
    }

    public static String getRealName(String str) {
        if (str.startsWith("\""))
            return str.substring(1, str.length() - 1);
        else
            return str.toUpperCase();
    }

    static String getRealParameterName(String str) {
        return str.toUpperCase()
                .substring(str.lastIndexOf(".") + 1,
                        str.length()
                );
    }

    static void clear() {
        reorder = false;
        errors = new StringBuilder();
        exceptions = new StringBuilder();
        scriptAfterConversion = new StringBuilder();
        statistic = false;
        stdout = true;
        blocksAfterScan = new ArrayList<>();
        inputStream = null;
        printStream.close();
        printStream = null;
        outputFile = null;
        StorageInfo.clearInfo();
        RewritingListener.clearInfo();
        ScanListener.clearInfo();
        CommentedListener.clearInfo();
    }

    static void printUsage() {
        System.err.println("Usage: ora2rdb.jar <input_file> [options]\n" +
                "Options:\n" +
                "    -o <output_file>    Specify output file.\n" +
                "    -r                  Reorder CREATE VIEW statements in according to their\n" +
                "                        dependencies. It allows to perform FORCE clause\n" +
                "                        conversion. Use this option only for scripts which\n" +
                "                        contain DB metadata.\n" +
                "    -s                  Output of statistics on non-convertible constructions\n" +
                "Notes:\n" +
                "    \"stdin\" may be used as a value of <input_file>.");
    }

    public static int parsingArgs(String[] args) {
        printStream = System.out;
        outputFile = null;
        if (args.length > 0) {
            if (args[0].equals("stdin")) {
                inputStream = System.in;
            } else {
                try {
                    inputStream = new FileInputStream(args[0]);
                } catch (Exception e) {
                    System.err.println("Unable to open: " + args[0]);
                    return 1;
                }
            }

            for (int i = 1; i < args.length; i++) {
                switch (args[i]) {
                    case "-o":
                        if (i < args.length - 1) {
                            i++;
                            outputFile = args[i];
                            stdout = false;
                        } else {
                            System.err.println("Missing argument for option: " + args[i]);
                            printUsage();
                            return 1;
                        }
                        break;
                    case "-r":
                        reorder = true;
                        break;
                    case "-s":
                        statistic = true;
                        break;
                    default:
                        System.err.println("Unknown option: " + args[i]);
                        printUsage();
                        return 1;
                }
            }
        } else {
            printUsage();
            return 1;
        }
        return 0;
    }


    private static String tryToParseBlock(String singleBlock, CustomErrorListener customErrorListener) {
        PlSqlParser parser = configurePlSqlParser(singleBlock, customErrorListener);
        try {
            currentTree = parser.sql_script();
        } catch (Exception e) {
            singleBlock = formatBlockWithErrors(singleBlock, customErrorListener);
        }
        return singleBlock;
    }

    private static String tryToParsePackageBodyBlock(String packageName, List<String> blocksInPackage, CustomErrorListener customErrorListener) {
        StringBuilder packageBody = new StringBuilder();
        boolean commentAll = false;
        for (int i = 0; i < blocksInPackage.size(); i++) {
            String block = blocksInPackage.get(i);
            PlSqlParser parser;
            if (i == 0)
                parser = configurePlSqlParser(block + "\nEND;", customErrorListener);
            else if (i == blocksInPackage.size() - 1)
                parser = configurePlSqlParser("CREATE PACKAGE BODY " + packageName + " IS\n" + block, customErrorListener);
            else
                parser = configurePlSqlParser("CREATE PACKAGE BODY " + packageName + " IS\n" + block + "\nEND;", customErrorListener);

            try {
                currentTree = parser.sql_script();
            } catch (Exception e) {
                block = formatBlockWithErrors(block, customErrorListener);
                if (i == 0)
                    commentAll = true;
            }
            packageBody.append(block);
        }

        currentTree = null;
        if (commentAll)
            return "/*\n" + deleteMultiLineComment(packageBody.toString()) + "*/\n";
        return packageBody.toString();
    }

    private static String formatBlockWithErrors(String block, CustomErrorListener customErrorListener) {
        StringBuilder parsedBlock = new StringBuilder();
        block = deleteMultiLineComment(block);
        List<String> errorList = customErrorListener.getErrorMessages();
        parsedBlock.append("\n").append("/*");
        for (String s : errorList) {
            errors.append(s).append("\n");
            parsedBlock.append("\n").append(s);
        }

        block = parsedBlock + "\n" + block + "\n" + "*/";
        RewritingListener.blocksWithErrorsAndExceptions.add(block);
        return block;
    }

    private static String deleteMultiLineComment(String block) {
        return block.replaceAll("/\\*", "").replaceAll("\\*/", "");
    }

    private static PlSqlParser configurePlSqlParser(String singleBlock, CustomErrorListener customErrorListener) {
        CharStream input = CharStreams.fromString(singleBlock);
        PlSqlLexer lexer = new PlSqlLexer(input);
        tokens = new CommonTokenStream(lexer);
        rewriter = new TokenStreamRewriter(tokens);
        PlSqlParser parser = new PlSqlParser(tokens);
        parser.setErrorHandler(new BailErrorStrategy());
        parser.setErrorHandler(new BailErrorStrategy());
        parser.removeErrorListeners();
        parser.addErrorListener(customErrorListener);
        return parser;
    }

    public static void main(String[] args) throws Exception {
        if (parsingArgs(args) == 1)
            return;

        SqlCodeParser sqlCodeParser = new SqlCodeParser();
        List<String> splitBlocks = sqlCodeParser.splitMetadataIntoBlocks(inputStream);

        Map<String, List<String>> blocksInPackageBody = sqlCodeParser.getBlocksInPackageBody();
        Map<Integer, String> packageBlockNumber = sqlCodeParser.getPackageBlockNumber();

        for (int i = 0; i < splitBlocks.size(); i++) {
            currentTree = null;
            String singleBlock = splitBlocks.get(i);
            CustomErrorListener customErrorListener = new CustomErrorListener();

            if (packageBlockNumber.containsKey(i)) {
                String getPackageName = packageBlockNumber.get(i);
                singleBlock = tryToParsePackageBodyBlock(getPackageName, blocksInPackageBody.get(getPackageName), customErrorListener);
            } else
                singleBlock = tryToParseBlock(singleBlock, customErrorListener);

            if (currentTree == null) {
                PlSqlParser parser = configurePlSqlParser(singleBlock, customErrorListener);
                currentTree = parser.sql_script();
            }

            ParseTreeWalker walker = new ParseTreeWalker();
            try {
                // Scanning of all necessary information for conversion
                ScanListener scan_listener = ScanListener.getInstance();
                walker.walk(scan_listener, currentTree);
            } catch (Exception e) {
                String message = "/*This SQL statement was not converted due to an exception. Please contact to fix it." + e.getMessage()
                        + "*/\n";
                singleBlock = deleteMultiLineComment(singleBlock);
                singleBlock = message + "/*" + singleBlock + "*/";

                RewritingListener.blocksWithErrorsAndExceptions.add(singleBlock);
                exceptions.append(e.getMessage()).append("\n");
            }
            blocksAfterScan.add(singleBlock);
        }

        for (String singleBlock : blocksAfterScan) {
            currentTree = null;
            CustomErrorListener customErrorListener = new CustomErrorListener();
            PlSqlParser parser = configurePlSqlParser(singleBlock, customErrorListener);

            currentTree = parser.sql_script();

            ParseTreeWalker walker = new ParseTreeWalker();
            try {
                //Commented of unconvertible blocks
                CommentedListener commentedListener = CommentedListener.getInstance(tokens, rewriter);
                walker.walk(commentedListener, currentTree);

                // Converting Oracle metadata to a syntax that is understandable for RDB
                RewritingListener converter = RewritingListener.getInstance(tokens, rewriter);

                walker.walk(converter, currentTree);
                scriptAfterConversion.append(rewriter.getText());
            } catch (Exception e) {
                String message = "/*This SQL statement was not converted due to an exception. Please contact to fix it." + e.getMessage()
                        + "*/\n";
                singleBlock = deleteMultiLineComment(singleBlock);

                RewritingListener.blocksWithErrorsAndExceptions.add(singleBlock);
                scriptAfterConversion.append(message).append("/*").append(singleBlock).append("*/").append("\n");
                exceptions.append(e.getMessage()).append("\n");
            }
        }

        RewritingListener converter = RewritingListener.getInstance();

        scriptAfterConversion.insert(0, converter.addExceptions());

        if (errors.length() != 0) { // errors in grammar
            errors.insert(0, errorMessage);
            errors.insert(0, "/*");
            errors.append("*/").append("\n\n\n");
            scriptAfterConversion.insert(0, errors);
        }
        if (exceptions.length() != 0) { // exceptions that occurred while ora2rdb was running
            exceptions.insert(0, exceptionMessage);
            exceptions.insert(0, "/*");
            exceptions.append("*/").append("\n\n\n");
            scriptAfterConversion.insert(0, exceptions);
        }


        if (outputFile != null) {
            try {
                printStream = new PrintStream(outputFile);
            } catch (IOException e) {
                System.err.println("Unable to write: " + outputFile);
                return;
            }
        }

        StringBuilder outputScript = new StringBuilder();
        if(reorder){
            outputScript.append(converter.getText());
        }else{
            outputScript.append(scriptAfterConversion.toString());
        }

        if (statistic) {
            if (stdout)
                outputScript.append("\n\n")
                        .append(StorageInfo.unconvertibleConstructionsStatistic.getUnconvertibleConstructionsStatistic());
            else
                outputScript.insert(0, StorageInfo.unconvertibleConstructionsStatistic.getUnconvertibleConstructionsStatistic() + "\n\n");
        }
        printStream.print(outputScript);
        clear();
    }
}
