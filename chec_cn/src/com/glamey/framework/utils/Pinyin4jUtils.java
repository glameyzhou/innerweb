package com.glamey.framework.utils;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;
import org.apache.commons.lang.StringUtils;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class Pinyin4jUtils {
    /**
     * 将汉字转换为全拼,如果参数为空则返回""
     * 只转换汉字，其他不转换
     *
     * @param str
     * @return String
     */
    public static String getPinYin(String str) {

        if (StringUtils.isEmpty(str)) {
            return "";
        }

        char[] tempChars = str.toCharArray();
        String[] tempStr = new String[tempChars.length];

        // 设置汉字拼音输出的格式
        HanyuPinyinOutputFormat pinyinFormat = new HanyuPinyinOutputFormat();
        pinyinFormat.setCaseType(HanyuPinyinCaseType.UPPERCASE);
        pinyinFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        pinyinFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
        String result = "";
        int index = tempChars.length;
        try {
            String tmp;
            for (int i = 0; i < index; i++) {
                tmp = Character.toString(tempChars[i]);
                if (StringUtils.isBlank(tmp)) {
                    result += "-";
                    continue;
                }
                // 判断是否为汉字字符
                if (tmp.matches("[\\u4E00-\\u9FA5]+")) {
                    // 将汉字的几种全拼都存到tempStr数组中
                    tempStr = PinyinHelper.toHanyuPinyinStringArray(tempChars[i], pinyinFormat);
                    // 取出该汉字全拼的第一种读音并连接到字符串result后
                    result += tempStr[0];
                } else {
                    // 如果不是汉字字符，间接取出字符并连接到字符串result后
                    result += StringUtils.upperCase(tmp);
                }
            }
        } catch (BadHanyuPinyinOutputFormatCombination e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 提取每个汉字的首字母
     *
     * @param str
     * @return String
     */
    public static String getPinYinHeadChar(String str) {
        String convert = "";
        if (StringUtils.isEmpty(str)) {
            return "";
        }
        for (int i = 0; i < str.length(); i++) {
            char word = str.charAt(i);
            // 提取汉字的首字母
            String pinyinArray = getPinYin(String.valueOf(word));
            convert += pinyinArray.charAt(0);
        }
        return convert;
    }

    public static void main(String[] args) {
        System.out.println(getPinYin("asdf中国人爱上对方"));
        System.out.println(getPinYin("asdf中国人爱上 对方"));
    }

}
