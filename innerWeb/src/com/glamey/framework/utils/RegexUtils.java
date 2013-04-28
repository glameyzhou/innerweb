package com.glamey.framework.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

public class RegexUtils {
	public static List<String> getStringGoup1(String source, String reg) {
		List<String> list = new ArrayList<String>();
		if (StringUtils.isBlank(reg))
			throw new IllegalArgumentException(
					"regex must contain group 1 at least.");
		if (StringUtils.isBlank(source))
			throw new IllegalArgumentException("source can`t be null.");
		Pattern p = Pattern.compile(reg, Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL) ;
		Matcher m = null;

		m = p.matcher(source);
		while (m.find()) {
			list.add(m.group(1));
		}
		return list;
	}

	public static void main(String[] args) {
		String source = "AasdfAB123Dd";
		System.out.println(getStringGoup1(source, "AB(.+?)DD"));
	}
}