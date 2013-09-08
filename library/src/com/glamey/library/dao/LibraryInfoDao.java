/**
 *
 */
package com.glamey.library.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.LibraryInfo;
import com.glamey.library.model.dto.LibraryQuery;

/**
 * 微型图书馆数据库操作类
 *
 * @author zy
 */
@Repository
public class LibraryInfoDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(LibraryInfoDao.class);

    @Resource
    private CategoryDao categoryDao ;
    /**
     * @param info
     * @return
     */
    public boolean create(final LibraryInfo info) {
        logger.info("[LibraryInfoDao] #create# " + info);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_library(lib_id,lib_category_id,lib_type,lib_name,lib_url,lib_content,lib_image,lib_time,lib_order,lib_showindex) " +
                            " values(?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i,info.getCategoryId());
                            pstmt.setInt(++i,info.getType());
                            pstmt.setString(++i, info.getName());
                            pstmt.setString(++i, info.getUrl());
                            pstmt.setString(++i, info.getContent());
                            pstmt.setString(++i, info.getImage());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setInt(++i, info.getOrder());
                            pstmt.setInt(++i, info.getShowIndex());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LibraryInfoDao] #create# error " + info, e);
            return false;
        }
    }

    /**
     * @param info
     * @return
     */
    public boolean update(final LibraryInfo info) {
        logger.info("[LibraryInfoDao] #update# " + info);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_library set lib_category_id=?,lib_type=?,lib_name=?,lib_url=?,lib_content=?,lib_image=?,lib_order = ?,lib_showindex=? where lib_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i,info.getCategoryId());
                            pstmt.setInt(++i,info.getType());
                            pstmt.setString(++i, info.getName());
                            pstmt.setString(++i, info.getUrl());
                            pstmt.setString(++i, info.getContent());
                            pstmt.setString(++i, info.getImage());
                            pstmt.setInt(++i, info.getOrder());
                            pstmt.setInt(++i, info.getShowIndex());
                            pstmt.setString(++i, info.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LibraryInfoDao] #update# error " + info, e);
            return false;
        }
    }

    /**
     * 删除对应的图书馆内容
     *
     * @param id
     * @return
     */
    public boolean deleteById(final String id) {
        logger.info("[LibraryInfoDao] #delete#" + id);
        try {
            int count = jdbcTemplate.update("delete from tbl_library where lib_id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, id);
                }
            });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LibraryInfoDao] #delete# error " + id, e);
        }
        return false;
    }

    /**
     * @param id
     * @return
     */
    public LibraryInfo getById(final String id) {
        logger.info("[LibraryInfoDao] #getById#" + id);
        try {
            List<LibraryInfo> list = jdbcTemplate.query("select * from tbl_library where lib_id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, id);
                        }
                    },
                    new LibraryInfoRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[LibraryInfoDao] #getById# error " + id, e);
        }
        return null;
    }

    public List<LibraryInfo> getByQuery(final LibraryQuery query) {
        logger.info("[LibraryInfoDao] #getByQuery# query=" + query);
        List<LibraryInfo> list = new ArrayList<LibraryInfo>();
        try {
        	StringBuffer sql = new StringBuffer("select * from tbl_library where 1=1 ");
        	
        	if(StringUtils.isNotBlank(query.getCategoryId()))
        		sql.append(" and lib_category_id = ? ");

            if(query.getCategoryIds() != null && query.getCategoryIds().size() > 0){
                int size = query.getCategoryIds().size() ;
                String psql = null ;
                for(int i = 0 ; i < size ; i ++){
                    psql += "," + "?" ;
                }
                psql = psql != null && psql.length() > 0 ? psql.substring(1) : null ;
                sql.append(" and lib_category_id in (" + psql + ") ");
            }

        	if(query.getType() > -1)
        		sql.append(" and lib_type = ? ");
        	
        	if(query.getShowImage() == 1)
                sql.append(" and (lib_image <> '' or lib_image is not null ) ");
        	
        	if(query.getShowImage() == 0 )
                sql.append(" and (lib_image is null) ");

        	if(StringUtils.isNotBlank(query.getKeyword()))
        		sql.append(" and (lib_name like ? or lib_content like ? or lib_url like ? ) ");

            if (query.getShowIndex() > -1)
                sql.append(" and lib_showindex = ? ");

        	sql.append(" order by lib_order desc limit ?,? ");
        	
            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                        	int i = 0 ;
                        	
                        	if(StringUtils.isNotBlank(query.getCategoryId()))
                                preparedstatement.setString(++i, query.getCategoryId());

                            if(query.getCategoryIds() != null && query.getCategoryIds().size() > 0){
                                for(String p : query.getCategoryIds()){
                                    preparedstatement.setString(++i,p);
                                }
                            }

                            if(query.getType() > -1)
                                preparedstatement.setInt(++i, query.getType());

                            if(StringUtils.isNotBlank(query.getKeyword())){
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                        	}

                            if (query.getShowIndex() > -1)
                                preparedstatement.setInt(++i , query.getShowIndex());

                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new LibraryInfoRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[LibraryInfoDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final LibraryQuery query) {
        logger.info("[LibraryInfoDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
        	List<Object> params = new ArrayList<Object>();
        	StringBuffer sql = new StringBuffer("select count(1) as total from tbl_library where 1=1 ");
        	if(StringUtils.isNotBlank(query.getCategoryId())){
        		sql.append(" and lib_category_id = ? ");
        		params.add(query.getCategoryId());
        	}

            if(query.getCategoryIds() != null && query.getCategoryIds().size() > 0){
                String psql = null ;
                for(String p : query.getCategoryIds()){
                    psql += "," + "?" ;
                    params.add(p);
                }
                psql = psql != null && psql.length() > 0 ? psql.substring(1) : null ;
                sql.append(" and lib_category_id in (" + psql + ") ");
            }
        	
        	if(query.getType() > -1){
        		sql.append(" and lib_type = ? ");
        		params.add(query.getType());
        	}

        	if(query.getShowImage() == 1)
                sql.append(" and (lib_image <> '' or lib_image is not null ) ");
        	
        	if(query.getShowImage() == 0 )
                sql.append(" and (lib_image is null) ");
        	
        	if(StringUtils.isNotBlank(query.getKeyword())){
        		sql.append(" and (lib_name like ? or lib_content like ? or lib_url like ? ) ");
        		params.add("%" + query.getKeyword() + "%");
        		params.add("%" + query.getKeyword() + "%");
        		params.add("%" + query.getKeyword() + "%");
        	}

            if (query.getShowIndex() > -1 ) {
                sql.append(" and lib_showindex = ? ");
                params.add(query.getShowIndex()) ;
            }

            count = jdbcTemplate.queryForInt(sql.toString(),params.toArray());
        } catch (Exception e) {
            logger.error("[LibraryInfoDao] #getCountByQuery# error! query=" + query , e);
        }
        return count;
    }

    
    /**
     * @return
     */
    class LibraryInfoRowMapper implements RowMapper<LibraryInfo> {
        @Override
        public LibraryInfo mapRow(ResultSet rs, int i) throws SQLException {
        	LibraryInfo info = new LibraryInfo();
            info.setId(rs.getString("lib_id"));
            info.setCategoryId(rs.getString("lib_category_id"));
            info.setType(rs.getInt("lib_type"));
            info.setName(rs.getString("lib_name"));
            info.setUrl(rs.getString("lib_url"));
            info.setContent(rs.getString("lib_content"));
            info.setImage(rs.getString("lib_image"));
            info.setTime(rs.getTimestamp("lib_time"));
            info.setOrder(rs.getInt("lib_order"));
            info.setShowIndex(rs.getInt("lib_showindex"));
            Category category = categoryDao.getById(info.getCategoryId());
            info.setCategory(category);
            
            return info;
        }
    }
}
