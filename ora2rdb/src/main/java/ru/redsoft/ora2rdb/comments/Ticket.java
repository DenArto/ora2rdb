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
    ,SYS_REFCURSOR_REF_CURSOR_TYPE_DEF  (239691)
    ,ACCESSIBLE_BY_CLAUSE               (239382)
    ,RESULT_CACHE_CLAUSE                (239599)
    ,PARALLEL_ENABLE_CLAUSE             (239601)
    ,EXTERNAL_FUNCTION                  (239602)
    ,PIPELINED_FUNCTION                 (239607)
    ,FORALL_LOOP                        (240654)
    ,FETCH_BULK_COLLECT                 (240714)
    ,OPEN_WITH_PARAM                    (240722)
    ,OPEN_FOR_STATEMENT                (240783)
    ;


    private final int ticketCode;

    Ticket(int ticketCode) {
        this.ticketCode = ticketCode;
    }

    public int getTicketCode() {
        return ticketCode;
    }
}

