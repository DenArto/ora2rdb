package ru.redsoft.ora2rdb;

import java.io.*;
import java.util.*;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import ru.redsoft.ora2rdb.comments.*;

public class Ora2rdb {
    public static boolean reorder = false;
    private static StringBuilder errors = new StringBuilder();
    private static InputStream inputStream;
    private static PrintStream printStream;
    private static String outputFile;
    static TokenStreamRewriter rewriter;
    private static CommonTokenStream tokens;


    final static String errorMessage = "Found error(s) in file while parsing\n";
    private final static String packageBodyStart = "CREATE OR REPLACE PACKAGE BODY package_for_parse IS";
    private final static String packageEnd = "END package_for_parse;";
    private final static String packageStart = "CREATE OR REPLACE PACKAGE package_for_parse IS";

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
        inputStream = null;
        printStream.close();
        printStream = null;
        outputFile = null;
        StorageInfo.clearInfo();
    }

    static void printUsage() {
        System.err.println("Usage: ora2rdb.jar <input_file> [options]\n" +
                "Options:\n" +
                "    -o <output_file>    Specify output file.\n" +
                "    -r                  Reorder CREATE VIEW statements in according to their\n" +
                "                        dependencies. It allows to perform FORCE clause\n" +
                "                        conversion. Use this option only for scripts which\n" +
                "                        contain DB metadata.\n" +
                "Notes:\n" +
                "    \"stdin\" may be used as a value of <input_file>.");
    }

    private static StringBuilder convertSplitBlocks(List<String> splitBlocks, SqlCodeParser sqlCodeParser) {
        Map<Integer, List<String>> mapWithBlocksInPackages = sqlCodeParser.getBlocksInPackage();
        StringBuilder mergedBlocks = new StringBuilder();
        int numberOfBlock = 0;
        for (String singleBlock : splitBlocks) {
            if (mapWithBlocksInPackages.containsKey(numberOfBlock)) {
                StringBuilder insidePackage = new StringBuilder();
                List<String> listWithBlocks = mapWithBlocksInPackages.get(numberOfBlock);
                for (int id = 0; id < listWithBlocks.size() - 2; id++) {
                    String startOfPackage = packageBodyStart;
                    if (sqlCodeParser.checkIfPragmaDeclaration(listWithBlocks.get(id))) {
                        startOfPackage = packageStart;
                    }
                    String singleBlockInPackage = tryToParseBlock(startOfPackage + " " + listWithBlocks.get(id) + " " + packageEnd).toString();
                    singleBlockInPackage = singleBlockInPackage.replace(startOfPackage, "");
                    singleBlockInPackage = singleBlockInPackage.replace(packageEnd, "");
                    insidePackage.append(singleBlockInPackage);
                }
                int size = listWithBlocks.size();
                StringBuilder parsedPackageDeclaration = tryToParseBlock(listWithBlocks.get(size - 2) + " " + listWithBlocks.get(size - 1));
                String[] splitPackageDeclaration = sqlCodeParser.findLastIndexOfEndSubstring(parsedPackageDeclaration.toString());
                mergedBlocks.append("\n\n\n").append(splitPackageDeclaration[0]).append(insidePackage).append(splitPackageDeclaration[1]);
            } else {
                mergedBlocks.append(tryToParseBlock(singleBlock));
            }
            numberOfBlock++;
        }
        if (errors.length() != 0) {
            errors.insert(0, errorMessage);
            errors.insert(0, "/*");
            errors.append("*/").append("\n\n\n");
            errors.append(mergedBlocks);
            mergedBlocks.setLength(0);
            mergedBlocks.append(errors);
        }
        return mergedBlocks;
    }

    private static StringBuilder tryToParseBlock(String block) {
        StringBuilder parsedBlock = new StringBuilder();
        CustomErrorListener customErrorListener = new CustomErrorListener();
        try {
            CharStream input = CharStreams.fromString(block);
            PlSqlLexer lexer = new PlSqlLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            PlSqlParser parser = new PlSqlParser(tokens);
            parser.setErrorHandler(new BailErrorStrategy());
            parser.removeErrorListeners();
            parser.addErrorListener(customErrorListener);
            ParserRuleContext tree = parser.sql_script();
            parsedBlock.append(block);
        } catch (Exception e) {
            block = block.replaceAll("/\\*", "").replaceAll("\\*/", "");
            List<String> errorList = customErrorListener.getErrorMessages();
            parsedBlock.append("\n").append("/*");
            for (String s : errorList) {
                errors.append(s).append("\n");
                parsedBlock.append("\n").append(s);
            }
            parsedBlock.append("\n").append(block).append("\n").append("*/");
        }
        return parsedBlock;
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
                        } else {
                            System.err.println("Missing argument for option: " + args[i]);
                            printUsage();
                            return 1;
                        }
                        break;
                    case "-r":
                        reorder = true;
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

    public static ParseTree getFirstRuleContext(ParseTree ctx, Class<?> ruleContext) {
        return getFirstRuleContext(ctx, ruleContext, ctx);
    }

    private static ParseTree getFirstRuleContext(ParseTree ctx, Class<?> ruleContext, ParseTree StartContext) {

        if (ctx instanceof ErrorNode)
            return null;

        if (ctx.getClass().equals(ruleContext))
            return ctx;

        if (ctx instanceof TerminalNode)
            return null;

        RuleNode r = (RuleNode) ctx;
        int n = r.getChildCount();
        for (int i = 0; i < n; i++) {
            if (r.getChild(i).getClass().equals(StartContext.getClass()))
                break;
            ParseTree find = getFirstRuleContext(r.getChild(i), ruleContext, StartContext);
            if (find != null)
                return find;
        }
        return null;
    }

    public static ParseTree getLastRuleContext(ParseTree ctx, Class<?> ruleContext) {
        return getLastRuleContext(ctx, ruleContext, ctx);
    }

    private static ParseTree getLastRuleContext(ParseTree ctx, Class<?> ruleContext, ParseTree startContext) {
        if (ctx instanceof ErrorNode) {
            return null;
        }

        if (ctx.getClass().equals(ruleContext)) {
            ParseTree lastFound = null;
            if (!(ctx instanceof TerminalNode)) {
                RuleNode r = (RuleNode) ctx;
                int n = r.getChildCount();
                for (int i = n - 1; i >= 0; i--) {
                    if (r.getChild(i).getClass().equals(startContext.getClass())) {
                        break;
                    }
                    ParseTree find = getLastRuleContext(r.getChild(i), ruleContext, startContext);
                    if (find != null) {
                        lastFound = find;
                        break;
                    }
                }
            }
            return lastFound != null ? lastFound : ctx;
        }

        if (ctx instanceof TerminalNode) {
            return null;
        }

        RuleNode r = (RuleNode) ctx;
        int n = r.getChildCount();
        ParseTree lastFound = null;

        for (int i = n - 1; i >= 0; i--) {
            if (r.getChild(i).getClass().equals(startContext.getClass())) {
                break;
            }
            ParseTree find = getLastRuleContext(r.getChild(i), ruleContext, startContext);
            if (find != null) {
                lastFound = find;
                break;
            }
        }
        return lastFound;
    }

    public static <T extends ParseTree> List<T> getAllRuleContexts(ParseTree ctx, Class<T> ruleContext) {
        List<T> result = new ArrayList<>();
        getAllRuleContexts(ctx, ruleContext, ctx, result);
        return result;
    }

    private static <T extends ParseTree> void getAllRuleContexts(ParseTree ctx, Class<T> ruleContext, ParseTree startContext, List<T> result) {
        if (ctx instanceof ErrorNode)
            return;

        if (ruleContext.isInstance(ctx))
            result.add(ruleContext.cast(ctx));

        if (ctx instanceof TerminalNode)
            return;

        if (ctx.getClass().equals(startContext.getClass()) && ctx != startContext)
            return;

        if (ctx instanceof RuleNode) {
            RuleNode r = (RuleNode) ctx;
            int n = r.getChildCount();
            for (int i = 0; i < n; i++) {
                getAllRuleContexts(r.getChild(i), ruleContext, startContext, result);
            }
        }
    }


    public static void main(String[] args) throws Exception {
        if (parsingArgs(args) == 1)
            return;

        SqlCodeParser sqlCodeParser = new SqlCodeParser();
        List<String> splitBlocks = sqlCodeParser.splitMetadataIntoBlocks(inputStream);

        StringBuilder mergedBlocks = convertSplitBlocks(splitBlocks, sqlCodeParser);

        CharStream input = CharStreams.fromString(mergedBlocks.toString());
        PlSqlLexer lexer = new PlSqlLexer(input);
        tokens = new CommonTokenStream(lexer);
        rewriter = new TokenStreamRewriter(tokens);
        PlSqlParser parser = new PlSqlParser(tokens);
        parser.setErrorHandler(new BailErrorStrategy());
        ParserRuleContext tree;
        try {
            tree = parser.sql_script();
        } catch (Exception e) {
            System.err.println("Output will not be generated");
            return;
        }
        mergedBlocks.setLength(0);
        errors.setLength(0);

        ParseTreeWalker walker = new ParseTreeWalker();

        // Scanning of all necessary information for conversion
        ScanListener scan_listener = new ScanListener();
        walker.walk(scan_listener, tree);

        //Commented of unconvertible blocks
        CommentedListener commentedListener = new CommentedListener(tokens, rewriter);
        walker.walk(commentedListener, tree);

        // Converting Oracle metadata to a syntax that is understandable for RDB
        RewritingListener converter = new RewritingListener(tokens, rewriter);
        walker.walk(converter, tree);


        if (outputFile != null) {
            try {
                printStream = new PrintStream(outputFile);
            } catch (IOException e) {
                System.err.println("Unable to write: " + outputFile);
                return;
            }
        }

        if (reorder)
            printStream.print(converter.getText());
        else
            printStream.print(rewriter.getText());
        clear();
    }
}
