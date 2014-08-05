package com.glamey.chec_cn.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Properties;

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
    public static boolean isDiff7Days(Date date){
        return isDiffDays(7,date);
    }


    /**
     * 获取前后几天的时间
     * @param d
     * @param day +后几天  -前几天
     * @return
     */
    public static Date getDay(Date d, int day) {
        Calendar now = Calendar.getInstance();
        now.setTime(d);
        now.set(Calendar.DATE, now.get(Calendar.DATE) + day);
        return now.getTime();
    }

    public static Date format(String dateString,String patter) {
        SimpleDateFormat format = new SimpleDateFormat(patter);
        Date date = null;
        try {
            date = format.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static void main(String[] args) throws ParseException {
        String cur = "2014-03-04 01:14:52";
        java.text.SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date curDate = sdf.parse(cur);
        System.out.println(sdf.format(curDate));
        System.out.println(isDiffDays(3,curDate));

        System.out.println(getDay(new Date(),-6));

        InputStream is = null;
        try {
            File home = new File("c:/cps");
            File conf = new File(home, "properties");
            File propertiesFile = new File(conf, "test.properties");
            is = new FileInputStream(propertiesFile);
            Properties properties = new Properties();
            properties.load(is);
            Enumeration enumeration = properties.propertyNames();
            while (enumeration.hasMoreElements()) {
                String name = (String) enumeration.nextElement();
                String value = properties.getProperty(name);
                if (value != null) {
                    System.setProperty(name, value);
                }
            }
        } catch (Throwable t) {
        }

        System.out.println("tst1=" + System.getProperty("test.a"));
        System.out.println("test2=" + System.getProperty("test.b"));
    }
}
