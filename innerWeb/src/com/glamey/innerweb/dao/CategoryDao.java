/**
 * 
 */
package com.glamey.innerweb.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.glamey.framework.utils.StringTools;
import com.glamey.innerweb.model.domain.Category;

/**
 * 分类数据库操作
 * 
 * @author zy
 *
 */
@Repository
public class CategoryDao extends BaseDao {
	private static final Logger logger = Logger.getLogger(CategoryDao.class);
	/**
	 * @param category
	 * @return
	 */
	public boolean create(final Category category){
		logger.info("[CategoryDao] #create# " + category);
		try{
			jdbcTemplate.update(
					"insert into tbl_category(id,name,shortname,alias,describe,showtype,showindex,parentid,categorytype,categoryimage),values(?,?,?,?,?,?,?,?,?,?,?)", 
					new PreparedStatementSetter() {
				@Override
				public void setValues(PreparedStatement pstmt)throws SQLException {
					int i = 0 ;
					pstmt.setString(++i,StringTools.getUniqueId());
					pstmt.setString(++i,category.getName());
					pstmt.setString(++i, category.getShortName());
					pstmt.setString(++i, category.getAlias());
					pstmt.setString(++i,category.getDescribe());
					pstmt.setInt(++i,category.getShowType());
					pstmt.setInt(++i,category.getShowIndex());
					pstmt.setString(++i,category.getParentId());
					pstmt.setString(++i,category.getCategoryType());
					pstmt.setString(++i, category.getCategoryImage());
				}
			});
			return true ;
		}catch (Exception e) {
			logger.error("[CategoryDao] #create# error " +  category);
			return false ;
		}
	}
	
	/**
	 * 
	 * @param category
	 * @return
	 */
	public boolean update(final Category category){
		logger.info("[CategoryDao] #update# " + category);
		try{
			jdbcTemplate.update(
					"update tbl_category set name=?,shortname=?,alias=?,describe=?,showtype=?,showindex=?,parentid=?,categorytype=? ,categoryimage = ? where id = ?", 
					new PreparedStatementSetter() {
				@Override
				public void setValues(PreparedStatement pstmt)throws SQLException {
					int i = 0 ;
					pstmt.setString(++i,category.getName());
					pstmt.setString(++i, category.getShortName());
					pstmt.setString(++i, category.getAlias());
					pstmt.setString(++i,category.getDescribe());
					pstmt.setInt(++i,category.getShowType());
					pstmt.setInt(++i,category.getShowIndex());
					pstmt.setString(++i,category.getParentId());
					pstmt.setString(++i,category.getCategoryType());
					pstmt.setString(++i, category.getCategoryImage());
					pstmt.setString(++i,category.getId());
				}
			});
			return true ;
		}catch (Exception e) {
			logger.error("[CategoryDao] #create# error " +  category);
			return false ;
		}
	}
	/**
	 * 通过ID删除分类
	 * @param id
	 * @return
	 */
	public boolean deleteById(final String id){
		logger.info("[CategoryDao] #delete#" + id);
		try{
			jdbcTemplate.update("delete from tbl_category where id = ?",new PreparedStatementSetter(){
				@Override
				public void setValues(PreparedStatement preparedstatement)
						throws SQLException {
					preparedstatement.setString(1, id);
				}});
			return true ;
		}catch (Exception e) {
			logger.error("[CategoryDao] #delete# error " + id);
		}
		return false ;
	}
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	public Category getById(final String id){
		logger.info("[CategoryDao] #getById#" + id);
		final Category category = new Category();
		try{
			jdbcTemplate.query("select * from tbl_category where id = ? ", 
					new PreparedStatementSetter() {
						@Override
						public void setValues(PreparedStatement preparedstatement)
								throws SQLException {
							preparedstatement.setString(1, id);
						}
					},
					new CategoryRowMapper());
		}catch (Exception e) {
			logger.error("[CategoryDao] #getById# error " + id);
		}
		return category ;
	}
	/**
	 * 
	 * @param parentId
	 * @param categoryType
	 * @return
	 */
	public List<Category> getByParentId(final String parentId,final String categoryType,final int start,final int num){
		logger.info("[CategoryDao] #getCategoryByParentId# parendId=" + parentId + " categoryType=" + categoryType);
		List<Category> list = new ArrayList<Category>();
		try{
			list = jdbcTemplate.query("select * from tbl_category where category = ? and parentid = ? limit ?,? ", 
					new PreparedStatementSetter() {
						@Override
						public void setValues(PreparedStatement preparedstatement)
								throws SQLException {
							preparedstatement.setString(1, categoryType);
							preparedstatement.setString(2, parentId);
							preparedstatement.setInt(3, start);
							preparedstatement.setInt(4, num);
						}
					},
					new CategoryRowMapper());			
			return list ;
		}catch (Exception e) {
		}
		return null ;
	}
	/**
	 * @param parentId
	 * @param categoryType
	 * @return
	 */
	public int getCountByParentId(String parentId,String categoryType){
		logger.info("[CategoryDao] #getCountByParentId# parendId=" + parentId + " categoryType=" + categoryType);
		int count = 0 ;
		try{
			count = jdbcTemplate.queryForInt(
					"select count(1) as total from tbl_category where category = ? and parentid = ? ", 
					new Object[]{categoryType,parentId});
		}catch (Exception e) {
			logger.error("[CategoryDao] #getCountByParentId# error parendId=" + parentId + " categoryType=" + categoryType);
		}
		return count ;
	}
	
	/**
	 * 
	 * @return
	 */
	class CategoryRowMapper implements RowMapper<Category>{
		@Override
		public Category mapRow(ResultSet rs, int i) throws SQLException {
			Category category = new Category();
			category.setId(rs.getString("id"));
			category.setName(rs.getString("name"));
			category.setShortName(rs.getString("shortname"));
			category.setAlias(rs.getString("alias"));
			category.setDescribe(rs.getString("describe"));
			category.setShowType(rs.getInt("showtype"));
			category.setShowIndex(rs.getInt("showindex"));
			category.setParentId(rs.getString("parentid"));
			category.setCategoryType(rs.getString("categorytype"));
			category.setCategoryImage(rs.getString("categoryimage"));
			return category;		
		}
	}
}
