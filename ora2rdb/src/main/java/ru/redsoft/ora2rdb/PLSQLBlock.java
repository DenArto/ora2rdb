package ru.redsoft.ora2rdb;

import org.antlr.v4.runtime.Token;

import java.util.*;

public class PLSQLBlock {
    ArrayList<String> package_constant_names = new ArrayList<>();
    Stack<TreeSet<String>> scopes = new Stack<TreeSet<String>>();
    private PlSqlParser.StatementContext statement;
    ArrayList<String> trigger_fields = new ArrayList<String>();
    String trigger_when_condition;
    String procedure_name;
    Stack<ReplaceRecordName> record_name_cursor_loop = new Stack<>();
    ArrayList<String> procedure_names_with_out_parameters = new ArrayList<>();
    TreeMap<String, ArrayType> associative_array_types = new TreeMap<String, ArrayType>();
    TreeMap<String, ArrayType> nested_array_types = new TreeMap<>();
    TreeMap<String, ArrayType> varray_types = new TreeMap<>();
    TreeMap<String, String> array_to_table = new TreeMap<String, String>();
    ArrayList<String> temporary_tables_ddl = new ArrayList<String>();
    ReferencingAttributes trigger_referencing_attributes = new ReferencingAttributes();
    boolean commentBlock = false;
    List<String> trigger_ddl_event = new ArrayList<>();
    public TreeMap<String, Cursor> cursor_select_statement = new TreeMap<>();
    String current_cursor_name;
    private TreeSet<String> used_temporary_table_names = new TreeSet<String>();
    Set<String> cursor_found_notfound_attr = new TreeSet<>();
    Set<String> cursor_open_attr = new TreeSet<>();
    Set<String> cursor_rowcount_attr = new TreeSet<>();
    Map<String, Token> fetch_statement = new TreeMap<>();
    Map<String, Token> close_statement = new TreeMap<>();
    Map<String, Token> open_statement = new TreeMap<>();
    ArrayList<String> record_type_names = new ArrayList<>();
    public void setStatement(PlSqlParser.StatementContext ctx) {
        this.statement = ctx;
    }

    public PlSqlParser.StatementContext getStatement() {
        return statement;
    }

    public void clearStatement() {
        statement = null;
    }

    class ArrayType {
        String data_type;
        ArrayList<String> index_types = new ArrayList<String>();
    }
     class ReplaceRecordName {
        String old_record_name;
        String new_record_name;
        boolean isRowType;
    }
    class ReferencingAttributes{
        String oldValue;
        String newValue;
    }

    class Cursor {
        String table_name;
        String column_name;

        Cursor(String table_name, String column_name) {
            this.table_name = table_name;
            this.column_name = column_name;
        }
    }

    void pushReplaceRecordName(String old_record_name, String new_record_name, boolean isRowType){
        ReplaceRecordName replaceRecordName = new ReplaceRecordName();
        replaceRecordName.old_record_name = old_record_name;
        replaceRecordName.new_record_name = new_record_name;
        replaceRecordName.isRowType = isRowType;
        record_name_cursor_loop.push(replaceRecordName);
    }
    void popReplaceRecordName(){
       record_name_cursor_loop.pop();
    }
    ReplaceRecordName peekReplaceRecordName(){
        return record_name_cursor_loop.peek();
    }

    void putCursorSelectStatement(String cur_name, String table_name, String column_name){
        cursor_select_statement.put(cur_name, new Cursor(table_name, column_name));
    }

    PLSQLBlock() {
        pushScope();
    }

    void pushScope() {
        scopes.push(new TreeSet<String>());
    }

    void popScope() {
        scopes.pop();
    }

    void declareVar(String var_name) {
        scopes.peek().add(var_name);
    }

    boolean containsInScope(String var_name) {
        for (TreeSet<String> scope : scopes) {
            if (scope.contains(var_name))
                return true;
        }

        return false;
    }

    void declareTypeOfAssociativeArray(String name, String type, String index_type) {
        ArrayType new_arr_type = new ArrayType();

        if (associative_array_types.containsKey(type)) {
            ArrayType arr_type = associative_array_types.get(type);
            new_arr_type.data_type = arr_type.data_type;
            new_arr_type.index_types.addAll(arr_type.index_types);
            new_arr_type.index_types.add(0, index_type);
        } else {
            new_arr_type.data_type = type;
            new_arr_type.index_types.add(index_type);
        }
        associative_array_types.put(name, new_arr_type);
    }

    void declareTypeOfNestedTableArray(String name, String type) {
        ArrayType new_arr_type = new ArrayType();
        if (nested_array_types.containsKey(type)) {
            ArrayType arr_type = nested_array_types.get(type);
            new_arr_type.data_type = arr_type.data_type;
            new_arr_type.index_types.addAll(arr_type.index_types);
        } else {
            new_arr_type.data_type = type;
        }
        nested_array_types.put(name, new_arr_type);
    }

    void declareTypeOfVarray(String name, String type) {
        ArrayType new_arr_type = new ArrayType();
        if (varray_types.containsKey(type)) {
            ArrayType arr_type = varray_types.get(type);
            new_arr_type.data_type = arr_type.data_type;
            new_arr_type.index_types.addAll(arr_type.index_types);
        } else {
            new_arr_type.data_type = type;
        }
        varray_types.put(name, new_arr_type);
    }

    void declareAssociativeArray(String name, String type) {
        if (associative_array_types.containsKey(type)) {
            ArrayType arr_type = associative_array_types.get(type);
            String new_name = name;

            for (int i = 1; ; i++) {
                if (used_temporary_table_names.contains(new_name))
                    new_name = name + i;
                else
                    break;
            }

            used_temporary_table_names.add(new_name);
            array_to_table.put(name, new_name);
            StringBuilder key_fields = new StringBuilder();
            StringBuilder table_ddl = new StringBuilder("--" + name +" " + type + "\nCREATE GLOBAL TEMPORARY TABLE " + new_name + " (\n");

            for (int i = 0; i < arr_type.index_types.size(); i++) {
                if (i != 0)
                    key_fields.append(", ");

                table_ddl.append("\tK").append(" ").append(arr_type.index_types.get(i)).append(",\n");
                key_fields.append("K");
            }

            table_ddl.append("\tVAL ").append(arr_type.data_type).
                    append(",\n\tCONSTRAINT PK_").append(new_name).append(" PRIMARY KEY (").append(key_fields).append(")\n);");
            temporary_tables_ddl.add(table_ddl.toString());
        }
    }
}
