package com.glamey.library.test;

import com.glamey.framework.utils.Pinyin4jUtils;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class PinyinTest {
    public static void main(String[] args) {
        String source = "周杨";
        System.out.println(Pinyin4jUtils.getPinYin(source));
        System.out.println(Pinyin4jUtils.getPinYinHeadChar(source));
    }
}
