package ru.redsoft.ora2rdb.comments;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;
import ru.redsoft.ora2rdb.*;
import ru.redsoft.ora2rdb.PlSqlParser.*;
import ru.redsoft.ora2rdb.StorageInfo;

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
    public void enterCreate_table(Create_tableContext ctx) {
        currentBlock.push(new CommentedBlock(ctx));
    }

    @Override
    public void exitCreate_table(Create_tableContext ctx) {
        if (!currentBlock.peek().unconvertableBlocksIsEmpty())
            StorageInfo.commentedBlockList.add(currentBlock.pop());
        else
            currentBlock.pop();
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
        currentBlock.peek().addUnconvertableBlock(ctx, Ticket.FORALL_LOOP);
    }

    @Override
    public void enterFetch_statement(Fetch_statementContext ctx) {
        if (ctx.BULK() != null){
            currentBlock.peek().addUnconvertableBlock(ctx.BULK().getSymbol(), ctx.stop, Ticket.FETCH_BULK_COLLECT);
        }
    }

    @Override
    public void enterOpen_statement(Open_statementContext ctx) {
        General_element_partContext gp_ctx = Finder.getLastRuleContext(ctx, General_element_partContext.class);
        if (gp_ctx != null){
            if (gp_ctx.function_argument() != null){
                currentBlock.peek().addUnconvertableBlock(ctx, Ticket.OPEN_WITH_PARAM);
            }
        }
    }

    @Override
    public void enterOpen_for_statement(Open_for_statementContext ctx) {
        currentBlock.peek().addUnconvertableBlock(ctx, Ticket.OPEN_FOR_STATEMENT);
    }

    @Override
    public void enterType_declaration(Type_declarationContext ctx) {
        Table_type_defContext tableType = Finder.getFirstRuleContext(ctx, Table_type_defContext.class);
        if (tableType != null)
            associative_array_types.add(Ora2rdb.getRealName(ctx.identifier().getText()));


        Nested_table_type_defContext nestedTableType = (Nested_table_type_defContext) Finder.getFirstRuleContext(ctx, Nested_table_type_defContext.class);
        if (nestedTableType != null) {
            nested_array_types.add(Ora2rdb.getRealName(ctx.identifier().getText()));
            currentBlock.peek().addUnconvertableBlock(ctx, Ticket.NESTED_TABLE_TYPE_VARIABLE);
        }

        Varray_type_defContext varrayType = (Varray_type_defContext) Finder.getFirstRuleContext(ctx, Varray_type_defContext.class);
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
            General_element_partContext generalElementPart = Finder.getFirstRuleContext(ctx.default_value_part(), General_element_partContext.class);
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
            IteratorContext iterator = Finder.getFirstRuleContext(ctx, IteratorContext.class);
            if (iterator != null) {
                unconvertableBlock.setBlockStop(iterator.stop);
                if (iterator.iteration_control().size() >= 2)
                    unconvertableBlock.addTicketNumber(Ticket.FOR_WITH_SET_ITERATOR_CONTROLS);
                for (Iteration_controlContext iterationControl_ctx : iterator.iteration_control()) {
                    if (iterationControl_ctx.stepped_control() != null && iterationControl_ctx.stepped_control().BY() != null)
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_STEPPED_CONTROL);
                }


                Values_indices_pairs_of_controlContext values_indices_pairs_of_control = Finder.getLastRuleContext(ctx, Values_indices_pairs_of_controlContext.class);
                if (values_indices_pairs_of_control != null) {
                    if (values_indices_pairs_of_control.VALUES() != null) {
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_VALUES_OF_CONTROL);
                        if (Finder.getFirstRuleContext(ctx, Pred_clause_seqContext.class) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_VALUES_OF_CONTROL);
                        if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_VALUES_OF_CONTROL);
                    } else if (values_indices_pairs_of_control.INDICES() != null) {
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_INDICES_OF_CONTROL);
                        if (Finder.getFirstRuleContext(ctx, Pred_clause_seqContext.class) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_INDICES_OF_CONTROL);
                        if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_INDICES_OF_CONTROL);
                    } else if (values_indices_pairs_of_control.PAIRS() != null) {
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_PAIRS_OF_CONTROL);
                        if (Finder.getFirstRuleContext(ctx, Pred_clause_seqContext.class) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_PAIRS_OF_CONTROL);
                        if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                            unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_PAIRS_OF_CONTROL);
                    }
                }
                Single_expression_controlContext single_expression_control = Finder.getLastRuleContext(ctx, Single_expression_controlContext.class);
                if (single_expression_control != null) {
                    unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_SINGLE_EXPRESSION_CONTROL);
                    if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_SINGLE_EXPRESSION_CONTROL);
                }

                Stepped_controlContext steppedControl = Finder.getFirstRuleContext(ctx, Stepped_controlContext.class);
                if (steppedControl != null) {
                    if (Finder.getFirstRuleContext(ctx, Pred_clause_seqContext.class) != null
                            || Finder.getFirstRuleContext(steppedControl.lower_bound(), General_element_partContext.class) != null
                            || Finder.getFirstRuleContext(steppedControl.upper_bound(), General_element_partContext.class) != null) {
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_STEPPED_CONTROL);
                    }
                    if (iterator.IMMUTABLE(0) != null || iterator.MUTABLE(0) != null)
                        unconvertableBlock.addTicketNumber(Ticket.FOR_LOOP_STEPPED_CONTROL);
                }
            }
            Cursor_loop_paramContext cursorLoopParam = Finder.getFirstRuleContext(ctx, Cursor_loop_paramContext.class);
            if (cursorLoopParam != null) {
                unconvertableBlock.setBlockStop(cursorLoopParam.stop);
                if (cursorLoopParam.DOUBLE_PERIOD() != null) {
                    if (Finder.getFirstRuleContext(cursorLoopParam.lower_bound(), General_element_partContext.class) != null
                            || Finder.getFirstRuleContext(cursorLoopParam.upper_bound(), General_element_partContext.class) != null)
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


    //The markup of DML constructions begins

    @Override
    public void enterData_manipulation_language_statements(Data_manipulation_language_statementsContext ctx) {
        if(Finder.getParentRuleContext(ctx, Sql_statementContext.class) == null){
            currentBlock.push(new CommentedBlock(ctx, true));
        }
    }



    @Override
    public void exitData_manipulation_language_statements(Data_manipulation_language_statementsContext ctx) {
        if(Finder.getParentRuleContext(ctx, Sql_statementContext.class) == null){
            if (!currentBlock.peek().unconvertableBlocksIsEmpty())
                StorageInfo.commentedBlockList.add(currentBlock.pop());
            else
                currentBlock.pop();
        }
    }

    @Override
    public void enterMerge_statement(PlSqlParser.Merge_statementContext ctx) { }

    @Override
    public void enterSelect_statement(Select_statementContext ctx) {
        //markup select_for_update
        For_update_clauseContext forUpdateClause = Finder.getFirstRuleContext(ctx, For_update_clauseContext.class);
        if(forUpdateClause != null)
            currentBlock.peek().addUnconvertableBlock(forUpdateClause, Ticket.SELECT_FOR_UPDATE);


        //markup cross apply, SELECT_QUERY_PARTITION
        Join_clauseContext joinClause = Finder.getFirstRuleContext(ctx, Join_clauseContext.class);
        if(joinClause != null) {
            //markup cross apply
            if (joinClause.APPLY() != null)
                currentBlock.peek().addUnconvertableBlock(joinClause, Ticket.SELECT_CROSS_APPLY);

            //markup SELECT_QUERY_PARTITION
            for (Query_partition_clauseContext queryPartitionClause : joinClause.query_partition_clause()) {
                currentBlock.peek().addUnconvertableBlock(queryPartitionClause, Ticket.SELECT_QUERY_PARTITION);
            }
        }

        //markup SELECT_ANALYTIC_VIEW
        Subav_factoring_clauseContext subavFactoringClause = Finder.getFirstRuleContext(ctx, Subav_factoring_clauseContext.class);
        if(subavFactoringClause != null){
            currentBlock.peek().addUnconvertableBlock(subavFactoringClause, Ticket.SELECT_ANALYTIC_VIEW);
        }

        //markup SELECT_FLASHBACK_QUERY
        Flashback_query_clauseContext flashbackQueryClause = Finder.getFirstRuleContext(ctx, Flashback_query_clauseContext.class);
        if(flashbackQueryClause != null && flashbackQueryClause.VERSIONS() == null){
            currentBlock.peek().addUnconvertableBlock(flashbackQueryClause, Ticket.SELECT_FLASHBACK_QUERY);
        }

        //markup SELECT_HIERARCHIES
        Finder.getAllRuleContexts(ctx, Hierarchies_clauseContext.class).forEach(hierarchiesClause ->
                currentBlock.peek().addUnconvertableBlock(hierarchiesClause, Ticket.SELECT_HIERARCHIES));

        //markup SELECT_HIERARCHIES
        List<Dml_table_expression_clauseContext> dmlTableExpressionClauseList = Finder.getAllRuleContexts(ctx, Dml_table_expression_clauseContext.class);
        for(Dml_table_expression_clauseContext dmlTableExpressionClause : dmlTableExpressionClauseList) {
            if (dmlTableExpressionClause.LATERAL() != null)
                currentBlock.peek().addUnconvertableBlock(dmlTableExpressionClause, Ticket.SELECT_LATERAL_ATTRIBUTE);
        }

        //markup SELECT_TABLE_COLLECTION
        Table_collection_expressionContext tableCollectionExpression = Finder.getFirstRuleContext(ctx, Table_collection_expressionContext.class);
        if(tableCollectionExpression != null){
            currentBlock.peek().addUnconvertableBlock(tableCollectionExpression, Ticket.SELECT_TABLE_COLLECTION);
        }

        //markup SELECT_PIVOT_CLAUSE
        Pivot_clauseContext pivotClause = Finder.getFirstRuleContext(ctx, Pivot_clauseContext.class);
        if(pivotClause != null){
            currentBlock.peek().addUnconvertableBlock(pivotClause, Ticket.SELECT_PIVOT_CLAUSE);
        }

        //markup SELECT_UNPIVOT_CLAUSE
        Unpivot_clauseContext unpivotClause = Finder.getFirstRuleContext(ctx, Unpivot_clauseContext.class);
        if(unpivotClause != null){
            currentBlock.peek().addUnconvertableBlock(unpivotClause, Ticket.SELECT_UNPIVOT_CLAUSE);
        }

        Rollup_cube_clauseContext rollupCubeClause = Finder.getFirstRuleContext(ctx, Rollup_cube_clauseContext.class);
        if(rollupCubeClause != null){
            //markup SELECT_GROUP_BY_CUBE
            if(rollupCubeClause.CUBE() != null)
                currentBlock.peek().addUnconvertableBlock(rollupCubeClause, Ticket.SELECT_GROUP_BY_CUBE);
            //markup SELECT_GROUP_BY_ROLLUP
            if(rollupCubeClause.ROLLUP() != null)
                currentBlock.peek().addUnconvertableBlock(rollupCubeClause, Ticket.SELECT_GROUP_BY_ROLLUP);
        }
        //markup SELECT_ROW_PATTERN
        Row_pattern_clauseContext rowPatternClause = Finder.getFirstRuleContext(ctx, Row_pattern_clauseContext.class);
        if(rowPatternClause != null){
            currentBlock.peek().addUnconvertableBlock(rowPatternClause, Ticket.SELECT_ROW_PATTERN);
        }

        Finder.getAllRuleContexts(ctx, Fetch_clauseContext.class).stream()
                .filter(fetchClause -> fetchClause.PERCENT_KEYWORD() != null)
                .forEach(fetchClause -> currentBlock.peek().addUnconvertableBlock(fetchClause.PERCENT_KEYWORD(), Ticket.SELECT_PERCENT_KEYWORD));

        List<Subquery_operation_partContext> subqueryOperationPartList = Finder.getAllRuleContexts(ctx, Subquery_operation_partContext.class);
        for(Subquery_operation_partContext subqueryOperationPart : subqueryOperationPartList){
            if(subqueryOperationPart.EXCEPT() != null)
                currentBlock.peek().addUnconvertableBlock(subqueryOperationPart.EXCEPT(), Ticket.SELECT_SET_OPERATOR_EXCEPT);
            else if(subqueryOperationPart.MINUS() != null)
                currentBlock.peek().addUnconvertableBlock(subqueryOperationPart.MINUS(), Ticket.SELECT_SET_OPERATOR_MINUS);
            else if(subqueryOperationPart.INTERSECT() != null)
                currentBlock.peek().addUnconvertableBlock(subqueryOperationPart.INTERSECT(), Ticket.SELECT_SET_OPERATOR_INTERSECT);
        }

        Finder.getAllRuleContexts(ctx, Search_clauseContext.class)
                .forEach(searchClauseList -> currentBlock.peek().addUnconvertableBlock(searchClauseList, Ticket.SELECT_WITH_CLAUSE_SEARCH));




    }

    @Override
    public void enterSelect_only_statement(Select_only_statementContext ctx) {

        //markup SELECT_PIVOT_CLAUSE
        Pivot_clauseContext pivotClause = Finder.getFirstRuleContext(ctx, Pivot_clauseContext.class);
        if(pivotClause != null){
            currentBlock.peek().addUnconvertableBlock(pivotClause, Ticket.SELECT_PIVOT_CLAUSE);
        }
    }

    @Override
    public void enterInsert_statement(Insert_statementContext ctx) {
        Multi_table_insertContext multiTableInsert = Finder.getFirstRuleContext(ctx, Multi_table_insertContext.class);
        if (multiTableInsert != null && multiTableInsert.ALL() != null)
                currentBlock.peek().addUnconvertableBlock(
                        multiTableInsert.start,
                        Finder.getLastRuleContext(ctx, Multi_table_elementContext.class).stop,
                        Ticket.INSERT_MULTI_TABLE_ALL
                );

        Conditional_insert_clauseContext conditionalInsertClause = Finder.getFirstRuleContext(ctx, Conditional_insert_clauseContext.class);
        if(conditionalInsertClause != null){
            if(conditionalInsertClause.ALL() != null)
                currentBlock.peek().addUnconvertableBlock(conditionalInsertClause, Ticket.INSERT_CONDITION_ALL);
            else if(conditionalInsertClause.FIRST() != null)
                currentBlock.peek().addUnconvertableBlock(conditionalInsertClause, Ticket.INSERT_CONDITION_FIRST);
            else
                currentBlock.peek().addUnconvertableBlock(conditionalInsertClause, Ticket.INSERT_CONDITION_ALL);
        }

        Error_logging_clauseContext errorLoggingClause = Finder.getFirstRuleContext(ctx, Error_logging_clauseContext.class);
        if(errorLoggingClause != null)
            currentBlock.peek().addUnconvertableBlock(errorLoggingClause, Ticket.INSERT_ERROR_LOGGING);

        General_table_refContext generalTableRef = Finder.getFirstRuleContext(ctx, General_table_refContext.class);
        if(generalTableRef != null && Finder.getFirstRuleContext(generalTableRef, Query_blockContext.class) != null){
            currentBlock.peek().addUnconvertableBlock(generalTableRef, Ticket.INSERT_INTO_SELECT);
        }
    }

    @Override
    public void enterUpdate_statement(Update_statementContext ctx) { }

    @Override
    public void enterDelete_statement(Delete_statementContext ctx) { }

    @Override
    public void enterExplain_statement(Explain_statementContext ctx) { }

    @Override
    public void enterLock_table_statement(Lock_table_statementContext ctx) { }

}
