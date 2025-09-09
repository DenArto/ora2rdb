package ru.redsoft.ora2rdb.comments;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

public class UnconvertableBlock {
    private Token start;
    private Token stop;
    private TreeSet<Ticket> ticketSet = new TreeSet<Ticket>();

    public boolean blockIsReady() {
        return start != null && stop != null && !ticketSet.isEmpty();
    }

    public UnconvertableBlock() {
    }

    public UnconvertableBlock(ParserRuleContext ctx, Ticket ticket) {
        this.start = ctx.getStart();
        this.stop = ctx.getStop();
        this.ticketSet.add(ticket);
    }

    public UnconvertableBlock(ParserRuleContext ctx) {
        this(ctx, null);
    }

    public UnconvertableBlock(Token start, Token stop, Ticket ticket) {
        this.start = start;
        this.stop = stop;
        this.ticketSet.add(ticket);
    }

    public UnconvertableBlock(Token start, Token stop) {
        this(start, stop, null);
    }

    public UnconvertableBlock(TerminalNode term, Ticket ticket) {
        this.start = term.getSymbol();
        this.stop = term.getSymbol();
        this.ticketSet.add(ticket);
    }

    public Token getBlockStart() {
        return start;
    }

    public void setBlockStart(Token start) {
        this.start = start;
    }

    public Token getBlockStop() {
        return stop;
    }

    public void setBlockStop(Token stop) {
        this.stop = stop;
    }

    public void setContext(Token start, Token stop) {
        this.start = start;
        this.stop = stop;
    }

    public void setContext(ParserRuleContext ctx) {
        this.start = ctx.getStart();
        this.stop = ctx.getStop();
    }

    public List<Ticket> getTicketNumbersList() {
        return new ArrayList<>(this.ticketSet);
    }

    public void addTicketNumber(Ticket ticket) {
        this.ticketSet.add(ticket);
    }
}
