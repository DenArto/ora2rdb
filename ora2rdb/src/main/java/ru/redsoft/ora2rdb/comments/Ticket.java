package ru.redsoft.ora2rdb.comments;

public enum Ticket {
      FOR_LOOP_PAIRS_OF_CONTROL             (238756)
    , FOR_LOOP_INDICES_OF_CONTROL           (238745)
    , FOR_LOOP_VALUES_OF_CONTROL            (238760)
    , FOR_LOOP_STEPPED_CONTROL              (238758)
    , FOR_LOOP_SINGLE_EXPRESSION_CONTROL    (238757)
    , FOR_WITH_WHILE_STOP_CLAUSE            (239150)
    , FOR_WITH_WHEN_SKIP_CLAUSE             (239161)
    , NESTED_TABLE_MULTISET_UNION           (239287)
    , FOR_WITH_SET_ITERATOR_CONTROLS        (239328)
    , NESTED_TABLE_TYPE_VARIABLE            (239346)
    , VARRAY_TYPE_VARIABLE                  (239343)
    , ASSOCIATIVE_ARRAY_CONSTRUCTOR         (239362)
    , NESTED_TABLE_CONSTRUCTOR              (239380)
    , VARRAY_CONSTRUCTOR                    (239379)

    , LABEL_VARIABLE                        (239627)
    , SYS_REFCURSOR_REF_CURSOR_TYPE_DEF     (239691)
    , CURSOR_WITH_PARAMETER                 (241342)
    , ACCESSIBLE_BY_CLAUSE                  (239382)
    , RESULT_CACHE_CLAUSE                   (239599)
    , PARALLEL_ENABLE_CLAUSE                (239601)
    , EXTERNAL_FUNCTION                     (239602)
    , PIPELINED_FUNCTION                    (239607)
    , FORALL_LOOP                           (240654)
    , FETCH_BULK_COLLECT                    (240714)
    , OPEN_WITH_PARAM                       (240722)
    , OPEN_FOR_STATEMENT                    (240783)

    , SELECT_FOR_UPDATE                     (241264)
    , SELECT_CROSS_APPLY                    (241266)
    , SELECT_QUERY_PARTITION                (241292)
    , SELECT_ANALYTIC_VIEW                  (241324)
    , SELECT_FLASHBACK_QUERY                (241327)
    , SELECT_HIERARCHIES                    (241349)
    , SELECT_LATERAL_ATTRIBUTE              (241381)
    , SELECT_PIVOT_CLAUSE                   (241383)
    , SELECT_UNPIVOT_CLAUSE                 (241384)
    , SELECT_TABLE_COLLECTION               (241392)
    , SELECT_GROUP_BY_CUBE                  (241397)
    , SELECT_GROUP_BY_ROLLUP                (241396)
    , SELECT_ROW_PATTERN                    (241390)
    , SELECT_PERCENT_KEYWORD                (241402)
    , SELECT_SET_OPERATOR_EXCEPT            (241406)
    , SELECT_SET_OPERATOR_MINUS             (241407)
    , SELECT_SET_OPERATOR_INTERSECT         (241408)
    , SELECT_WITH_CLAUSE_SEARCH             (241439)

    , INSERT_MULTI_TABLE_ALL                (241759)
    , INSERT_CONDITION_ALL                  (241760)
    , INSERT_CONDITION_FIRST                (241761)
    , INSERT_ERROR_LOGGING                  (241764)
    , INSERT_INTO_SELECT                    (241765)

    , UPDATE_ERROR_LOGGING                  (242209)
    , UPDATE_INTO_SELECT                    (242218)
    , UPDATE_FROM_USING                     (242233)
    , UPDATE_PARTITION_SUBPARTITION         (242238)
    , UPDATE_MULTICOLUMN                    (242240)

    , GOTO_OPERATOR                         (241308)

    , NESTED_PROCEDURE_FUNCTION             (241716)

    , OBJECT_VIEW                           (241921)
    , XML_TYPE_VIEW                         (241929)
    , MATERIALIZED_VIEW                     (241931)
    ;


    private final int ticketCode;

    Ticket(int ticketCode) {
        this.ticketCode = ticketCode;
    }

    public int getTicketCode() {
        return ticketCode;
    }
}

