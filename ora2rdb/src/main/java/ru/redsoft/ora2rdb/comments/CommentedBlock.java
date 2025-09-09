package ru.redsoft.ora2rdb.comments;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommentedBlock {
    private ParserRuleContext parentContext;

    private TerminalNode startDeclareBlock;
    private TerminalNode startBodyBlock;
    private TerminalNode stopBodyBlock;

    //    private List<UnconvertableBlock> unconvertableBlockList = new ArrayList<>();
    private Map<Integer, UnconvertableBlock> unconvertableBlockMap = new HashMap<>();

    private boolean convertAllBlock;



    public CommentedBlock(ParserRuleContext parentContext, boolean convertAllBlock){
        this.parentContext = parentContext;
        this.convertAllBlock = convertAllBlock;
    }
    public CommentedBlock(ParserRuleContext parentContext){
        this(parentContext, false);
    }

    public CommentedBlock(ParserRuleContext parentContext, TerminalNode startDeclareBlock, TerminalNode startBodyBlock, TerminalNode stopBodyBlock, boolean convertAllBlock){
        this.parentContext = parentContext;
        this.startDeclareBlock = startDeclareBlock;
        this.startBodyBlock = startBodyBlock;
        this.stopBodyBlock = stopBodyBlock;
        this.convertAllBlock = convertAllBlock;
    }
    public CommentedBlock(ParserRuleContext parentContext, TerminalNode startDeclareBlock, TerminalNode startBodyBlock, TerminalNode stopBodyBlock){
        this(parentContext,  startDeclareBlock,  startBodyBlock,  stopBodyBlock,  false);
    }

    public boolean unconvertableBlocksIsEmpty(){
        return unconvertableBlockMap.isEmpty();
    }

    public ParserRuleContext getParentContext() {
        return parentContext;
    }

    public void setParentContext(ParserRuleContext parentContext) {
        this.parentContext = parentContext;
    }


    public List<UnconvertableBlock> getUnconvertableBlockList() {
        return new ArrayList<>(unconvertableBlockMap.values());
    }

//    public void addUnconvertableBlock(UnconvertableBlock unconvertableBlock) {
//        this.unconvertableBlockList.add(unconvertableBlock);
//    }



    public void addUnconvertableBlock(ParserRuleContext ctx, Ticket ticket) {
        if(ctx != null) {
            int startIndex = ctx.getStart().getTokenIndex();
            if (!this.unconvertableBlockMap.containsKey(startIndex))
                this.unconvertableBlockMap.put(startIndex, new UnconvertableBlock(ctx, ticket));
            else {
                unconvertableBlockMap.get(startIndex).setBlockStop(ctx.getStop());
                unconvertableBlockMap.get(startIndex).addTicketNumber(ticket);
            }

//            this.unconvertableBlockList.add(new UnconvertableBlock(ctx,ticket.getTicketCode()));
        }
    }



    public void addUnconvertableBlock(Token start, Token stop, Ticket ticket) {
        if(start != null && stop != null) {
            int startIndex = start.getTokenIndex();
            if (!this.unconvertableBlockMap.containsKey(startIndex))
                this.unconvertableBlockMap.put(startIndex, new UnconvertableBlock(start, stop, ticket));
            else {
                unconvertableBlockMap.get(startIndex).setBlockStop(stop);
                unconvertableBlockMap.get(startIndex).addTicketNumber(ticket);
            }
//            this.unconvertableBlockList.add(new UnconvertableBlock(start, stop, ticket.getTicketCode()));
        }
    }

    public void addUnconvertableBlock(TerminalNode term, Ticket ticket) {
        if(term != null) {
            int startIndex = term.getSymbol().getTokenIndex();
            this.unconvertableBlockMap.put(startIndex, new UnconvertableBlock(term, ticket));
//            this.unconvertableBlockList.add(new UnconvertableBlock(term, ticket.getTicketCode()));
        }
    }

    public void addUnconvertableBlock(TerminalNode start, TerminalNode stop, Ticket ticket) {
        if (start != null && stop != null) {
            int startIndex = start.getSymbol().getTokenIndex();
            if (!this.unconvertableBlockMap.containsKey(startIndex))
                this.unconvertableBlockMap.put(startIndex, new UnconvertableBlock(start.getSymbol(), stop.getSymbol(),ticket));
            else {
                unconvertableBlockMap.get(startIndex).setBlockStop(stop.getSymbol());
                unconvertableBlockMap.get(startIndex).addTicketNumber(ticket);
            }
//            this.unconvertableBlockList.add(new UnconvertableBlock(start.getSymbol(), stop.getSymbol(), ticket.getTicketCode()));
        }
    }


    public boolean isConvertAllBlock() {
        return convertAllBlock;
    }

    public void setConvertAllBlock(boolean convertAllBlock) {
        this.convertAllBlock = convertAllBlock;
    }

    public TerminalNode getStartDeclareBlock() {
        return startDeclareBlock;
    }

    public TerminalNode getStartBodyBlock() {
        return startBodyBlock;
    }

    public TerminalNode getStopBodyBlock() {
        return stopBodyBlock;
    }

}

