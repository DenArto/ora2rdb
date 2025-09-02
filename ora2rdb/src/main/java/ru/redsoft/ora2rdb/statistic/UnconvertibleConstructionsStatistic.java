package ru.redsoft.ora2rdb.statistic;

import java.util.Map;
import java.util.TreeMap;

public class UnconvertibleConstructionsStatistic {

    private TreeMap<Integer, Integer> unconvertibleCondtructionsStatistic = new TreeMap<>();

    public UnconvertibleConstructionsStatistic(){}

    public void addTicket(int ticket){
        if(unconvertibleCondtructionsStatistic.containsKey(ticket))
            unconvertibleCondtructionsStatistic.put(ticket, unconvertibleCondtructionsStatistic.get(ticket) + 1);
        else
            unconvertibleCondtructionsStatistic.put(ticket, 1);
    }

    public String getStatistic(){
        StringBuilder statistic = new StringBuilder();
        unconvertibleCondtructionsStatistic.entrySet().stream()
                .sorted(Map.Entry.<Integer, Integer>comparingByValue().reversed())
                .forEach(entry -> {
                    statistic.append("RS-")
                            .append(entry.getKey())
                            .append(":\t")
                            .append(entry.getValue())
                            .append(" time(s)\n");
                });
        statistic.append("Total:\t")
                .append(unconvertibleCondtructionsStatistic.values().stream().mapToInt(Integer::intValue).sum())
                .append(" unconvertible constructions\n");
        return statistic.toString();
    }

    public void clear(){
        unconvertibleCondtructionsStatistic.clear();
    }

}
