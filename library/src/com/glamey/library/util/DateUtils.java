package com.glamey.library.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class DateUtils {

    /**
     * 与当前相比，是否在指定的天数之内
     *
     * @param diffDays
     * @return
     */
    public static boolean isDiffDays(int diffDays, Date date) {
        Date current = new Date();
        if (date == null)
            return false;

        if (diffDays < 0)
            return false;

        long diff = current.getTime() - date.getTime();
        return diff / (24 * 3600 * 1000) <= diffDays;
    }

    /**
     * 是否在八天之内
     * @param date
     * @return
     */
    public static boolean isDiff8Days(Date date){
        return isDiffDays(8,date);
    }

    public static void main(String[] args) throws ParseException {
        String cur = "2013-12-31 01:14:52";
        java.text.SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date curDate = sdf.parse(cur);
//        System.out.println(sdf.format(curDate));

        System.out.println(isDiffDays(7,curDate));
    }
}
