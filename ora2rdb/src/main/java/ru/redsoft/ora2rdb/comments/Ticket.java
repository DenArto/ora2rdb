package ru.redsoft.ora2rdb.comments;

public enum Ticket {
      FOR_LOOP_PAIRS_OF_CONTROL         (238756)
    , FOR_LOOP_INDICES_OF_CONTROL       (238745)
    , FOR_LOOP_VALUES_OF_CONTROL        (238760)

    , FOR_LOOP_STEPPED_CONTROL          (238758)
    , FOR_LOOP_SINGLE_EXPRESSION_CONTROL(238757)

    , FOR_WITH_WHILE_STOP_CLAUSE        (239150)
    , FOR_WITH_WHEN_SKIP_CLAUSE         (239161)

    , NESTED_TABLE_MULTISET_UNION       (239287)


    , FOR_WITH_SET_ITERATOR_CONTROLS    (239328)

    , NESTED_TABLE_TYPE_VARIABLE        (239346)
    , VARRAY_TYPE_VARIABLE              (239343)

    , ASSOCIATIVE_ARRAY_CONSTRUCTOR     (239362)
    , NESTED_TABLE_CONSTRUCTOR          (239380)
    , VARRAY_CONSTRUCTOR                (239379)

    ,test                               (1)
    ,ACCESSIBLE_BY_CLAUSE               (239382)
    ,RESULT_CACHE_CLAUSE                (239599)
    ,PARALLEL_ENABLE_CLAUSE             (239601)
    ,EXTERNAL_FUNCTION                  (239602)
    ,PIPELINED_FUNCTION                 (239607)

    , SELECT_FOR_UPDATE                 (241264)
    , SELECT_CROSS_APPLY                (241266)
    , SELECT_QUERY_PARTITION            (241292)
    , SELECT_ANALYTIC_VIEW              (241324)
    , SELECT_FLASHBACK_QUERY            (241327)
    , SELECT_HIERARCHIES                (241349)
    , SELECT_LATERAL_ATTRIBUTE          (241381)
    , SELECT_PIVOT_CLAUSE               (241383)
    , SELECT_UNPIVOT_CLAUSE             (241384)
    , SELECT_TABLE_COLLECTION           (241392)
    , SELECT_GROUP_BY_CUBE              (241397)
    , SELECT_GROUP_BY_ROLLUP            (241396)
    , SELECT_ROW_PATTERN                (241390)
    , SELECT_PERCENT_KEYWORD            (241402)
    , SELECT_SET_OPERATOR_EXCEPT        (241406)
    , SELECT_SET_OPERATOR_MINUS         (241407)
    , SELECT_SET_OPERATOR_INTERSECT     (241408)
    , SELECT_WITH_CLAUSE_SEARCH         (241439)

    ;


    private final int ticketCode;

    Ticket(int ticketCode) {
        this.ticketCode = ticketCode;
    }

    public int getTicketCode() {
        return ticketCode;
    }
}

