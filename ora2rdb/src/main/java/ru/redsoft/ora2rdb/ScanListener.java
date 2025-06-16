package ru.redsoft.ora2rdb;

import java.util.*;
import java.util.stream.Collectors;

import ru.redsoft.ora2rdb.PlSqlParser.*;

public class ScanListener extends PlSqlParserBaseListener {
    Stack<StoredBlock> storedBlocksStack = new Stack<>();
    String currentProcedureName;
    String current_package_name = null;
    StoredTrigger current_trigger = null;
    String current_cursor_declaration = null;

    @Override
    public void enterCreate_package_body(Create_package_bodyContext ctx) {
        current_package_name = Ora2rdb.getRealName(ctx.package_name(0).getText());
        for (Package_obj_bodyContext obj_body : ctx.package_obj_body()) {
            if (obj_body.type_declaration() != null) {
                Type_declarationContext type = obj_body.type_declaration();
                if (type.record_type_def() != null) {
                    for (Field_specContext field_spec : type.record_type_def().field_spec()) {
                        if (field_spec.type_spec() != null) {
                            Type_specContext typeSpec = field_spec.type_spec();
                            if (typeSpec.type_name() != null && typeSpec.PERCENT_TYPE() != null) {
                                String tableName = Ora2rdb.getRealName(typeSpec.type_name().id_expression(0).getText());
                                String columnName = Ora2rdb.getRealName(typeSpec.type_name().id_expression(1).getText());
                                if (StorageInfo.types_of_column.containsKey(tableName)) {
                                    StorageInfo.types_of_column.get(tableName).put(columnName, null);
                                } else {
                                    TreeMap<String, String> unknown_column_type = new TreeMap<>();
                                    unknown_column_type.put(columnName, null);
                                    StorageInfo.types_of_column.put(tableName, unknown_column_type);
                                }
                            }
                        }
                    }
                }

            }
        }
    }

    @Override
    public void exitCreate_package_body(Create_package_bodyContext ctx) {
        current_package_name = null;
    }

    @Override
    public void enterCreate_table(Create_tableContext ctx) {
        if(ctx.relational_table() == null)
            return;
        Table table = new Table();
        String name;
        name = Ora2rdb.getRealName(ctx.schema_and_name().name.getText());
        table.setName(name);
            for (Relational_propertyContext rela_prop : ctx.relational_table().relational_property()) {
                if (rela_prop.column_definition() == null)
                    continue;
                if (rela_prop.column_definition().datatype() != null)
                    table.setColumn(Ora2rdb.getRealName(rela_prop.column_definition().column_name().getText()),
                            Ora2rdb.getRealName(rela_prop.column_definition().datatype().native_datatype_element().getText())
                    );
                else
                    table.setColumn(Ora2rdb.getRealName(rela_prop.column_definition().column_name().getText()),
                            Ora2rdb.getRealName(rela_prop.column_definition().regular_id().getText())
                    );

        }
        StorageInfo.tables.add(table);
    }

    @Override
    public void enterAlter_table(Alter_tableContext ctx) {
        Column_clausesContext columns_ctx = ctx.column_clauses();
        Constraint_clausesContext constraint_clauses_ctx = ctx.constraint_clauses();

        if (columns_ctx != null) {
            Add_modify_drop_column_clausesContext add_modify_drop_column_clauses_ctx = columns_ctx.add_modify_drop_column_clauses();
            if (add_modify_drop_column_clauses_ctx != null) {
                if (add_modify_drop_column_clauses_ctx.constraint_clauses() != null) {
                    Modify_column_clausesContext modify_column_clauses_ctx = add_modify_drop_column_clauses_ctx.modify_column_clauses(0);
                    if (!modify_column_clauses_ctx.modify_col_properties().isEmpty()) {
                        Modify_col_propertiesContext modify_col_properties_ctx = modify_column_clauses_ctx.modify_col_properties(0);

                        if (!modify_col_properties_ctx.inline_constraint().isEmpty()) {
                            Inline_constraintContext inline_constraint_ctx = modify_col_properties_ctx.inline_constraint(0);

                            if (inline_constraint_ctx.NOT() != null && inline_constraint_ctx.NULL_() != null) {
                                String table_name = Ora2rdb.getRealName(ctx.tableview_name().schema_and_name().name.getText());
                                String column_name = Ora2rdb.getRealName(modify_col_properties_ctx.column_name().getText());

                                if (StorageInfo.table_not_null_cols.containsKey(table_name)) {
                                    StorageInfo.table_not_null_cols.get(table_name).add(column_name);
                                } else {
                                    TreeSet<String> columns_set = new TreeSet<String>();
                                    columns_set.add(column_name);
                                    StorageInfo.table_not_null_cols.put(table_name, columns_set);
                                }
                            }
                        }
                    }
                }
            }
        } else if (constraint_clauses_ctx != null) {
            if (!constraint_clauses_ctx.out_of_line_constraint().isEmpty()) {
                Out_of_line_constraintContext out_of_line_constraint_ctx = constraint_clauses_ctx.out_of_line_constraint(0);

                if (out_of_line_constraint_ctx.PRIMARY() != null) {
                    TreeSet<String> columns_set = new TreeSet<String>();

                    for (Column_nameContext column_name_ctx : out_of_line_constraint_ctx.column_name())
                        columns_set.add(Ora2rdb.getRealName(column_name_ctx.getText()));

                    String table_name = Ora2rdb.getRealName(ctx.tableview_name().schema_and_name().name.getText());

                    if (StorageInfo.table_not_null_cols.containsKey(table_name))
                        StorageInfo.table_not_null_cols.get(table_name).addAll(columns_set);
                    else
                        StorageInfo.table_not_null_cols.put(table_name, columns_set);
                }
                if (out_of_line_constraint_ctx.PRIMARY() != null)
                    StorageInfo.index_names.add(new Index(Ora2rdb.getRealName(out_of_line_constraint_ctx.constraint_name().getText()), null, null, null, true));
                else if (out_of_line_constraint_ctx.UNIQUE() != null)
                    StorageInfo.index_names.add(new Index(Ora2rdb.getRealName(out_of_line_constraint_ctx.constraint_name().getText()), null, null, null, true));
                else if (out_of_line_constraint_ctx.foreign_key_clause() != null) {
                    if (out_of_line_constraint_ctx.foreign_key_clause().FOREIGN() != null)
                        StorageInfo.index_names.add(new Index(Ora2rdb.getRealName(out_of_line_constraint_ctx.constraint_name().getText()), null, null, null, true));
                }
            }
        }
    }

    @Override
    public void enterCreate_trigger(Create_triggerContext ctx) {
        StoredTrigger storedTrigger = new StoredTrigger();
        String name;
        name = Ora2rdb.getRealName(ctx.trigger_name().schema_and_name().name.getText());
        storedTrigger.setName(name);
        if (ctx.simple_dml_trigger() != null) {
            Simple_dml_triggerContext simpleDmlTrigger = ctx.simple_dml_trigger();
            if (simpleDmlTrigger.dml_event_clause() != null) {
                Dml_event_clauseContext dmlEventClause = simpleDmlTrigger.dml_event_clause();
                if (dmlEventClause.tableview_name() != null) {
                    String table_name;
                    table_name = Ora2rdb.getRealName(dmlEventClause.tableview_name().schema_and_name().name.getText());

                    StorageInfo.tables.stream()
                            .filter(e -> Objects.equals(e.getName(), table_name))
                            .findFirst().ifPresent(storedTrigger::setTable_view);
                }
            }
        }

        if (ctx.trigger_body().trigger_block() != null) {
            Trigger_blockContext trigger_block = ctx.trigger_body().trigger_block();
            for (Declare_specContext declare_spec : trigger_block.declare_spec()) {
                if (declare_spec.variable_declaration() != null) {
                    String param_name = Ora2rdb.getRealName(declare_spec.variable_declaration().identifier().getText());
                    String param_type = Ora2rdb.getRealName(declare_spec.variable_declaration().type_spec().getText());
                    storedTrigger.setDeclaredVariables(param_name, param_type);
                }
            }
            for (Declare_specContext declare_spec : trigger_block.declare_spec()) {
                if (declare_spec.variable_declaration() != null) {
                    String param_name = Ora2rdb.getRealName(declare_spec.variable_declaration().identifier().getText());
                    String param_type = Ora2rdb.getRealName(declare_spec.variable_declaration().type_spec().getText());
                    storedTrigger.setDeclaredVariables(param_name, param_type);
                }
            }
        }
        storedBlocksStack.push(storedTrigger);

    }

    @Override
    public void exitCreate_trigger(Create_triggerContext ctx) {
        StorageInfo.stored_blocks_list.add(storedBlocksStack.pop());
    }

    @Override
    public void exitTrigger_ordering_clause(Trigger_ordering_clauseContext ctx) {
        StoredTrigger currentTrigger = (StoredTrigger) storedBlocksStack.peek();
        if (ctx.FOLLOWS() != null){
            for (Trigger_nameContext stmt : ctx.trigger_name()){
                StoredTrigger storedTrigger = findStorageTrigger(Ora2rdb.getRealName(stmt.getText()));
                storedTrigger.setPositionToZeroIfNecessary();
                currentTrigger.increasePosition(storedTrigger.getPosition());
            }
        }
        if (ctx.PRECEDES() != null){
            for (Trigger_nameContext stmt : ctx.trigger_name()){
                StoredTrigger storedTrigger = findStorageTrigger(Ora2rdb.getRealName(stmt.getText()));

                currentTrigger.setFollowingTrigger(storedTrigger.getName());
                currentTrigger.setPositionToZeroIfNecessary();

                storedTrigger.increasePosition(currentTrigger.getPosition());

                findFollowingTrigger(storedTrigger);
            }
        }
    }

    @Override
    public void exitTrigger_edition_clause(Trigger_edition_clauseContext ctx) {
        StoredTrigger currentTrigger = (StoredTrigger) storedBlocksStack.peek();
        currentTrigger.edition_clause = true;
    }

    private StoredTrigger findStorageTrigger(String trigger_name){
        StoredTrigger storedTrigger = new StoredTrigger();
        storedTrigger.setName(trigger_name);
        return (StoredTrigger) StorageInfo.stored_blocks_list.stream()
                .filter(e -> e.equal(storedTrigger))
                .findFirst().orElse(null);
    }


    private void findFollowingTrigger (StoredTrigger trigger){
        if (trigger.getFollowingTrigger() != null){
            StoredTrigger followingTr = findStorageTrigger(trigger.getFollowingTrigger());
            followingTr.increasePosition(trigger.getPosition());
            findFollowingTrigger(findStorageTrigger(trigger.getFollowingTrigger()));
        }
        return;
    }

    @Override
    public void enterCreate_index(Create_indexContext ctx) {
        String index_name;
        index_name = Ora2rdb.getRealName(ctx.index_name().schema_and_name().name.getText());
        String uniqueStatement = "";
        String tableSpace = "";
        String alias = "";
        if (ctx.UNIQUE() != null)
            uniqueStatement = "UNIQUE ";

        Table_index_clauseContext table_index_clause_ctx = ctx.table_index_clause();

        if (table_index_clause_ctx == null)
            return;

        if (table_index_clause_ctx.table_alias() != null)
            alias = " " + Ora2rdb.getRealName(table_index_clause_ctx.table_alias().getText());
        tableSpace = " IN TABLESPACE PRIMARY ";
        if (table_index_clause_ctx.index_properties() != null)
            if (table_index_clause_ctx.index_properties().index_attributes() != null)
                for (Index_attributesContext index_attr_ctx : table_index_clause_ctx.index_properties().index_attributes())
                    if (!index_attr_ctx.TABLESPACE().isEmpty()) {
                        if (index_attr_ctx.DEFAULT().isEmpty())
                            tableSpace = " IN TABLESPACE " + Ora2rdb.getRealName(index_attr_ctx.tablespace().get(0).id_expression().getText()) + " ";
                        else if (table_index_clause_ctx.index_properties().local_partitioned_index() != null)
                            tableSpace = "";
                    }
        String tableName = Ora2rdb.getRealName(ctx.table_index_clause().tableview_name().schema_and_name().name.getText()) + alias;

        Index index = new Index(index_name, uniqueStatement, tableSpace, tableName, false);
        StorageInfo.index_names.add(index);
    }

    @Override
    public void enterCreate_procedure_body(Create_procedure_bodyContext ctx) {
        String procedureName;
        StoredProcedure storedProcedure = new StoredProcedure();
        procedureName = Ora2rdb.getRealName(ctx.procedure_name().schema_and_name().name.getText());

        storedProcedure.setName(procedureName);
        storedProcedure.setPackage_name(current_package_name);

        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                storedProcedure.setParameters(i, ctx.parameter(i), !ctx.parameter(i).OUT().isEmpty());
            }
        }
        currentProcedureName = procedureName;
        storedBlocksStack.push(storedProcedure);
    }

    @Override
    public void exitCreate_procedure_body(Create_procedure_bodyContext ctx) {
        currentProcedureName = null;
        StorageInfo.stored_blocks_list.add(storedBlocksStack.pop());
    }

    @Override
    public void enterProcedure_body(Procedure_bodyContext ctx) {
        StoredProcedure storedProcedure = new StoredProcedure();
        String procedureName = Ora2rdb.getRealName(ctx.identifier().id_expression().getText());


        storedProcedure.setName(procedureName);
        storedProcedure.setPackage_name(current_package_name);

        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                storedProcedure.setParameters(i, ctx.parameter(i), !ctx.parameter(i).OUT().isEmpty());
            }
        }
        if (!storedBlocksStack.isEmpty()) {
            storedProcedure.setParent(storedBlocksStack.peek());
            storedBlocksStack.peek().setChildren(storedProcedure);
        }
        storedBlocksStack.push(storedProcedure);
        currentProcedureName = procedureName;

    }

    @Override
    public void exitProcedure_body(Procedure_bodyContext ctx) {
        currentProcedureName = null;
        StorageInfo.stored_blocks_list.add(storedBlocksStack.pop());
    }

    @Override
    public void enterCreate_function_body(Create_function_bodyContext ctx) {
        String functionName;
        StoredFunction storedFunction = new StoredFunction();
        functionName = Ora2rdb.getRealName(ctx.function_name().schema_and_name().name.getText());

        storedFunction.setName(functionName);
        storedFunction.setPackage_name(current_package_name);
        if (ctx.type_spec().datatype() != null)
            storedFunction.setFunction_returns_type(Ora2rdb.getRealName(ctx.type_spec().datatype().native_datatype_element().getText()));
        else
            storedFunction.setFunction_returns_type(Ora2rdb.getRealName(ctx.type_spec().getText()));
        storedFunction.setConvert_function_return_type(getConvertType(ctx.type_spec()));
        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                storedFunction.setParameters(i, ctx.parameter(i), !ctx.parameter(i).OUT().isEmpty());
            }
        }
        currentProcedureName = functionName;
        storedBlocksStack.push(storedFunction);
    }

    @Override
    public void exitCreate_function_body(Create_function_bodyContext ctx) {
        StorageInfo.stored_blocks_list.add(storedBlocksStack.pop());
    }

    @Override
    public void enterFunction_body(Function_bodyContext ctx) {
        StoredFunction storedFunction = new StoredFunction();
        String functionName = Ora2rdb.getRealName(ctx.identifier().id_expression().getText());

        storedFunction.setName(functionName);
        storedFunction.setPackage_name(current_package_name);
        if (ctx.type_spec().datatype() != null)
            storedFunction.setFunction_returns_type(Ora2rdb.getRealName(ctx.type_spec().datatype().native_datatype_element().getText()));
        else
            storedFunction.setFunction_returns_type(Ora2rdb.getRealName(ctx.type_spec().getText()));
        storedFunction.setConvert_function_return_type(getConvertType(ctx.type_spec()));
        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                storedFunction.setParameters(i, ctx.parameter(i), !ctx.parameter(i).OUT().isEmpty());
            }
        }

        if (!storedBlocksStack.isEmpty()) {
            storedFunction.setParent(storedBlocksStack.peek());
            storedBlocksStack.peek().setChildren(storedFunction);
        }
        storedBlocksStack.push(storedFunction);

    }

    @Override
    public void exitFunction_body(Function_bodyContext ctx) {
        StorageInfo.stored_blocks_list.add(storedBlocksStack.pop());
    }

    @Override
    public void enterCall_statement(Call_statementContext ctx) {
        FinderBlockCall finder = new FinderBlockCall();
        String name;
        String package_name;
        if (ctx.routine_name(0).id_expression(0) != null) {
            name = Ora2rdb.getRealName(ctx.routine_name(0).id_expression(0).getText());
            package_name = Ora2rdb.getRealName(ctx.routine_name(0).identifier().getText());
        } else {
            name = Ora2rdb.getRealName(ctx.routine_name(0).identifier().getText());
            package_name = null;
        }
        finder.setName(name);
        finder.setPackage_name(package_name);
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
        if (!storedBlocksStack.isEmpty()) {
            List<StoredBlock> tempList = storedBlocksStack.peek().getChildren().stream()
                    .filter(e -> e.equalsIgnoreParent(finder, true)).collect(Collectors.toList());
            if (tempList.size() > 1)
                tempList.stream().filter(e -> e.equalsIgnoreParent(finder, false))
                        .findFirst().ifPresent(child -> finder.setParent(child.getParent()));
            else if (!tempList.isEmpty())
                finder.setParent(tempList.get(0).getParent());
        }
        StoredBlock storedBlock;
        List<StoredBlock> tempList =
                StorageInfo.stored_blocks_list.stream()
                        .filter(e -> e.getPackage_name() != null)
                        .filter(e -> e.equal(finder, true))
                        .collect(Collectors.toList());
        if (tempList.size() > 1)
            storedBlock = tempList.stream()
                    .filter(e -> e.equal(finder, false))
                    .findFirst().orElse(null);
        else storedBlock = tempList.stream()
                .findFirst().orElse(null);


        if (storedBlock == null) {
            tempList = StorageInfo.stored_blocks_list.stream()
                    .filter(e -> e.equal(finder, true))
                    .collect(Collectors.toList());
            if (tempList.size() > 1) {
                storedBlock = tempList.stream()
                        .filter(e -> e.equal(finder, false))
                        .findFirst().orElse(tempList.get(0));
            } else storedBlock = tempList.stream()
                    .findFirst().orElse(null);
        }
        if (storedBlock != null && !storedBlocksStack.isEmpty())
            if (!storedBlocksStack.peek().getCalledStorageBlocks().contains(storedBlock))
                storedBlocksStack.peek().setCalledStorageBlocks(storedBlock);
    }

    @Override
    public void enterGeneral_element_part(General_element_partContext ctx) {
        if (ctx.function_argument() != null) {
            FinderBlockCall finder = new FinderBlockCall();
            String name;
            String package_name;
            if (!ctx.PERIOD().isEmpty()) {
                name = Ora2rdb.getRealName(ctx.id_expression(1).getText());
                package_name = Ora2rdb.getRealName(ctx.id_expression(0).getText());
            } else {
                name = Ora2rdb.getRealName(ctx.id_expression(0).getText());
                package_name = null;
            }
            finder.setName(name);
            finder.setPackage_name(package_name);
            finder.setArea_package_name(current_package_name);

            if (ctx.function_argument() != null && !storedBlocksStack.isEmpty()) {
                String arg_name;
                for (int i = 0; i < ctx.function_argument().argument().size(); i++) {
                    arg_name = Ora2rdb.getRealName(ctx.function_argument().argument(i).getText());
                    finder.setParameters(
                            i,
                            arg_name,
                            storedBlocksStack.peek().getParamType(arg_name)
                    );
                }
            }

            if (!storedBlocksStack.isEmpty()) {
                List<StoredBlock> tempList = storedBlocksStack.peek().getChildren().stream()
                        .filter(e -> e.equalsIgnoreParent(finder, true)).collect(Collectors.toList());
                if (tempList.size() > 1)
                    tempList.stream().filter(e -> e.equalsIgnoreParent(finder, false))
                            .findFirst().ifPresent(child -> finder.setParent(child.getParent()));
                else if (!tempList.isEmpty())
                    finder.setParent(tempList.get(0).getParent());
            }

            StoredBlock storedBlock;
            List<StoredBlock> tempList =
                    StorageInfo.stored_blocks_list.stream()
                            .filter(e -> e.getPackage_name() != null)
                            .filter(e -> e.equal(finder, true))
                            .collect(Collectors.toList());
            if (tempList.size() > 1)
                storedBlock = tempList.stream()
                        .filter(e -> e.equal(finder, false))
                        .findFirst().orElse(null);
            else storedBlock = tempList.stream()
                    .findFirst().orElse(null);

            if (storedBlock == null) {
                tempList = StorageInfo.stored_blocks_list.stream()
                        .filter(e -> e.equal(finder, true))
                        .collect(Collectors.toList());
                if (tempList.size() > 1) {
                    storedBlock = tempList.stream()
                            .filter(e -> e.equal(finder, false))
                            .findFirst().orElse(tempList.get(0));
                } else storedBlock = tempList.stream()
                        .findFirst().orElse(null);
            }
            if (storedBlock != null && !storedBlocksStack.isEmpty())
                if (!storedBlocksStack.peek().getCalledStorageBlocks().contains(storedBlock))
                    storedBlocksStack.peek().setCalledStorageBlocks(storedBlock);
        }
    }


    @Override
    public void exitVariable_declaration(Variable_declarationContext ctx) {
        if (ctx.CONSTANT() != null
                && ctx.parent.getClass().equals(PlSqlParser.Package_obj_specContext.class)
                || ctx.parent.getClass().equals(PlSqlParser.Package_obj_bodyContext.class)) {

            StorageInfo.package_constant_names.add(ctx.identifier().getText());
        }
        if (!storedBlocksStack.isEmpty()) {
            storedBlocksStack.peek().setDeclaredVariables(ctx);
        }
    }

    @Override
    public void enterCreate_view(Create_viewContext ctx) {
        StorageInfo.views.put(Ora2rdb.getRealName(ctx.tableview_name().schema_and_name().name.getText()), new View(ctx));
    }

    private String getConvertType(Type_specContext ctx) { //todo переделать стандартные значения
        String type = Ora2rdb.getRealName(ctx.getText());
        if (ctx.datatype() != null) {
            DatatypeContext datatype = ctx.datatype();
            if (datatype.native_datatype_element() != null) {
                Native_datatype_elementContext nde = datatype.native_datatype_element();

                if (nde.VARCHAR2() != null || nde.NVARCHAR2() != null)
                    type = "VARCHAR (32765)";
                else if (nde.NUMBER() != null)
                    type = "NUMERIC (34, 8)";
                else if (nde.BINARY_FLOAT() != null)
                    type = "FLOAT";
                else if (nde.BINARY_DOUBLE() != null)
                    type = "DOUBLE PRECISION";
                else if (nde.NCHAR() != null)
                    type = "CHAR (250)";
                else if (nde.BINARY_INTEGER() != null)
                    type = "INTEGER";
            }
        }
        return type;
    }
}
