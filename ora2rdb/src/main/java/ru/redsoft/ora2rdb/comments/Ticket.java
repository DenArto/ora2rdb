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


    ,FOR_WITH_SET_ITERATOR_CONTROLS     (239328)
    ,test                               (1)
    ;


    private final int ticketCode;

    Ticket(int ticketCode) {
        this.ticketCode = ticketCode;
    }

    public int getTicketCode() {
        return ticketCode;
    }
}

