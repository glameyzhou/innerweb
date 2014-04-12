package com.glamey.chec_cn.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

/**
 * 
 * @author zy
 *
 */
@Repository
public class BaseDao{
	@Autowired
	protected JdbcTemplate jdbcTemplate;
}