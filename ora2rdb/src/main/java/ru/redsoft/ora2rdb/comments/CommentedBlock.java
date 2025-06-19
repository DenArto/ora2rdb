package ru.redsoft.ora2rdb.comments;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.List;

public class CommentedBlock {

    private ParserRuleContext parentContext;

    private TerminalNode startDeclareBlock;
    private TerminalNode startBodyBlock;
    private TerminalNode stopBodyBlock;

    private List<UnconvertableBlock> unconvertableBlockList = new ArrayList<>();
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
        return unconvertableBlockList.isEmpty();
    }

    public ParserRuleContext getParentContext() {
        return parentContext;
    }

    public void setParentContext(ParserRuleContext parentContext) {
        this.parentContext = parentContext;
    }


    public List<UnconvertableBlock> getUnconvertableBlockList() {
        return unconvertableBlockList;
    }

    public void addUnconvertableBlock(UnconvertableBlock unconvertableBlockList) {
        this.unconvertableBlockList.add(unconvertableBlockList);
    }

    public void addUnconvertableBlock(ParserRuleContext ctx, Integer ticketNumber) {
        if(ctx != null) {
            this.unconvertableBlockList.add(new UnconvertableBlock(ctx,ticketNumber));
        }
    }

    public void addUnconvertableBlock(Token start, Token stop, Integer ticketNumber) {
        if(start != null && stop != null) {
            this.unconvertableBlockList.add(new UnconvertableBlock(start, stop, ticketNumber));
        }
    }

    public void addUnconvertableBlock(TerminalNode term, Integer ticketNumber) {
        if(term != null) {
            this.unconvertableBlockList.add(new UnconvertableBlock(term, ticketNumber));
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

