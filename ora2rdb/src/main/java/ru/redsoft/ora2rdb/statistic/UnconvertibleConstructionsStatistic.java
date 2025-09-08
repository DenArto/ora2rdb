package ru.redsoft.ora2rdb.statistic;

import ru.redsoft.ora2rdb.comments.Ticket;

import java.util.Map;
import java.util.TreeMap;

public class UnconvertibleConstructionsStatistic {

    private final TreeMap<Ticket, Integer> unconvertibleConstructionsStatistic = new TreeMap<>();

    public UnconvertibleConstructionsStatistic(){}

    public void addTicket(Ticket ticket){
        if(unconvertibleConstructionsStatistic.containsKey(ticket))
            unconvertibleConstructionsStatistic.put(ticket, unconvertibleConstructionsStatistic.get(ticket) + 1);
        else
            unconvertibleConstructionsStatistic.put(ticket, 1);
    }

    public String getUnconvertibleConstructionsStatistic(){
        StringBuilder statistic = new StringBuilder("-- Summary of unconvertible constructions\n");

        int maxNameLength = unconvertibleConstructionsStatistic.keySet().stream()
                .mapToInt(ticket -> ticket.getName().length())
                .max()
                .orElse(30);

        unconvertibleConstructionsStatistic.entrySet().stream()
                .sorted(Map.Entry.<Ticket, Integer>comparingByValue().reversed())
                .forEach(entry -> {
                    statistic.append("--\tRS-")
                            .append(String.format("%6d", entry.getKey().getTicketCode()))
                            .append(" (")
                            .append(String.format("%-" + (maxNameLength + 2) + "s", entry.getKey().getName() + "):"))
                            .append(String.format("%6d", entry.getValue()))
                            .append(" time(s)\n");
                });

        statistic.append("--\tTotal:\t")
                .append(unconvertibleConstructionsStatistic.values().stream().mapToInt(Integer::intValue).sum())
                .append(" unconvertible constructions\n");

        return statistic.toString();
    }

    public void clear(){
        unconvertibleConstructionsStatistic.clear();
    }

}
