package ru.redsoft.ora2rdb.comments;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;
import ru.redsoft.ora2rdb.*;
import ru.redsoft.ora2rdb.PlSqlParser.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class CommentedListener extends PlSqlParserBaseListener {
    TokenStreamRewriter rewriter;
    CommonTokenStream tokens;
    Stack<CommentedBlock> currentBlock = new Stack<>();

    ArrayList<String> associative_array_types = new ArrayList<>();
    ArrayList<String> nested_array_types = new ArrayList<>();
    ArrayList<String> varray_types = new ArrayList<>();

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

    String getRuleText(RuleContext ctx) {
        return tokens.getText(ctx);
    }

    void commentBlock(int start_tok_idx, int stop_tok_idx) {
        rewriter.insertBefore(start_tok_idx, "/*");
        rewriter.insertAfter(stop_tok_idx, "*/");

        List<Token> multi_line_comments = tokens.getTokens(start_tok_idx, stop_tok_idx, PlSqlLexer.MULTI_LINE_COMMENT);

        if (multi_line_comments != null)
            for (Token tok : multi_line_comments)
                rewriter.delete(tok);
    }

    private void commentUnconvertibleBlock(CommentedBlock commentedBlock) {
        for (UnconvertableBlock unconvertableBlock : commentedBlock.getUnconvertableBlockList()) {
            if (!unconvertableBlock.blockIsReady())
                continue;
            StringBuilder ticketNumbers = new StringBuilder();
            for (int ticket : unconvertableBlock.getTicketNumbersList())
                ticketNumbers.append("RS-").append(ticket).append(" ");
            insertBefore(unconvertableBlock.getBlockStart(), "[-unconvertible " + ticketNumbers);
            insertAfter(unconvertableBlock.getBlockStop(), "]");
        }
        if (commentedBlock.isConvertAllBlock()) {
            commentBlock(commentedBlock.getParentContext().start.getTokenIndex()
                    , commentedBlock.getParentContext().stop.getTokenIndex());

        } else if (commentedBlock.getStartDeclareBlock() == null
                || commentedBlock.getStartBodyBlock() == null
                || commentedBlock.getStopBodyBlock() == null) {

            commentBlock(commentedBlock.getParentContext().start.getTokenIndex()
                    , commentedBlock.getParentContext().stop.getTokenIndex());
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
            commentUnconvertibleBlock(commentedBlock);
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

        if (!ctx.accessible_by_clause().isEmpty()){
            currentBlock.peek().addUnconvertableBlock(ctx.accessible_by_clause(0), Ticket.ACCESSIBLE_BY_CLAUSE);
            currentBlock.peek().setConvertAllBlock(true);
        }
        if (!ctx.result_cache_clause().isEmpty()){
            currentBlock.peek().addUnconvertableBlock(ctx.result_cache_clause(0), Ticket.RESULT_CACHE_CLAUSE);
            currentBlock.peek().setConvertAllBlock(true);
        }
        if (!ctx.parallel_enable_clause().isEmpty()){
            currentBlock.peek().addUnconvertableBlock(ctx.parallel_enable_clause(0), Ticket.PARALLEL_ENABLE_CLAUSE);
            currentBlock.peek().setConvertAllBlock(true);
        }
        if (ctx.call_spec() != null){
            currentBlock.peek().addUnconvertableBlock(ctx.call_spec(), Ticket.EXTERNAL_FUNCTION);
            currentBlock.peek().setConvertAllBlock(true);
        }
        if (!ctx.PIPELINED().isEmpty()){
            currentBlock.peek().addUnconvertableBlock(ctx.PIPELINED(0), Ticket.PIPELINED_FUNCTION);
            currentBlock.peek().setConvertAllBlock(true);
        }
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
        if (!ctx.accessible_by_clause().isEmpty()) {
            currentBlock.peek().addUnconvertableBlock(ctx.accessible_by_clause(0), Ticket.ACCESSIBLE_BY_CLAUSE);
            currentBlock.peek().setConvertAllBlock(true);
        }
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
    public void enterMultiset_expression(Multiset_expressionContext ctx) {
        if (ctx.MULTISET() != null && ctx.UNION() != null)
            currentBlock.peek().addUnconvertableBlock(ctx, Ticket.NESTED_TABLE_MULTISET_UNION);
    }

    @Override
    public void enterForall_statement(Forall_statementContext ctx) {

    }

    @Override
    public void enterType_declaration(Type_declarationContext ctx) {
        Table_type_defContext tableType = (Table_type_defContext) Ora2rdb.getFirstRuleContext(ctx, Table_type_defContext.class);
        if (tableType != null)
            associative_array_types.add(Ora2rdb.getRealName(ctx.identifier().getText()));


        Nested_table_type_defContext nestedTableType = (Nested_table_type_defContext) Ora2rdb.getFirstRuleContext(ctx, Nested_table_type_defContext.class);
        if (nestedTableType != null) {
            nested_array_types.add(Ora2rdb.getRealName(ctx.identifier().getText()));
            currentBlock.peek().addUnconvertableBlock(ctx, Ticket.NESTED_TABLE_TYPE_VARIABLE);
        }

        Varray_type_defContext varrayType = (Varray_type_defContext) Ora2rdb.getFirstRuleContext(ctx, Varray_type_defContext.class);
        if (varrayType != null) {
            varray_types.add(Ora2rdb.getRealName(ctx.identifier().getText()));
            currentBlock.peek().addUnconvertableBlock(ctx, Ticket.VARRAY_TYPE_VARIABLE);
        }

        // convert TYPE <name> IS REF CURSOR
        if (ctx.ref_cursor_type_def() != null)
            currentBlock.peek().addUnconvertableBlock(ctx, Ticket.SYS_REFCURSOR_REF_CURSOR_TYPE_DEF);
    }

    @Override
    public void enterVariable_declaration(Variable_declarationContext ctx) {

        if (nested_array_types.contains(Ora2rdb.getRealName(ctx.type_spec().getText()))) {
            currentBlock.peek().addUnconvertableBlock(ctx.start, ctx.type_spec().stop, Ticket.NESTED_TABLE_TYPE_VARIABLE);
        } else if (varray_types.contains(Ora2rdb.getRealName(ctx.type_spec().getText()))) {
            currentBlock.peek().addUnconvertableBlock(ctx.start, ctx.type_spec().stop, Ticket.VARRAY_TYPE_VARIABLE);
        }

        if (ctx.default_value_part() != null) {
            General_element_partContext generalElementPart = (General_element_partContext) Ora2rdb.getFirstRuleContext(ctx.default_value_part(), General_element_partContext.class);
            if (generalElementPart != null && generalElementPart.function_argument() != null) {
                if (associative_array_types.contains(Ora2rdb.getRealName(generalElementPart.id_expression(0).getText()))) {
                    currentBlock.peek().addUnconvertableBlock(generalElementPart, Ticket.ASSOCIATIVE_ARRAY_CONSTRUCTOR);
                } else if (nested_array_types.contains(Ora2rdb.getRealName(generalElementPart.id_expression(0).getText()))) {
                    currentBlock.peek().addUnconvertableBlock(generalElementPart, Ticket.NESTED_TABLE_CONSTRUCTOR);
                } else if (varray_types.contains(Ora2rdb.getRealName(generalElementPart.id_expression(0).getText()))) {
                    currentBlock.peek().addUnconvertableBlock(generalElementPart, Ticket.VARRAY_CONSTRUCTOR);
                }
            }
        }

        // convert SYS_REFCURSOR type
        if (ctx.type_spec().type_name() != null) {
            if (Ora2rdb.getRealName(getRuleText(ctx.type_spec().type_name())).equals("SYS_REFCURSOR")){
                currentBlock.peek().addUnconvertableBlock(ctx.type_spec().type_name(), Ticket.SYS_REFCURSOR_REF_CURSOR_TYPE_DEF);
            }
        }

    }

    @Override
    public void enterType_spec(Type_specContext ctx) {

    }

    private Stack<String> labelLoopArea = new Stack<>();

    @Override
    public void enterLoop_statement(Loop_statementContext ctx) {

        if (ctx.label_declaration() != null) {
            labelLoopArea.push(Ora2rdb.getRealName(ctx.label_declaration().label_name().getText()));
        }
        if (ctx.FOR() != null) {
            UnconvertableBlock unconvertableBlock = new UnconvertableBlock();
            unconvertableBlock.setBlockStart(ctx.FOR().getSymbol());
            IteratorContext iterator = (IteratorContext) Ora2rdb.getFirstRuleContext(ctx, IteratorContext.class);
            if (iterator != null) {
                unconvertableBlock.setBlockStop(iterator.stop);
                if (iterator.iteration_control().size() >= 2)
                    unconvertableBlock.addTicketNumber(Ticket.FOR_WITH_SET_ITERATOR_CONTROLS);
                for (Iteration_controlContext iterationControl_ctx : iterator.iteration_control()) {
                    if (iterationControl_ctx.stepped_control() != null && iterationControl_ctx.stepped_control().BY() != null)
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_STEPPED_CONTROL);
                }


                Values_indices_pairs_of_controlContext values_indices_pairs_of_control =
                        (Values_indices_pairs_of_controlContext) Ora2rdb.getLastRuleContext(ctx, Values_indices_pairs_of_controlContext.class);
                if (values_indices_pairs_of_control != null) {
                    if (values_indices_pairs_of_control.VALUES() != null) {
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_VALUES_OF_CONTROL);
                        if (Ora2rdb.getFirstRuleContext(ctx, Pred_clause_seqContext.class) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_VALUES_OF_CONTROL);
                        if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_VALUES_OF_CONTROL);
                    } else if (values_indices_pairs_of_control.INDICES() != null) {
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_INDICES_OF_CONTROL);
                        if (Ora2rdb.getFirstRuleContext(ctx, Pred_clause_seqContext.class) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_INDICES_OF_CONTROL);
                        if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_INDICES_OF_CONTROL);
                    } else if (values_indices_pairs_of_control.PAIRS() != null) {
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_PAIRS_OF_CONTROL);
                        if (Ora2rdb.getFirstRuleContext(ctx, Pred_clause_seqContext.class) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_PAIRS_OF_CONTROL);
                        if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_PAIRS_OF_CONTROL);
                    }
                }
                Single_expression_controlContext single_expression_control =
                        (Single_expression_controlContext) Ora2rdb.getLastRuleContext(ctx, Single_expression_controlContext.class);
                if (single_expression_control != null) {
                    unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_SINGLE_EXPRESSION_CONTROL);
                    if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_SINGLE_EXPRESSION_CONTROL);
                }

                Stepped_controlContext steppedControl = (Stepped_controlContext) Ora2rdb.getFirstRuleContext(ctx, Stepped_controlContext.class);
                if (steppedControl != null) {
                    if (Ora2rdb.getFirstRuleContext(ctx, Pred_clause_seqContext.class) != null
                            || Ora2rdb.getFirstRuleContext(steppedControl.lower_bound(), General_element_partContext.class) != null
                            || Ora2rdb.getFirstRuleContext(steppedControl.upper_bound(), General_element_partContext.class) != null) {
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_STEPPED_CONTROL);
                    }
                    if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_STEPPED_CONTROL);
                }
            }
            Cursor_loop_paramContext cursorLoopParam = (Cursor_loop_paramContext) Ora2rdb.getFirstRuleContext(ctx, Cursor_loop_paramContext.class);
            if (cursorLoopParam != null) {
                unconvertableBlock.setBlockStop(cursorLoopParam.stop);
                if (cursorLoopParam.DOUBLE_PERIOD() != null) {
                    if (Ora2rdb.getFirstRuleContext(cursorLoopParam.lower_bound(), General_element_partContext.class) != null
                            || Ora2rdb.getFirstRuleContext(cursorLoopParam.upper_bound(), General_element_partContext.class) != null)
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_STEPPED_CONTROL);
                }
            }

            currentBlock.peek().addUnconvertableBlock(unconvertableBlock);
        }
    }

    @Override
    public void exitLoop_statement(Loop_statementContext ctx) {
        if (ctx.label_declaration() != null) {
            labelLoopArea.pop();
        }
    }

    @Override
    public void enterGeneral_element_part(General_element_partContext ctx) {
        if (labelLoopArea.empty())
            return;
        for (Id_expressionContext id : ctx.id_expression()) {
            if (Ora2rdb.getRealName(id.getText()).equals(labelLoopArea.peek()))
                currentBlock.peek().addUnconvertableBlock(ctx, Ticket.test);
        }
    }

}
