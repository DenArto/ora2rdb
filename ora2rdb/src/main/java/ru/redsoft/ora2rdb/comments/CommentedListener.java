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

    public CommentedListener(CommonTokenStream tokens, TokenStreamRewriter rewriter) {
        this.tokens = tokens;
        this.rewriter = rewriter;
    }

    void insertBefore(Token token, Object text) {
        if (token != null)
            rewriter.insertBefore(token, text);
    }

    void insertBefore(TerminalNode term, Object text) {
        if (term != null)
            rewriter.insertBefore(term.getSymbol(), text);
    }

    void insertAfter(Token token, Object text) {
        if (token != null)
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
            insertAfter(unconvertableBlock.getBlockStop(), "]");
        }
        if (commentedBlock.isConvertAllBlock()) {
            commentBlock(commentedBlock.getParentContext().start.getTokenIndex()
                    ,commentedBlock.getParentContext().stop.getTokenIndex());

        } else if (commentedBlock.getStartDeclareBlock() == null
                || commentedBlock.getStartBodyBlock() == null
                || commentedBlock.getStopBodyBlock() == null) {

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
        if (ctx.call_spec() != null)
            currentBlock.push(new CommentedBlock(ctx));
        else if (ctx.AS() != null)
            currentBlock.push(new CommentedBlock(ctx, ctx.AS(), ctx.body().BEGIN(), ctx.body().END()));
        else
            currentBlock.push(new CommentedBlock(ctx, ctx.IS(), ctx.body().BEGIN(), ctx.body().END()));
    }
    @Override
    public void exitCreate_function_body(Create_function_bodyContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }


    @Override
    public void enterCreate_procedure_body(Create_procedure_bodyContext ctx) {
        if (ctx.AS() != null)
            currentBlock.push(new CommentedBlock(ctx, ctx.AS(), ctx.body().BEGIN(), ctx.body().END()));
        else
            currentBlock.push(new CommentedBlock(ctx, ctx.IS(), ctx.body().BEGIN(), ctx.body().END()));
    }
    @Override
    public void exitCreate_procedure_body(Create_procedure_bodyContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }

    @Override
    public void enterCreate_trigger(Create_triggerContext ctx) {
        if (ctx.trigger_body().trigger_block() != null)
            currentBlock.push(
                    new CommentedBlock(
                            ctx,
                            ctx.trigger_body().trigger_block().DECLARE(),
                            ctx.trigger_body().trigger_block().body().BEGIN(),
                            ctx.trigger_body().trigger_block().body().END()
                    )
            );
        else
            currentBlock.push(new CommentedBlock(ctx));
    }

    @Override
    public void exitCreate_trigger(Create_triggerContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }


    @Override
    public void enterCreate_package(Create_packageContext ctx) {
        currentBlock.push(new CommentedBlock(ctx));
    }

    @Override
    public void exitCreate_package(Create_packageContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }

    @Override
    public void enterCreate_package_body(Create_package_bodyContext ctx) {
        if (ctx.AS() != null)
            currentBlock.push(new CommentedBlock(ctx, ctx.AS(), ctx.BEGIN(), ctx.END()));
        else
            currentBlock.push(new CommentedBlock(ctx, ctx.IS(), ctx.BEGIN(), ctx.END()));
    }

    @Override
    public void exitCreate_package_body(Create_package_bodyContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }


    @Override
    public void enterProcedure_spec(Procedure_specContext ctx) {
        currentBlock.push(new CommentedBlock(ctx));
    }

    @Override
    public void exitProcedure_spec(Procedure_specContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }

    @Override
    public void enterProcedure_body(Procedure_bodyContext ctx) {
        if (ctx.AS() != null)
            currentBlock.push(new CommentedBlock(ctx, ctx.AS(), ctx.body().BEGIN(), ctx.body().END()));
        else
            currentBlock.push(new CommentedBlock(ctx, ctx.IS(), ctx.body().BEGIN(), ctx.body().END()));
    }

    @Override
    public void exitProcedure_body(Procedure_bodyContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }


    @Override
    public void enterFunction_spec(Function_specContext ctx) {
        currentBlock.push(new CommentedBlock(ctx));
    }

    @Override
    public void exitFunction_spec(Function_specContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }

    @Override
    public void enterFunction_body(Function_bodyContext ctx) {
        if (ctx.AS() != null)
            currentBlock.push(new CommentedBlock(ctx, ctx.AS(), ctx.body().BEGIN(), ctx.body().END()));
        else
            currentBlock.push(new CommentedBlock(ctx, ctx.IS(), ctx.body().BEGIN(), ctx.body().END()));
    }

    @Override
    public void exitFunction_body(Function_bodyContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }

    @Override
    public void enterAnonymous_block(Anonymous_blockContext ctx) {
        currentBlock.push(new CommentedBlock(ctx, ctx.DECLARE(), ctx.body().BEGIN(), ctx.body().END()));
    }
    @Override
    public void exitAnonymous_block(Anonymous_blockContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }

    @Override
    public void enterPackage_function_spec(Package_function_specContext ctx) {
        currentBlock.push(new CommentedBlock(ctx));
    }

    @Override
    public void exitPackage_function_spec(Package_function_specContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }

    @Override
    public void enterPackage_procedure_spec(Package_procedure_specContext ctx) {
        currentBlock.push(new CommentedBlock(ctx));
    }

    @Override
    public void exitPackage_procedure_spec(Package_procedure_specContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
    }


    //The markup of PL SQL constructions begins
    @Override
    public void enterForall_statement(Forall_statementContext ctx) {

    }

    @Override
    public void enterType_declaration(Type_declarationContext ctx) {


    }

    @Override
    public void enterType_spec(Type_specContext ctx) {

    }

    @Override
    public void enterLoop_statement(Loop_statementContext ctx) {


        Pred_clause_seqContext predClauseSeq = (Pred_clause_seqContext) Ora2rdb.getFirstRuleContext(ctx, Pred_clause_seqContext.class);
        if(predClauseSeq != null) {
            if (predClauseSeq.WHILE() != null && predClauseSeq.WHEN() != null) {
                currentBlock.peek().addUnconvertableBlock(predClauseSeq.WHILE().getSymbol(), predClauseSeq.logical_expression(0).stop, Ticket.FOR_WITH_WHILE_STOP_CLAUSE);
                currentBlock.peek().addUnconvertableBlock(predClauseSeq.WHEN().getSymbol(), predClauseSeq.logical_expression(1).stop, Ticket.FOR_WITH_WHEN_SKIP_CLAUSE);
            }
            else if (predClauseSeq.WHILE() != null)
                currentBlock.peek().addUnconvertableBlock(predClauseSeq.WHILE().getSymbol(), predClauseSeq.logical_expression(0).stop, Ticket.FOR_WITH_WHILE_STOP_CLAUSE);
            else if (predClauseSeq.WHEN() != null)
                currentBlock.peek().addUnconvertableBlock(predClauseSeq.WHEN().getSymbol(), predClauseSeq.logical_expression(0).stop, Ticket.FOR_WITH_WHEN_SKIP_CLAUSE);
        }

        Values_indices_pairs_of_controlContext values_indices_pairs_of_control =
                (Values_indices_pairs_of_controlContext) Ora2rdb.getFirstRuleContext(ctx, Values_indices_pairs_of_controlContext.class);
        if (values_indices_pairs_of_control != null) {
            if (values_indices_pairs_of_control.VALUES() != null)
                currentBlock.peek().addUnconvertableBlock(ctx.start, values_indices_pairs_of_control.stop, Ticket.FOR_LOOP_VALUES_OF_CONTROL);
            else if (values_indices_pairs_of_control.INDICES() != null)
                currentBlock.peek().addUnconvertableBlock(ctx.start, values_indices_pairs_of_control.stop, Ticket.FOR_LOOP_INDICES_OF_CONTROL);
            else if (values_indices_pairs_of_control.PAIRS() != null)
                currentBlock.peek().addUnconvertableBlock(ctx.start, values_indices_pairs_of_control.stop, Ticket.FOR_LOOP_PAIRS_OF_CONTROL);
            return;
        }

        Single_expression_controlContext single_expression_control =
                (Single_expression_controlContext) Ora2rdb.getLastRuleContext(ctx, Single_expression_controlContext.class);
        if (single_expression_control != null) {
            currentBlock.peek().addUnconvertableBlock(ctx.start, single_expression_control.stop, Ticket.FOR_LOOP_SINGLE_EXPRESSION_CONTROL);
            return;
        }


    }

}
