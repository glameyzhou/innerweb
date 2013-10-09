package com.glamey.framework.utils.tld;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.LibraryInfo;
import org.apache.commons.lang.StringUtils;
import com.glamey.framework.utils.StringTools;
import org.springframework.util.PatternMatchUtils;


public class StringTld {
    /**
     * @param source
     * @param end
     * @param append
     * @return
     */
    public static String substringAppend(String source, Integer end, String append) {
        return StringTools.substring(source, end.intValue(), append);
    }
    public static String substringPreciseAppend(String source, Integer end, String append) {
        if (StringUtils.isBlank(source)) {
            return "";
        }
        source = source.trim();
        append = StringUtils.isNotBlank(append) ? append : "...";
        int len = source.length();

        if (len > end) {
            StringBuffer result = new StringBuffer(end);
            int sourceLen = source.length() ;
            String ss [] = source.split("");
            double subIndex = 0;
            double increment = 0.333333333333333333 ;
            String s ;
            for(int i = 0 ; i < sourceLen ; i ++){
                s = ss [i] ;
                int sLen = s.getBytes().length;
                //utf-8的中文
                if(sLen == 3 ){
                    subIndex += 1 ;
                }
                //gbk的中文
                else if(sLen == 2){
                    subIndex += 1 ;
                    increment = 0.5 ;
                } else {
                    subIndex += increment ;
                }
                result.append(s);
                if((int)subIndex == end){
                    break;
                }
            }
            return result.append(append).toString();
        }
        if (len <= end) {
            return source;
        }
        return "";
    }

    public static String substring(String source, Integer end) {
        return StringTools.substring(source, end.intValue());
    }

    public static String encoder(String source) {
        return StringTools.encoder(source);
    }

    public static String decoder(String source) {
        return StringTools.decoder(source);
    }

    public static boolean isContainsInList(String source, List<String> list) {
        if ((StringUtils.isBlank(source)) || (list == null)
                || (list.size() == 0)) {
            return false;
        }
        return list.contains(source);
    }

    public static boolean containsInList(String source, List<Category> list) {
        if (StringUtils.isBlank(source) || list == null || list.size() == 0) {
            return false;
        }
        for (Category c : list) {
            if (StringUtils.isNotBlank(c.getId()) && StringUtils.equals(c.getId(), source)) {
                return true;
            }
        }
        return false;
    }

    public static boolean aContantsb(String src, String dest) {
        boolean result = false;
        if (StringUtils.isBlank(src) || StringUtils.isBlank(dest)) {
            return false;
        }
        return src.contains(dest);
    }

    public static boolean hasRights(List<String> list, String rights) {
        if (list == null || list.size() == 0 || StringUtils.isBlank(rights)) {
            return false;
        }
        return list.contains(rights);
    }

    /**
     *
     * @param list 01_news_yyxx_create
     * @param regex 01_news*
     * @return
     */
    public static boolean hasRightsRegex(List<String> list, String regex) {
        if (list == null || list.size() == 0 || StringUtils.isBlank(regex)) {
            return false;
        }
        for (String s : list) {
            if(PatternMatchUtils.simpleMatch(regex,s)){
                return true ;
            }
        }
        return false;
    }
    public static boolean hasRights(Map<String, String> rightsMap, String rights) {
        if (rightsMap == null || rightsMap.size() == 0 || StringUtils.isBlank(rights)) {
            return false;
        }
        return rightsMap.containsKey(rights);
    }

    public static void main(String[] args) {
        System.out.println("home/a.htm".matches(".+htm"));
        List<String> list = new ArrayList<String>();
        list.add("01_news_xx_create");
        list.add("01_news_xx_update");
        list.add("01_news_xx_delete");

        System.out.println(hasRightsRegex(list,"01_notices*"));
        System.out.println("..." + StringTld.substringPreciseAppend("2013-2018年中国电力供应市场深度调研及战略决策咨询分析报告",18,".."));
        System.out.println("..." + StringTld.substringPreciseAppend("中国华电科[2013]133号    关于转发中国电力科学技术奖奖励通报（2012年度）的通知",20,".."));

    }
}