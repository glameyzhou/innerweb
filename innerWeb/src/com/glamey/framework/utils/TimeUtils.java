package com.glamey.framework.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.util.StringUtils;

public class TimeUtils {
	/*public static void main(String[] args) {
		System.out.println(DateFormatUtils.format(new Date(),
				"yyyy-MM-dd HH:mm:ss"));

		System.out.println(getDate(new Date(), 0));
	}*/

	public static String getDate(Date date, int amount) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(5, amount);
		return new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
	}
	
	
	public static String getDate(Date date,String format, int amount) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, amount);
//		calendar.add(Calendar.MINUTE, -30);
		return new SimpleDateFormat(format).format(calendar.getTime());
	}

	public static Date formatDate(String dateString) {
		if (!StringUtils.hasText(dateString))
			return new Date();
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(dateString);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static String getLongDate(){
		return DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
	}
	
	public static void main(String[] args) {
		System.out.println(getDate(new Date(), "yyyy-MM-dd HH:mm:ss", 0));
	}
}