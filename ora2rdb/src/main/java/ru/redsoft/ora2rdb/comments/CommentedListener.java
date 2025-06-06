package ru.redsoft.ora2rdb.comments;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;
import ru.redsoft.ora2rdb.*;
import ru.redsoft.ora2rdb.PlSqlParser.*;

import java.util.List;
import java.util.Stack;

public class CommentedListener extends PlSqlParserBaseListener {
    TokenStreamRewriter rewriter;
    CommonTokenStream tokens;
    Stack<CommentedBlock> currentBlock = new Stack<>();

    public CommentedListener( TokenStreamRewriter rewriter) {
        this.rewriter = rewriter;
    }

    void insertBefore(Token token, Object text){
        if(token != null)
            rewriter.insertBefore(token, text);
    }

    void insertBefore(TerminalNode term, Object text) {
        if (term != null)
            rewriter.insertBefore(term.getSymbol(), text);
    }

    void insertAfter(Token token, Object text) {
        if(token != null)
            rewriter.insertAfter(token, text);
    }

    void insertAfter(TerminalNode term, Object text) {
        if (term != null)
            rewriter.insertAfter(term.getSymbol(), text);
    }



    void commentBlock(int start_tok_idx, int stop_tok_idx) {
        rewriter.insertBefore(start_tok_idx, "/*");
        rewriter.insertAfter(stop_tok_idx, "*/");

        List<Token> multi_line_comments = tokens.getTokens(start_tok_idx, stop_tok_idx, PlSqlLexer.MULTI_LINE_COMMENT);

        if (multi_line_comments != null)
            for (Token tok : multi_line_comments)
                rewriter.delete(tok);
    }


    private void commendUnconvertibleBlock(CommentedBlock commentedBlock) {
        for (UnconvertableBlock unconvertableBlock : commentedBlock.getUnconvertableBlockList()) {
            insertBefore(unconvertableBlock.getBlockStart(), " [-unconvertible RS-" + unconvertableBlock.getTicketNumber() + " ");
            insertAfter(unconvertableBlock.getBlockStop(), " ]");
        }
        if (commentedBlock.isConvertAllBlock()) {
            commentBlock(commentedBlock.getParentContext().start.getTokenIndex()
                    ,commentedBlock.getParentContext().stop.getTokenIndex());
        } else {
            insertAfter(commentedBlock.getStartDeclareBlock(), "\n/*");
            insertBefore(commentedBlock.getStartBodyBlock(), "*/\n");

            insertAfter(commentedBlock.getStartBodyBlock(), "\n/*");
            insertBefore(commentedBlock.getStopBodyBlock(), "*/\n");

        }
    }

    @Override
    public void exitSql_script(Sql_scriptContext ctx) {
        for (CommentedBlock commentedBlock : StorageInfo.commentedBlockList) {
            commendUnconvertibleBlock(commentedBlock);
        }
    }

    @Override
    public void enterCreate_function_body(Create_function_bodyContext ctx) {
        if(ctx.AS() != null)
            currentBlock.push(new CommentedBlock(ctx, ctx.AS(), ctx.body().BEGIN(), ctx.body().END()));
        else
            currentBlock.push(new CommentedBlock(ctx, ctx.IS(), ctx.body().BEGIN(), ctx.body().END()));
    }

    @Override
    public void exitCreate_function_body(Create_function_bodyContext ctx) {
        if(!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }


    @Override
    public void enterAnonymous_block(PlSqlParser.Anonymous_blockContext ctx) {
        CommentedBlock block = new CommentedBlock(ctx, ctx.DECLARE(), ctx.body().BEGIN(), ctx.body().END());
        block.setConvertAllBlock(true);
        currentBlock.push(block);

    }

    public void exitAnonymous_block(PlSqlParser.Anonymous_blockContext ctx) {
        if(!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }


    @Override
    public void enterForall_statement(Forall_statementContext ctx) {
        currentBlock.peek().addUnconvertableBlock(ctx, 123456);
    }

    @Override
    public void enterType_declaration(Type_declarationContext ctx) {
        if(ctx.ref_cursor_type_def()!=null)
            currentBlock.peek().addUnconvertableBlock(ctx, 123123);
    }

    @Override
    public void enterType_spec(Type_specContext ctx) {
        if(ctx.type_name()!= null && Ora2rdb.getRealName(ctx.type_name().getText()).equals("SYS_REFCURSOR"))
            currentBlock.peek().addUnconvertableBlock(ctx, 321123);


    }




}
