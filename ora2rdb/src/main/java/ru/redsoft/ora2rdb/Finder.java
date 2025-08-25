package ru.redsoft.ora2rdb;

import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.RuleNode;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.List;

public class Finder {

    public static <T extends ParseTree> T getFirstRuleContext(ParseTree ctx, Class<T> ruleContext) {
        return getFirstRuleContext(ctx, ruleContext, ctx);
    }

    private static <T extends ParseTree> T getFirstRuleContext(ParseTree ctx, Class<T> ruleContext, ParseTree StartContext) {

        if (ctx instanceof ErrorNode)
            return null;

        if (ctx.getClass().equals(ruleContext))
            return ruleContext.cast(ctx);

        if (ctx instanceof TerminalNode)
            return null;

        RuleNode r = (RuleNode) ctx;
        int n = r.getChildCount();
        for (int i = 0; i < n; i++) {
            if (r.getChild(i).getClass().equals(StartContext.getClass()))
                break;
            T find = getFirstRuleContext(r.getChild(i), ruleContext, StartContext);
            if (find != null)
                return find;
        }
        return null;
    }

    public static <T extends ParseTree> T getLastRuleContext(ParseTree ctx, Class<T> ruleContext) {
        return getLastRuleContext(ctx, ruleContext, ctx);
    }

    private static <T extends ParseTree> T getLastRuleContext(ParseTree ctx, Class<T> ruleContext, ParseTree startContext) {
        if (ctx instanceof ErrorNode) {
            return null;
        }

        if (ctx.getClass().equals(ruleContext)) {
            T lastFound = null;
            if (!(ctx instanceof TerminalNode)) {
                RuleNode r = (RuleNode) ctx;
                int n = r.getChildCount();
                for (int i = n - 1; i >= 0; i--) {
                    if (r.getChild(i).getClass().equals(startContext.getClass())) {
                        break;
                    }
                    T find = getLastRuleContext(r.getChild(i), ruleContext, startContext);
                    if (find != null) {
                        lastFound = find;
                        break;
                    }
                }
            }
            return lastFound != null ? lastFound : ruleContext.cast(ctx);
        }

        if (ctx instanceof TerminalNode) {
            return null;
        }

        RuleNode r = (RuleNode) ctx;
        int n = r.getChildCount();
        T lastFound = null;

        for (int i = n - 1; i >= 0; i--) {
            if (r.getChild(i).getClass().equals(startContext.getClass())) {
                break;
            }
            T find = getLastRuleContext(r.getChild(i), ruleContext, startContext);
            if (find != null) {
                lastFound = find;
                break;
            }
        }
        return lastFound;
    }

    public static <T extends ParseTree> List<T> getAllRuleContexts(ParseTree ctx, Class<T> ruleContext) {
        List<T> result = new ArrayList<>();
        getAllRuleContexts(ctx, ruleContext, ctx, result);
        return result;
    }

    private static <T extends ParseTree> void getAllRuleContexts(ParseTree ctx, Class<T> ruleContext, ParseTree startContext, List<T> result) {
        if (ctx instanceof ErrorNode)
            return;

        if (ruleContext.isInstance(ctx))
            result.add(ruleContext.cast(ctx));

        if (ctx instanceof TerminalNode)
            return;

        if (ctx.getClass().equals(startContext.getClass()) && ctx != startContext)
            return;

        if (ctx instanceof RuleNode) {
            RuleNode r = (RuleNode) ctx;
            int n = r.getChildCount();
            for (int i = 0; i < n; i++) {
                getAllRuleContexts(r.getChild(i), ruleContext, startContext, result);
            }
        }
    }

    public static <T extends ParseTree> List<T> getAllRuleContextsIntoCtx(ParseTree ctx, Class<T> ruleContext) {
        List<T> result = new ArrayList<>();
        getAllRuleContextsIntoCtx(ctx, ruleContext, ctx, result);
        return result;
    }

    private static <T extends ParseTree> void getAllRuleContextsIntoCtx(ParseTree ctx, Class<T> ruleContext, ParseTree startContext, List<T> result) {
        if (ctx instanceof ErrorNode)
            return;

        if (ruleContext.isInstance(ctx)) {
            result.add(ruleContext.cast(ctx));
            return;
        }
        if (ctx instanceof TerminalNode)
            return;

        if (ctx.getClass().equals(startContext.getClass()) && ctx != startContext)
            return;

        if (ctx instanceof RuleNode) {
            RuleNode r = (RuleNode) ctx;
            int n = r.getChildCount();
            for (int i = 0; i < n; i++) {
                getAllRuleContextsIntoCtx(r.getChild(i), ruleContext, startContext, result);
            }
        }
    }

    public static <T extends ParseTree> T getParentRuleContext(ParseTree ctx, Class<T> ruleContext){
        if (ctx instanceof ErrorNode)
            return null;

        if(ctx.getParent() == null)
            return null;

        if(ctx.getParent().getClass().equals(ruleContext))
            return ruleContext.cast(ctx.getParent());

        return getParentRuleContext(ctx.getParent(), ruleContext);
    }

}
