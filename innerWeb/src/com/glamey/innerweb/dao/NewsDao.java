/**
 * 
 */
package com.glamey.innerweb.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.glamey.innerweb.model.domain.Post;

/**
 * 新闻内容数据库操作
 * 
 * @author zy
 *
 */
@Repository
public class NewsDao {
	private static final Logger logger = Logger.getLogger(NewsDao.class);
	
	@Resource
	private JdbcTemplate jdbcTemplate ;
	
	/**
	 * 
	 * @param news
	 * @return
	 */
	public boolean create(Post news){
		logger.info("[NewsDao] #save#" + news);
		try{
			jdbcTemplate.execute("");
			return true ;
		}catch (Exception e) {
		}
		return false ;
	}
	
	/**
	 * 
	 * @param news
	 * @return
	 */
	public boolean update(Post news){
		logger.info("[NewsDao] #update#" + news);
		try{
			jdbcTemplate.update("");
			return true ;
		}catch (Exception e) {
		}
		return false ;
	}
	/**
	 * @param id
	 * @return
	 */
	public boolean delete(String id){
		logger.info("[NewsDao] #delete#" + id);
		try{
			jdbcTemplate.update("");
			return true ;
		}catch (Exception e) {
		}
		return false ;
	}
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	public Post getById(String id){
		logger.info("[NewsDao] #getCategoryById#" + id);
		try{
		}catch (Exception e) {
		}
		return null ;
	}
	/**
	 * 
	 * @return
	 */
	public List<Post> getListByCondition(String...strings){
		logger.info("[NewsDao] #getAllCategory#");
		try{
		}catch (Exception e) {
		}
		return null ;
	}
}
