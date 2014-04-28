package com.glamey.framework.utils;


import java.text.DecimalFormat;

/**
 * Created by zy
 */
public class NumberUtils {

    public static String division(long a, long b) {
        if (b == 0)
            return "无穷大";
        if (a == 0)
            return "0";
        double p1 = a;
        double p2 = b;
        double result = p1 / p2;
        DecimalFormat decimalFormat = new DecimalFormat("0.00");
        return decimalFormat.format(result);
    }

    public static String getFileSize(long fileSize) {
        if (fileSize > 0 && fileSize < 1024) {
            return fileSize + "B";
        }
        else if (fileSize >= 1024 && fileSize < 1024 * 1024) {
            return division(fileSize,1024) + "K";
        }
        else if (fileSize >= 1024 * 1024 && fileSize < 1024 * 1024 * 1024) {
            return division(fileSize,1024 * 1024) + "M";
        }
        else {
            return division(fileSize,1024 * 1024 * 1024) + "M";
        }
    }
    public static void main(String[] args) {
        System.out.println(division(3,5));
        System.out.println(getFileSize(123123142));
    }
}
