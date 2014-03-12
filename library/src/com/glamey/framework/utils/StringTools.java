package com.glamey.framework.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;

public class StringTools {
	public static String converISO2GBK(String source) {
		if (StringUtils.isBlank(source))
			return null;
		try {
			return new String(source.getBytes("ISO-8859-1"), "GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String converGBK2ISO(String source) {
		if (StringUtils.isBlank(source))
			return null;
		try {
			return new String(source.getBytes("GBK"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String converISO2UTF8(String source) {
		if (StringUtils.isNotBlank(source))
			try {
				return new String(source.getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return source;
			}
		return "";
	}

	public static String re(String str) {
		return StringUtils.isNotBlank(str) ? str.replaceAll("<", "&lt;")
				.replaceAll(">", "&gt;").replaceAll("\"", "&quot;") : "";
	}

	public static String filter(String str) {
		return StringUtils.isNotBlank(str) ? str.replaceAll("'", "''")
				.replaceAll("#", "\\#") : "";
	}
	
	public static String removeHtml(String str) {
		return StringUtils.isNotBlank(str) ? str.replaceAll("<.+?>", "") : "";
	}

	public static String substring(String source, int end, String append) {
		if (StringUtils.isBlank(source)) {
			return "";
		}
		append = StringUtils.isNotBlank(append) ? append : "...";
		int len = source.length();

		if (len > end) {
			return source.substring(0, end).concat(append);
		}
		if (len <= end) {
			return source;
		}
		return "";
	}

	public static String substring(String source, int end) {
		return StringUtils.substring(source, 0, end);
	}

	public static String getUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	public static String encoder(String source) {
		if (StringUtils.isBlank(source))
			return "";
		try {
			return URLEncoder.encode(source, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "";
	}

	public static String decoder(String source) {
		if (StringUtils.isBlank(source))
			return "";
		try {
			return URLDecoder.decode(source, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "";
	}
	/**
	 * 根据当前UUID获取一个唯一的短连接
	 * @return
	 */
	public static String getUniqueId(){
		return URLUtils.getShort(getUUID());
	}
	public static void main(String[] args) throws UnsupportedEncodingException {
		/*String str = "<a>aa</a>";
		System.out.println(substring(str, 2, ".."));*/
		System.out.println(getUUID());
		System.out.println(getUUID().length());
		/*System.out.println("a3,");*/
		System.out.println(substring("2011-05-11 14:42:03", 16, ""));
		System.out.println(getUniqueId());


        String str = "aSd123中国人aSd123中国人" ;
        char c [] = str.toCharArray();
        for (char c1 : c) {
            System.out.println(c1 + " 数字：" + Character.isDigit(c1) + " 字母：" + Character.isLetter(c1) + " " + Character.isLowerCase(c1));
        }
        /*StringBuffer result = new StringBuffer();
        int subLen = 8 ;
        double subIndex = 0 ;
        int len = c.length ;
        char ch ;
        for(int i = 0 ; i < len ; i ++){
            ch = c[i] ;
            if(Character.isDefined(ch) || Character.isLetter(ch)){
               subIndex += 0.5 ;
            }else{
                subIndex += 1 ;
            }
            result.append(ch);
            if(subIndex == 8){
                break;
            }
        }
        System.out.println(result);*/
        System.out.println("+++++++++++++++++++++++++++");
        str = "中国人、assbABS123--+" ;
        str = "2013-2018年中国电力产业发展规划与投资战略部署专题研究报告";
        String ss [] = str.split("");
        int sublen = 18 ;
        StringBuffer result = new StringBuffer(sublen);
        double subIndex = 0;
        String s ;
        for(int i = 0 ; i < str.length() ; i ++){
            s = ss [i] ;
            //utf-8的中文
            if(s.getBytes().length == 3 ){
                result.append(s);
                subIndex += 1 ;
            }
            else {
                subIndex += 0.3333333 ;
                result.append(s);
            }
            if((int)subIndex == sublen){
                break;
            }
            System.out.println(s + " " + s.getBytes("UTF-8").length);
        }
        System.out.println(result);
        /*for (String s : ss) {
            System.out.println(s + " length = " + s.getBytes().length);
        }*/


        System.out.println(URLUtils.getShort("通知公告"));
        System.out.println(URLUtils.getShort("行业资讯"));
        System.out.println(URLUtils.getShort("BBS_煤炭清洁利用"));
        System.out.println(URLUtils.getShort("专题讨论区"));

    }
}