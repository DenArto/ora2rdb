package ru.redsoft.ora2rdb;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;
import ru.redsoft.ora2rdb.PlSqlParser.*;

import java.util.*;
import java.util.stream.Collectors;

public class RewritingListener extends PlSqlParserBaseListener {

    static final int SPACES_TYPE = PlSqlLexer.SPACES;

    TokenStreamRewriter rewriter;
    CommonTokenStream tokens;

    Stack<StoredBlock> storedBlocksStack = new Stack<>();
    String current_package_name = null;

    View current_view;
    PLSQLBlock current_plsql_block;

    ArrayList<Create_sequenceContext> sequences = new ArrayList<Create_sequenceContext>();
    ArrayList<Create_tableContext> tables = new ArrayList<Create_tableContext>();
    ArrayList<Comment_on_tableContext> comments = new ArrayList<Comment_on_tableContext>();
    ArrayList<Alter_tableContext> alter_tables = new ArrayList<Alter_tableContext>();
    ArrayList<Create_indexContext> create_indexes = new ArrayList<Create_indexContext>();
    ArrayList<Create_function_bodyContext> create_functions = new ArrayList<Create_function_bodyContext>();
    ArrayList<Create_procedure_bodyContext> create_procedures = new ArrayList<Create_procedure_bodyContext>();
    ArrayList<Create_triggerContext> create_triggers = new ArrayList<Create_triggerContext>();
    ArrayList<Alter_triggerContext> alter_triggers = new ArrayList<Alter_triggerContext>();

    ArrayList<String> create_temporary_tables = new ArrayList<String>();
    ArrayList<String> loop_index_names = new ArrayList<String>();
    TreeMap<String, String> loop_rec_name_and_cursor_name = new TreeMap<>();
    TreeMap<String, String> rowtype_rec_name_and_select_statement = new TreeMap<>();
    TreeMap<String, String> loop_for_in_collection = new TreeMap<>();
    TreeMap<String, String> exceptions = new TreeMap<>();
    StoredAnonymousBlock currentAnonymousBlock = null;

    public RewritingListener(CommonTokenStream tokens, TokenStreamRewriter rewriter) {
        this.rewriter = rewriter;
        this.tokens = tokens;
    }

    public String getText() {
        StringBuilder out = new StringBuilder();

        for (Map.Entry<String, String> entry : exceptions.entrySet())
            out.append("CREATE EXCEPTION ").append(entry.getKey())
                    .append("\n\t'").append(entry.getValue()).append("';\n");

        for (Create_sequenceContext sequence : sequences)
            out.append(getRewriterText(sequence)).append("\n\n");

        for (Create_tableContext table : tables)
            out.append(getRewriterText(table)).append("\n\n");

        ArrayList<View> views = View.sort(StorageInfo.views.values());

        for (View view : views)
            out.append(getRewriterText(view.ctx)).append("\n\n");

        for (Comment_on_tableContext comment : comments)
            out.append(getRewriterText(comment)).append(";").append("\n\n");

        for (Alter_tableContext alter_table : alter_tables)
            out.append(getRewriterText(alter_table)).append("\n\n");

        for (Create_indexContext create_index : create_indexes)
            out.append(getRewriterText(create_index)).append("\n\n");

        for (String create_temporary_table : create_temporary_tables)
            out.append(create_temporary_table);

        for (Create_function_bodyContext create_function : create_functions)
            out.append(getRewriterText(create_function)).append("\n\n");

        for (Create_procedure_bodyContext create_procedure : create_procedures)
            out.append(getRewriterText(create_procedure)).append("\n\n");

        for (Create_triggerContext create_trigger : create_triggers)
            out.append(getRewriterText(create_trigger)).append("\n\n");

        for (Alter_triggerContext alter_trigger : alter_triggers)
            out.append(getRewriterText(alter_trigger)).append("\n\n");

        return out.toString();
    }

    void insertBefore(ParserRuleContext ctx, Object text) {
        if (ctx != null)
            rewriter.insertBefore(ctx.start, text);
    }

    void insertBefore(TerminalNode term, Object text) {
        if (term != null)
            rewriter.insertBefore(term.getSymbol(), text);
    }

    void insertBefore(Token token, Object text) {
        if (token != null)
            rewriter.insertBefore(token, text);
    }

    void insertAfter(ParserRuleContext ctx, Object text) {
        if (ctx != null)
            rewriter.insertAfter(ctx.stop, text);
    }

    void insertAfter(TerminalNode term, Object text) {
        if (term != null)
            rewriter.insertAfter(term.getSymbol(), text);
    }

    void insertAfter(Token token, Object text) {
        if (token != null)
            rewriter.insertAfter(token, text);
    }

    void replace(ParserRuleContext ctx, Object text) {
        if (ctx != null)
            rewriter.replace(ctx.start, ctx.stop, text);
    }

    void replace(TerminalNode term, Object text) {
        if (term != null)
            rewriter.replace(term.getSymbol(), text);
    }

    void replace(List<? extends ParserRuleContext> ctx_list, Object text) {
        if (!ctx_list.isEmpty())
            rewriter.replace(ctx_list.get(0).start, ctx_list.get(ctx_list.size() - 1).stop, text);
    }

    void delete(ParserRuleContext ctx) {
        if (ctx != null)
            rewriter.delete(ctx.start, ctx.stop);
    }

    void delete(TerminalNode term) {
        if (term != null)
            rewriter.delete(term.getSymbol());
    }

    void delete(Token token) {
        if (token != null)
            rewriter.delete(token);
    }

    void delete(List<? extends ParserRuleContext> ctx_list) {
        if (!ctx_list.isEmpty())
            rewriter.delete(ctx_list.get(0).start, ctx_list.get(ctx_list.size() - 1).stop);
    }

    Token getPreviousToken(Token token) {
        if (token != null) {
            int tokenIndex = token.getTokenIndex();
            if (tokenIndex == 0) return null;
            return tokens.get(tokenIndex - 1);
        }
        return null;
    }

    Token getNextToken(Token token) {
        if (token != null) {
            int tokenIndex = token.getTokenIndex();
            if (tokens.size() <= tokenIndex) return null;
            return tokens.get(tokenIndex + 1);
        }
        return null;
    }

    void deleteSPACESLeft(Token token) {
        if (token != null && token.getType() == SPACES_TYPE) {
            rewriter.delete(token);
            deleteSPACESLeft(getPreviousToken(token));
        }
    }

    void deleteSPACESLeft(ParserRuleContext ctx) {
        if (ctx != null)
            deleteSPACESLeft(getPreviousToken(ctx.start));
    }

    void deleteSPACESLeft(TerminalNode term) {
        if (term != null)
            deleteSPACESLeft(getPreviousToken(term.getSymbol()));
    }

    void deleteSPACESRight(Token token) {
        if (token != null && token.getType() == SPACES_TYPE) {
            rewriter.delete(token);
            deleteSPACESRight(getNextToken(token));
        }
    }

    void deleteSPACESRight(ParserRuleContext ctx) {
        if (ctx != null) {
            deleteSPACESRight(getNextToken(ctx.stop));
        }
    }

    void deleteSPACESRight(TerminalNode term) {
        if (term != null)
            deleteSPACESRight(getPreviousToken(term.getSymbol()));
    }

    void deleteSPACESAbut(ParserRuleContext ctx) {
        if (ctx != null) {
            deleteSPACESLeft(getPreviousToken(ctx.start));
            deleteSPACESRight(getNextToken(ctx.stop));
        }
    }

    void deleteSPACESAbut(TerminalNode term) {
        if (term != null) {
            deleteSPACESLeft(getPreviousToken(term.getSymbol()));
            deleteSPACESRight(getNextToken(term.getSymbol()));
        }
    }

    void deleteSemicolonRight(Token token) {
        if (token == null) return;
        if (token.getType() == PlSqlLexer.SEMICOLON) {
            rewriter.delete(token);
        } else {
            Token nextToken = getNextToken(token);
            if (nextToken != null && nextToken.getType() == PlSqlLexer.SEMICOLON)
                rewriter.delete(nextToken);
        }
    }

    void deleteSemicolonRight(TerminalNode term) {
        if (term != null)
            deleteSemicolonRight(getNextToken(term.getSymbol()));
    }

    void deleteSemicolonRight(ParserRuleContext ctx) {
        if (ctx != null) {
            deleteSemicolonRight(getNextToken(ctx.stop));
        }
    }


    void deleteSemicolonLeft(Token token) {
        if (token == null) return;
        if (token.getType() == PlSqlLexer.SEMICOLON) {
            rewriter.delete(token);
        } else {
            Token previousToken = getPreviousToken(token);
            if (previousToken != null && previousToken.getType() == PlSqlLexer.SEMICOLON)
                rewriter.delete(previousToken);
        }
    }

    void deleteSemicolonLeft(TerminalNode term) {
        if (term != null)
            deleteSemicolonLeft(getPreviousToken(term.getSymbol()));
    }

    void deleteSemicolonLeft(ParserRuleContext ctx) {
        if (ctx != null) {
            deleteSemicolonLeft(getPreviousToken(ctx.start));
        }
    }

    void commentBlock(int start_tok_idx, int stop_tok_idx) {
        rewriter.insertBefore(start_tok_idx, "--");
//        rewriter.insertAfter(stop_tok_idx, "*/");

        List<Token> multi_line_comments = tokens.getTokens(start_tok_idx, stop_tok_idx, PlSqlLexer.MULTI_LINE_COMMENT);

        if (multi_line_comments != null)
            for (Token tok : multi_line_comments)
                rewriter.delete(tok);
    }

    String getIndentation(ParserRuleContext ctx) {
        Integer tok_idx = ctx.start.getTokenIndex();

        if (tok_idx > 0) {
            List<Token> spc_tok_list = tokens.getTokens(tok_idx - 1, tok_idx, PlSqlLexer.SPACES);

            if (spc_tok_list != null) {
                String spc = spc_tok_list.get(0).getText();
                Integer idx1 = spc.lastIndexOf('\r');
                Integer idx2 = spc.lastIndexOf('\n');
                return spc.substring((idx1 > idx2 ? idx1 : idx2) + 1);
            }
        }
        return "";
    }

    String getRuleText(RuleContext ctx) {
        return tokens.getText(ctx);
    }

    String getRewriterText(ParserRuleContext ctx) {
        return rewriter.getText(ctx.getSourceInterval());
    }

    void pushScope() {
        if (current_plsql_block == null)
            current_plsql_block = new PLSQLBlock();
        else
            current_plsql_block.pushScope();
    }

    void popScope() {
        if (current_plsql_block.scopes.size() == 1)
            current_plsql_block = null;
        else
            current_plsql_block.popScope();
    }


    @Override
    public void exitSql_script(Sql_scriptContext ctx) {
        for (TerminalNode solid : ctx.SOLIDUS())
            delete(solid);
        if (!Ora2rdb.reorder)
            for (Map.Entry<String, String> entry : exceptions.entrySet())
                insertBefore(ctx, "CREATE EXCEPTION " + entry.getKey() + "\n\t" + "'" + entry.getValue() + "';" + "\n");
    }

    @Override
    public void exitSet_command(Set_commandContext ctx) {
        delete(ctx);
    }

    @Override
    public void exitRelational_table(Relational_tableContext ctx) {
        deleteSPACESAbut(ctx.physical_properties());
        if (!ctx.table_properties().isEmpty())
            delete(ctx.table_properties().column_properties());
        delete(ctx.physical_properties());
    }


    private void convertRelationTable(Create_tableContext ctx) {
        String table_name;
        table_name = Ora2rdb.getRealName(getRuleText(ctx.schema_and_name().name));

        if (StorageInfo.table_not_null_cols.containsKey(table_name)) {
            TreeSet<String> columns_set = StorageInfo.table_not_null_cols.get(table_name);

            if (ctx.relational_table() != null) {
                Relational_tableContext relational_tableContext = ctx.relational_table();

                for (Relational_propertyContext rel_prop_ctx : relational_tableContext.relational_property()) {

                    Column_definitionContext col_def_ctx = rel_prop_ctx.column_definition();
                    if (col_def_ctx != null) {
                        String column_name = Ora2rdb.getRealName(getRuleText(col_def_ctx.column_name()));

                        if (columns_set.contains(column_name)) {
                            boolean not_null = false;

                            for (Inline_constraintContext inl_con_ctx : col_def_ctx.inline_constraint()) {
                                if (inl_con_ctx.NOT() != null) {
                                    not_null = true;
                                    break;
                                }
                            }

                            if (!not_null)
                                insertAfter(col_def_ctx, " NOT NULL");
                        }
                    }

                    if (rel_prop_ctx.out_of_line_constraint() != null) {
                        delete(rel_prop_ctx);
                        deleteSPACESLeft(rel_prop_ctx);
                        delete(relational_tableContext.COMMA(relational_tableContext.COMMA().size() - 1));
                    }
                }
            }
        }

        tables.add(ctx);
        if (StorageInfo.types_of_column.containsKey(table_name)) {
            if (ctx.relational_table() != null) {
                Relational_tableContext relational_table = ctx.relational_table();
                for (Relational_propertyContext property : relational_table.relational_property()) {
                    if (property.column_definition() != null) {
                        Column_definitionContext columnDefinition = property.column_definition();
                        String column_name = Ora2rdb.getRealName(columnDefinition.column_name().getText());
                        String column_type = getRewriterText(columnDefinition.datatype());
                        if (StorageInfo.types_of_column.get(table_name).containsKey(column_name)) {
                            StorageInfo.types_of_column.get(table_name).put(column_name, column_type);
                        }
                    }
                }
            }
        }
        delete(ctx.table_sharing_clause());
    }

    @Override
    public void exitCreate_table(Create_tableContext ctx) {
        if (ctx.relational_table() != null)
            convertRelationTable(ctx);
    }

    @Override
    public void exitTable_properties(Table_propertiesContext ctx){
        delete(ctx.parallel_clause());
        delete(ctx.CACHE());
        delete(ctx.NOCACHE());
    }

    @Override
    public void exitRelational_property(PlSqlParser.Relational_propertyContext ctx) {
        if (ctx.column_definition() != null){
            Column_definitionContext columnDefinition = ctx.column_definition();
            Constraint_stateContext context = Finder.getFirstRuleContext(columnDefinition, Constraint_stateContext.class);
            if(context != null){
                delete(context.ENABLE(0));
            }


        }
        else if (ctx.virtual_column_definition() != null){
            Virtual_column_definitionContext virtualColumnDefinition = ctx.virtual_column_definition();
            delete(virtualColumnDefinition.VIRTUAL());
//            Autogenerated_sequence_definitionContext context = Finder.getFirstRuleContext(virtualColumnDefinition, Autogenerated_sequence_definitionContext.class);
        }

    }

    @Override
    public void exitColumn_definition(Column_definitionContext ctx) {
        if (ctx != null)
            if (ctx.datatype() != null)
                if (ctx.datatype().native_datatype_element() != null)
                    if (ctx.datatype().native_datatype_element().RAW() != null)
                        replace(ctx, ctx.column_name().getText() + " BLOB ");
    }

    @Override
    public void exitDatatype(DatatypeContext ctx) {
        if (ctx.native_datatype_element() != null) {
            if (ctx.native_datatype_element().NUMBER() != null) {
                if (ctx.precision_part() != null)
                    replace(ctx.precision_part().ASTERISK(), "34");
                else
                    replace(ctx, getRewriterText(ctx) + "(34, 8)");
            } else if (ctx.native_datatype_element().FLOAT() != null) {
//                if (ctx.precision_part() != null)
                replace(ctx, "DOUBLE PRECISION");
            } else if (ctx.native_datatype_element().TIMESTAMP() != null) {
                delete(ctx.precision_part());
            } else if (ctx.native_datatype_element().VARCHAR2() != null ||
                    ctx.native_datatype_element().VARCHAR() != null) {
                if (ctx.precision_part() == null)
                    replace(ctx, getRewriterText(ctx) + "(32765)");
            } else if (ctx.native_datatype_element().NUMERIC() != null) {
                if (ctx.precision_part() == null)
                    replace(ctx, getRewriterText(ctx) + "(34, 8)");
            }
        }
    }

    @Override
    public void exitPrecision_part(Precision_partContext ctx) {
        delete(ctx.BYTE());
        delete(ctx.CHAR());
    }

    @Override
    public void exitNative_datatype_element(Native_datatype_elementContext ctx) {
        if (ctx.VARCHAR2() != null || ctx.NVARCHAR2() != null)
            replace(ctx, "VARCHAR");
        else if (ctx.CLOB() != null)
            replace(ctx, "BLOB SUB_TYPE TEXT");
        else if (ctx.NUMBER() != null)
            replace(ctx, "NUMERIC");
        else if (ctx.BINARY_FLOAT() != null)
            replace(ctx, "FLOAT");
        else if (ctx.BINARY_DOUBLE() != null)
            replace(ctx, "DOUBLE PRECISION");
        else if (ctx.NCHAR() != null)
            replace(ctx, "CHAR");
        else if (ctx.BINARY_INTEGER() != null)
            replace(ctx, "INTEGER");
        else if (ctx.ROWID() != null)
            replace(ctx, "BINARY(8)");
        else if (ctx.PLS_INTEGER() != null)
            replace(ctx.PLS_INTEGER(), "INTEGER");
    }
    @Override
    public void exitJson_return_clause(Json_return_clauseContext ctx){
        delete(ctx.BYTE());
        delete(ctx.CHAR());
        if (ctx.VARCHAR2() != null) {
            replace(ctx.VARCHAR2(), "VARCHAR");
            if (ctx.UNSIGNED_INTEGER() == null)
                insertAfter(ctx.VARCHAR2(), "(4000)");

        }
        else if(ctx.CLOB() != null)
            replace(ctx.CLOB(), "BLOB SUB_TYPE TEXT");
    }

    @Override
    public void exitComment_on_column(Comment_on_columnContext ctx) {
        if (ctx.column_name() != null) {
            Column_nameContext column_nameContext = ctx.column_name();
            if (column_nameContext.identifier() != null) {
                delete(column_nameContext.identifier());
                delete(column_nameContext.PERIOD(0));
            }
        }
    }

    @Override
    public void exitTableview_name(Tableview_nameContext ctx) {
        deleteSPACESLeft(ctx.start);
        String getSystemTableName = convertSystemTable(Ora2rdb.getRealName(ctx.schema_and_name().name.getText()));
        if (getSystemTableName != null) {
            replace(ctx, getSystemTableName);
        }
    }

    @Override
    public void exitOut_of_line_constraint(Out_of_line_constraintContext ctx) {
        delete(ctx.constraint_state());
    }

    @Override
    public void exitAlter_table(Alter_tableContext ctx) {
        if (ctx.constraint_clauses() != null) {
            Constraint_clausesContext constraintClausesContext = ctx.constraint_clauses();
            if (!constraintClausesContext.out_of_line_constraint().isEmpty()) {
                Out_of_line_constraintContext out_of_line_constraintContext = constraintClausesContext.out_of_line_constraint(0);
                if (out_of_line_constraintContext.constraint_state() != null && out_of_line_constraintContext.constraint_state().ENABLE(0) != null) {
                    delete(out_of_line_constraintContext.constraint_state());
                }
            }
        }
        Constraint_clausesContext constraint_clauses_ctx = ctx.constraint_clauses();
        Column_clausesContext column_clauses_ctx = ctx.column_clauses();

        if (constraint_clauses_ctx != null) {
            if (!constraint_clauses_ctx.out_of_line_constraint().isEmpty()) {
                Constraint_stateContext constraint_state_ctx = constraint_clauses_ctx.out_of_line_constraint(0).constraint_state();
                delete(constraint_state_ctx);
            }
        } else if (column_clauses_ctx != null) {

            Add_modify_drop_column_clausesContext add_modify_drop_column_clausesContext = column_clauses_ctx.add_modify_drop_column_clauses();
            if (add_modify_drop_column_clausesContext != null) {
                Modify_column_clausesContext modify_column_clauses_ctx = add_modify_drop_column_clausesContext.modify_column_clauses(0);

                if (!modify_column_clauses_ctx.modify_col_properties().isEmpty()) {
                    Modify_col_propertiesContext modify_col_properties_ctx = modify_column_clauses_ctx.modify_col_properties(0);

                    if (!modify_col_properties_ctx.inline_constraint().isEmpty()) {
                        if (modify_col_properties_ctx.inline_constraint(0).NULL_() != null) {
                            delete(ctx);
                            return;
                        }
                    }
                }
            }
        }

        alter_tables.add(ctx);
    }

    @Override
    public void exitString_function(String_functionContext ctx) {
        if (ctx.SUBSTR() != null) {
            replace(ctx.SUBSTR(), "SUBSTRING");
            replace(ctx.COMMA(0), " FROM ");
            if (ctx.COMMA(1) != null)
                replace(ctx.COMMA(1), " FOR ");

        }
    }

    @Override
    public void exitSchema_and_name(Schema_and_nameContext ctx) {
        delete(ctx.schema);
        delete(ctx.PERIOD());
    }

    private StoredBlock findFunctionCall(Call_statementContext ctx) {
        FinderBlockCall finder = new FinderBlockCall();
        if (ctx.routine_name(0).id_expression(0) != null) {
            finder.setName(Ora2rdb.getRealName(ctx.routine_name(0).id_expression(0).getText()));
            finder.setPackage_name(Ora2rdb.getRealName(ctx.routine_name(0).identifier().getText()));
        } else {
            finder.setName(Ora2rdb.getRealName(ctx.routine_name(0).identifier().getText()));
            finder.setPackage_name(null);
        }
        finder.setArea_package_name(current_package_name);
        if (ctx.function_argument(0) != null && !storedBlocksStack.isEmpty()) {
            String arg_name;
            for (int i = 0; i < ctx.function_argument(0).argument().size(); i++) {
                arg_name = Ora2rdb.getRealParameterName(ctx.function_argument(0).argument(i).getText());
                finder.setParameters(
                        i,
                        arg_name,
                        storedBlocksStack.peek().getParamType(arg_name)
                );
            }
        }
        // for anonymous block
        if (currentAnonymousBlock != null)
            if (!currentAnonymousBlock.getIsNested() && ctx.function_argument(0) != null) {
                String arg_name;
                for (int i = 0; i < ctx.function_argument(0).argument().size(); i++) {
                    arg_name = Ora2rdb.getRealParameterName(ctx.function_argument(0).argument(i).getText());
                    finder.setParameters(
                            i,
                            arg_name,
                            currentAnonymousBlock.getParamType(arg_name)
                    );
                }
            }

        StoredBlock storedBlock;
        if (!storedBlocksStack.isEmpty()) {
            List<StoredBlock> tempList = storedBlocksStack.peek().getChildren().stream()
                    .filter(e -> e.equalsIgnoreParent(finder, true)).collect(Collectors.toList());
            if (tempList.size() > 1)
                tempList.stream().filter(e -> e.equalsIgnoreParent(finder, false))
                        .findFirst().ifPresent(child -> finder.setParent(child.getParent()));
            else if (!tempList.isEmpty())
                finder.setParent(tempList.get(0).getParent());


            tempList = storedBlocksStack.peek().getCalledStorageBlocks().stream()
                    .filter(e -> e.equal(finder, true))
                    .collect(Collectors.toList());
            if (tempList.size() > 1)
                storedBlock = tempList.stream().filter(e -> e.equal(finder, false))
                        .findFirst().orElse(null);
            else
                storedBlock = tempList.stream().findFirst().orElse(null);
        } else {
            List<StoredBlock> tempList = StorageInfo.stored_blocks_list.stream()
                    .filter(e -> e.getPackage_name() != null)
                    .filter(e -> e.equal(finder, true))
                    .collect(Collectors.toList());
            if (tempList.size() > 1)
                storedBlock = tempList.stream().filter(e -> e.equal(finder, false))
                        .findFirst().orElse(null);
            else
                storedBlock = tempList.stream().findFirst().orElse(null);

            if (storedBlock == null) {
                tempList = StorageInfo.stored_blocks_list.stream()
                        .filter(e -> e.equal(finder, true))
                        .collect(Collectors.toList());
                if (tempList.size() > 1)
                    storedBlock = tempList.stream().filter(e -> e.equal(finder, false))
                            .findFirst().orElse(null);
                else
                    storedBlock = tempList.stream().findFirst().orElse(null);
            }
        }
        return storedBlock;
    }

    private StoredBlock findFunctionCall(General_element_partContext ctx) {
        FinderBlockCall finder = new FinderBlockCall();
        if (!ctx.PERIOD().isEmpty()) {
            finder.setName(Ora2rdb.getRealName(ctx.id_expression(1).getText()));
            finder.setPackage_name(Ora2rdb.getRealName(ctx.id_expression(0).getText()));
        } else {
            finder.setName(Ora2rdb.getRealName(ctx.id_expression(0).getText()));
            finder.setPackage_name(null);
        }
        finder.setArea_package_name(current_package_name);
        if (ctx.function_argument() != null && !storedBlocksStack.isEmpty()) {
            String arg_name;
            for (int i = 0; i < ctx.function_argument().argument().size(); i++) {
                arg_name = Ora2rdb.getRealParameterName(ctx.function_argument().argument(i).getText());
                finder.setParameters(
                        i,
                        arg_name,
                        storedBlocksStack.peek().getParamType(arg_name)
                );
            }
        }

        // for anonymous block
        if (currentAnonymousBlock != null)
            if (!currentAnonymousBlock.getIsNested() && ctx.function_argument() != null) {
                String arg_name;
                for (int i = 0; i < ctx.function_argument().argument().size(); i++) {
                    arg_name = Ora2rdb.getRealParameterName(ctx.function_argument().argument(i).getText());
                    finder.setParameters(
                            i,
                            arg_name,
                            currentAnonymousBlock.getParamType(arg_name)
                    );
                }
            }

        StoredBlock storedBlock;
        if (!storedBlocksStack.isEmpty()) {
            List<StoredBlock> tempList = storedBlocksStack.peek().getChildren().stream()
                    .filter(e -> e.equalsIgnoreParent(finder, true)).collect(Collectors.toList());
            if (tempList.size() > 1)
                tempList.stream().filter(e -> e.equalsIgnoreParent(finder, false))
                        .findFirst().ifPresent(child -> finder.setParent(child.getParent()));
            else if (!tempList.isEmpty())
                finder.setParent(tempList.get(0).getParent());


            tempList = storedBlocksStack.peek().getCalledStorageBlocks().stream()
                    .filter(e -> e.equal(finder, true))
                    .collect(Collectors.toList());
            if (tempList.size() > 1)
                storedBlock = tempList.stream().filter(e -> e.equal(finder, false))
                        .findFirst().orElse(null);
            else
                storedBlock = tempList.stream().findFirst().orElse(null);
        } else {
            List<StoredBlock> tempList = StorageInfo.stored_blocks_list.stream()
                    .filter(e -> e.getPackage_name() != null)
                    .filter(e -> e.equal(finder, true))
                    .collect(Collectors.toList());
            if (tempList.size() > 1)
                storedBlock = tempList.stream().filter(e -> e.equal(finder, false))
                        .findFirst().orElse(null);
            else
                storedBlock = tempList.stream().findFirst().orElse(null);

            if (storedBlock == null) {
                tempList = StorageInfo.stored_blocks_list.stream()
                        .filter(e -> e.equal(finder, true))
                        .collect(Collectors.toList());
                if (tempList.size() > 1)
                    storedBlock = tempList.stream().filter(e -> e.equal(finder, false))
                            .findFirst().orElse(null);
                else
                    storedBlock = tempList.stream().findFirst().orElse(null);
            }
        }
        return storedBlock;
    }

    //    todo part233
    private StoredFunction findStorageFunction(Create_function_bodyContext ctx) {
        StoredFunction storedFunction = new StoredFunction();
        String name;
        name = Ora2rdb.getRealName(ctx.function_name().schema_and_name().name.getText());

        String type;

        if (ctx.type_spec().datatype() != null && ctx.type_spec().datatype().native_datatype_element() != null)
            type = Ora2rdb.getRealName(
                    ctx.type_spec().datatype().native_datatype_element().getText());
        else
            type = Ora2rdb.getRealName(ctx.type_spec().getText());

        storedFunction.setName(name);
        storedFunction.setFunction_returns_type(type);
        storedFunction.setPackage_name(current_package_name);
        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                storedFunction.setParameters(i, ctx.parameter(i), !ctx.parameter(i).OUT().isEmpty());
            }
        }

        return (StoredFunction) StorageInfo.stored_blocks_list.stream()
                .filter(e -> e.equal(storedFunction))
                .findFirst().orElse(null);
    }

    private StoredFunction findStorageFunction(Function_bodyContext ctx) {
        StoredFunction storedFunction = new StoredFunction();
        String name;
        name = Ora2rdb.getRealName(ctx.identifier().id_expression().getText());
        String type;

        if (ctx.type_spec().datatype() != null)
            type = Ora2rdb.getRealName(
                    ctx.type_spec().datatype().native_datatype_element().getText());
        else
            type = Ora2rdb.getRealName(ctx.type_spec().getText());

        String package_name = current_package_name;

        storedFunction.setName(name);
        storedFunction.setFunction_returns_type(type);
        storedFunction.setPackage_name(package_name);
        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                storedFunction.setParameters(i, ctx.parameter(i), !ctx.parameter(i).OUT().isEmpty());
            }
        }

        if (!storedBlocksStack.isEmpty()) {
            storedFunction.setParent(storedBlocksStack.peek());
        }

        return (StoredFunction) StorageInfo.stored_blocks_list.stream()
                .filter(e -> e.equal(storedFunction))
                .findFirst().orElse(null);
    }

    private StoredProcedure findStorageProcedure(Create_procedure_bodyContext ctx) {
        StoredProcedure storedProcedure = new StoredProcedure();
        String name;
        name = Ora2rdb.getRealName(ctx.procedure_name().schema_and_name().name.getText());
        storedProcedure.setName(name);
        storedProcedure.setPackage_name(current_package_name);

        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                storedProcedure.setParameters(i, ctx.parameter(i), !ctx.parameter(i).OUT().isEmpty());
            }
        }

        return (StoredProcedure) StorageInfo.stored_blocks_list.stream()
                .filter(e -> e.equal(storedProcedure))
                .findFirst().orElse(null);
    }

    private StoredProcedure findStorageProcedure(Procedure_bodyContext ctx) {
        StoredProcedure storedProcedure = new StoredProcedure();
        String name;
        name = Ora2rdb.getRealName(ctx.identifier().getText());

        storedProcedure.setName(name);
        storedProcedure.setPackage_name(current_package_name);

        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                storedProcedure.setParameters(i, ctx.parameter(i), !ctx.parameter(i).OUT().isEmpty());
            }
        }

        if (!storedBlocksStack.isEmpty())
            storedProcedure.setParent(storedBlocksStack.peek());

        return (StoredProcedure) StorageInfo.stored_blocks_list.stream()
                .filter(e -> e.equal(storedProcedure))
                .findFirst().orElse(null);
    }

    private StoredTrigger findStorageTrigger(Create_triggerContext ctx) {
        String trigger_name;
        trigger_name = Ora2rdb.getRealName(ctx.trigger_name().schema_and_name().name.getText());
        StoredTrigger storedTrigger = new StoredTrigger();
        storedTrigger.setName(trigger_name);
        return (StoredTrigger) StorageInfo.stored_blocks_list.stream()
                .filter(e -> e.equal(storedTrigger))
                .findFirst().orElse(null);
    }

    @Override
    public void exitGeneral_element(PlSqlParser.General_elementContext ctx) {
        if (current_plsql_block == null)
            return;
        String ctxToString = Ora2rdb.getRealName(getRuleText(ctx));
        if (ctxToString.contains("."))
            ctxToString = ctxToString.substring(0, ctxToString.indexOf("."));
        if (!current_plsql_block.record_name_cursor_loop.isEmpty()) {
            if (!current_plsql_block.peekReplaceRecordName().isRowType) {
                PLSQLBlock.ReplaceRecordName replaceRecordName = current_plsql_block.peekReplaceRecordName();
                if (ctxToString.equals(replaceRecordName.old_record_name)) {
                    replace(ctx, replaceRecordName.new_record_name);
                }
            }
        }
    }

    @Override
    public void exitGeneral_element_part(General_element_partContext ctx) {
        if (ctx.id_expression().size() == 1) {
            Id_expressionContext id_expr_ctx = ctx.id_expression(0);
            if (id_expr_ctx.regular_id() != null) {
                Regular_idContext reg_id = id_expr_ctx.regular_id();
                if (reg_id.non_reserved_keywords_pre12c() != null) {
                    if (reg_id.non_reserved_keywords_pre12c().TO_NUMBER() != null) {
                        replace(reg_id.non_reserved_keywords_pre12c().TO_NUMBER(), "CAST");
                        delete(ctx.function_argument().RIGHT_PAREN());
                        insertAfter(ctx.function_argument(), " AS NUMERIC)");
                    }

                    if (reg_id.non_reserved_keywords_pre12c().TO_DATE() != null) {
                        replace(reg_id.non_reserved_keywords_pre12c().TO_DATE(), "CAST");
                        delete(ctx.function_argument().RIGHT_PAREN());
                        insertAfter(ctx.function_argument(), " AS TIMESTAMP)");

                        if (ctx.function_argument().argument().size() > 1) {
                            for (int i = 1; i < ctx.function_argument().argument().size(); i++) {
                                delete(ctx.function_argument().COMMA(i - 1));
                                delete(ctx.function_argument().argument(i));
                            }
                        }
                    }

                    if (reg_id.non_reserved_keywords_pre12c().INSTR() != null) {
                        replace(reg_id.non_reserved_keywords_pre12c().INSTR(), "POSITION");
                        String tempArgument = ctx.function_argument().argument(0).getText();
                        replace(ctx.function_argument().argument(0), ctx.function_argument().argument(1).getText());
                        replace(ctx.function_argument().argument(1), tempArgument);
                    }

                    if (reg_id.non_reserved_keywords_pre12c().MONTHS_BETWEEN() != null) {
                        replace(reg_id.non_reserved_keywords_pre12c().MONTHS_BETWEEN(), "-DATEDIFF");
                        replace(ctx.function_argument().LEFT_PAREN(), "(MONTH, ");
                    }
                }
            }
        }
        if (ctx.id_expression().size() > 1) {
            for (Id_expressionContext id_expr_ctx : ctx.id_expression()) {
                String id = getRewriterText(id_expr_ctx);

                if (id.startsWith(":"))
                    replace(id_expr_ctx, id.substring(1));
                String name = Ora2rdb.getRealName(getRuleText(ctx.id_expression(0)));

                // convert methods of associative array
                if (current_plsql_block != null && current_plsql_block.array_to_table.containsKey(name)) {
                    // COUNT
                    if (id_expr_ctx.regular_id() != null && id_expr_ctx.regular_id().non_reserved_keywords_pre12c() != null
                            && id_expr_ctx.regular_id().non_reserved_keywords_pre12c().COUNT() != null) {
                        replace(ctx, "(SELECT COUNT(*) FROM " + current_plsql_block.array_to_table.get(name)
                                + ")");
                    }
                    // FIRST
                    if (id_expr_ctx.regular_id() != null && id_expr_ctx.regular_id().non_reserved_keywords_pre12c() != null
                            && id_expr_ctx.regular_id().non_reserved_keywords_pre12c().FIRST() != null) {
                        replace(ctx, "(SELECT FIRST 1 K FROM " + current_plsql_block.array_to_table.get(name)
                                + " ORDER BY K ASC)");
                    }
                    // LAST
                    if (id_expr_ctx.regular_id() != null && id_expr_ctx.regular_id().non_reserved_keywords_pre12c() != null
                            && id_expr_ctx.regular_id().non_reserved_keywords_pre12c().LAST() != null) {
                        replace(ctx, "(SELECT FIRST 1 K FROM " + current_plsql_block.array_to_table.get(name)
                                + " ORDER BY K DESC)");
                    }
                    // NEXT
                    if (id_expr_ctx.regular_id() != null && id_expr_ctx.regular_id().non_reserved_keywords_pre12c() != null
                            && id_expr_ctx.regular_id().non_reserved_keywords_pre12c().NEXT() != null) {
                        String argument = Ora2rdb.getRealName(getRuleText(ctx.function_argument().argument(0)));
                        if (isVariable(argument))
                            argument = ":" + argument;
                        replace(ctx, "(SELECT FIRST 1 K FROM " + current_plsql_block.array_to_table.get(name)
                                + " WHERE K > " + argument + " ORDER BY K ASC)");
                    }
                    // PRIOR
                    if (id_expr_ctx.regular_id() != null && id_expr_ctx.regular_id().non_reserved_keywords_pre12c() != null
                            && id_expr_ctx.regular_id().non_reserved_keywords_pre12c().PRIOR() != null) {
                        String argument = Ora2rdb.getRealName(getRuleText(ctx.function_argument().argument(0)));
                        if (isVariable(argument))
                            argument = ":" + argument;
                        replace(ctx, "(SELECT FIRST 1 K FROM " + current_plsql_block.array_to_table.get(name)
                                + " WHERE K < " + argument + " ORDER BY K DESC)");
                    }
                    // EXISTS
                    if (id_expr_ctx.regular_id() != null && id_expr_ctx.regular_id().EXISTS() != null) {
                        String argument = Ora2rdb.getRealName(getRuleText(ctx.function_argument().argument(0)));
                        if (isVariable(argument))
                            argument = ":" + argument;
                        replace(ctx, "(SELECT COUNT(*) > 0 FROM " + current_plsql_block.array_to_table.get(name)
                                + " WHERE K = " + argument + ")");
                    }
                }
            }
        } else {
            String name = Ora2rdb.getRealName(getRuleText(ctx.id_expression(0)));

            if (current_plsql_block != null && current_plsql_block.array_to_table.containsKey(name) &&
                    ctx.function_argument() != null) {
                String select_stmt = "(SELECT VAL FROM " + current_plsql_block.array_to_table.get(name) + " WHERE ";
                boolean abort = false;

                if (ctx.function_argument().argument().size() == 1) {

                    select_stmt += "K" + " = " + getRewriterText(ctx.function_argument().argument(0));
                } else {
                    abort = true;
                }


                if (!abort) {
                    select_stmt += ")";
                    replace(ctx, select_stmt);
                    return;
                }
            }

            Regular_idContext regular_id_ctx = ctx.id_expression(0).regular_id();

            if (regular_id_ctx != null) {
                if (regular_id_ctx.non_reserved_keywords_pre12c() != null) {
                    if (regular_id_ctx.non_reserved_keywords_pre12c().REPLACE() != null) {
                        if (ctx.function_argument() != null) {
                            Function_argumentContext function_argument_ctx = ctx.function_argument();

                            if (function_argument_ctx != null)
                                if (function_argument_ctx.argument().size() == 2)
                                    insertAfter(function_argument_ctx.argument(1), ", ''");
                        }
                    }
                    if (regular_id_ctx.non_reserved_keywords_pre12c().LENGTH() != null)
                        replace(regular_id_ctx.non_reserved_keywords_pre12c().LENGTH(), "CHAR_LENGTH");
                }
            }
        }
        if (ctx.function_argument() != null)
            convertFunctionCall(ctx);
    }

    private boolean isVariable(String value) {
        // true - if argument is variable , false if not
        if (value.isEmpty())
            return false;
        boolean ret_val;
        // check if argument is number
        try {
            Integer.parseInt(value);
            ret_val = false;
        } catch (NumberFormatException e) {
            ret_val = true;
        }
        // if argument is not number check if it varchar
        if (ret_val)
            ret_val = value.indexOf('\'') == -1;
        return ret_val;
    }


    private void convertFunctionCall(General_element_partContext ctx) {
        StoredBlock storedBlock = findFunctionCall(ctx);
        if (storedBlock != null) {
            if (storedBlock instanceof StoredFunction) {
                if (storedBlock.containOutParameters())
                    convertFunctionWithOutParameters(ctx, (StoredFunction) storedBlock);
            } else if (storedBlock instanceof StoredProcedure) {
                if (storedBlock.containOutParameters())
                    convertProcedureWithOutParameters(ctx, (StoredProcedure) storedBlock);
            }
        }
//            else insertBefore(ctx, "\n/*ФУНКЦИЯ НЕ ОПРЕДЕЛИЛАСЬ*/\n");
    }

    private void convertFunctionWithOutParameters(General_element_partContext ctx, StoredFunction storedFunction) {
        StringBuilder selectQuery = new StringBuilder();
        if (storedFunction != null) {
            if (storedFunction.containOutParameters()) {
                selectQuery.append("SELECT ").append("RET_VAL, ");
                for (int i : storedFunction.getParameters().keySet()) {
                    if (storedFunction.getParameters().get(i).isOut()) {
                        if (!Objects.equals(i, storedFunction.getParameters().lastKey()))
                            selectQuery.append(storedFunction.getParameters().get(i).getName()).append("_OUT, ");
                        else
                            selectQuery.append(storedFunction.getParameters().get(i).getName()).append("_OUT ");
                    }
                }
                selectQuery.append(" FROM ").append(getRewriterText(ctx));
                selectQuery.append(" INTO ").append(storedFunction.getName()).append("_RET_VAL").append(", ");
                for (int i : storedFunction.getParameters().keySet()) {
                    if (storedFunction.getParameters().get(i).isOut()) {
                        if (!Objects.equals(i, storedFunction.getParameters().lastKey()))
                            selectQuery.append(ctx.function_argument().argument(i).getText()).append(", ");
                        else
                            selectQuery.append(ctx.function_argument().argument(i).getText()).append(";\n");
                    }
                }
                if (current_plsql_block.getStatement() != null) {
                    StatementContext statement = current_plsql_block.getStatement();
                    if (statement.loop_statement() != null) {
                        Loop_statementContext loop = statement.loop_statement();
                        String loopBodyIndentation = getIndentation(loop.seq_of_statements());
                        StringBuilder stringBuilder = new StringBuilder();
                        stringBuilder
                                .append(selectQuery.toString())
                                .append(loopBodyIndentation).append("if( NOT :")
                                .append(storedFunction.getName().concat("_RET_VAL )\n"))
                                .append(loopBodyIndentation).append("\tLEAVE;\n");

                        replace(loop.condition(), "TRUE");
                        insertBefore(loop.seq_of_statements(), stringBuilder.toString());
                    } else {
                        insertBefore(statement, selectQuery.toString());
                        replace(ctx, storedFunction.getName().concat("_RET_VAL"));
                    }
                }
            }
        }
    }

    private void convertProcedureWithOutParameters(General_element_partContext ctx, StoredProcedure storedProcedure) {
        if (storedProcedure != null) {
            StringBuilder selectQuery = new StringBuilder();
            selectQuery.append("SELECT ");
            for (int i : storedProcedure.getParameters().keySet()) {
                if (storedProcedure.getParameters().get(i).isOut()) {
                    if (!Objects.equals(i, storedProcedure.getParameters().lastKey()))
                        selectQuery.append(storedProcedure.getParameters().get(i).getName()).append("_OUT, ");
                    else
                        selectQuery.append(storedProcedure.getParameters().get(i).getName()).append("_OUT ");
                }

            }
            selectQuery.append(" FROM ").append(getRewriterText(ctx));
            selectQuery.append(" INTO ");

            for (int i : storedProcedure.getParameters().keySet()) {
                if (storedProcedure.getParameters().get(i).isOut()) {
                    if (!Objects.equals(i, storedProcedure.getParameters().lastKey()))
                        selectQuery.append(ctx.function_argument().argument(i).getText()).append(", ");
                    else
                        selectQuery.append(ctx.function_argument().argument(i).getText()).append("\n");
                }
            }
            replace(ctx, selectQuery.toString());
        }
    }

    @Override
    public void exitCall_statement(Call_statementContext ctx) {
        if (Ora2rdb.getRealName(getRuleText(ctx.routine_name(0).identifier())).equals("DBMS_OUTPUT")) {
            if (Ora2rdb.getRealName(getRuleText(ctx.routine_name(0).id_expression(0))).equals("PUT_LINE"))
                replace(ctx.routine_name(0), "RDB$TRACE_MSG");
            insertBefore(ctx.function_argument(0).RIGHT_PAREN(), ", TRUE");
            if (Ora2rdb.getRealName(getRuleText(ctx.routine_name(0).id_expression(0))).equals("PUT")) {
                replace(ctx.routine_name(0), "RDB$TRACE_MSG");
                insertBefore(ctx.function_argument(0).RIGHT_PAREN(), ", FALSE");
            }
        } else if (Ora2rdb.getRealName(getRuleText(ctx.routine_name(0))).equals("RAISE_APPLICATION_ERROR")) {
            exceptions.put("CUSTOM_EXCEPTION", "error");
//            containsException = true;
            replace(ctx.routine_name(0), "EXCEPTION CUSTOM_EXCEPTION");
            delete(ctx.function_argument(0).argument(0));
            delete(ctx.function_argument(0).COMMA(0));
        } else
            convertFunctionCall(ctx);
    }

    private void convertFunctionCall(Call_statementContext ctx) {
        StoredBlock storedBlock = findFunctionCall(ctx);
        if (storedBlock != null) {
            if (storedBlock instanceof StoredFunction) {
                if (storedBlock.containOutParameters())
                    convertFunctionWithOutParameters(ctx, (StoredFunction) storedBlock);
            } else if (storedBlock instanceof StoredProcedure)
                if (storedBlock.containOutParameters())
                    convertProcedureWithOutParameters(ctx, (StoredProcedure) storedBlock);
                else
                    replace(ctx, "EXECUTE PROCEDURE " + getRewriterText(ctx));
        } else {
            String name = Ora2rdb.getRealName(ctx.routine_name(0).getText());
            storedBlock = StorageInfo.stored_blocks_list.stream().filter(e -> e.getName().equals(name)).findFirst().orElse(null);
            if (storedBlock instanceof StoredProcedure)
                replace(ctx, "EXECUTE PROCEDURE " + getRewriterText(ctx));
        }

    }

    private void convertFunctionWithOutParameters(Call_statementContext ctx, StoredFunction storedFunction) {
        StringBuilder selectQuery = new StringBuilder();
        if (storedFunction != null) {

            selectQuery.append("SELECT ").append("RET_VAL, ");
            for (int i : storedFunction.getParameters().keySet()) {
                if (storedFunction.getParameters().get(i).isOut()) {
                    if (!Objects.equals(i, storedFunction.getParameters().lastKey()))
                        selectQuery.append(storedFunction.getParameters().get(i).getName()).append("_OUT, ");
                    else
                        selectQuery.append(storedFunction.getParameters().get(i).getName()).append("_OUT ");
                }

            }
            selectQuery.append(" FROM ").append(getRewriterText(ctx));
            selectQuery.append(" INTO ").append(storedFunction.getName()).append("_RET_VAL").append(", ");

            for (int i : storedFunction.getParameters().keySet()) {
                if (storedFunction.getParameters().get(i).isOut()) {
                    if (!Objects.equals(i, storedFunction.getParameters().lastKey()))
                        selectQuery.append(ctx.function_argument(0).argument(i).getText()).append(", ");
                    else
                        selectQuery.append(ctx.function_argument(0).argument(i).getText());
                }
            }

        }

        delete(ctx);
        if (current_plsql_block.getStatement().loop_statement() != null)
            return;
        if (current_plsql_block.getStatement() != null) {
            insertBefore(current_plsql_block.getStatement(), selectQuery.toString());
            current_plsql_block.clearStatement();
        }
    }

    private void convertProcedureWithOutParameters(Call_statementContext ctx, StoredProcedure storedProcedure) {
        if (storedProcedure != null) {
            StringBuilder selectQuery = new StringBuilder();
            selectQuery.append("SELECT ");
            for (int i : storedProcedure.getParameters().keySet()) {
                if (storedProcedure.getParameters().get(i).isOut()) {
                    if (!Objects.equals(i, storedProcedure.getParameters().lastKey()))
                        selectQuery.append(storedProcedure.getParameters().get(i).getName()).append("_OUT, ");
                    else
                        selectQuery.append(storedProcedure.getParameters().get(i).getName()).append("_OUT ");
                }
            }
            selectQuery.append(" FROM ").append(getRewriterText(ctx));
            selectQuery.append(" INTO ");

            for (int i : storedProcedure.getParameters().keySet()) {
                if (storedProcedure.getParameters().get(i).isOut()) {
                    if (!Objects.equals(i, storedProcedure.getParameters().lastKey()))
                        selectQuery.append(ctx.function_argument(0).argument(i).getText()).append(", ");
                    else
                        selectQuery.append(ctx.function_argument(0).argument(i).getText());
                }
            }
            replace(ctx, selectQuery.toString());
        }
    }

    @Override
    public void exitVariable_name(Variable_nameContext ctx) {
        if (ctx.id_expression().size() > 1) {
            for (Id_expressionContext id_expr_ctx : ctx.id_expression()) {
                String id = getRewriterText(id_expr_ctx);

                if (id.startsWith(":"))
                    replace(id_expr_ctx, id.substring(1));
            }
            if (StorageInfo.package_constant_names.contains(getRewriterText(ctx.id_expression(1)))) {
                replace(ctx.PERIOD(), ":");
            }
        }
    }

    @Override
    public void exitCreate_index(Create_indexContext ctx) {
        StringBuilder alterIndexCtx = new StringBuilder();
        String inactive = "";
        String index_name;
        index_name = Ora2rdb.getRealName(getRuleText(ctx.index_name().schema_and_name().name));

        if (StorageInfo.index_names.stream().anyMatch(e -> Objects.equals(e.indexName(), index_name)
                && e.isSystemIndex())) {
            delete(ctx);
            return;
        }

        Index index = StorageInfo.index_names.stream()
                .filter(e -> e.indexName().equals(index_name))
                .findFirst()
                .orElse(null);

        if (index == null) {
            delete(ctx);
            return;
        }

        if (ctx.BITMAP() != null)
            delete(ctx.BITMAP());
        if (ctx.MULTIVALUE() != null) {
            replace(ctx, "/* This type of index - " + ctx.MULTIVALUE().getText()
                    + " is not supported in Red Database \n" + Ora2rdb.getRealName(getRuleText(ctx)) + "*/");
            index.setIsOriginalNameInUse(false);
            create_indexes.add(ctx);
            return;
        }
        if (ctx.USABLE() != null)
            delete(ctx.USABLE());
        if (ctx.UNUSABLE() != null) {
            delete(ctx.UNUSABLE());
            inactive = "INACTIVE";
        }
        if (ctx.deferred_immediate_invalidation() != null) {
            if (ctx.deferred_immediate_invalidation().DEFERRED() != null)
                delete(ctx.deferred_immediate_invalidation().DEFERRED());
            if (ctx.deferred_immediate_invalidation().IMMEDIATE() != null)
                delete(ctx.deferred_immediate_invalidation().IMMEDIATE());
            delete(ctx.deferred_immediate_invalidation().INVALIDATION());
        }
        if (ctx.index_ilm_clause() != null)
            delete(ctx.index_ilm_clause());

        Table_index_clauseContext table_index_clause_ctx = ctx.table_index_clause();

        if (table_index_clause_ctx == null) {
            replace(ctx, "/* This type of index is not supported in Red Database\n"
                    + Ora2rdb.getRealName(getRuleText(ctx)) + "*/");
            index.setIsOriginalNameInUse(false);
            create_indexes.add(ctx);
            return;
        }

        if (table_index_clause_ctx.index_properties() != null) // find invisible attribute in create index
            if (table_index_clause_ctx.index_properties().index_attributes() != null)
                for (Index_attributesContext index_attr_ctx : table_index_clause_ctx.index_properties().index_attributes())
                    if (!index_attr_ctx.visible_or_invisible().isEmpty()) {
                        if (index_attr_ctx.visible_or_invisible().get(0).INVISIBLE() != null)
                            inactive = "INACTIVE";
                        index_attr_ctx.visible_or_invisible().forEach(this::delete);
                    }

        List<Index_exprContext> index_expr_list = table_index_clause_ctx.index_expr();
        String AscOrDesc = index_expr_list.stream().findFirst()
                .filter(e -> e.DESC() != null)
                .map(e -> " DESCENDING ")
                .orElse("");

        if (index_expr_list.stream().allMatch(e -> e.expression() != null)) {
            if (table_index_clause_ctx.index_expr().size() > 1) {
                replace(ctx, "/* The functional index by multiple columns is not supported in RDB \n"
                        + Ora2rdb.getRealName(getRuleText(ctx)) + "*/");
                index.setIsOriginalNameInUse(false);
                create_indexes.add(ctx);
                return;
            } else {
                Index_exprContext index_expr = index_expr_list.get(0);
                if (index_expr.DESC() != null)
                    delete(index_expr.DESC());
                if (index_expr.ASC() != null)
                    delete(index_expr.ASC());
                delete(table_index_clause_ctx.LEFT_PAREN());
                delete(table_index_clause_ctx.RIGHT_PAREN());
                replace(index_expr, " COMPUTED BY " + "( "
                        + getRewriterText(index_expr.expression()) + " )");
            }
        } else if (index_expr_list.stream().allMatch(e -> e.column_name() != null)) {
            index_expr_list
                    .forEach(e -> {
                        if (e.ASC() != null)
                            delete(e.ASC());
                        if (e.DESC() != null)
                            delete(e.DESC());
                    });
        } else {
            replace(ctx, "/* The mixed index (functional and by column) is not supported in RDB\n"
                    + Ora2rdb.getRealName(getRuleText(ctx)) + "*/");
            index.setIsOriginalNameInUse(false);
            create_indexes.add(ctx);
            return;
        }

        delete(table_index_clause_ctx.index_properties());
        deleteSPACESAbut(table_index_clause_ctx.index_properties());

        replace(ctx.INDEX(), AscOrDesc + ctx.INDEX());
        replace(ctx.SEMICOLON(), index.tableSpace() + ctx.SEMICOLON());
        if (!inactive.isEmpty())
            alterIndexCtx.append("\nALTER INDEX ").append(index_name).append(" ").append(inactive).append(";");
        replace(ctx, getRewriterText(ctx) + alterIndexCtx);

        create_indexes.add(ctx);
    }

    @Override
    public void exitAlter_index(Alter_indexContext ctx) {
        String index_name;
        index_name = Ora2rdb.getRealName(getRuleText(ctx.index_name().schema_and_name().name));

        Index getIndex = StorageInfo.index_names.stream()
                .filter(e -> e.indexName().equals(index_name))
                .findFirst()
                .orElse(null);

        if (getIndex == null) {
            delete(ctx);
            return;
        }
        if (!getIndex.isOriginalNameInUse()) {
            replace(ctx, "/* This index was commented \n" + Ora2rdb.getRealName(getRuleText(ctx) + "*/"));
            return;
        }
        StringBuilder newContext = new StringBuilder();

        Alter_index_ops_set2Context alter_ctx_2 = ctx.alter_index_ops_set2();

        if (alter_ctx_2 == null) {
            delete(ctx);
            return;
        }

        String ActiveOrInactive = "";
        String tableSpace = "";

        if (alter_ctx_2.enable_or_disable() != null) {
            if (alter_ctx_2.enable_or_disable().ENABLE() != null)
                ActiveOrInactive = "ACTIVE ";
            if (alter_ctx_2.enable_or_disable().DISABLE() != null)
                ActiveOrInactive = "INACTIVE ";
        }

        if (alter_ctx_2.visible_or_invisible() != null) {
            if (alter_ctx_2.visible_or_invisible().VISIBLE() != null)
                ActiveOrInactive = "ACTIVE ";
            if (alter_ctx_2.visible_or_invisible().INVISIBLE() != null)
                ActiveOrInactive = "INACTIVE ";
        }

        if (alter_ctx_2.UNUSABLE() != null)
            ActiveOrInactive = "INACTIVE ";
        if (alter_ctx_2.rebuild_clause() != null) {
            ActiveOrInactive = "ACTIVE ";
            if (!alter_ctx_2.rebuild_clause().TABLESPACE().isEmpty())
                tableSpace = "SET TABLESPACE TO " +
                        Ora2rdb.getRealName(getRuleText(alter_ctx_2.rebuild_clause().tablespace().get(0)));
        }
        if (tableSpace.isEmpty() && ActiveOrInactive.isEmpty()) {
            replace(ctx, newContext);
            return;
        }

//        if (getIndex.isOriginalNameInUse())
        newContext.append("ALTER INDEX ").append(index_name).append(" ").append(ActiveOrInactive).append(tableSpace).append(";\n");

//        for (String nameOfIndex : getIndex.functionalIndexes()) {
//            newContext.append("ALTER INDEX ").append(nameOfIndex).append(" ").append(ActiveOrInactive).append(tableSpace).append(";\n");
//        }
//        for (String nameOfIndex : getIndex.columnIndexes()) {
//            newContext.append("ALTER INDEX ").append(nameOfIndex).append(" ").append(ActiveOrInactive).append(tableSpace).append(";\n");
//        }

        replace(ctx, newContext);
    }

    @Override
    public void exitCreate_sequence(Create_sequenceContext ctx) {
        Sequence_nameContext sequence_name_ctx = ctx.sequence_name();
        String sequence_name;

        if (sequence_name_ctx.PERIOD(0) != null) {
            delete(sequence_name_ctx.id_expression(0));
            delete(sequence_name_ctx.PERIOD(0));
            deleteSPACESRight(sequence_name_ctx.id_expression(1));
            sequence_name = getRuleText(sequence_name_ctx.id_expression(1));
        } else {
            deleteSPACESRight(sequence_name_ctx.id_expression(0));
            sequence_name = getRuleText(sequence_name_ctx.id_expression(0));
        }

        for (Sequence_specContext sequence_spec_ctx : ctx.sequence_spec()) {
            deleteSPACESLeft(sequence_spec_ctx);
            delete(sequence_spec_ctx);
        }

        String set_generator_statements = "";

        for (Sequence_start_clauseContext sequence_start_clause_ctx : ctx.sequence_start_clause()) {
            set_generator_statements += "\nALTER SEQUENCE " + sequence_name +
                    " RESTART WITH " + sequence_start_clause_ctx.UNSIGNED_INTEGER().getText() + ";";

            delete(sequence_start_clause_ctx);
        }

        replace(ctx, getRewriterText(ctx) + set_generator_statements);
        sequences.add(ctx);
    }

    @Override
    public void enterCreate_view(Create_viewContext ctx) {
        current_view = StorageInfo.views.get(Ora2rdb.getRealName(getRuleText(ctx.tableview_name().schema_and_name().name)));
    }

    @Override
    public void exitCreate_view(Create_viewContext ctx) {
        StringBuilder newView = new StringBuilder();

        String view_name = Ora2rdb.getRealName(getRuleText(ctx.tableview_name().schema_and_name().name));
        newView.append("CREATE OR ALTER VIEW ").append(view_name).append(" ");
        if (ctx.view_options() != null)
            if (ctx.view_options().view_alias_constraint() != null) {
                if (!ctx.view_options().view_alias_constraint().inline_constraint().isEmpty())
                    for (Inline_constraintContext constraint : ctx.view_options().view_alias_constraint().inline_constraint())
                        delete(constraint);
//                if (!ctx.view_options().view_alias_constraint().out_of_line_constraint().isEmpty())
//                    for (Out_of_line_constraintContext constraint : ctx.view_options().view_alias_constraint().out_of_line_constraint())
//                        commentBlock(constraint.start.getTokenIndex(), constraint.stop.getTokenIndex());
                if (!ctx.view_options().view_alias_constraint().VISIBLE().isEmpty()
                        || !ctx.view_options().view_alias_constraint().INVISIBLE().isEmpty()) {
                    for (TerminalNode invisible : ctx.view_options().view_alias_constraint().INVISIBLE())
                        replace(invisible, "/*INVISIBLE*/");
                    for (TerminalNode visible : ctx.view_options().view_alias_constraint().VISIBLE())
                        replace(visible, "/*VISIBLE*/");
                }
                newView.append(getRewriterText(ctx.view_options().view_alias_constraint()));
            } else {
//                commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
                insertBefore(ctx, "/* This type of view is not supported */\n");
                current_view = null;
                return;
            }
        if (ctx.BEQUEATH() != null) {
            if (ctx.DEFINER() != null)
                newView.append(" /* BEQUEATH DEFINER */ ");
            else if (ctx.CURRENT_USER() != null) {
                newView.append(" /* BEQUEATH CURRENT_USER */ ");
                newView.insert(0, "/* In Red Database this view is executed in the context of the DEFINER. \n" +
                        "You can change it using < ALTER DATABASE SET DEFAULT SQL SECURITY {DEFINER|INVOKER} > operator */");
            }
        }
        newView.append(" AS\n");
        newView.append(getRewriterText(ctx.select_only_statement())).append(" ");
        String readOnlyTrigger = "";
        if (ctx.subquery_restriction_clause() != null) {
            if (ctx.subquery_restriction_clause().CHECK() != null)
                newView.append("WITH CHECK OPTION ");
            if (ctx.subquery_restriction_clause().READ() != null) {
                readOnlyTrigger = makeReadOnlyTrgForView(view_name);
                exceptions.put("READ_ONLY_VIEW", "cannot perform a DML operation on a read-only view");
            }
            if (ctx.subquery_restriction_clause().CONSTRAINT() != null)
                newView.append(" /* CONSTRAINT ").append(Ora2rdb.getRealName(getRuleText(ctx.subquery_restriction_clause().constraint_name())))
                        .append("*/");
        }
        newView.append(";").append(readOnlyTrigger);
        delete(ctx.SEMICOLON());
        replace(ctx, newView);
        current_view = null;
    }

    private String makeReadOnlyTrgForView(String view_name) {
        StringBuilder trg = new StringBuilder();
        String infMessage = "\n/*This is a trigger that makes view read only*/";
        trg.append(infMessage);
        trg.append("\nCREATE TRIGGER ").append(view_name).append("_TR").append(" FOR ")
                .append(view_name).append(" ").append("\nBEFORE INSERT OR UPDATE OR DELETE\n")
                .append("AS BEGIN \n ").append("EXCEPTION READ_ONLY_VIEW;\n").append("END;\n");
        return trg.toString();
    }

    @Override
    public void exitEditioning_clause(Editioning_clauseContext ctx) {
        delete(ctx);
        deleteSPACESLeft(ctx);
    }

    @Override
    public void exitDml_table_expression_clause(Dml_table_expression_clauseContext ctx) {
        if (current_view != null && ctx.tableview_name() != null) {
            String dependency_name = Ora2rdb.getRealName(getRuleText(ctx.tableview_name()));

            if (StorageInfo.views.containsKey(dependency_name))
                current_view.dependencies.add(StorageInfo.views.get(dependency_name));
        }

        if (current_plsql_block != null)
            if (current_plsql_block.current_cursor_name != null)
                if (ctx.tableview_name() != null) {
                    String table_name = Ora2rdb.getRealName(Ora2rdb.getRealName(ctx.tableview_name().schema_and_name().name.getText()));
                    current_plsql_block.cursor_select_statement.get(current_plsql_block.current_cursor_name).table_name = table_name;
                }
    }


    @Override
    public void enterCursor_declaration(Cursor_declarationContext ctx) {
        List<Select_list_elementsContext> cursor_select_list;
        if (ctx.select_statement() != null)
            cursor_select_list = ctx.select_statement().select_only_statement().subquery()
                    .subquery_basic_elements().query_block().selected_list().select_list_elements();
        else
            return;

        if (cursor_select_list.size() == 1) {
            current_plsql_block.current_cursor_name = Ora2rdb.getRealName(getRuleText(ctx.identifier()));
            String column_name = Ora2rdb.getRealName(getRuleText(cursor_select_list.get(0)));
            if (column_name.contains("."))                                             // если в запросе использователся алиас таблицы: <алиас>.<столбец>
                column_name = column_name.substring(column_name.indexOf(".") + 1);

            current_plsql_block.putCursorSelectStatement(Ora2rdb.getRealName(ctx.identifier().getText()),
                    "", column_name);
        }
    }

    @Override
    public void exitSubquery_restriction_clause(Subquery_restriction_clauseContext ctx) {
        delete(ctx);
    }

    @Override
    public void exitComment_on_table(Comment_on_tableContext ctx) {
        comments.add(ctx);
    }

    @Override
    public void exitQuery_block(Query_blockContext ctx) {
        if (ctx.into_clause() != null) {
            String indentation = getIndentation(ctx);
            String into_clause = getRewriterText(ctx.into_clause());
            deleteSPACESAbut(ctx.into_clause());
            delete(ctx.into_clause());
            insertAfter(ctx.selected_list(), '\n' + indentation);
            replace(ctx, getRewriterText(ctx) + '\n' + indentation + into_clause);

            StringBuilder if_clause = new StringBuilder();
            if_clause.append('\n').append(indentation).append("IF (ROW_COUNT = 0) THEN").append('\n');
            if_clause.append(indentation).append('\t').append("EXCEPTION NO_DATA_FOUND");
            replace(ctx, getRewriterText(ctx) + ";" + if_clause);
            exceptions.put("NO_DATA_FOUND", "no data found");
        }
    }

    @Override
    public void exitRegular_id(Regular_idContext ctx) {
        if (ctx.non_reserved_keywords_pre12c() != null) {
            switch (getRuleText(ctx.non_reserved_keywords_pre12c()).toUpperCase()) {
                case "SYSTIMESTAMP":
                    replace(ctx, "CURRENT_TIMESTAMP");
                    break;
                case "SYSDATE":
                    replace(ctx, "CURRENT_TIMESTAMP");
            }
        }
    }

    @Override
    public void exitFunction_name(Function_nameContext ctx) {
    }

    @Override
    public void enterCreate_function_body(Create_function_bodyContext ctx) {
        pushScope();
        String procedureName;
        procedureName = Ora2rdb.getRealName(ctx.function_name().schema_and_name().name.getText());
        current_plsql_block.procedure_name = procedureName;
        storedBlocksStack.push(findStorageFunction(ctx));
    }

    @Override
    public void exitCreate_function_body(Create_function_bodyContext ctx) {
        replace(ctx.REPLACE(), "ALTER");
        delete(ctx.EDITIONABLE());
        delete(ctx.NONEDITIONABLE());
        //convert invoker_rights_clause statement
        if (ctx.invoker_rights_clause().isEmpty()) {
            replace(ctx.IS(), "\n SQL SECURITY DEFINER \n AS");
            replace(ctx.AS(), "\n SQL SECURITY DEFINER \n AS");
        } else {
            if (ctx.invoker_rights_clause().get(0).CURRENT_USER() != null) {
                replace(ctx.IS(), "SQL SECURITY INVOKER \n AS");
                replace(ctx.AS(), "SQL SECURITY INVOKER \n AS");
            }
            if (ctx.invoker_rights_clause().get(0).DEFINER() != null) {
                replace(ctx.IS(), "SQL SECURITY DEFINER \n AS");
                replace(ctx.AS(), "SQL SECURITY DEFINER \n AS");
            }
            delete(ctx.invoker_rights_clause().get(0));
            deleteSPACESLeft(ctx.invoker_rights_clause().get(0));
        }

        //delete default collation clause
        if (!ctx.default_collation_clause().isEmpty())
            delete(ctx.default_collation_clause().get(0));

//        replace(ctx.SEMICOLON(), "^");
        StoredFunction currentFunction = (StoredFunction) storedBlocksStack.peek();
        String getWhiteSpace = getIndentation(ctx) + "  ";
        if (currentFunction.containOutParameters()) {
            replace(ctx.FUNCTION(), "PROCEDURE");
            replace(ctx.RETURN(), "\nRETURNS ( RET_VAL");

            ArrayList<Parameter> out_parameters = (ArrayList<Parameter>) currentFunction.getParameters().values().stream()
                    .filter(Parameter::isOut).collect(Collectors.toList());
            StringBuilder return_parameters = new StringBuilder();
            return_parameters.append(",\n");
            for (Parameter parameter : out_parameters) {
                String type = null;
                ParameterContext parameterContext = ctx.parameter().stream()
                        .filter(e -> Ora2rdb.getRealName(e.parameter_name().getText()).equals(parameter.getName()))
                        .findFirst().orElse(null);
                if (parameterContext != null) {
                    type = getRewriterText(parameterContext.type_spec());
                }
                if (!out_parameters.get(out_parameters.size() - 1).equals(parameter))
                    return_parameters.append(parameter.getName()).append("_OUT ").append(type).append(", \n");
                else
                    return_parameters.append(parameter.getName()).append("_OUT ").append(type).append(")\n");
            }
            insertAfter(ctx.type_spec(), return_parameters);
        } else {
            replace(ctx.RETURN(), "RETURNS");
        }

        if (currentFunction.containFunctionCallWithOutParameters()) {
            StringBuilder declare_ret_val = new StringBuilder();
            currentFunction.getCalledFunctions().stream()
                    .filter(StoredFunction::containOutParameters)
                    .forEach(e -> declare_ret_val.append("\n").append(getWhiteSpace).append("DECLARE ")
                            .append(e.getName())
                            .append("_RET_VAL ")
                            .append(e.getConvert_function_return_type())
                            .append(";")
                    );
            insertBefore(ctx.body(), declare_ret_val.append('\n'));
        }

        StringBuilder declare_loop_index_names = new StringBuilder();
        if (!loop_index_names.isEmpty()) {
            for (String index_name : loop_index_names) {
                declare_loop_index_names.append("\n  DECLARE VARIABLE ").append(index_name).append(" INTEGER;\n");
            }
            insertBefore(ctx.body(), declare_loop_index_names.toString());
        }
        loop_index_names.clear();

        StringBuilder declare_loop_rowtype_names = new StringBuilder();
        if (!loop_rec_name_and_cursor_name.isEmpty()) {
            for (String rec : loop_rec_name_and_cursor_name.keySet()) {
                if (current_plsql_block.cursor_select_statement.containsKey(loop_rec_name_and_cursor_name.get(rec))) {
                    String table_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).table_name;
                    String column_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).column_name;
                    declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                            append(" TYPE OF COLUMN ").append(table_name).append(".").append(column_name).append(";\n");
                } else
                    declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                            append(" TYPE OF TABLE ").append(loop_rec_name_and_cursor_name.get(rec)).append(";\n");
            }
            insertBefore(ctx.body(), declare_loop_rowtype_names.toString());
        }
        loop_rec_name_and_cursor_name.clear();

        createTempCursorAndRowtypeVariable(ctx.body());

        autonomousTransactionBlockConvert(ctx);

        StringBuilder temp_tables_ddl = new StringBuilder();

        if (current_plsql_block.commentBlock) {
            commentBlock(ctx.seq_of_declare_specs().start.getTokenIndex(), ctx.seq_of_declare_specs().stop.getTokenIndex());
            commentBlock(ctx.body().seq_of_statements().start.getTokenIndex(), ctx.body().seq_of_statements().stop.getTokenIndex());
        }

        for (String table_ddl : current_plsql_block.temporary_tables_ddl)
            temp_tables_ddl.append(table_ddl).append("\n\n");

        if (!Ora2rdb.reorder)
            insertBefore(ctx, temp_tables_ddl + "\n");
//            replace(ctx, temp_tables_ddl + "\n" + getRewriterText(ctx));
        else
            create_temporary_tables.add(temp_tables_ddl.toString());

        popScope();
        create_functions.add(ctx);
        storedBlocksStack.pop();
    }

    @Override
    public void enterFunction_body(Function_bodyContext ctx) {
        pushScope();
        current_plsql_block.procedure_name = Ora2rdb.getRealName(ctx.identifier().getText());
        storedBlocksStack.push(findStorageFunction(ctx));
    }

    @Override
    public void exitFunction_body(Function_bodyContext ctx) {
        if (Finder.getParentRuleContext(ctx, Create_package_bodyContext.class) == null)
            replace(ctx.FUNCTION(), "DECLARE FUNCTION");
        replace(ctx.IS(), "AS");
//      replace(ctx.SEMICOLON(), "^");
        String getWhiteSpace = getIndentation(ctx) + "  ";
        if (storedBlocksStack.peek() instanceof StoredFunction) {
            StoredFunction currentFunction = (StoredFunction) storedBlocksStack.peek();

            if (currentFunction.containOutParameters()) {
                replace(ctx.FUNCTION(), "DECLARE PROCEDURE");
                replace(ctx.RETURN(), "\nRETURNS ( RET_VAL");

                ArrayList<Parameter> out_parameters = (ArrayList<Parameter>) currentFunction.getParameters().values().stream()
                        .filter(Parameter::isOut).collect(Collectors.toList());
                StringBuilder return_parameters = new StringBuilder();
                return_parameters.append(",\n");
                for (Parameter parameter : out_parameters) {
                    String type = null;
                    ParameterContext parameterContext = ctx.parameter().stream()
                            .filter(e -> Ora2rdb.getRealName(e.parameter_name().getText()).equals(parameter.getName()))
                            .findFirst().orElse(null);
                    if (parameterContext != null) {
                        type = getRewriterText(parameterContext.type_spec());
                    }
                    if (!out_parameters.get(out_parameters.size() - 1).equals(parameter))
                        return_parameters.append(parameter.getName()).append("_OUT ").append(type).append(", \n");
                    else
                        return_parameters.append(parameter.getName()).append("_OUT ").append(type).append(")\n");
                }
                insertAfter(ctx.type_spec(), return_parameters);
            } else {
                replace(ctx.RETURN(), "RETURNS");
            }
            delete(ctx.SEMICOLON());

            if (currentFunction.containFunctionCallWithOutParameters()) {
                StringBuilder declare_ret_val = new StringBuilder();
                currentFunction.getCalledFunctions().stream()
                        .filter(StoredBlock::containOutParameters)
                        .forEach(e -> declare_ret_val.append(getWhiteSpace).append("\nDECLARE ")
                                .append(e.getName())
                                .append("_RET_VAL ")
                                .append(e.getConvert_function_return_type())
                                .append(";")
                        );
                insertBefore(ctx.body(), declare_ret_val.append('\n'));
            }
        }

        StringBuilder declare_loop_index_names = new StringBuilder();
        if (!loop_index_names.isEmpty()) {
            for (String index_name : loop_index_names) {
                declare_loop_index_names.append("\n  DECLARE VARIABLE ").append(index_name).append(" INTEGER;\n");
            }
            insertBefore(ctx.body(), declare_loop_index_names.toString());
        }
        loop_index_names.clear();

        StringBuilder declare_loop_rowtype_names = new StringBuilder();
        if (!loop_rec_name_and_cursor_name.isEmpty()) {
            for (String rec : loop_rec_name_and_cursor_name.keySet()) {
                if (current_plsql_block.cursor_select_statement.containsKey(loop_rec_name_and_cursor_name.get(rec))) {
                    String table_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).table_name;
                    String column_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).column_name;
                    declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                            append(" TYPE OF COLUMN ").append(table_name).append(".").append(column_name).append(";\n");
                } else
                    declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                            append(" TYPE OF TABLE ").append(loop_rec_name_and_cursor_name.get(rec)).append(";\n");
            }
            insertAfter(ctx.seq_of_declare_specs(), declare_loop_rowtype_names.toString());
        }
        loop_rec_name_and_cursor_name.clear();

        createTempCursorAndRowtypeVariable(ctx.body());
        autonomousTransactionBlockConvert(ctx);


        popScope();
        storedBlocksStack.pop();
    }

    @Override
    public void exitFunction_spec(Function_specContext ctx) {
        replace(ctx.FUNCTION(), "DECLARE FUNCTION");
        replace(ctx.RETURN(), "RETURNS");
        deleteSPACESLeft(ctx.SEMICOLON());
        StringBuilder return_parameters = new StringBuilder();
        ArrayList<ParameterContext> parameters = (ArrayList<ParameterContext>) ctx.parameter().stream()
                .filter(e -> !e.OUT().isEmpty())
                .collect(Collectors.toList());
        if (!parameters.isEmpty()) {
            replace(ctx.FUNCTION(), "DECLARE PROCEDURE");
            replace(ctx.RETURN(), "\nRETURNS ( RET_VAL");
            return_parameters.append(",\n");
            for (ParameterContext parameter : parameters) {
                String parameterType = getRewriterText(parameter.type_spec());
                String parameterName = Ora2rdb.getRealParameterName(parameter.parameter_name().getText());
                return_parameters.append(parameterName).append("_OUT ").append(parameterType);
                if (!parameters.get(parameters.size() - 1).equals(parameter))
                    return_parameters.append(", \n");
                else
                    return_parameters.append(" )");
            }
            insertAfter(ctx.type_spec(), return_parameters.toString());
        }
    }

    @Override
    public void exitParameter(ParameterContext ctx) {
        for (TerminalNode in_node : ctx.IN())
            delete(in_node);
        for (TerminalNode out_node : ctx.OUT())
            delete(out_node);
        for (TerminalNode nocopy_node : ctx.NOCOPY())
            delete(nocopy_node);
        for (TerminalNode inout_node : ctx.INOUT())
            delete(inout_node);

        if (current_plsql_block != null)
            current_plsql_block.declareVar(Ora2rdb.getRealName(getRuleText(ctx.parameter_name())));

        if (getRewriterText(ctx).startsWith(":"))
            replace(ctx, getRewriterText(ctx).substring(1));
    }

    @Override
    public void exitExecute_immediate(Execute_immediateContext ctx) {
        replace(ctx.IMMEDIATE(), "STATEMENT");
        insertBefore(ctx.expression(), "(");
        insertAfter(ctx.expression(), ")");
        if (ctx.into_clause() != null) {
            String into_clause = getRewriterText(ctx.into_clause());
            delete(ctx.into_clause());
            replace(ctx, getRewriterText(ctx) + " " + into_clause);
        }
    }

    @Override
    public void exitPragma_declaration(Pragma_declarationContext ctx) {
        delete(ctx);
        deleteSPACESLeft(ctx);
    }

    @Override
    public void exitVariable_declaration(Variable_declarationContext ctx) {
        if (getRewriterText(ctx).startsWith(":"))
            replace(ctx, getRewriterText(ctx).substring(1));

        if (current_plsql_block != null && ctx.CONSTANT() != null
                && ctx.parent.getClass().equals(PlSqlParser.Package_obj_specContext.class)
                || ctx.parent.getClass().equals(PlSqlParser.Package_obj_bodyContext.class)) {

            current_plsql_block.package_constant_names.add(ctx.identifier().getText());
            if (ctx.default_value_part() != null)
                replace(ctx.default_value_part().ASSIGN_OP(), "=");

            delete(ctx.CONSTANT());
            insertBefore(ctx, "CONSTANT ");
        } else {
            String name = Ora2rdb.getRealName(getRuleText(ctx.identifier()));
            String type = Ora2rdb.getRealName(getRuleText(ctx.type_spec()));

            String recordType = "";
            Type_specContext typeSpec = Finder.getFirstRuleContext(ctx, Type_specContext.class);
            if(typeSpec != null && typeSpec.type_name() != null){
                if(typeSpec.type_name().PERIOD(0) == null)
                    recordType = Ora2rdb.getRealName(getRuleText(typeSpec.type_name().id_expression(0)));
                else if(typeSpec.type_name().PERIOD(0) != null){
                    recordType = Ora2rdb.getRealName(getRuleText(typeSpec.type_name().id_expression(typeSpec.type_name().id_expression().size() - 1)));
                }
            }


            if (current_plsql_block != null) {
                if (ctx.default_value_part() != null
                        & !current_plsql_block.record_type_names.isEmpty()
                        && current_plsql_block.record_type_names.contains(recordType)){
                    General_element_partContext generalElementPart = Finder.getFirstRuleContext(ctx, General_element_partContext.class);
                    if(generalElementPart != null
                            && generalElementPart.PERIOD() == null
                            && recordType.equals(Ora2rdb.getRealName(generalElementPart.id_expression(0).getText()))){
                        replace(generalElementPart.id_expression(0), "ROW");
                    }
                    else if(generalElementPart != null
                            && generalElementPart.PERIOD() != null
                            && recordType.equals(Ora2rdb.getRealName(generalElementPart.id_expression(generalElementPart.id_expression().size() - 1 ).getText()))){
                        replace(generalElementPart.id_expression(), "ROW");

                    }
                }
                if (current_plsql_block.associative_array_types.containsKey(type)) {
                    current_plsql_block.declareAssociativeArray(name, type);
                    commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
                    return;
                }
                if (current_plsql_block.nested_array_types.containsKey(type)) {
                    return;
                }
                if (current_plsql_block.varray_types.containsKey(type)) {
                    return;
                }

                current_plsql_block.declareVar(name);
            }

            if (ctx.type_spec().PERCENT_ROWTYPE() != null) {
                insertBefore(ctx, "VARIABLE ");
            }

            insertBefore(ctx, " DECLARE ");
        }
    }

    @Override
    public void exitDefault_value_part(Default_value_partContext ctx) {
        if (ctx.ASSIGN_OP() != null) {
            replace(ctx.ASSIGN_OP(), "=");
        }
    }

    @Override
    public void exitType_declaration(Type_declarationContext ctx) {
        if (ctx.record_type_def() != null) {
            if(current_plsql_block != null)
                current_plsql_block.record_type_names.add(Ora2rdb.getRealName(ctx.identifier().getText()));
            insertBefore(ctx.TYPE(), "DECLARE ");
            delete(ctx.IS());
            delete(ctx.record_type_def().RECORD());
            Finder.getAllRuleContexts(ctx, Field_specContext.class)
                    .forEach(fieldSpecContext -> {
                        if (fieldSpecContext.NOT() != null && fieldSpecContext.NULL_() != null) {
                            delete(fieldSpecContext.NOT());
                            delete(fieldSpecContext.NULL_());
                        }
                        if (fieldSpecContext.default_value_part() != null) {
                            replace(fieldSpecContext.default_value_part().ASSIGN_OP(), "DEFAULT");
                        }
                    });
        } else {
            if (ctx.table_type_def() != null) {
                commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
                if (current_plsql_block != null && ctx.table_type_def() != null
                        && ctx.table_type_def().table_indexed_by_part() != null) {
                    current_plsql_block.declareTypeOfAssociativeArray(Ora2rdb.getRealName(getRuleText(ctx.identifier())),
                            getRewriterText(ctx.table_type_def().type_spec()),
                            getRewriterText(ctx.table_type_def().table_indexed_by_part().type_spec()));
                }
            } else if (ctx.nested_table_type_def() != null) {
                if (current_plsql_block != null)
                    current_plsql_block.declareTypeOfNestedTableArray(Ora2rdb.getRealName(getRuleText(ctx.identifier())),
                            getRewriterText(ctx.nested_table_type_def().type_spec()));
            } else if (ctx.varray_type_def() != null) {
                if (current_plsql_block != null)
                    current_plsql_block.declareTypeOfVarray(Ora2rdb.getRealName(getRuleText(ctx.identifier())),
                            getRewriterText(ctx.varray_type_def().type_spec()));
            }
        }
    }

    @Override
    public void exitCursor_declaration(Cursor_declarationContext ctx) {
        replace(ctx.CURSOR(), "DECLARE");
        replace(ctx.IS(), "CURSOR FOR");
        insertBefore(ctx.select_statement(), "(");
        insertAfter(ctx.select_statement(), ")");
        // delete return statement inside cursor declaration
        delete(ctx.RETURN());
        delete(ctx.type_spec());
        current_plsql_block.current_cursor_name = null;
    }

    @Override
    public void exitFetch_statement(Fetch_statementContext ctx) {
        if (current_plsql_block != null) {
            String cursor_name = getRuleText(ctx.cursor_name());
            Token t = getNextToken(ctx.stop);
            while (t.getType() != PlSqlLexer.SEMICOLON)
                t = getNextToken(t);
            current_plsql_block.fetch_statement.put(cursor_name, t);
        }
    }

    @Override
    public void exitClose_statement(Close_statementContext ctx) {
        if (current_plsql_block != null) {
            String cursor_name = getRuleText(ctx.cursor_name());
            Token t = getNextToken(ctx.stop);
            while (t.getType() != PlSqlLexer.SEMICOLON)
                t = getNextToken(t);
            current_plsql_block.close_statement.put(cursor_name, t);
        }
    }

    @Override
    public void exitOpen_statement(Open_statementContext ctx) {
        if (current_plsql_block != null) {
            String cursor_name = getRuleText(ctx.cursor_name());
            Token t = getNextToken(ctx.stop);
            while (t.getType() != PlSqlLexer.SEMICOLON)
                t = getNextToken(t);
            current_plsql_block.open_statement.put(cursor_name, t);
        }
    }

    @Override
    public void exitJson_function(Json_functionContext ctx) {
        delete(ctx.STRICT());
    }

    @Override
    public void exitOther_function(Other_functionContext ctx) {
        if (ctx.cursor_name() != null) {
            if (ctx.PERCENT_FOUND() != null || ctx.PERCENT_NOTFOUND() != null) {
                String cursor_name = getRuleText(ctx.cursor_name());
                String variable_name = cursor_name + "_found";
                // for explicit cursor (<cursor_name>%FOUND or <cursor_name>%NOTFOUND)
                if (current_plsql_block != null && !cursor_name.equalsIgnoreCase("SQL")) {
                    current_plsql_block.cursor_found_notfound_attr.add(variable_name);
                    if (current_plsql_block.fetch_statement.containsKey(cursor_name)) {
                        insertAfter(current_plsql_block.fetch_statement.get(cursor_name),
                                "\n\t" + variable_name + " = DECODE(ROW_COUNT, 0, FALSE, TRUE);\n");
                    }
                    if (ctx.PERCENT_FOUND() != null)
                        replace(ctx, variable_name);
                    else if (ctx.PERCENT_NOTFOUND() != null)
                        replace(ctx, "(NOT " + variable_name + ")");
                } // for implicit cursor (SQL%FOUND or SQL%NOTFOUND)
                else if (current_plsql_block != null && cursor_name.equalsIgnoreCase("SQL")) {
                    if (ctx.PERCENT_FOUND() != null)
                        replace(ctx, " DECODE(ROW_COUNT, 0, FALSE, TRUE)");
                    else if (ctx.PERCENT_NOTFOUND() != null)
                        replace(ctx, " DECODE(ROW_COUNT, 0, TRUE, FALSE)");
                }
            }
            if (ctx.PERCENT_ISOPEN() != null) {
                String cursor_name = getRuleText(ctx.cursor_name());
                String variable_name = cursor_name + "_isopen";
                if (current_plsql_block != null) {
                    current_plsql_block.cursor_open_attr.add(variable_name);
                    if (current_plsql_block.open_statement.containsKey(cursor_name)) {
                        insertAfter(current_plsql_block.open_statement.get(cursor_name),
                                "\n\t" + variable_name + " = TRUE;\n");
                        if (current_plsql_block.close_statement.containsKey(cursor_name))
                            insertAfter(current_plsql_block.close_statement.get(cursor_name),
                                    "\n\t" + variable_name + " = FALSE;\n");
                    }
                    replace(ctx, variable_name);
                }
            }
            if (ctx.PERCENT_ROWCOUNT() != null) {
                String cursor_name = getRuleText(ctx.cursor_name());
                String variable_name = cursor_name + "_counter";
                // for explicit cursor (<cursor_name>%FOUND or <cursor_name>%NOTFOUND)
                if (current_plsql_block != null && !cursor_name.equalsIgnoreCase("SQL")) {
                    current_plsql_block.cursor_rowcount_attr.add(variable_name);
                    if (current_plsql_block.fetch_statement.containsKey(cursor_name)) {
                        insertAfter(current_plsql_block.fetch_statement.get(cursor_name),
                                "\n\t" + variable_name + " = " + variable_name + " + ROW_COUNT;\n");
                    }
                    // %ROWCOUNT inside for in <cursor_name>
                    Loop_statementContext loop_ctx = Finder.getParentRuleContext(ctx, Loop_statementContext.class);
                    if (loop_ctx != null && Finder.getFirstRuleContext(loop_ctx, Cursor_loop_paramContext.class) != null) {
                        insertBefore(loop_ctx, "\n\t" + variable_name + " = " + variable_name + " + ROW_COUNT;\n");
                        insertAfter(loop_ctx.seq_of_statements(),
                                "\n\t" + variable_name + " = " + variable_name + " + ROW_COUNT;\n");
                    }
                    replace(ctx, variable_name);
                } // for implicit cursor (SQL%FOUND or SQL%NOTFOUND)
                else if (current_plsql_block != null && cursor_name.equalsIgnoreCase("SQL")) {
                    replace(ctx, "ROW_COUNT");
                }
            }
        }
    }

    @Override
    public void exitId_expression(Id_expressionContext ctx) {
        String id_expression = Ora2rdb.getRealName(getRuleText(ctx));
        if (current_plsql_block != null && current_plsql_block.containsInScope(id_expression)) {
            replace(ctx, ":" + getRuleText(ctx));
        }
        if (current_plsql_block != null && !current_plsql_block.record_name_cursor_loop.isEmpty() &&
                current_plsql_block.peekReplaceRecordName().isRowType) {
            PLSQLBlock.ReplaceRecordName replaceRecordName = current_plsql_block.peekReplaceRecordName();
            if (id_expression.equals(replaceRecordName.old_record_name)) {
                replace(ctx, replaceRecordName.new_record_name);
            }
        }
    }

    @Override
    public void exitBind_variable(Bind_variableContext ctx) {

        for (General_element_partContext elementPart : ctx.general_element_part())
            if (getRewriterText(elementPart).startsWith(":"))
                replace(elementPart, getRewriterText(elementPart).substring(1));

        if (current_plsql_block != null) {
            if (current_plsql_block.trigger_referencing_attributes.oldValue != null) {
                for (int i = 0; i < ctx.BINDVAR().size(); i++) {
                    String alias = Ora2rdb.getRealName(ctx.BINDVAR(i).getText());
                    if (alias.startsWith(":"))
                        alias = alias.substring(1);

                    if (Objects.equals(alias, current_plsql_block.trigger_referencing_attributes.oldValue)) {
                        replace(ctx.BINDVAR(i), "OLD");
                    }
                }
            }
            if (current_plsql_block.trigger_referencing_attributes.newValue != null) {
                for (int i = 0; i < ctx.BINDVAR().size(); i++) {
                    String alias = Ora2rdb.getRealName(ctx.BINDVAR(i).getText());
                    if (alias.startsWith(":"))
                        alias = alias.substring(1);

                    if (Objects.equals(alias, current_plsql_block.trigger_referencing_attributes.newValue)) {
                        replace(ctx.BINDVAR(i), "NEW");
                    }
                }
            }
        }
    }

    @Override
    public void exitColumn_name(Column_nameContext ctx) {
        try {
            String name = getRewriterText(ctx);

            if (name.startsWith(":"))
                replace(ctx, name.substring(1));
        } catch (Exception e) {
            System.err.println(e.fillInStackTrace() + rewriter.getText());
        }
    }

    @Override
    public void exitSql_plus_command(Sql_plus_commandContext ctx) {
        if (ctx.PROMPT_MESSAGE() != null)
            commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
        else
            delete(ctx);
    }

    @Override
    public void enterCreate_package(Create_packageContext ctx) {
        pushScope();
    }

    @Override
    public void exitCreate_package(Create_packageContext ctx) {
        if (ctx.REPLACE() != null) {
            replace(ctx.REPLACE(), "ALTER");
        }
        delete(ctx.EDITIONABLE());
        delete(ctx.NONEDITIONABLE());
        //delete sharing clause
        if (ctx.sharing_clause() != null) {
            delete(ctx.sharing_clause());
        }
        if (ctx.default_collation_clause() != null) {
            delete(ctx.default_collation_clause());
        }
        if (ctx.schema_object_name() != null) {
            delete(ctx.schema_object_name());
            delete(ctx.PERIOD());
        }
        if (ctx.AS() != null) {
            if (ctx.invoker_rights_clause() == null)
                insertBefore(ctx.AS(), "\nSQL SECURITY DEFINER\n");
            insertAfter(ctx.AS(), " BEGIN");
        }
        if (ctx.IS() != null) {
            replace(ctx.IS(), "AS");
            if (ctx.invoker_rights_clause() == null)
                insertBefore(ctx.IS(), "\nSQL SECURITY DEFINER\n");
            insertAfter(ctx.IS(), " BEGIN");
        }
        if (!ctx.package_name().isEmpty()) {
            if (ctx.package_name().size() > 1) {
                //if (ctx.package_name(ctx.package_name().size() - 1) != null) {
//                replace(ctx.package_name(ctx.package_name().size() - 1),
//                        "/*" + Ora2rdb.getRealName(ctx.package_name(ctx.package_name().size() - 1).getText()) + "*/");
                delete(ctx.package_name(ctx.package_name().size() - 1));
            }
        }

        popScope();
    }

    @Override
    public void exitPackage_function_spec(Package_function_specContext ctx) {
        replace(ctx.RETURN(), "RETURNS");
    }

    @Override
    public void enterCreate_package_body(Create_package_bodyContext ctx) {
        pushScope();
        current_package_name = Ora2rdb.getRealName(ctx.package_name(0).getText());
    }

    @Override
    public void exitCreate_package_body(Create_package_bodyContext ctx) {
        current_package_name = null;
        if (ctx.OR() != null) {
            if (ctx.REPLACE() != null) {
                delete(ctx.OR());
                delete(ctx.REPLACE());
                replace(ctx.CREATE(), "RECREATE");
            }
        }
        delete(ctx.EDITIONABLE());
        delete(ctx.NONEDITIONABLE());
        if (ctx.schema_object_name() != null) {
            delete(ctx.schema_object_name());
            delete(ctx.PERIOD());
        }
        if (ctx.AS() != null) {
            insertAfter(ctx.AS(), " BEGIN");
        }
        if (ctx.IS() != null) {
            replace(ctx.IS(), "AS");
            insertAfter(ctx.IS(), " BEGIN");
        }
        if (!ctx.package_name().isEmpty()) {
            if (ctx.package_name().size() > 1) {
//                replace(ctx.package_name(ctx.package_name().size() - 1),
//                        "/*" + Ora2rdb.getRealName(ctx.package_name(ctx.package_name().size() - 1).getText()) + "*/");
                delete(ctx.package_name(ctx.package_name().size() - 1));
            }
        }

        StringBuilder temp_tables_ddl = new StringBuilder();
        for (String table_ddl : current_plsql_block.temporary_tables_ddl)
            temp_tables_ddl.append(table_ddl).append("\n\n");

        if (!Ora2rdb.reorder)
            insertBefore(ctx, temp_tables_ddl + "\n");
//            replace(ctx, temp_tables_ddl + "\n" + getRewriterText(ctx));
        else
            create_temporary_tables.add(temp_tables_ddl.toString());
        popScope();
    }

    @Override
    public void exitProcedure_name(Procedure_nameContext ctx) {
    }


    @Override
    public void exitProcedure_spec(Procedure_specContext ctx) {
        replace(ctx.PROCEDURE(), "DECLARE PROCEDURE");
        StringBuilder return_parameters = new StringBuilder();
        return_parameters.append("RETURNS ( ");

        ArrayList<ParameterContext> parameters = (ArrayList<ParameterContext>) ctx.parameter().stream()
                .filter(e -> !e.OUT().isEmpty())
                .collect(Collectors.toList());
        if (!parameters.isEmpty()) {
            deleteSPACESLeft(ctx.SEMICOLON());
            delete(ctx.SEMICOLON());
            for (ParameterContext parameter : parameters) {
                String parameterType = getRewriterText(parameter.type_spec());
                String parameterName = Ora2rdb.getRealParameterName(parameter.parameter_name().getText());
                return_parameters.append(parameterName).append("_OUT ").append(parameterType);
                if (!parameters.get(parameters.size() - 1).equals(parameter))
                    return_parameters.append(", \n");
                else {
                    return_parameters.append(" );\n");
                }
            }
            insertAfter(ctx.RIGHT_PAREN(), '\n' + return_parameters.toString() + '\n');
        }
    }

    @Override
    public void enterCreate_procedure_body(Create_procedure_bodyContext ctx) {
        pushScope();
        storedBlocksStack.push(findStorageProcedure(ctx));
    }

    @Override
    public void exitCreate_procedure_body(Create_procedure_bodyContext ctx) {

        replace(ctx.REPLACE(), "ALTER");
        //convert invoker_rights_clause statement
        if (ctx.invoker_rights_clause().isEmpty()) {
            replace(ctx.IS(), "\n SQL SECURITY DEFINER \n AS");
            replace(ctx.AS(), "\n SQL SECURITY DEFINER \n AS");
        } else {
            if (ctx.invoker_rights_clause().get(0).CURRENT_USER() != null) {
                replace(ctx.IS(), "SQL SECURITY INVOKER \n AS");
                replace(ctx.AS(), "SQL SECURITY INVOKER \n AS");
            }
            if (ctx.invoker_rights_clause().get(0).DEFINER() != null) {
                replace(ctx.IS(), "SQL SECURITY DEFINER \n AS");
                replace(ctx.AS(), "SQL SECURITY DEFINER \n AS");
            }
            delete(ctx.invoker_rights_clause().get(0));
            deleteSPACESLeft(ctx.invoker_rights_clause().get(0));
        }

        //delete sharing clause
        if (ctx.ddl_sharing_clause() != null) {
            delete(ctx.ddl_sharing_clause());
            deleteSPACESLeft(ctx.ddl_sharing_clause());
        }

        String getWhiteSpace = getIndentation(ctx) + "  ";
        StoredProcedure currentProcedure = (StoredProcedure) storedBlocksStack.peek();
        if (currentProcedure.containOutParameters()) {
            StringBuilder return_parameters = new StringBuilder();
            StringBuilder equating_parameters = new StringBuilder("\n");
            return_parameters.append(getWhiteSpace).append("RETURNS( ");

            ArrayList<Parameter> out_parameters = (ArrayList<Parameter>) currentProcedure.getParameters().values().
                    stream().filter(Parameter::isOut).collect(Collectors.toList());

            for (Parameter parameter : out_parameters) {
                String type = null;
                ParameterContext parameterContext = ctx.parameter().stream()
                        .filter(e -> Ora2rdb.getRealName(e.parameter_name().getText()).equals(parameter.getName()))
                        .findFirst().orElse(null);

                if (parameterContext != null) {
                    type = getRewriterText(parameterContext.type_spec());
                }

                if (!out_parameters.get(out_parameters.size() - 1).equals(parameter))
                    return_parameters.append(parameter.getName()).append("_OUT ").append(type).append(", \n");
                else
                    return_parameters.append(parameter.getName()).append("_OUT ").append(type).append(")\n");
                equating_parameters.append(parameter.getName()).append("_OUT = ").append(parameter.getName()).append(";\n");
            }
            if (ctx.IS() != null) {
                insertBefore(ctx.IS(), return_parameters.toString() + '\n');
            } else {
                insertBefore(ctx.AS(), return_parameters.toString() + '\n');
            }

            insertBefore(ctx.body().END(), equating_parameters.append(getWhiteSpace).append("SUSPEND;\n"));
        }


        if (currentProcedure.containFunctionCallWithOutParameters()) {
            StringBuilder declare_ret_val = new StringBuilder();
            currentProcedure.getCalledFunctions().stream()
                    .filter(StoredFunction::containOutParameters)
                    .forEach(e -> declare_ret_val.append("\nDECLARE ")
                            .append(e.getName())
                            .append("_RET_VAL ")
                            .append(e.getConvert_function_return_type())
                            .append(";"));
            insertBefore(ctx.body(), declare_ret_val.append('\n'));
        }

        StringBuilder declare_loop_index_names = new StringBuilder();
        if (!loop_index_names.isEmpty()) {
            for (String index_name : loop_index_names) {
                declare_loop_index_names.append("\n  DECLARE VARIABLE ").append(index_name).append(" INTEGER;\n");
            }
            insertBefore(ctx.body(), declare_loop_index_names.toString());
        }
        loop_index_names.clear();

        StringBuilder declare_loop_rowtype_names = new StringBuilder();
        if (!loop_rec_name_and_cursor_name.isEmpty()) {
            for (String rec : loop_rec_name_and_cursor_name.keySet()) {
                if (current_plsql_block.cursor_select_statement.containsKey(loop_rec_name_and_cursor_name.get(rec))) {
                    String table_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).table_name;
                    String column_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).column_name;
                    declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                            append(" TYPE OF COLUMN ").append(table_name).append(".").append(column_name).append(";\n");
                } else
                    declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                            append(" TYPE OF TABLE ").append(loop_rec_name_and_cursor_name.get(rec)).append(";\n");
            }
            insertBefore(ctx.body(), declare_loop_rowtype_names.toString());
        }
        loop_rec_name_and_cursor_name.clear();

        createTempCursorAndRowtypeVariable(ctx.body());
        autonomousTransactionBlockConvert(ctx);

        StringBuilder temp_tables_ddl = new StringBuilder();

        for (String table_ddl : current_plsql_block.temporary_tables_ddl)
            temp_tables_ddl.append(table_ddl).append("\n\n");

        if (!Ora2rdb.reorder)
            insertBefore(ctx, temp_tables_ddl + "\n");
//        replace(ctx, temp_tables_ddl + "\n" + getRewriterText(ctx));
        else
            create_temporary_tables.add(temp_tables_ddl.toString());

        popScope();

        create_procedures.add(ctx);
        storedBlocksStack.pop();
    }


    @Override
    public void enterProcedure_body(Procedure_bodyContext ctx) {
        pushScope();
        storedBlocksStack.push(findStorageProcedure(ctx));
    }

    @Override
    public void exitProcedure_body(Procedure_bodyContext ctx) {
        if (Finder.getParentRuleContext(ctx, Create_package_bodyContext.class) == null)
            replace(ctx.PROCEDURE(), "DECLARE PROCEDURE");
        replace(ctx.IS(), "AS");
        delete(ctx.SEMICOLON());
        StoredProcedure currentProcedure = (StoredProcedure) storedBlocksStack.peek();
//        String procedure_name = currentProcedure.getName();//todo
        String getWhiteSpace = getIndentation(ctx) + "  ";

        if (currentProcedure.containOutParameters()) {
            StringBuilder return_parameters = new StringBuilder();
            StringBuilder equating_parameters = new StringBuilder('\n');
            return_parameters.append(getWhiteSpace).append("RETURNS( ");

            ArrayList<Parameter> out_parameters = (ArrayList<Parameter>) currentProcedure.getParameters().values().
                    stream().filter(Parameter::isOut).collect(Collectors.toList());

            for (Parameter parameter : out_parameters) {
                String type = null;
                ParameterContext parameterContext = ctx.parameter().stream()
                        .filter(e -> Ora2rdb.getRealName(e.parameter_name().getText()).equals(parameter.getName()))
                        .findFirst().orElse(null);
                if (parameterContext != null) {
                    type = getRewriterText(parameterContext.type_spec());
                }
                if (!out_parameters.get(out_parameters.size() - 1).equals(parameter))
                    return_parameters.append(parameter.getName()).append("_OUT ").append(type).append(", \n");
                else
                    return_parameters.append(parameter.getName()).append("_OUT ").append(type).append(")\n");
                equating_parameters.append(parameter.getName()).append("_OUT = ").append(parameter.getName()).append(";\n");
            }
            if (ctx.IS() != null) {
                insertBefore(ctx.IS(), return_parameters.toString() + '\n');
            } else {
                insertBefore(ctx.AS(), return_parameters.toString() + '\n');
            }
            insertBefore(ctx.body().END(), equating_parameters.append("SUSPEND;\n"));
        }


        if (currentProcedure.containFunctionCallWithOutParameters()) {
            StringBuilder declare_ret_val = new StringBuilder();
            currentProcedure.getCalledFunctions().stream()
                    .filter(StoredFunction::containOutParameters)
                    .forEach(e -> declare_ret_val.append("\nDECLARE ")
                            .append(e.getName())
                            .append("_RET_VAL ")
                            .append(e.getConvert_function_return_type())
                            .append(";"));
            insertBefore(ctx.body(), declare_ret_val.append('\n'));
        }


        StringBuilder declare_loop_index_names = new StringBuilder();
        if (!loop_index_names.isEmpty()) {
            for (String index_name : loop_index_names) {
                declare_loop_index_names.append("\n  DECLARE VARIABLE ").append(index_name).append(" INTEGER;\n");
            }
            insertBefore(ctx.body(), declare_loop_index_names.toString());
        }
        loop_index_names.clear();

        StringBuilder declare_loop_rowtype_names = new StringBuilder();
        if (!loop_rec_name_and_cursor_name.isEmpty()) {
            for (String rec : loop_rec_name_and_cursor_name.keySet()) {
                if (current_plsql_block.cursor_select_statement.containsKey(loop_rec_name_and_cursor_name.get(rec))) {
                    String table_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).table_name;
                    String column_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).column_name;
                    declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                            append(" TYPE OF COLUMN ").append(table_name).append(".").append(column_name).append(";\n");
                } else
                    declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                            append(" TYPE OF TABLE ").append(loop_rec_name_and_cursor_name.get(rec)).append(";\n");
            }
            insertBefore(ctx.body(), declare_loop_rowtype_names.toString());
        }
        loop_rec_name_and_cursor_name.clear();

        createTempCursorAndRowtypeVariable(ctx.body());
        autonomousTransactionBlockConvert(ctx);
        popScope();
        storedBlocksStack.pop();
    }


    private void autonomousTransactionBlockConvert(Procedure_bodyContext ctx) {
        if (checkAndDeleteAutonomousTransaction(ctx.seq_of_declare_specs())) {
            insertBefore(ctx.body().seq_of_statements(), "IN AUTONOMOUS TRANSACTION DO BEGIN\n");
            insertAfter(ctx.body().seq_of_statements(), "\n\tEND");
        }
    }

    private void autonomousTransactionBlockConvert(Function_bodyContext ctx) {
        if (checkAndDeleteAutonomousTransaction(ctx.seq_of_declare_specs())) {
            insertBefore(ctx.body().seq_of_statements(), "IN AUTONOMOUS TRANSACTION DO BEGIN\n");
            insertAfter(ctx.body().seq_of_statements(), "\n\tEND");
        }
    }

    private void autonomousTransactionBlockConvert(Create_procedure_bodyContext ctx) {
        if (checkAndDeleteAutonomousTransaction(ctx.seq_of_declare_specs())) {
            insertBefore(ctx.body().seq_of_statements(), "IN AUTONOMOUS TRANSACTION DO BEGIN\n");
            insertAfter(ctx.body().seq_of_statements(), "\n\tEND");
        }
    }

    private void autonomousTransactionBlockConvert(Create_function_bodyContext ctx) {
        if (checkAndDeleteAutonomousTransaction(ctx.seq_of_declare_specs())) {
            insertBefore(ctx.body().seq_of_statements(), "IN AUTONOMOUS TRANSACTION DO BEGIN\n");
            insertAfter(ctx.body().seq_of_statements(), "\n\tEND");
        }
    }

    private boolean checkAndDeleteAutonomousTransaction(Seq_of_declare_specsContext ctx) {
        if (ctx != null) {
            if (!ctx.declare_spec().isEmpty()) {
                for (Declare_specContext declare_spec : ctx.declare_spec()) {
                    if (declare_spec.pragma_declaration() != null &&
                            declare_spec.pragma_declaration().AUTONOMOUS_TRANSACTION() != null) {
                        delete(declare_spec);
                        return true;
                    }
                }
            }
        }
        return false;
    }


    @Override
    public void exitType_spec(Type_specContext ctx) {
        if (ctx.PERCENT_TYPE() != null)
            replace(ctx, "TYPE OF COLUMN " + getRuleText(ctx.type_name()));
        if (ctx.PERCENT_ROWTYPE() != null) {
            delete(ctx.PERCENT_ROWTYPE());
            replace(ctx, "TYPE OF TABLE " + getRuleText(ctx.type_name()));
        }
    }

    @Override
    public void enterAnonymous_block(PlSqlParser.Anonymous_blockContext ctx) {
        pushScope();
        currentAnonymousBlock = new StoredAnonymousBlock();
        if (ctx.seq_of_declare_specs() != null)
            for (Declare_specContext declare_spec : ctx.seq_of_declare_specs().declare_spec()) {
                if (declare_spec.variable_declaration() != null) {
                    String param_name = Ora2rdb.getRealName(declare_spec.variable_declaration().identifier().getText());
                    String param_type = Ora2rdb.getRealName(declare_spec.variable_declaration().type_spec().getText());
                    currentAnonymousBlock.setDeclaredVariables(param_name, param_type);
                }
            }

        // check if nested anonymous block
        for (StatementContext stm_ctx : ctx.body().seq_of_statements().statement()) {
            if (stm_ctx.body() != null || stm_ctx.block() != null) {
                currentAnonymousBlock.setIsNested(true);
                break;
            }
        }
    }

    @Override
    public void exitAnonymous_block(PlSqlParser.Anonymous_blockContext ctx) {
        if (!currentAnonymousBlock.getIsNested()) {
            if (ctx.body().EXCEPTION() != null)
                replace(ctx.body().EXCEPTION(), "/*EXCEPTION*/");

            StringBuilder declare_loop_index_names = new StringBuilder();
            if (!loop_index_names.isEmpty()) {
                for (String index_name : loop_index_names) {
                    declare_loop_index_names.append("\n  DECLARE VARIABLE ").append(index_name).append(" INTEGER;\n");
                }
                insertBefore(ctx.body(), declare_loop_index_names.toString());
            }
            loop_index_names.clear();

            StringBuilder declare_loop_rowtype_names = new StringBuilder();
            if (!loop_rec_name_and_cursor_name.isEmpty()) {
                for (String rec : loop_rec_name_and_cursor_name.keySet()) {
                    if (current_plsql_block.cursor_select_statement.containsKey(loop_rec_name_and_cursor_name.get(rec))) {
                        String table_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).table_name;
                        String column_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).column_name;
                        declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                                append(" TYPE OF COLUMN ").append(table_name).append(".").append(column_name).append(";\n");
                    } else
                        declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                                append(" TYPE OF TABLE ").append(loop_rec_name_and_cursor_name.get(rec)).append(";\n");
                }
                insertBefore(ctx.body(), declare_loop_rowtype_names.toString());
            }
            loop_rec_name_and_cursor_name.clear();


            StringBuilder temp_tables_ddl = new StringBuilder();
            for (String table_ddl : current_plsql_block.temporary_tables_ddl)
                temp_tables_ddl.append(table_ddl).append("\n\n");

            if (ctx.DECLARE() != null)
                replace(ctx.DECLARE(), "EXECUTE BLOCK \n AS \n");
            else
                insertBefore(ctx.body(), "EXECUTE BLOCK \n AS \n");

            if (!Ora2rdb.reorder)
                insertBefore(ctx, temp_tables_ddl + "\n");
//                replace(ctx, temp_tables_ddl + "\n" + getRewriterText(ctx) + "\n");
            else
                create_temporary_tables.add(temp_tables_ddl.toString());
        } else {
            commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
            insertBefore(ctx, "/*Multilevel nesting of an anonymous block is not supported in Red Database*/ \n");
        }

        currentAnonymousBlock = null;
        popScope();
    }

    @Override
    public void enterCreate_trigger(Create_triggerContext ctx) {
        pushScope();
        storedBlocksStack.push(findStorageTrigger(ctx));
    }

    @Override
    public void exitCreate_trigger(Create_triggerContext ctx) {
        StoredTrigger current_trigger = (StoredTrigger) storedBlocksStack.peek();

        if (current_trigger == null)
            return;

        String indentation = getIndentation(ctx);
        replace(ctx.REPLACE(), "ALTER");
        /*deleteSPACESLeft(ctx.trigger_body());*/
        //        replace(ctx.SEMICOLON(), "^");

        StringBuilder temp_tables_ddl = new StringBuilder();

        for (String table_ddl : current_plsql_block.temporary_tables_ddl)
            temp_tables_ddl.append(table_ddl).append("\n\n");


        // delete default collation clause
        if (ctx.default_collation_clause() != null) {
            delete(ctx.default_collation_clause());
            deleteSPACESLeft(ctx.default_collation_clause());
        }

        // delete SHARING clause
        if (ctx.ddl_sharing_clause() != null) {
            delete(ctx.ddl_sharing_clause());
            deleteSPACESLeft(ctx.ddl_sharing_clause());
        }

        if (ctx.instead_of_dml_trigger() != null) {
            replace(ctx.instead_of_dml_trigger().INSTEAD(), "BEFORE");
            delete(ctx.instead_of_dml_trigger().OF());
            deleteSPACESLeft(ctx.instead_of_dml_trigger().OF());

            if (ctx.instead_of_dml_trigger().DISABLE() != null)
                insertAfter(ctx, "\nALTER TRIGGER " + Ora2rdb.getRealName(ctx.trigger_name().getText()) + " INACTIVE;");

            delete(ctx.instead_of_dml_trigger().DISABLE());
            delete(ctx.instead_of_dml_trigger().ENABLE());
        }

        // set the position of trigger
        String position = "";
        if (current_trigger.getPosition() != -1) {
            position = "\nPOSITION " + current_trigger.getPosition();
        }

        StringBuilder declare_loop_index_names = new StringBuilder();
        if (!loop_index_names.isEmpty()) {
            for (String index_name : loop_index_names) {
                declare_loop_index_names.append("\n  DECLARE VARIABLE ").append(index_name).append(" INTEGER;\n");
            }
            insertBefore(ctx.trigger_body().trigger_block().body(), declare_loop_index_names.toString());
        }
        loop_index_names.clear();

        insertBefore(ctx.trigger_body(), indentation + position + "\nSQL SECURITY DEFINER\nAS\n");

        if (ctx.simple_dml_trigger() != null) {
            if (ctx.simple_dml_trigger().for_each_row() == null) {
                replace(ctx, " -unconvertible  RS-228329 \n" + getRewriterText(ctx));
                current_plsql_block.commentBlock = true;
            }
            if (ctx.simple_dml_trigger().DISABLE() != null)
                insertAfter(ctx, "\nALTER TRIGGER " + Ora2rdb.getRealName(ctx.trigger_name().getText()) + " INACTIVE;");

            delete(ctx.simple_dml_trigger().DISABLE());
            delete(ctx.simple_dml_trigger().ENABLE());
        }

        if (ctx.compound_dml_trigger() != null) {
            replace(ctx.compound_dml_trigger(), "[-unconvertible RS-228297 " + getRewriterText(ctx.compound_dml_trigger()));
            insertAfter(ctx.trigger_body().compound_trigger_block(), "]");
            current_plsql_block.commentBlock = true;

            if (ctx.compound_dml_trigger().DISABLE() != null)
                insertAfter(ctx, "\nALTER TRIGGER " + Ora2rdb.getRealName(ctx.trigger_name().getText()) + " INACTIVE;");

            delete(ctx.compound_dml_trigger().DISABLE());
            delete(ctx.compound_dml_trigger().ENABLE());
        }

        if (ctx.non_dml_trigger() != null) {
            if (ctx.non_dml_trigger().DISABLE() != null)
                insertAfter(ctx, "\nALTER TRIGGER " + Ora2rdb.getRealName(ctx.trigger_name().getText()) + " INACTIVE;");

            delete(ctx.non_dml_trigger().DISABLE());
            delete(ctx.non_dml_trigger().ENABLE());

            if (ctx.non_dml_trigger().INSTEAD() != null) {
                insertBefore(ctx.non_dml_trigger(), "[-unconvertible RS-228348 ");
                insertAfter(ctx.non_dml_trigger(), "]");
                current_plsql_block.commentBlock = true;
            } else {
                boolean checkDDL = false;
                for (Non_dml_eventContext stmt : ctx.non_dml_trigger().non_dml_event()) {
                    if (stmt.database_event() != null) {
                        if (stmt.database_event().LOGON() != null) {
                            replace(stmt.database_event().LOGON(), "ON CONNECT");
                        } else if (stmt.database_event().LOGOFF() != null) {
                            replace(stmt.database_event().LOGOFF(), "ON DISCONNECT");
                        } else {
                            insertBefore(stmt.database_event(), "[-unconvertible RS-228336 ");
                            insertAfter(stmt.database_event(), "]");
                            current_plsql_block.commentBlock = true;
                        }
                        delete(ctx.non_dml_trigger().AFTER());
                        delete(ctx.non_dml_trigger().BEFORE());
                    }
                    if (stmt.ddl_event() != null) {
                        if (stmt.ddl_event().CREATE() != null || stmt.ddl_event().ALTER() != null
                                || stmt.ddl_event().DROP() != null || stmt.ddl_event().DDL() != null && !checkDDL) {
                            replace(stmt.ddl_event(), " ANY DDL STATEMENT");
                            checkDDL = true;
                        } else {
                            insertBefore(stmt.ddl_event(), "[-unconvertible RS-228339 ");
                            insertAfter(stmt.ddl_event(), "]");
                            current_plsql_block.commentBlock = true;
                        }
                    }
                }
            }
            delete(ctx.non_dml_trigger().ON());
            delete(ctx.non_dml_trigger().SCHEMA());
            delete(ctx.non_dml_trigger().schema_name());
            delete(ctx.non_dml_trigger().PLUGGABLE());
            delete(ctx.non_dml_trigger().DATABASE());
        }

        if (!Ora2rdb.reorder)
            insertBefore(ctx, temp_tables_ddl + "\n");
//            replace(ctx, temp_tables_ddl + getRewriterText(ctx));
        else
            create_temporary_tables.add(temp_tables_ddl.toString());

        if (current_plsql_block.commentBlock) {
            commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
        }

        if (current_trigger.edition_clause) {
            insertBefore(ctx, "/*IT WAS A CROSSEDITION TRIGGER*/\n");
        }

        popScope();
        create_triggers.add(ctx);
        storedBlocksStack.pop();
    }

    @Override
    public void exitReferencing_clause(Referencing_clauseContext ctx) {
        if (current_plsql_block != null) {
            for (int i = 0; i < ctx.referencing_element().size(); i++) {
                Referencing_elementContext stmt = ctx.referencing_element().get(i);
                if (stmt.NEW() != null) {
                    current_plsql_block.trigger_referencing_attributes.newValue = Ora2rdb.getRealName(stmt.column_alias().identifier().getText());
                }
                if (stmt.OLD() != null) {
                    current_plsql_block.trigger_referencing_attributes.oldValue = Ora2rdb.getRealName(stmt.column_alias().identifier().getText());
                }
                if (stmt.PARENT() != null) {
                    replace(stmt.PARENT(), "[-unconvertible RS-228325 " + stmt.PARENT());
                    replace(stmt.column_alias(), getRewriterText(stmt.column_alias()) + "]");
                    current_plsql_block.commentBlock = true;
                    return;
                }
            }
        }
        delete(ctx);
        deleteSPACESLeft(ctx);
    }

    @Override
    public void exitNon_dml_trigger(Non_dml_triggerContext ctx) {
        if (current_plsql_block != null) {
            for (Non_dml_eventContext stmt : ctx.non_dml_event()) {
                if (stmt.ddl_event() != null) {
                    if (stmt.ddl_event().CREATE() != null && ctx.INSTEAD() == null)
                        current_plsql_block.trigger_ddl_event.add("CREATE");
                    if (stmt.ddl_event().ALTER() != null)
                        current_plsql_block.trigger_ddl_event.add("ALTER");
                    if (stmt.ddl_event().DROP() != null)
                        current_plsql_block.trigger_ddl_event.add("DROP");
                }
            }
        }
    }

    @Override
    public void exitTrigger_edition_clause(Trigger_edition_clauseContext ctx) {
        delete(ctx);
        deleteSPACESLeft(ctx);
    }

    @Override
    public void exitFor_each_row(For_each_rowContext ctx) {
        delete(ctx);
        deleteSPACESAbut(ctx);
    }

    @Override
    public void exitTrigger_when_clause(Trigger_when_clauseContext ctx) {
        if (current_plsql_block != null)
            current_plsql_block.trigger_when_condition = getRewriterText(ctx.condition());

        delete(ctx);
        deleteSPACESLeft(ctx);
    }

    @Override
    public void exitDml_event_element(Dml_event_elementContext ctx) {
        if (current_plsql_block != null) {
            if (ctx.column_list() != null) {
                for (Column_nameContext col_name_ctx : ctx.column_list().column_name())
                    current_plsql_block.trigger_fields.add(getRuleText(col_name_ctx));
            }
        }

        delete(ctx.OF());
        if (ctx.column_list() != null) {
            delete(ctx.column_list().column_name());
        }
    }

    @Override
    public void exitDml_event_nested_clause(Dml_event_nested_clauseContext ctx) {
        replace(ctx, "[-unconvertible RS-228312 " + getRewriterText(ctx) + "]");
        if (current_plsql_block != null)
            current_plsql_block.commentBlock = true;
    }

    @Override
    public void exitTrigger_ordering_clause(Trigger_ordering_clauseContext ctx) {
        delete(ctx);
        deleteSPACESLeft(ctx);
    }

    @Override
    public void enterBlock(BlockContext ctx) {
        pushScope();
    }

    @Override
    public void exitBlock(BlockContext ctx) {
        popScope();
    }

    @Override
    public void exitBody(BodyContext ctx) {
        if (ctx.EXCEPTION() != null)
            replace(ctx.EXCEPTION(), "/*EXCEPTION*/");
        if (current_plsql_block != null &&
                (!current_plsql_block.trigger_fields.isEmpty() || current_plsql_block.trigger_when_condition != null)) {
            String execute_condition = "\nIF (";
            String update_condition = "";

            for (int i = 0; i < current_plsql_block.trigger_fields.size(); i++) {
                if (i != 0)
                    update_condition += " OR ";

                update_condition += "NEW." + current_plsql_block.trigger_fields.get(i) + " <> OLD." + current_plsql_block.trigger_fields.get(i);
            }

            if (!current_plsql_block.trigger_fields.isEmpty() && current_plsql_block.trigger_when_condition != null)
                execute_condition += "(" + update_condition + ") AND (" + current_plsql_block.trigger_when_condition + ")";
            else if (!current_plsql_block.trigger_fields.isEmpty())
                execute_condition += update_condition;
            else
                execute_condition += current_plsql_block.trigger_when_condition;

            execute_condition += ") THEN";

            if (ctx.seq_of_statements().statement().size() > 1)
                execute_condition += "\nBEGIN";

            insertAfter(ctx.BEGIN(), execute_condition);

            if (ctx.seq_of_statements().statement().size() > 1)
                insertBefore(ctx.END(), "END\n");
        }
        if (current_plsql_block != null && !current_plsql_block.trigger_ddl_event.isEmpty()) {
            StringBuilder execute_condition = new StringBuilder();
            execute_condition.append("\nIF (");
            StringBuilder update_condition = new StringBuilder();
            for (int i = 0; i < current_plsql_block.trigger_ddl_event.size(); i++) {
                if (i != 0)
                    update_condition.append(" OR ");
                update_condition.append("RDB$GET_CONTEXT ('DDL_TRIGGER','EVENT_TYPE') = ").append("'")
                        .append(current_plsql_block.trigger_ddl_event.get(i)).append("'");
            }
            execute_condition.append(update_condition).append(") THEN").append("\nBEGIN");
            insertAfter(ctx.BEGIN(), execute_condition);
            insertBefore(ctx.END(), "\nEND\n");
        }

        // declare variable that stores cursor%FOUND value
        if (current_plsql_block != null && current_plsql_block.cursor_found_notfound_attr != null) {
            ListIterator<String> li = new ArrayList<>(current_plsql_block.cursor_found_notfound_attr).
                    listIterator(current_plsql_block.cursor_found_notfound_attr.size());
            while (li.hasPrevious()) {
                insertBefore(ctx, "\tDECLARE " + li.previous() + " BOOLEAN = NULL; \n");
            }
        }
        // declare variable that stores cursor%OPEN value
        if (current_plsql_block != null && current_plsql_block.cursor_open_attr != null) {
            ListIterator<String> li = new ArrayList<>(current_plsql_block.cursor_open_attr).
                    listIterator(current_plsql_block.cursor_open_attr.size());
            while (li.hasPrevious()) {
                insertBefore(ctx, "\tDECLARE " + li.previous() + " BOOLEAN = FALSE; \n");
            }
        }
        // declare variable that stores cursor%ROWCOUNT value
        if (current_plsql_block != null && current_plsql_block.cursor_rowcount_attr != null) {
            ListIterator<String> li = new ArrayList<>(current_plsql_block.cursor_rowcount_attr).
                    listIterator(current_plsql_block.cursor_rowcount_attr.size());
            while (li.hasPrevious()) {
                insertBefore(ctx, "\tDECLARE " + li.previous() + " INT = 0; \n");
            }
        }
    }

    @Override
    public void exitTrigger_block(Trigger_blockContext ctx) {
        delete(ctx.DECLARE());
        deleteSPACESLeft(ctx.DECLARE());
        if (ctx.body() != null) {
            StringBuilder declare_loop_rowtype_names = new StringBuilder();
            if (!loop_rec_name_and_cursor_name.isEmpty()) {
                for (String rec : loop_rec_name_and_cursor_name.keySet()) {
                    if (current_plsql_block.cursor_select_statement.containsKey(loop_rec_name_and_cursor_name.get(rec))) {
                        String table_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).table_name;
                        String column_name = current_plsql_block.cursor_select_statement.get(loop_rec_name_and_cursor_name.get(rec)).column_name;
                        declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                                append(" TYPE OF COLUMN ").append(table_name).append(".").append(column_name).append(";\n");
                    } else
                        declare_loop_rowtype_names.append("\n  DECLARE VARIABLE ").append(rec).
                                append(" TYPE OF TABLE ").append(loop_rec_name_and_cursor_name.get(rec)).append(";\n");
                }
                insertBefore(ctx.body(), declare_loop_rowtype_names.toString());
            }
            loop_rec_name_and_cursor_name.clear();

            createTempCursorAndRowtypeVariable(ctx.body());

        }
    }

    @Override
    public void exitAlter_trigger(Alter_triggerContext ctx) {
        replace(ctx.ENABLE(), "ACTIVE");
        replace(ctx.DISABLE(), "INACTIVE");

        alter_triggers.add(ctx);
    }

    @Override
    public void exitLabel_name(Label_nameContext ctx) {
        if (Finder.getParentRuleContext(ctx, Continue_statementContext.class) != null
                || Finder.getParentRuleContext(ctx, Exit_statementContext.class) != null)
            return;
        else
            delete(ctx);
//        replace(ctx, "/*" + getRewriterText(ctx) + "*/");
    }

    @Override
    public void exitLabel_declaration(Label_declarationContext ctx) {
        replace(ctx, getRuleText(ctx.label_name()) + ":");
    }

    @Override
    public void exitStandard_function(Standard_functionContext ctx) {
        if (ctx.string_function() != null) {
            if (ctx.string_function().NVL() != null)
                replace(ctx.string_function().NVL(), "COALESCE");
            if (ctx.string_function().TO_CHAR() != null) {
                replace(ctx.string_function().TO_CHAR(), "CAST");
                if (ctx.string_function().COMMA(0) != null) {
                    insertBefore(ctx, "UPPER( ");
                    replace(ctx.string_function().COMMA(0), " AS VARCHAR(32765) FORMAT");
                    replace(ctx, getRewriterText(ctx) + ")");
                } else {
                    insertAfter(ctx.string_function().expression(0), " AS VARCHAR(32765)");
                }
            }
            if (ctx.string_function().TO_DATE() != null) {
                replace(ctx.string_function().TO_DATE(), "CAST");
                delete(ctx.string_function().RIGHT_PAREN());
                if (ctx.string_function().expression() != null)
                    insertAfter(ctx.string_function().expression(0), " AS TIMESTAMP)");
                else if (ctx.string_function().table_element() != null)
                    insertAfter(ctx.string_function().table_element(), " AS TIMESTAMP)");
                delete(ctx.string_function().COMMA(0));
                delete(ctx.string_function().quoted_string());
            }
        }
    }

    @Override
    public void enterStatement(StatementContext ctx) {
        current_plsql_block.setStatement(ctx);
    }

    @Override
    public void exitAssignment_statement(Assignment_statementContext ctx) {
        if (ctx.general_element() != null) {
            if (ctx.general_element().general_element_part().size() == 1) {
                General_element_partContext gen_elem_part_ctx = ctx.general_element().general_element_part(0);

                if (gen_elem_part_ctx.id_expression().size() == 1) {
                    String name = Ora2rdb.getRealName(getRuleText(gen_elem_part_ctx.id_expression(0)));

                    if (current_plsql_block != null && current_plsql_block.array_to_table.containsKey(name) &&
                            gen_elem_part_ctx.function_argument() != null) {
                        String insert_stmt = "UPDATE OR INSERT INTO " + current_plsql_block.array_to_table.get(name) + " VALUES (";
                        boolean abort = false;
                        Function_argumentContext func_arg_ctx = gen_elem_part_ctx.function_argument();

                        if (func_arg_ctx.argument().size() == 1)
                            insert_stmt += getRewriterText(func_arg_ctx.argument(0)) + ", ";
                        else {
                            abort = true;
                        }

                        if (!abort) {
                            insert_stmt += getRewriterText(ctx.expression()) + ")";
                            replace(ctx, insert_stmt);
                            return;
                        }
                    }
                }
            }

            String target = getRewriterText(ctx.general_element());

            if (target.startsWith(":"))
                replace(ctx.general_element(), target.substring(1));
        }

        replace(ctx.ASSIGN_OP(), "=");
    }

    @Override
    public void exitSimple_case_expression(Simple_case_expressionContext ctx) {
        String case_expression = getRewriterText(ctx.expression());
        delete(ctx.expression());
        for (Case_when_part_expressionContext caseWhenPartStatement : ctx.case_when_part_expression()) {
            convertCaseExpressionInsideSimpleCaseExpression(caseWhenPartStatement, case_expression);
        }
    }

    private void convertCaseExpressionInsideSimpleCaseExpression(Case_when_part_expressionContext caseWhenPartExpressionContext, String expression) {
        for (int i = 0; i < caseWhenPartExpressionContext.expression().size() - 1; i++) {
            ExpressionContext expressionContext = caseWhenPartExpressionContext.expression(i);
            Relational_operatorContext operator;
            try {
                operator = expressionContext.logical_expression().unary_logical_expression().
                        multiset_expression().relational_expression().relational_operator();
            } catch (NullPointerException e) {
                operator = null;
            }
            if (operator == null) {
                if (Ora2rdb.getRealName(getRuleText(expressionContext)).equals("NULL"))
                    insertBefore(expressionContext, expression + " IS ");
                else
                    insertBefore(expressionContext, expression + "= ");
            } else
                insertBefore(expressionContext, expression);
        }
        for (TerminalNode comma : caseWhenPartExpressionContext.COMMA())
            replace(comma, " OR ");
    }

    @Override
    public void exitSimple_case_statement(Simple_case_statementContext ctx) {
        deleteSPACESLeft(ctx.ck1);
        delete(ctx.ck1);
        delete(ctx.END());
        delete(ctx.CASE(1));
        String indentation = getIndentation(ctx);
        String expression = getRewriterText(ctx.expression()) + " ";
        delete(ctx.expression());
        deleteSPACESLeft(ctx.expression());
        for (Case_when_part_statementContext caseWhenPartStatement : ctx.case_when_part_statement()) {
            if (caseWhenPartStatement.equals(ctx.case_when_part_statement(0)))
                replace(caseWhenPartStatement.WHEN(), "IF");
            else
                replace(caseWhenPartStatement.WHEN(), "ELSE IF");
            convertCaseExpressionInsideSimpleCaseStatement(caseWhenPartStatement, expression);
            insertBefore(caseWhenPartStatement.seq_of_statements(), "BEGIN \n\t" + indentation + '\t');
            insertAfter(caseWhenPartStatement.seq_of_statements(), '\n' + indentation + "\tEND");
            replace(caseWhenPartStatement.THEN(), "THEN");
        }

        if (ctx.case_else_part_statement() != null) {
            replace(ctx.case_else_part_statement().ELSE(), "ELSE");
            insertBefore(ctx.case_else_part_statement().seq_of_statements(), "BEGIN \n\t" + indentation + '\t');
            insertAfter(ctx.case_else_part_statement().seq_of_statements(), '\n' + indentation + "\tEND");
        } else {
            insertAfter(ctx, "ELSE BEGIN\n" + indentation +
                    "\t\tEXCEPTION CASE_NOT_FOUND;\n" + indentation +
                    "\tEND");
            exceptions.put("CASE_NOT_FOUND", "CASE not found while executing CASE statement");
        }

        deleteSemicolonRight(ctx);
    }

    private void convertCaseExpressionInsideSimpleCaseStatement(Case_when_part_statementContext caseWhenPartStatement, String expression) {
        for (int i = 0; i < caseWhenPartStatement.expression().size(); i++) {
            ExpressionContext expressionContext = caseWhenPartStatement.expression(i);
            Relational_operatorContext operator;
            try {
                operator = expressionContext.logical_expression().unary_logical_expression().
                        multiset_expression().relational_expression().relational_operator();
            } catch (NullPointerException e) {
                operator = null;
            }
            if (operator == null) {
                if (Ora2rdb.getRealName(getRuleText(expressionContext)).equals("NULL"))
                    insertBefore(expressionContext, expression + " IS ");
                else
                    insertBefore(expressionContext, expression + "= ");
            } else
                insertBefore(expressionContext, expression);
            if (i == 0)
                insertBefore(expressionContext, "(");
            if (i == caseWhenPartStatement.expression().size() - 1)
                insertAfter(expressionContext, ")");
        }
        for (TerminalNode comma : caseWhenPartStatement.COMMA())
            replace(comma, " OR ");
    }

    @Override
    public void exitSearched_case_statement(Searched_case_statementContext ctx) {
        deleteSPACESLeft(ctx.ck1);
        delete(ctx.ck1);
        delete(ctx.END());
        delete(ctx.CASE(1));
        String indentation = getIndentation(ctx);
        for (Case_when_part_statementContext caseWhenPartStatement : ctx.case_when_part_statement()) {
            if (caseWhenPartStatement.equals(ctx.case_when_part_statement(0)))
                replace(caseWhenPartStatement.WHEN(), "IF");
            else
                replace(caseWhenPartStatement.WHEN(), "ELSE IF");
            insertBefore(caseWhenPartStatement.expression(0), "(");
            insertAfter(caseWhenPartStatement.expression(0), ")");
            insertBefore(caseWhenPartStatement.seq_of_statements(), "BEGIN \n\t" + indentation + '\t');
            insertAfter(caseWhenPartStatement.seq_of_statements(), '\n' + indentation + "\tEND");
            replace(caseWhenPartStatement.THEN(), "THEN");
        }
        if (ctx.case_else_part_statement() != null) {
            replace(ctx.case_else_part_statement().ELSE(), "ELSE");
            insertBefore(ctx.case_else_part_statement().seq_of_statements(), "BEGIN \n\t" + indentation + '\t');
            insertAfter(ctx.case_else_part_statement().seq_of_statements(), '\n' + indentation + "\tEND");
        } else {
            insertAfter(ctx, "ELSE BEGIN\n" + indentation +
                    "\t\tEXCEPTION CASE_NOT_FOUND;\n" + indentation +
                    "\tEND");
            exceptions.put("CASE_NOT_FOUND", "CASE not found while executing CASE statement");
        }
        deleteSemicolonRight(ctx);
    }

    @Override
    public void exitIf_statement(If_statementContext ctx) {
        if (ctx.condition().LEFT_PAREN() == null && ctx.condition().RIGHT_PAREN() == null) {
            insertBefore(ctx.condition(), "(");
            insertAfter(ctx.condition(), ")");
        }

        if (!ctx.seq_of_statements().statement().isEmpty()) {
            String indentation = getIndentation(ctx);
            insertAfter(ctx.THEN(), "\n" + indentation + "BEGIN");
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");
        }
        delete(ctx.END());
        deleteSPACESAbut(ctx.END());
        delete(ctx.IF(1));
    }

    @Override
    public void exitElsif_part(Elsif_partContext ctx) {
        replace(ctx.ELSIF(), "ELSE IF");
        if (ctx.condition().LEFT_PAREN() == null && ctx.condition().RIGHT_PAREN() == null) {
            insertBefore(ctx.condition(), "(");
            insertAfter(ctx.condition(), ")");
        }
        if (!ctx.seq_of_statements().statement().isEmpty()) {
            String indentation = getIndentation(ctx);
            insertAfter(ctx.THEN(), "\n" + indentation + "BEGIN");
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");
        }
    }

    @Override
    public void exitElse_part(Else_partContext ctx) {
        if (!ctx.seq_of_statements().statement().isEmpty()) {
            String indentation = getIndentation(ctx);
            insertAfter(ctx.ELSE(), "\n" + indentation + "BEGIN");
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");
        }
    }

    @Override
    public void enterLoop_statement(Loop_statementContext ctx) {

        if (ctx.FOR() != null && ctx.cursor_loop_param() != null) {
            if (ctx.cursor_loop_param().DOUBLE_PERIOD() != null) {
                String index_name = Ora2rdb.getRealName((getRuleText(ctx.cursor_loop_param().index_name())));

                if (current_plsql_block != null)
                    if (!current_plsql_block.containsInScope(Ora2rdb.getRealName(getRuleText(ctx))))
                        current_plsql_block.declareVar(index_name);

                // check if it for in collection
                boolean isCollection = Ora2rdb.getRealName(getRuleText(ctx.cursor_loop_param().lower_bound())).contains(".");
                if (isCollection) {
                    String nameOfCollection = Ora2rdb.getRealName(getRuleText(ctx.cursor_loop_param().lower_bound()));
                    nameOfCollection = nameOfCollection.substring(0, nameOfCollection.indexOf("."));

                    if (current_plsql_block != null && current_plsql_block.array_to_table.containsKey(nameOfCollection)) {
                        String recName = nameOfCollection + "_ITEM" + "." + "I1";
//                        String cursorName = nameOfCollection + "_TEMP_CURSOR";
                        current_plsql_block.pushReplaceRecordName(index_name, recName, true);
                        current_plsql_block.declareVar(recName);
                    }
                }

            }
            if (ctx.cursor_loop_param().cursor_name() != null && !cursorNameIsFunction(ctx)) {
                String recName = Ora2rdb.getRealName(ctx.cursor_loop_param().record_name().getText());
                String cursorName = Ora2rdb.getRealName(ctx.cursor_loop_param().cursor_name().getText());
                current_plsql_block.pushScope();
                if (!current_plsql_block.cursor_select_statement.containsKey(cursorName))
                    current_plsql_block.pushReplaceRecordName(recName, cursorName + "_" + recName, true);
                else
                    current_plsql_block.pushReplaceRecordName(recName, cursorName + "_" + recName, false);
            }
        }
    }

    @Override
    public void exitLoop_statement(Loop_statementContext ctx) {
        if (ctx.FOR() != null)
            convertLoopFor(ctx);
        else if (ctx.WHILE() != null)
            convertLoopWhile(ctx);
        else {
            replace(ctx.LOOP(0), "WHILE (TRUE) DO BEGIN");
            delete(ctx.LOOP(1));
        }
    }

    @Override
    public void exitExit_statement(Exit_statementContext ctx) {
        String indentation = getIndentation(ctx);
        replace(ctx.EXIT(), "LEAVE");
        if (ctx.WHEN() != null) {
            delete(ctx.WHEN());
            insertBefore(ctx, "IF( " + getRewriterText(ctx.condition()) + " ) THEN \n" + indentation + "\t");
            delete(ctx.condition());
        }
    }

    @Override
    public void exitContinue_statement(Continue_statementContext ctx) {
        String indendation = getIndentation(ctx);
        if (Finder.getFirstRuleContext(ctx, Label_nameContext.class) == null) {
            Loop_statementContext lctx = Finder.getParentRuleContext(ctx, Loop_statementContext.class);
            if (lctx != null) {
                if (lctx.FOR() != null && lctx.cursor_loop_param() != null) {
                    if (lctx.cursor_loop_param().DOUBLE_PERIOD() != null && lctx.cursor_loop_param().REVERSE() != null) {
                        String index_name = lctx.cursor_loop_param().index_name().getText();
                        insertBefore(ctx, index_name + " = " + index_name + " - 1;\n" + indendation);
                    } else if (lctx.cursor_loop_param().DOUBLE_PERIOD() != null) {
                        String index_name = lctx.cursor_loop_param().index_name().getText();
                        insertBefore(ctx, index_name + " = " + index_name + " + 1;\n" + indendation);
                    }
                }
            }
        }
        if (ctx.WHEN() != null) {
            insertBefore(ctx, "IF (" + getRewriterText(ctx.condition()) + ") THEN BEGIN \n" + indendation + "\t");
            insertAfter(ctx, "\n" + indendation + "END\n");
            deleteSemicolonRight(ctx);
            insertAfter(ctx, ';');
            delete(ctx.WHEN());
            delete(ctx.condition());
        }
    }

    private boolean cursorNameIsFunction(Loop_statementContext ctx) {
        if (ctx.cursor_loop_param() != null) {
            Cursor_loop_paramContext cursorLoopParam = ctx.cursor_loop_param();
            if (cursorLoopParam.cursor_name().general_element() != null) {
                General_elementContext generalElement = ctx.cursor_loop_param().cursor_name().general_element();
                if (generalElement.general_element_part() != null) {
                    General_element_partContext generalElementPart = generalElement.general_element_part(0);
                    if (generalElementPart.function_argument() != null)
                        return true;
                }
            }

        }
        return false;
    }

    private void convertLoopForRecordInCursor(Loop_statementContext ctx) {
        String cursorName = Ora2rdb.getRealName(ctx.cursor_loop_param().cursor_name().getText());
        String recName = cursorName + "_" + Ora2rdb.getRealName(ctx.cursor_loop_param().record_name().getText());
        loop_rec_name_and_cursor_name.put(recName, cursorName);
        String indentation = getIndentation(ctx);
        String openCursor = '\n' + indentation + "OPEN " + cursorName + ";";
        String fetchCursor = '\n' + indentation + "FETCH " + cursorName + " INTO " + recName + ";\n";

        insertBefore(ctx, openCursor + fetchCursor);
        deleteSPACESLeft(ctx.FOR());
        replace(ctx.FOR(), indentation + "WHILE ( ROW_COUNT != 0 ) DO");
        delete(ctx.cursor_loop_param());
        deleteSPACESAbut(ctx.cursor_loop_param());

        // two insertAfter to convert cursor%ROWCOUNT in for in <cursor>
        insertAfter(ctx.seq_of_statements(), "\n" + indentation + "\tFETCH " + cursorName + " INTO " + recName + ";\n"
                + indentation /*+ "END"*/);
        insertAfter(getNextToken(ctx.seq_of_statements().stop), "END");

        insertAfter(ctx, "\n" + indentation + "CLOSE " + cursorName + ";\n");


        insertAfter(ctx.LOOP(0), "\n" + indentation + "BEGIN");


        delete(ctx.END());
        deleteSPACESLeft(ctx.END());

        delete(ctx.LOOP(0));
        deleteSPACESLeft(ctx.LOOP(0));

        delete(ctx.LOOP(1));
        deleteSPACESAbut(ctx.LOOP(1));
    }


    private void convertLoopForRecordInSelect(Loop_statementContext ctx) {
        String rowRecName = getRewriterText(ctx.cursor_loop_param().record_name());
        String indentation = getIndentation(ctx);
        rowtype_rec_name_and_select_statement.put(rowRecName,
                getRewriterText(ctx.cursor_loop_param().select_statement())
        );
        Cursor_loop_paramContext cursorLoopParam = ctx.cursor_loop_param();
        deleteSPACESLeft(cursorLoopParam.record_name());
        delete(cursorLoopParam.record_name());

        deleteSPACESLeft(cursorLoopParam.IN());
        delete(cursorLoopParam.IN());

        if (cursorLoopParam.select_statement() != null) {
            Select_statementContext selectStatement = cursorLoopParam.select_statement();
            if (selectStatement.select_only_statement() != null) {
                Select_only_statementContext selectOnlyStatement = selectStatement.select_only_statement();
                if (selectOnlyStatement.subquery() != null) {
                    SubqueryContext subquery = selectOnlyStatement.subquery();
                    if (subquery.subquery_basic_elements() != null) {
                        Subquery_basic_elementsContext subqueryBasicElements = subquery.subquery_basic_elements();
                        if (subqueryBasicElements.query_block() != null) {
                            Query_blockContext queryBlock = subqueryBasicElements.query_block();
                            if (queryBlock.selected_list().ASTERISK() == null
                                    && queryBlock.selected_list().select_list_elements().size() < 2) {
                                insertBefore(queryBlock.selected_list(), "ROW( ");
                                insertAfter(queryBlock.selected_list(), " )");
                            }
                        }
                    }
                }
            }
        }


        insertAfter(cursorLoopParam.RIGHT_PAREN(), " INTO " + rowRecName + " DO\n"
                + indentation + "BEGIN\n");

        delete(ctx.LOOP(0));
        deleteSPACESLeft(ctx.LOOP(0));

        delete(ctx.LOOP(1));
        deleteSPACESLeft(ctx.LOOP(1));
    }

    private void convertForInCollection(Loop_statementContext ctx) {
        String nameOfCollection = Ora2rdb.getRealName(getRuleText(ctx.cursor_loop_param().lower_bound()));
        nameOfCollection = nameOfCollection.substring(0, nameOfCollection.indexOf("."));

        if (current_plsql_block != null && current_plsql_block.array_to_table.containsKey(nameOfCollection)) {
            String recName = nameOfCollection + "_ITEM";
            String cursorName = nameOfCollection + "_TEMP_CURSOR";

            loop_for_in_collection.put(nameOfCollection,
                    "SELECT I1, VAL FROM " + current_plsql_block.array_to_table.get(nameOfCollection));

            String indentation = getIndentation(ctx);
            String openCursor = '\n' + indentation + "OPEN " + cursorName + ";";
            String fetchCursor = '\n' + indentation + "FETCH " + cursorName + " INTO " + recName + ";\n";

            insertBefore(ctx, openCursor + fetchCursor);
            deleteSPACESLeft(ctx.FOR());
            replace(ctx.FOR(), indentation + "WHILE ( ROW_COUNT != 0 ) DO");
            delete(ctx.cursor_loop_param());
            deleteSPACESAbut(ctx.cursor_loop_param());
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "\tFETCH " + cursorName + " INTO " + recName + ";\n"
                    + indentation + "END");
            insertAfter(ctx, "\n" + indentation + "CLOSE " + cursorName + ";\n");


            insertAfter(ctx.LOOP(0), "\n" + indentation + "BEGIN");


            delete(ctx.END());
            deleteSPACESLeft(ctx.END());

            delete(ctx.LOOP(0));
            deleteSPACESLeft(ctx.LOOP(0));

            delete(ctx.LOOP(1));
            deleteSPACESAbut(ctx.LOOP(1));
        }
    }

    private void createTempCursorAndRowtypeVariable(BodyContext ctx) {
        StringBuilder declare_cursor_and_rowtype = new StringBuilder();
        if (!rowtype_rec_name_and_select_statement.isEmpty()) {
            for (String rec : rowtype_rec_name_and_select_statement.keySet()) {
                String cursor_name = rec + "_TEMP_CURSOR";
                declare_cursor_and_rowtype.append("\n  DECLARE VARIABLE ").append(cursor_name).
                        append(" CURSOR FOR (").append(rowtype_rec_name_and_select_statement.get(rec)).append(");\n");

                declare_cursor_and_rowtype.append("\n  DECLARE VARIABLE ").append(rec).
                        append(" TYPE OF TABLE ").append(cursor_name).append(";\n");
            }
            insertBefore(ctx, declare_cursor_and_rowtype);
        }
        if (!loop_for_in_collection.isEmpty()) {
            for (String nameOfCollection : loop_for_in_collection.keySet()) {
                String rec = nameOfCollection + "_ITEM";
                String cursor_name = nameOfCollection + "_TEMP_CURSOR";

                declare_cursor_and_rowtype.append("\n  DECLARE VARIABLE ").append(cursor_name).
                        append(" CURSOR FOR (").append(loop_for_in_collection.get(nameOfCollection)).append(");\n");

                declare_cursor_and_rowtype.append("\n  DECLARE VARIABLE ").append(rec).
                        append(" TYPE OF TABLE ").append(cursor_name).append(";\n");
            }
            loop_for_in_collection.clear();
            insertBefore(ctx, declare_cursor_and_rowtype);
        }
    }

    private void convertLoopForInRange(Loop_statementContext ctx) {

        Cursor_loop_paramContext cursorLoopParam = Finder.getFirstRuleContext(ctx, Cursor_loop_paramContext.class);
        if (cursorLoopParam != null) {
            if (Finder.getFirstRuleContext(cursorLoopParam.lower_bound(), General_element_partContext.class) != null
                    || Finder.getFirstRuleContext(cursorLoopParam.upper_bound(), General_element_partContext.class) != null)
                return;
        }

        boolean isCollection = Ora2rdb.getRealName(getRuleText(ctx.cursor_loop_param().lower_bound())).contains(".");
        if (isCollection) {
            convertForInCollection(ctx);
            return;
        }

        String index_name = ctx.cursor_loop_param().index_name().getText();

        if (!loop_index_names.contains(index_name))
            loop_index_names.add(index_name);

        String indentation = getIndentation(ctx);
        String target = getRewriterText(ctx.cursor_loop_param().index_name());
        if (target.startsWith(":"))
            replace(ctx.cursor_loop_param().index_name(), target.substring(1));

        insertBefore(ctx, index_name + " = " + ctx.cursor_loop_param().lower_bound().getText() + ";\n");

        replace(ctx.FOR(), indentation + "WHILE (");
        insertAfter(ctx.cursor_loop_param(), ") DO" + '\n' + indentation + "BEGIN");

        replace(ctx.cursor_loop_param().IN(), " <= ");
        deleteSPACESAbut(ctx.cursor_loop_param().IN());
        delete(ctx.cursor_loop_param().lower_bound());
        deleteSPACESAbut(ctx.cursor_loop_param().lower_bound());
        delete(ctx.cursor_loop_param().DOUBLE_PERIOD());
        deleteSPACESAbut(ctx.cursor_loop_param().DOUBLE_PERIOD());
        insertAfter(ctx.seq_of_statements(), '\n' + indentation + index_name + " = " + index_name + " + 1;\n" + indentation + "END");

        delete(ctx.LOOP(0));
        deleteSPACESLeft(ctx.LOOP(0));
        delete(ctx.LOOP(1));
        deleteSPACESLeft(ctx.LOOP(1));
        delete(ctx.END());
        deleteSPACESLeft(ctx.END());
    }

    private void convertLoopForInRangeReverse(Loop_statementContext ctx) {

        Cursor_loop_paramContext cursorLoopParam = Finder.getFirstRuleContext(ctx, Cursor_loop_paramContext.class);
        if (cursorLoopParam != null) {
            if (Finder.getFirstRuleContext(cursorLoopParam.lower_bound(), General_element_partContext.class) != null
                    || Finder.getFirstRuleContext(cursorLoopParam.upper_bound(), General_element_partContext.class) != null)
                return;
        }

        String index_name = ctx.cursor_loop_param().index_name().getText();

        if (!loop_index_names.contains(index_name))
            loop_index_names.add(index_name);

        String target = getRewriterText(ctx.cursor_loop_param().index_name());
        if (target.startsWith(":"))
            replace(ctx.cursor_loop_param().index_name(), target.substring(1));

        insertBefore(ctx, index_name + " = " + ctx.cursor_loop_param().upper_bound().getText() + ";\n");

        String indentation = getIndentation(ctx);
        replace(ctx.FOR(), indentation + "WHILE (");
        insertAfter(ctx.cursor_loop_param(), ") DO" + '\n' + indentation + "BEGIN");
        insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");
        replace(ctx.cursor_loop_param().IN(), " >= ");
        delete(ctx.cursor_loop_param().REVERSE());
        delete(ctx.cursor_loop_param().upper_bound());
        delete(ctx.cursor_loop_param().DOUBLE_PERIOD());

        insertAfter(ctx.seq_of_statements(), '\n' + index_name + " = " + index_name + " - 1;");


        delete(ctx.LOOP(0));
        deleteSPACESLeft(ctx.LOOP(0));
        delete(ctx.LOOP(1));
        delete(ctx.END());
        deleteSPACESLeft(ctx.END());
    }

    private void convertLoopFor(Loop_statementContext ctx) {
        if (ctx.cursor_loop_param() == null) return;
        if (ctx.cursor_loop_param().REVERSE() != null && ctx.cursor_loop_param().DOUBLE_PERIOD() != null) {
            convertLoopForInRangeReverse(ctx);
        } else if (ctx.cursor_loop_param().DOUBLE_PERIOD() != null) {
            convertLoopForInRange(ctx);
        } else if (ctx.cursor_loop_param().record_name() != null && ctx.cursor_loop_param().cursor_name() != null && !cursorNameIsFunction(ctx)) {
            convertLoopForRecordInCursor(ctx);
            current_plsql_block.popReplaceRecordName();
            current_plsql_block.popScope();
        } else if (ctx.cursor_loop_param().record_name() != null && ctx.cursor_loop_param().select_statement() != null) {
            convertLoopForRecordInSelect(ctx);
        } else {

            String indentation = getIndentation(ctx);

            insertAfter(ctx.cursor_loop_param(), "\n" + indentation + "DO" + '\n' + indentation + "BEGIN");
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");


            delete(ctx.LOOP(0));
            deleteSPACESLeft((ctx.LOOP(0)));

            delete(ctx.END());
            deleteSPACESLeft(ctx.END());

            delete(ctx.LOOP(1));
            deleteSPACESLeft(ctx.LOOP(1));
        }
    }

    public void convertLoopWhile(Loop_statementContext ctx) {
        if (ctx.condition().LEFT_PAREN() == null && ctx.condition().RIGHT_PAREN() == null) {
            insertBefore(ctx.condition(), "(");
            insertAfter(ctx.condition(), ") DO");
        } else
            insertAfter(ctx.condition(), " DO");


        deleteSPACESRight(ctx.condition());
        String indentation = getIndentation(ctx);
        insertAfter(ctx.LOOP(0), "\n" + indentation + "BEGIN");
        insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");
        delete(ctx.LOOP(0));
        delete(ctx.LOOP(1));
        deleteSPACESAbut(ctx.LOOP(1));
        delete(ctx.END());
        deleteSPACESAbut(ctx.END());
    }

    @Override
    public void exitReturn_statement(Return_statementContext ctx) {

        if (ctx.expression() != null) {
            String returnVal = getRewriterText(ctx.expression());

            if (returnVal.startsWith(":"))
                replace(ctx.expression(), returnVal.substring(1));
        }
        StoredFunction storedFunction;
        if (!storedBlocksStack.isEmpty()) {
            if (storedBlocksStack.peek() instanceof StoredFunction) {
                storedFunction = (StoredFunction) storedBlocksStack.peek();
                if (storedFunction.containOutParameters()) {
                    StringBuilder return_parameters = new StringBuilder();
                    String indentation = getIndentation(ctx);
                    for (Parameter parameter : storedFunction.getParameters().values()) {
                        if (parameter.isOut()) {
                            return_parameters.append(indentation).append(parameter.getName()).append("_OUT = ").append(parameter.getName()).append(";\n");
                        }
                    }
                    if (ctx.expression() != null) {
                        indentation = getIndentation(ctx);
                        replace(ctx, "RET_VAL = " + getRewriterText(ctx.expression()) + ";\n" + return_parameters +
                                indentation + "SUSPEND;\n" +
                                indentation + "EXIT");
                    } else
                        replace(ctx, "EXIT");
                }
            } else
                replace(ctx, "EXIT");
        }
    }

    @Override
    public void enterSeq_of_statements(Seq_of_statementsContext ctx) {
        pushScope();
    }

    @Override
    public void exitSeq_of_statements(Seq_of_statementsContext ctx) {
        for (int i = 0; i < ctx.statement().size(); i++) {
            StatementContext stmt_ctx = ctx.statement(i);

            if (stmt_ctx.if_statement() != null ||
                    stmt_ctx.loop_statement() != null ||
                    stmt_ctx.body() != null)
                delete(ctx.SEMICOLON(i));
            if (stmt_ctx.null_statement() != null) {
                delete(stmt_ctx.null_statement());
                delete(ctx.SEMICOLON(i));
//                deleteSPACESLeft(stmt_ctx.null_statement());
            }
            //convert DELETE method of associative array
            if (stmt_ctx.sql_statement() != null && stmt_ctx.sql_statement().collection_method_call() != null &&
                    stmt_ctx.sql_statement().collection_method_call().DELETE() != null) {

                String name = Ora2rdb.getRealName(getRuleText(stmt_ctx.sql_statement()
                        .collection_method_call().expression().stream().findFirst().orElse(null)));

                if (current_plsql_block != null && current_plsql_block.array_to_table.containsKey(name)) {
                    StringBuilder deleteStmt = new StringBuilder("DELETE FROM " + current_plsql_block.array_to_table.get(name));
                    List<ExpressionContext> expr_list = stmt_ctx.sql_statement().collection_method_call().expression();
                    if (expr_list.size() <= 2) {
                        String argument = Ora2rdb.getRealName(getRuleText(expr_list.get(1)));
                        if (isVariable(argument))
                            argument = ":" + argument;
                        if (!argument.isEmpty())
                            deleteStmt.append(" WHERE K = ").append(argument);
                    } else {
                        deleteStmt.append(" WHERE K >= ");
                        String argument;
                        for (int j = 1; j < expr_list.size(); j++) {
                            if (j != 1)
                                deleteStmt.append(" AND K <= ");
                            argument = Ora2rdb.getRealName(getRuleText(expr_list.get(j)));
                            if (isVariable(argument))
                                argument = ":" + argument;
                            deleteStmt.append(argument);
                        }
                        deleteStmt.append(" ORDER BY K");
                    }
                    replace(stmt_ctx, deleteStmt);
                }
            }
        }
        popScope();
    }

    @Override
    public void enterSelection_directive(Selection_directiveContext ctx) {
        commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
    }

    @Override
    public void exitSelect_statement(Select_statementContext ctx) {
       List<Order_by_elementsContext> orderByElementList = Finder.getAllRuleContexts(ctx, Order_by_elementsContext.class);
       for( Order_by_elementsContext orderByElement : orderByElementList){
           if(orderByElement.NULLS()==null){
               if(orderByElement.ASC() != null){
                   insertAfter(orderByElement.ASC(), " NULLS LAST");
               }
               else if(orderByElement.DESC() != null){
                   insertAfter(orderByElement.DESC(), " NULLS FIRST");
               }
               else if(orderByElement.ASC() == null && orderByElement.DESC() == null){
                   insertAfter(orderByElement, " ASC NULLS LAST");
               }
           }
       }

       Finder.getAllRuleContexts(ctx, Query_blockContext.class).stream()
               .filter(queryBlock ->  queryBlock.UNIQUE() != null)
               .forEach(queryBlock -> replace(queryBlock.UNIQUE(), "DISTINCT"));
    }

    @Override
    public void exitSelect_list_elements(Select_list_elementsContext ctx) {
        if (Ora2rdb.getRealName(ctx.getText()).equals("ROWID"))
            replace(ctx, "RDB$DB_KEY");
    }

    @Override
    public void exitInsert_statement(Insert_statementContext ctx) {


        Values_clauseContext valuesClause = Finder.getFirstRuleContext(ctx, Values_clauseContext.class);
        if(valuesClause != null && valuesClause.expressions_() != null){
            for(ExpressionContext expression : Finder.getAllRuleContexts(valuesClause, ExpressionContext.class)) {
                General_element_partContext generalElementPart = Finder.getFirstRuleContext(expression, General_element_partContext.class);
                if (generalElementPart != null) {
                    if (generalElementPart.id_expression().size() <= 2
                            && Ora2rdb.getRealName(generalElementPart.id_expression(generalElementPart.id_expression().size() - 1).getText()).equals("NEXTVAL")) {
                        insertBefore(expression, "NEXT VALUE FOR ");
                        delete(generalElementPart.id_expression(1));
                        delete(generalElementPart.PERIOD(generalElementPart.PERIOD().size() - 1));
                    }
                }
            }
        }
    }

    @Override
    public void exitStatic_returning_clause(Static_returning_clauseContext ctx) {
        if(ctx.RETURN() != null)
            replace(ctx.RETURN(), "RETURNING");
    }

    @Override
    public void exitRelational_expression(Relational_expressionContext ctx) {
        if (Ora2rdb.getRealName(ctx.getText()).equals("ROWID"))
            replace(ctx, "RDB$DB_KEY");
    }

    @Override
    public void exitException_handler(Exception_handlerContext ctx) {
        String indentation = getIndentation(ctx.seq_of_statements());
        replace(ctx.THEN(), "DO");
        deleteSPACESRight(ctx.seq_of_statements());

        insertBefore(ctx.seq_of_statements(), "BEGIN\n\t" + indentation);
        insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END\n");

        for (int i = 0; i < ctx.exception_name().size(); i++) {
            replace(ctx.exception_name(i), convertException_name(ctx.exception_name(i)));
        }

    }

    private String convertException_name(Exception_nameContext ctx) {
        String exceptionName = Ora2rdb.getRealName(ctx.getText());
        switch (exceptionName) {
            case "TOO_MANY_ROWS":
                return "GDSCODE SING_SELECT_ERR";
            case "DUP_VAL_ON_INDEX":
                return "GDSCODE UNIQUE_KEY_VIOLATION";
            case "NO_DATA_FOUND":
                return "EXCEPTION NO_DATA_FOUND";
//             case "ROW_LOCKED":
//                 return "SING_SELECT_ERR";
            case "VALUE_ERROR":
                return "GDSCODE SING_SELECT_ERR";
            case "ZERO_DIVIDE":
                return "GDSCODE EXCEPTION_INTEGER_DIVIDE_BY_ZERO, GDSCODE EXCEPTION_FLOAT_DIVIDE_BY_ZERO";
            case "OTHERS":
                return "ANY";
        }
        return exceptionName;
    }

    private String convertSystemTable(String id_expr) {
        switch (id_expr) {
            case "DUAL":
                return "RDB$DATABASE";
            // TODO : добавить конвертацию других системных таблиц
            default:
                return null;
        }
    }

}
