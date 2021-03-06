package com.glamey.framework.utils.tld;

import com.glamey.chec_cn.model.domain.Category;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.springframework.util.PatternMatchUtils;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;


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
            for(int i = 1 ; i < sourceLen ; i ++){ //第一个是空格，直接跳过
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
                    increment = 0.5 ;
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

    public static void main(String[] args) throws UnsupportedEncodingException {
        /*System.out.println("home/a.htm".matches(".+htm"));
        List<String> list = new ArrayList<String>();
        list.add("01_news_xx_create");
        list.add("01_news_xx_update");
        list.add("01_news_xx_delete");

        System.out.println(hasRightsRegex(list,"01_notices*"));
        System.out.println("..." + StringTld.substringPreciseAppend("2013-2018年中国电力供应市场深度调研及战略决策咨询分析报告",18,".."));
        System.out.println("..." + StringTld.substringPreciseAppend("中国华电科[2013]133号    关于转发中国电力科学技术奖奖励通报（2012年度）的通知",20,".."));*/


        System.out.println(substringPreciseAppend("EI Annual Enerny Outlook 2013",18,""));
        System.out.println(substringPreciseAppend("Journal of Biobased Materials and Bioenergy》",18,""));
        /*String s = "国中华电科[2013]76号 关于下EIA：Annual Enerny Outlook 201";
        String ss [] = s.split("");
        int index = 0 ;

        char chars [] = s.toCharArray();
        for (char aChar : chars) {
            System.out.println(aChar);
        }*/
        /*for (String s1 : ss) {
            int len = s1.getBytes("UTF-8").length;
            if(index == 0) continue;
            if(len == 3){ // 表示是中文字符

            }
            System.out.println(">>>" + s1 + " length=" + s1.getBytes("UTF-8").length);
            index ++ ;
        }*/
    }
}