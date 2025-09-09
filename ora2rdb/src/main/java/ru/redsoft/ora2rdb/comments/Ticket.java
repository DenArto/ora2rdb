package ru.redsoft.ora2rdb.comments;

public enum Ticket {
      FOR_LOOP_PAIRS_OF_CONTROL                 (238756, "FOR loop over pairs of control")
    , FOR_LOOP_INDICES_OF_CONTROL               (238745, "FOR loop over indices of control")
    , FOR_LOOP_VALUES_OF_CONTROL                (238760, "FOR loop over values of control")
    , FOR_LOOP_STEPPED_CONTROL                  (238758, "FOR loop with step")
    , FOR_LOOP_SINGLE_EXPRESSION_CONTROL        (238757, "FOR loop with single expression")
    , FOR_WITH_WHILE_STOP_CLAUSE                (239150, "FOR loop with WHILE clause")
    , FOR_WITH_WHEN_SKIP_CLAUSE                 (239161, "FOR loop with WHEN clause")
    , NESTED_TABLE_MULTISET_UNION               (239287, "Nested table multiset union")
    , FOR_WITH_SET_ITERATOR_CONTROLS            (239328, "FOR loop with set iterators")
    , NESTED_TABLE_TYPE_VARIABLE                (239346, "Nested table type variable")
    , VARRAY_TYPE_VARIABLE                      (239343, "VARRAY type variable")
    , ASSOCIATIVE_ARRAY_CONSTRUCTOR             (239362, "Associative array constructor")
    , NESTED_TABLE_CONSTRUCTOR                  (239380, "Nested table constructor")
    , VARRAY_CONSTRUCTOR                        (239379, "VARRAY constructor")

    , LABEL_VARIABLE                            (239627, "Accessing a variable via label")
    , SYS_REFCURSOR_REF_CURSOR_TYPE_DEF         (239691, "SYS_REFCURSOR type variable")
    , CURSOR_WITH_PARAMETER                     (241342, "Cursor with parameters")
    , ACCESSIBLE_BY_CLAUSE                      (239382, "ACCESSIBLE BY clause")
    , RESULT_CACHE_CLAUSE                       (239599, "RESULT_CACHE clause")
    , PARALLEL_ENABLE_CLAUSE                    (239601, "PARALLEL_ENABLE clause")
    , EXTERNAL_FUNCTION                         (239602, "External function")
    , PIPELINED_FUNCTION                        (239607, "Pipelined function")
    , FORALL_LOOP                               (240654, "FORALL loop")
    , FETCH_BULK_COLLECT                        (240714, "FETCH with BULK COLLECT")
    , OPEN_WITH_PARAM                           (240722, "OPEN cursor with parameter")
    , OPEN_FOR_STATEMENT                        (240783, "OPEN cursor with FOR statement")
    , DECLARE_CURSOR_IN_PACKAGE                 (233552, "Cursor declared in package")
    , CURSOR_FOR_LOOP_IN_ANONYMOUS_BLOCK        (243534, "Cursor FOR loop in anonymous block")

    , SELECT_FOR_UPDATE                         (241264, "SELECT with FOR UPDATE")
    , SELECT_CROSS_APPLY                        (241266, "SELECT with CROSS APPLY operator")
    , SELECT_QUERY_PARTITION                    (241292, "SELECT with Query partitioning clause")
    , SELECT_ANALYTIC_VIEW                      (241324, "Analytic view query")
    , SELECT_FLASHBACK_QUERY                    (241327, "Flashback query")
    , SELECT_HIERARCHIES                        (241349, "SELECT with Hierarchical query")
    , SELECT_LATERAL_ATTRIBUTE                  (241381, "SELECT with LATERAL subquery")
    , SELECT_PIVOT_CLAUSE                       (241383, "SELECT with PIVOT clause")
    , SELECT_UNPIVOT_CLAUSE                     (241384, "SELECT with UNPIVOT clause")
    , SELECT_TABLE_COLLECTION                   (241392, "SELECT with TABLE collection")
    , SELECT_GROUP_BY_CUBE                      (241397, "SELECT with GROUP BY CUBE")
    , SELECT_GROUP_BY_ROLLUP                    (241396, "SELECT with GROUP BY ROLLUP")
    , SELECT_GROUP_BY_GROUPING_SETS             (244719, "SELECT with GROUP BY GROUPING SETS")
    , SELECT_ROW_PATTERN                        (241390, "Row pattern matching")
    , SELECT_PERCENT_KEYWORD                    (241402, "PERCENT keyword")
    , SELECT_SET_OPERATOR_EXCEPT                (241406, "EXCEPT set operator")
    , SELECT_SET_OPERATOR_MINUS                 (241407, "MINUS set operator")
    , SELECT_SET_OPERATOR_INTERSECT             (241408, "INTERSECT set operator")
    , SELECT_WITH_CLAUSE_SEARCH                 (241439, "WITH clause SEARCH")

    , INSERT_MULTI_TABLE_ALL                    (241759, "Multi-table INSERT ALL")
    , INSERT_CONDITION_ALL                      (241760, "Conditional INSERT ALL")
    , INSERT_CONDITION_FIRST                    (241761, "Conditional INSERT FIRST")
    , INSERT_ERROR_LOGGING                      (241764, "INSERT with error logging")
    , INSERT_INTO_SELECT                        (241765, "INSERT into SELECT query")

    , UPDATE_ERROR_LOGGING                      (242209, "UPDATE with error logging")
    , UPDATE_INTO_SELECT                        (242218, "UPDATE from SELECT subquery")
    , UPDATE_FROM_USING                         (242233, "UPDATE from USING clause")
    , UPDATE_PARTITION_SUBPARTITION             (242238, "UPDATE on partition/subpartition")
    , UPDATE_MULTICOLUMN                        (242240, "Multi-column UPDATE")
    , UPDATE_AN_OBJECT_TABLE                    (247119, "UPDATE on object table")

    , DELETE_FROM_SUBQUERY                      (242279, "DELETE from subquery")
    , DELETE_PARTITION_SUBPARTITION             (242280, "DELETE on partition/subpartition")
    , DELETE_ERROR_LOGGING                      (242281, "DELETE with error logging")

    , MERGE_ERROR_LOGGING                       (242476, "MERGE with error logging")
    , MERGE_UPDATE_DELETE_PART                  (242478, "MERGE with UPDATE/DELETE")
    , MERGE_WHERE_CLAUSE                        (242485, "MERGE with WHERE clause")

    , EXPLAIN_PLAN                              (242306, "EXPLAIN PLAN statement")

    , LOCK_TABLE                                (242313, "LOCK TABLE statement")

    , CALL_STATEMENT                            (242391, "CALL statement")

    , GOTO_OPERATOR                             (241308, "GOTO statement")

    , NESTED_PROCEDURE_FUNCTION                 (241716, "Nested procedure/function")

    , OBJECT_VIEW                               (241921, "Object view")
    , XML_TYPE_VIEW                             (241929, "XMLType view")
    , MATERIALIZED_VIEW                         (241931, "Materialized view")


    , CREATE_TABLE_COLUMN_PROPERTIES            (243328, "unconvertible column properties")
    , CREATE_PRIVATE_TEMPORARY_TABLE            (243353, "CREATE PRIVATE TEMPORARY TABLE")
    , CREATE_IMMUTABLE_BLOCKCHAIN_TABLE         (243359, "CREATE IMMUTABLE/BLOCKCHAIN TABLE")
    , CREATE_SHARDED_TABLE                      (243395, "CREATE SHARDED TABLE")
    , TABLE_PARTITION_CLAUSES                   (243394, "Table partition clauses")
    , CREATE_TABLE_ROWDEPENDENCIES              (243409, "CREATE TABLE with ROWDEPENDENCIES")
    , CREATE_OBJECT_TABLE                       (247116, "CREATE OBJECT TABLE")

    , KEEP_CLAUSE                               (244696, "KEEP (DENSE_RANK) clause")
    , WINDOW_GROUPS_EXCLUDE                     (244675, "WINDOW_GROUPS_EXCLUDE")
    , AGGREGATE_AND_ANALYTIC_FUNCTION           (244710, "Unconvertible aggregate or analytic function")
    , JSON_FUNCTION_ORDER_BY                    (244715, "JSON function with ORDER BY")


    , ANOTHER_DATATYPE                          (244032, "ANOTHER_DATATYPE")
    , DATE_TIME_DATATYPE                        (244046, "Unconvertible Date/Time data type")
    , STRING_FUNCTION                           (245294, "Unconvertible string function")
    , NUMERIC_FUNCTION                          (245388, "Unconvertible numeric function")
    , COLLATION_FUNCTION                        (245419, "Unconvertible collation function")
    , DATETIME_FUNCTION                         (245858, "Unconvertible date/time function")
    , CONVERT_FUNCTION                          (245838, "Unconvertible conversion function")
    , DEFAULT_ON_CONVERSION_ERROR               (245741, "conversion function whit DEFAULT ON CONVERSION ERROR clauses ")

    , ORA_SQL_TXT                               (245165, "ORA_SQL_TXT function")

    , EXECUTE_IMMEDIATE_USING_CLAUSE            (245747, "EXECUTE IMMEDIATE with USING")
    , EXECUTE_IMMEDIATE_RETURNING_INTO_CLAUSE   (245749, "EXECUTE IMMEDIATE with RETURNING INTO")

    , STATEMENT_TRIGGER                         (228329, "STATEMENT_TRIGGER")
    , COMPOUND_TRIGGER                          (228297, "COMPOUND_TRIGGER")
    , INSTEAD_OF_CREATE_TRIGGER                 (228348, "INSTEAD_OF_CREATE_TRIGGER")
    , DATABASE_TRIGGER                          (228336, "DATABASE_TRIGGER")
    , DDL_TRIGGER                               (228339, "DDL_TRIGGER")
    , REFERENCING_PARENT_AS_CLAUSE              (228325, "REFERENCING_PARENT_AS_CLAUSE")
    , INSTEAD_OF_TRIGGER_FOR_NESTED_TABLE       (228312, "INSTEAD_OF_TRIGGER_FOR_NESTED_TABLE")

    , DECLARE_EXCEPTION                         (245963, "Exception declaration")
    , DECLARE_SUBTYPE                           (197284, "Subtype declaration")
    , DECLARE_VARIABLE_INTO_PAC                 (246002, "Variable declaration in package")
    , PACKAGE_INIT_BLOCK                        (246022, "Package with initialization block")

    , COLLATE_OPERATOR                          (246304, "COLLATE operator")
    , HIERARCHICAL_QUERY                        (246313, "Hierarchical query (CONNECT BY)")
    , HIERARCHICAL_QUERY_PSEUDOCOLUMNS          (246310, "Hierarchical pseudocolumns (e.g., LEVEL)")

    , SEQUENCE_CURRVAL                          (246219, "SEQUENCE_CURRVAL")

    , BITMAP_INDEX                              (246430, "Bitmap index")
    , CREATE_INDEX                              (246433, "CREATE_INDEX")

    , OVERLOAD_STATEMENT                        (246918, "Overload procedure or function")
    ;


    private final int ticketCode;
    private final String ticketName;

    Ticket(int ticketCode, String ticketName){
        this.ticketCode = ticketCode;
        this.ticketName = ticketName;
    }

    public int getTicketCode() {
        return ticketCode;
    }

    public String getName(){
        return ticketName;
    }
}

