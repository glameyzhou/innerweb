package com.glamey.framework.utils;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

public class WebUtils {
	public static String getRequestParameterAsString(
			HttpServletRequest req, String parameter, String defaultValue) {
		String value = getRequestParameterAsString(req, parameter);
		if (StringUtils.isBlank(value)) {
			return StringUtils.isBlank(defaultValue) ? "" : defaultValue;
		}
		return value;
	}

	public static String getRequestParameterAsString(
			HttpServletRequest req, String parameter) {
		if (StringUtils.isBlank(parameter)) {
			return "";
		}
		String value = req.getParameter(parameter);
		if (StringUtils.isBlank(value)) {
			return "";
		}
		return value;
	}
	
	public static String getRequestParameterAsStringEscape(
			HttpServletRequest req, String parameter) {
		String value = getRequestParameterAsString(req, parameter);
		return StringTools.re(value);
	}

	public static int getRequestParameterAsInt(HttpServletRequest req,
			String parameter, int defaultValue) {
		if (StringUtils.isBlank(parameter)) {
			return defaultValue;
		}
		String value = req.getParameter(parameter);
		if (StringUtils.isBlank(value)) {
			return defaultValue;
		}
		if (value.matches("\\d+")) {
			return Integer.parseInt(value);
		}
		return defaultValue;
	}
	public static float getRequestParameterAsFloat(HttpServletRequest req,String parameter, float defaultValue) {
		if (StringUtils.isBlank(parameter)) {
			return defaultValue;
		}
		String value = req.getParameter(parameter);
		if (StringUtils.isBlank(value)) {
			return defaultValue;
		}
		if (value.matches("\\d+\\.\\d+")) {
			return Float.valueOf(value).floatValue();
		}
		return defaultValue;
	}

	public static String[] getRequestParameterAsStringArrs(
			HttpServletRequest req, String parameter) {
		if (StringUtils.isBlank(parameter)) {
			return null;
		}
		return req.getParameterValues(parameter);
	}
}