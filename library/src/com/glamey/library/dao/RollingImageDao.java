/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.RollingImageInfo;
import com.glamey.library.model.dto.RollingImageQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 分类数据库操作
 *
 * @author zy
 */
@Repository
public class RollingImageDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(RollingImageDao.class);

    @Resource
    private CategoryDao categoryDao ;
    
    /**
     * @param rolling
     * @return
     */
    public boolean create(final RollingImageInfo rolling) {
        logger.info("[RollingImageInfoDao] #create# " + rolling);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_rollingimages(id,name,image,rolling_time,category_id_fk,is_valid) " +
                            " values(?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, rolling.getName());
                            pstmt.setString(++i, rolling.getImage());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, rolling.getCategoryId());
                            pstmt.setInt(++i, rolling.getValid());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[RollingImageInfoDao] #create# error " + rolling, e);
            return false;
        }
    }

    /**
     * @param rolling
     * @return
     */
    public boolean update(final RollingImageInfo rolling) {
        logger.info("[RollingImageInfoDao] #update# " + rolling);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_rollingimages set name=?,image=?,rolling_time=?,category_id_fk=?,is_valid=? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, rolling.getName());
                            pstmt.setString(++i, rolling.getImage());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, rolling.getCategoryId());
                            pstmt.setInt(++i, rolling.getValid());
                            pstmt.setString(++i, rolling.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[RollingImageInfoDao] #update# error " + rolling, e);
            return false;
        }
    }

    /**
     * 通过ID删除分类
     *
     * @param id
     * @return
     */
    public boolean deleteById(final String id) {
        logger.info("[RollingImageInfoDao] #delete#" + id);
        try {
            int count = jdbcTemplate.update("delete from tbl_rollingimages where id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, id);
                }
            });
            return count > 0;
        } catch (Exception e) {
            logger.error("[RollingImageInfoDao] #delete# error " + id, e);
        }
        return false;
    }

    /**
     * @param id
     * @return
     */
    public RollingImageInfo getById(final String id) {
        logger.info("[RollingImageInfoDao] #getById#" + id);
        try {
            List<RollingImageInfo> list = jdbcTemplate.query("select * from tbl_rollingimages where id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, id);
                        }
                    },
                    new RollingImageInfoRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[RollingImageInfoDao] #getById# error " + id, e);
        }
        return null;
    }

    public List<RollingImageInfo> getByParentId(final RollingImageQuery query) {
        logger.info("[RollingImageInfoDao] #getByParentId# query=" + query);
        List<RollingImageInfo> list = new ArrayList<RollingImageInfo>();
        try {
        	StringBuffer sql = new StringBuffer("select * from tbl_rollingimages where 1=1 ");

        	if(StringUtils.isNotBlank(query.getCategoryId()))
        		sql.append(" and category_id_fk = ? ");
        	
        	if(StringUtils.isNotBlank(query.getKeyword()))
        		sql.append(" and (name like ?) ");

            if(query.getValid() > -1)
        		sql.append(" and is_valid = ? ");
        	
        	sql.append(" order by rolling_time desc limit ?,? ");
        	
            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                        	int i = 0 ;

                        	if(StringUtils.isNotBlank(query.getCategoryId()))
                                preparedstatement.setString(++i, query.getCategoryId());
                        	
                        	if(StringUtils.isNotBlank(query.getKeyword())){
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                        	}
                            if(query.getValid() > -1)
                                preparedstatement.setInt(++i,query.getValid());

                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new RollingImageInfoRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[RollingImageInfoDao] #getByParentId# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByParentId(final RollingImageQuery query) {
        logger.info("[RollingImageInfoDao] #getCountByParentId# query=" + query);
        int count = 0;
        try {
        	List<Object> params = new ArrayList<Object>();
        	StringBuffer sql = new StringBuffer("select count(1) as total from tbl_rollingimages where 1=1 ");

            if(StringUtils.isNotBlank(query.getCategoryId())){
        		sql.append(" and category_id_fk = ? ");
        		params.add(query.getCategoryId());
        	}
        	
        	if(StringUtils.isNotBlank(query.getKeyword())){
        		sql.append(" and (name like ?) ");
        		params.add("%" + query.getKeyword() + "%");
        	}

            if(query.getValid() > -1){
                sql.append(" and is_valid = ? ");
                params.add(query.getValid());
            }
        	
            count = jdbcTemplate.queryForInt(sql.toString(),params.toArray());
        } catch (Exception e) {
            logger.error("[RollingImageInfoDao] #getCountByParentId# error! query=" + query , e);
        }
        return count;
    }

    /**
     * 删除指定分类的图片信息
     *
     * @param rollingId
     * @return
     */
    public boolean deleteImage(final String rollingId) {
        logger.info("[RollingImageInfoDao] #delete-image#" + rollingId);
        try {
            int count = jdbcTemplate.update("update tbl_rollingimages set image = ?  where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, "");
                            preparedstatement.setString(2, rollingId);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[RollingImageInfoDao] #delete-image# error!" + rollingId, e);
        }
        return false;
    }
    
    /**
     * @return
     */
    class RollingImageInfoRowMapper implements RowMapper<RollingImageInfo> {
        @Override
        public RollingImageInfo mapRow(ResultSet rs, int i) throws SQLException {
            RollingImageInfo rolling = new RollingImageInfo();
            rolling.setId(rs.getString("id"));
            rolling.setName(rs.getString("name"));
            rolling.setImage(rs.getString("image"));
            rolling.setRollingDate(rs.getTimestamp("rolling_time"));
            rolling.setValid(rs.getInt("is_valid"));

            rolling.setCategoryId(rs.getString("category_id_fk"));
            Category category = categoryDao.getById(rolling.getCategoryId());
            rolling.setCategory(category);
            
            return rolling;
        }
    }
}
