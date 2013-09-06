package com.glamey.library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.glamey.framework.utils.PropertiesUtil;

@Deprecated
@Repository
public class DBFactory {
	
	private static DBFactory _instance = null;

	public static DBFactory getInstance() {
		if (_instance == null) {
			synchronized (DBFactory.class) {
				if (_instance == null) {
					_instance = new DBFactory();
				}
			}
		}
		return _instance;
	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName(PropertiesUtil.getDBDriver());
			conn = DriverManager.getConnection(
					PropertiesUtil.getDBConnectionURL(),
					PropertiesUtil.getDBUserName(),
					PropertiesUtil.getDBPassword());
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	
}
