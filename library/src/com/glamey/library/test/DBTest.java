package com.glamey.library.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

public class DBTest {

	public static void main(String[] args) {
		
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/glamey/library/conf/dataSource.xml");
		
		JdbcTemplate template = (JdbcTemplate) context.getBean("jdbcTemplate");
		
		int a = template.queryForInt("select count(1) from tbl_category");
	}
}
