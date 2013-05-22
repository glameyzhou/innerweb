package com.glamey.framework.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;

public class PropertiesUtil {
	private static Properties proConstants;

	private static void init() {
		try {
			proConstants = new Properties();
			InputStream inConstants = PropertiesUtil.class.getClassLoader()
					.getResourceAsStream("constants.properties");
			proConstants.load(inConstants);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getValue(String key) {
		String value = "";
		if (proConstants == null) {
			init();
		}
		if (StringUtils.isBlank(proConstants.getProperty(key))) {
			return "";
		}
		value = proConstants.getProperty(key);
		return value;
	}

	public static String getDBBasePath() {
		return getValue("db.mysqlBasePath");
	}

	public static String getDBName() {
		return getValue("db.mysqlDBName");
	}

	public static String getDBUserName() {
		return getValue("db.mysqlDBUsername");
	}

	public static String getDBPassword() {
		return getValue("db.mysqlDBPassword");
	}

	public static String getDBDriver() {
		return getValue("db.mysqlDBDriver");
	}

	public static String getDBConnectionURL() {
		return getValue("db.mysqlConnectionURL");
	}

	public static String getLuceneIndexDir() {
		return getValue("lucene.indexDir");
	}

	public static String getProjectBasePath() {
		return getValue("projectBasePath");
	}

	public static String getProjectBaseURL() {
		return getValue("projectBaseURL");
	}

	public static String getChecIp() {
		return getValue("chec.DBIP");
	}

	public static String getChecDBName() {
		return getValue("chec.DBName");
	}

	public static String getChecDBUser() {
		return getValue("chec.DBUsername");
	}

	public static String getChecDBPassword() {
		return getValue("chec.DBPassword");
	}

	public static String getChecDBDriver() {
		return getValue("chec.DBDriver");
	}

	public static String getChecDBConnectionURL() {
		return getValue("chec.DBConnectionURL");
	}

	public static String getChecENIp() {
		return getValue("chec.en.DBIP");
	}

	public static String getChecENDBName() {
		return getValue("chec.en.DBName");
	}

	public static String getChecENDBUser() {
		return getValue("chec.en.DBUsername");
	}

	public static String getChecENDBPassword() {
		return getValue("chec.en.DBPassword");
	}

	public static String getChecENDBDriver() {
		return getValue("chec.en.DBDriver");
	}

	public static String getChecENDBConnectionURL() {
		return getValue("chec.en.DBConnectionURL");
	}

	public static void main(String[] args) {
		System.out.println(getDBBasePath());
		System.out.println(getChecDBDriver());
		System.out.println(getChecENDBConnectionURL());
		System.out.println(getLuceneIndexDir());
	}
}