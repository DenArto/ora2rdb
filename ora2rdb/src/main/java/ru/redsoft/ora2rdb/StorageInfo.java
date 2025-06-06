package ru.redsoft.ora2rdb;

import ru.redsoft.ora2rdb.comments.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.TreeMap;
import java.util.TreeSet;

public class StorageInfo {
    public static ArrayList<String> package_constant_names = new ArrayList<>();
    public static ArrayList<StoredBlock> stored_blocks_list = new ArrayList<>();
    public static ArrayList<Table> tables = new ArrayList<>();
    public static TreeMap<String, TreeSet<String>> table_not_null_cols = new TreeMap<String, TreeSet<String>>();
    public static HashSet<Index> index_names = new HashSet<>();
    public static TreeMap<String, View> views = new TreeMap<String, View>();
    public static TreeMap<String, TreeMap<String, String>> types_of_column = new TreeMap<>();
    public static ArrayList<CommentedBlock> commentedBlockList = new ArrayList<>();




    public static void clearInfo() {
        package_constant_names.clear();
        stored_blocks_list.clear();
        tables.clear();
        table_not_null_cols.clear();
        index_names.clear();
        views.clear();
        types_of_column.clear();
        commentedBlockList.clear();
    }
}
