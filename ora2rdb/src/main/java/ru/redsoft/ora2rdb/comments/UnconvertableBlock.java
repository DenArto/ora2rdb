package ru.redsoft.ora2rdb.comments;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;

public class UnconvertableBlock {
    private Token start;
    private Token stop;
    private Integer ticketNumber;


    public UnconvertableBlock(ParserRuleContext ctx, Integer ticketNumber) {
        this.start = ctx.getStart();
        this.stop = ctx.getStop();
        this.ticketNumber = ticketNumber;
    }

    public UnconvertableBlock(ParserRuleContext ctx) {
        this(ctx, null);
    }

    public UnconvertableBlock(Token start, Token stop, Integer ticketNumber) {
        this.start = start;
        this.stop = stop;
        this.ticketNumber = ticketNumber;
    }

    public UnconvertableBlock(Token start, Token stop) {
        this(start, stop, null);
    }

    public UnconvertableBlock(TerminalNode term, Integer ticketNumber){
        this.start = term.getSymbol();
        this.stop = term.getSymbol();
        this.ticketNumber = ticketNumber;
    }


    public Token getBlockStart() {
        return start;
    }

    public Token getBlockStop() {
        return stop;
    }

    public void setContext(Token start, Token stop) {
        this.start = start;
        this.stop = stop;
    }

    public void setContext(ParserRuleContext ctx) {
        this.start = ctx.getStart();
        this.stop = ctx.getStop();
    }

    public Integer getTicketNumber() {
        return ticketNumber;
    }

    public void setTicketNumber(Integer ticketNumber) {
        this.ticketNumber = ticketNumber;
    }
}
