package com.glamey.framework.utils;

/**
 * <p>中英文数字的字符串长度的截取</p>
 * <p/>
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class SubStringUtils {

    /**
     * @param s      要截取的字符串
     * @param length 要截取字符串的长度->是字节一个汉字2个字节
     *               return 返回length长度的字符串（含汉字）
     * @author cn
     */
    public static String substring(String s, int length) throws Exception {

        byte[] bytes = s.getBytes("Unicode");
        int byteLength = bytes.length;
        int n = 0; // 表示当前的字节数
        int i = 2; // 要截取的字节数，从第3个字节开始
        for (; i < byteLength && n < length; i++) {
            // 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
            if (i % 2 == 1) {
                n++; // 在UCS2第二个字节时n加1
            } else {
                // 当UCS2编码的第一个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
                if (bytes[i] != 0) {
                    n++;
                }
            }

        }
        // 如果i为奇数时，处理成偶数
       /*if (i % 2 == 1){
           // 该UCS2字符是汉字时，去掉这个截一半的汉字
           if (bytes[i - 1] != 0)
               i = i - 1;
           // 该UCS2字符是字母或数字，则保留该字符
           else
               i = i + 1;
       }*/
        //将截一半的汉字要保留
        if (i % 2 == 1) {
            i = i + 1;
        }
        return new String(bytes, 0, i, "Unicode") + (byteLength > length ? "..." : "");
    }

    public static void main(String[] args) throws Exception {
        System.out.println(substring("2013-2018年中国电力供应市场深度调研及战略决策咨询分析报告", 400));
        System.out.println(substring("中国华电科[2013]133号    关于转发中国电力科学技术奖奖励通报（2012年度）的通知", 40));
    }
}
