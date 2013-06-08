package com.glamey.framework.utils;

import java.security.MessageDigest;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * Date: 13-5-17
 * Time: 下午1:20
 * To change this template use File | Settings | File Templates.
 */
public class StringHandler {
    private static final byte CRYPTKEY = 0x6E;

    /**
     * 解密
     *
     * @param target
     * @return
     */
    public static String decrypt(String target) {
        byte[] bytes = target.getBytes();
        int len = bytes.length;
        for (int i = 0; i < len; i++) {
            bytes[i] = (byte) (bytes[i] ^ CRYPTKEY);
        }
        return new String(bytes);
    }

    /**
     * 解密
     *
     * @param source
     * @return
     */
    public static String ecrypt(String source) {
        if (source == null) {
            return null;
        }
        byte[] bytes = source.getBytes();
        int len = bytes.length;
        for (int i = 0; i < len; i++) {
            bytes[i] = (byte) (bytes[i] ^ CRYPTKEY);
        }
        return new String(bytes);
    }

    /**
     * md5运算
     *
     * @param source
     * @return
     */
    public static String md5(String source) {
        MessageDigest md5 = null;
        try {
            md5 = MessageDigest.getInstance("MD5");
        } catch (Exception e) {
            System.out.println(e.toString());
            e.printStackTrace();
            return "";
        }
        char[] charArray = source.toCharArray();
        byte[] byteArray = new byte[charArray.length];

        for (int i = 0; i < charArray.length; i++)
            byteArray[i] = (byte) charArray[i];

        byte[] md5Bytes = md5.digest(byteArray);

        StringBuffer hexValue = new StringBuffer();

        for (int i = 0; i < md5Bytes.length; i++) {
            int val = ((int) md5Bytes[i]) & 0xff;
            if (val < 16)
                hexValue.append("0");
            hexValue.append(Integer.toHexString(val));
        }
        return hexValue.toString();
    }
}
