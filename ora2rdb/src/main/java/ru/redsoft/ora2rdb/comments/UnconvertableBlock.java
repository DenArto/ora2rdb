package ru.redsoft.ora2rdb.comments;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public class UnconvertableBlock {
    private Token start;
    private Token stop;
    private HashSet<Integer> ticketNumbers = new HashSet<Integer>();

    public UnconvertableBlock(){}

    public UnconvertableBlock(ParserRuleContext ctx, Integer ticketNumber) {
        this.start = ctx.getStart();
        this.stop = ctx.getStop();
        this.ticketNumbers.add(ticketNumber);
    }

    public UnconvertableBlock(ParserRuleContext ctx) {
        this(ctx, null);
    }

    public UnconvertableBlock(Token start, Token stop, Integer ticketNumber) {
        this.start = start;
        this.stop = stop;
        this.ticketNumbers.add(ticketNumber);
    }

    public UnconvertableBlock(Token start, Token stop) {
        this(start, stop, null);
    }

    public UnconvertableBlock(TerminalNode term, Integer ticketNumber){
        this.start = term.getSymbol();
        this.stop = term.getSymbol();
        this.ticketNumbers.add(ticketNumber);
    }

    public Token getBlockStart() {
        return start;
    }

    public void setBlockStart(Token start){
        this.start = start;
    }

    public Token getBlockStop() {
        return stop;
    }

    public void setBlockStop(Token stop){
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

    public List<Integer> getTicketNumbersList(){
        return new ArrayList<>(this.ticketNumbers);
    }

    public void addTicketNumber(Ticket ticket){
        this.ticketNumbers.add(ticket.getTicketCode());
    }
}
