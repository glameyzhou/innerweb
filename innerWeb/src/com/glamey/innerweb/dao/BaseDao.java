package com.glamey.innerweb.dao;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

/**
 * 
 * @author zy
 *
 */
@Repository
public class BaseDao{
	@Resource
	protected JdbcTemplate jdbcTemplate ;
}
