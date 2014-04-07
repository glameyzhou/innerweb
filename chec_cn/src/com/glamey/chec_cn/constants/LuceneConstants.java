package com.glamey.chec_cn.constants;

import com.glamey.framework.utils.PropertiesUtil;

import java.io.File;

public class LuceneConstants {
    /**
     * 进行索引的字段
     */
    public static final String flID = "ID";
    public static final String flModel = "MODEL";
    public static final String flModelName = "MODELNAME" ;
    public static final String flHref = "HREF";
    public static final String flTitle = "TITLE";
    public static final String flSummary = "SUMMARY";
    public static final String flContent = "CONTENT";
    public static final String flTime = "TIME";

    static {
        File folder = new File(PropertiesUtil.getLuceneIndexDir());
        if(!folder.exists()){
            folder.mkdirs();
        }
    }
    public static final File INDEXDIR = new File(PropertiesUtil.getLuceneIndexDir());
}
