/**
 *
 */
package com.glamey.innerweb.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.glamey.framework.utils.StringTools;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.dto.CategoryQuery;

/**
 * 分类数据库操作
 *
 * @author zy
 */
@Repository
public class CategoryDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(CategoryDao.class);
    
    /**
     * 创建分类信息
     *
     * @param category
     * @return
     */
    public boolean create(final Category category) {
        logger.info("[CategoryDao] #create# " + category);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_category(id,name,shortname,aliasname,categorydescribe,showtype,showindex,categoryorder,parentid,categorytype,categoryimage,categorytime) values(?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, category.getName());
                            pstmt.setString(++i, category.getShortName());
                            pstmt.setString(++i, category.getAliasName());
                            pstmt.setString(++i, category.getDescribe());
                            pstmt.setInt(++i, category.getShowType());
                            pstmt.setInt(++i, category.getShowIndex());
                            pstmt.setInt(++i, category.getCategoryOrder());
                            pstmt.setString(++i, category.getParentId());
                            pstmt.setString(++i, category.getCategoryType());
                            pstmt.setString(++i, category.getCategoryImage());
                            pstmt.setString(++i, category.getCategoryTime());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[CategoryDao] #create# error " + category, e);
            return false;
        }
    }
    public String createReturnId(final Category category) {
        logger.info("[CategoryDao] #create# " + category);
        try {
            final String id = StringTools.getUniqueId() ;
            int count = jdbcTemplate.update(
                    "insert into tbl_category(id,name,shortname,aliasname,categorydescribe,showtype,showindex,categoryorder,parentid,categorytype,categoryimage,categorytime) values(?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, id);
                            pstmt.setString(++i, category.getName());
                            pstmt.setString(++i, category.getShortName());
                            pstmt.setString(++i, category.getAliasName());
                            pstmt.setString(++i, category.getDescribe());
                            pstmt.setInt(++i, category.getShowType());
                            pstmt.setInt(++i, category.getShowIndex());
                            pstmt.setInt(++i, category.getCategoryOrder());
                            pstmt.setString(++i, category.getParentId());
                            pstmt.setString(++i, category.getCategoryType());
                            pstmt.setString(++i, category.getCategoryImage());
                            pstmt.setString(++i, category.getCategoryTime());
                        }
                    });
            return count > 0 ? id : null ;
        } catch (Exception e) {
            logger.error("[CategoryDao] #create# error " + category, e);
            return null;
        }
    }

    /**
     * @param category
     * @return
     */
    public boolean update(final Category category) {
        logger.info("[CategoryDao] #update# " + category);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_category set name=?,shortname=?,aliasname=?,categorydescribe=?,showtype=?,showindex=?,categoryorder=?,parentid=?,categorytype=? ,categoryimage = ? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, category.getName());
                            pstmt.setString(++i, category.getShortName());
                            pstmt.setString(++i, category.getAliasName());
                            pstmt.setString(++i, category.getDescribe());
                            pstmt.setInt(++i, category.getShowType());
                            pstmt.setInt(++i, category.getShowIndex());
                            pstmt.setInt(++i, category.getCategoryOrder());
                            pstmt.setString(++i, category.getParentId());
                            pstmt.setString(++i, category.getCategoryType());
                            pstmt.setString(++i, category.getCategoryImage());
                            pstmt.setString(++i, category.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[CategoryDao] #create# error " + category, e);
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
        logger.info("[CategoryDao] #delete#" + id);
        try {
            int count = jdbcTemplate.update("delete from tbl_category where id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, id);
                }
            });
            return count > 0;
        } catch (Exception e) {
            logger.error("[CategoryDao] #delete# error " + id, e);
        }
        return false;
    }
    
    /**
     * 针对文章操作，删除分类的同时，会把旗下的文章、连接设置为无分类
     * @param categoryId
     * @param categoryType
     * @return
     */
    public boolean deleteById(final String categoryId,final String categoryType) {
        logger.info("[CategoryDao] #delete#" + String.format("categoryId=%s,categoryType=%s", categoryId,categoryType));
        try {
            int cateCount = jdbcTemplate.update("delete from tbl_category where id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, categoryId);
                }
            });
            int cateContentCount = 0 ;
            //通告、新闻 tbl_post
            if(StringUtils.equals(categoryType, CategoryConstants.CATEGORY_NEWS) || StringUtils.equals(categoryType, CategoryConstants.CATEGORY_NOTICES)){
            	cateContentCount = jdbcTemplate.update("update tbl_post set post_category_id=? where post_category_id=? and post_category_type =?",
                		new PreparedStatementSetter(){
    						@Override
    						public void setValues(PreparedStatement preparedstatement)
    								throws SQLException {
    							preparedstatement.setString(1, "");
    							preparedstatement.setString(2, categoryId);
    							preparedstatement.setString(3, categoryType);
    						}
                	
                });
            }
            //友情链接 tbl_links
            if(StringUtils.equals(categoryType, CategoryConstants.CATEOGRY_FRIENDLYLINKS)){
            	cateContentCount = jdbcTemplate.update("update tbl_links set links_category_id=? where links_category_id=? and links_category_type =?",
                		new PreparedStatementSetter(){
    						@Override
    						public void setValues(PreparedStatement preparedstatement)
    								throws SQLException {
    							preparedstatement.setString(1, "");
    							preparedstatement.setString(2, categoryId);
    							preparedstatement.setString(3, categoryType);
    						}
                	
                });
            }
           //TODO 微型图书馆
            if(StringUtils.equals(categoryType, CategoryConstants.CATEGORY_LIBRARY)){
            	cateContentCount = jdbcTemplate.update("update tbl_library set lib_category_id = ? where lib_category_id = ? ",
                		new PreparedStatementSetter(){
    						@Override
    						public void setValues(PreparedStatement preparedstatement)
    								throws SQLException {
    							preparedstatement.setString(1, "");
    							preparedstatement.setString(2, categoryId);
    						}
                	
                });
            }
            return cateCount > 0 && cateContentCount >= 0 ;
        } catch (Exception e) {
            logger.info("[CategoryDao] #delete# error! " + String.format("categoryId=%s,categoryType=%s", categoryId,categoryType));
        }
        return false;
    }

    /**
     * 删除指定分类的图片信息
     *
     * @param categoryId
     * @return
     */
    public boolean deleteImage(final String categoryId) {
        logger.info("[CategoryDao] #delete-image#" + categoryId);
        try {
            int count = jdbcTemplate.update("update tbl_category set categoryimage = ?  where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, "");
                            preparedstatement.setString(2, categoryId);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[CategoryDao] #delete-image# error!" + categoryId, e);
        }
        return false;
    }

    /**
     * @param id
     * @return
     */
    public Category getById(final String id) {
        logger.info("[CategoryDao] #getById#" + id);
        try {
            List<Category> list = jdbcTemplate.query("select * from tbl_category where id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, id);
                        }
                    },
                    new CategoryRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[CategoryDao] #getById# error " + id, e);
        }
        return null;
    }

    /**
     * 通过引用名字获取对应的分类信息
     *
     * @param aliasName
     * @return
     */
    public Category getByAliasName(final String aliasName) {
        logger.info("[CategoryDao] #getByAliasName#" + aliasName);
        try {
            List<Category> list = jdbcTemplate.query("select * from tbl_category where aliasname = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, aliasName);
                        }
                    },
                    new CategoryRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[CategoryDao] #getByAliasName# error " + aliasName, e);
        }
        return null;
    }

    /**
     * 获取分类(指定的分类)下的所有子分类。
     *
     * @param parentId
     * @param categoryType
     * @return
     */
    public List<Category> getByParentId(final String parentId, final String categoryType, final int start, final int num) {
        logger.info("[CategoryDao] #getCategoryByParentId# parendId=" + parentId + " categoryType=" + categoryType);
        List<Category> list = new ArrayList<Category>();
        try {
            list = jdbcTemplate.query("select * from tbl_category where categorytype = ? and parentid = ? order by categoryorder asc limit ?,? ",
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
            return list;
        } catch (Exception e) {
            logger.error("[CategoryDao] #getByParentId# error", e);
        }
        return null;
    }

    /**
     * 获取分类(指定的分类)下的所有子分类的总数
     *
     * @param parentId
     * @param categoryType
     * @return
     */
    public int getCountByParentId(String parentId, String categoryType) {
        logger.info("[CategoryDao] #getCountByParentId# parendId=" + parentId + " categoryType=" + categoryType);
        int count = 0;
        try {
            count = jdbcTemplate.queryForInt("select count(1) as total from tbl_category where category = ? and parentid = ? ",
                    new Object[]{categoryType, parentId});
        } catch (Exception e) {
            logger.error("[CategoryDao] #getCountByParentId# error parendId=" + parentId + " categoryType=" + categoryType, e);
        }
        return count;
    }

    public List<Category> getByQuery(final CategoryQuery query, final int start, final int num) {
        logger.info("[CategoryDao] #getByQuery# query=" + query);
        List<Category> list = new ArrayList<Category>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_category where 1=1 ");
            if (StringUtils.isNotBlank(query.getCategoryType()))
                sql.append(" and categorytype = ? ");

            if (StringUtils.isNotBlank(query.getParentId()))
                sql.append(" and parentid = ? ");

            if (query.getShowIndex() > -1)
                sql.append(" and showindex = ? ");

            if (query.getShowType() > -1)
                sql.append(" and showtype = ? ");

            if (StringUtils.isNotBlank(query.getCategoryImage()))
                sql.append(" and categoryimage <> '' ");

            if (StringUtils.isNotBlank(query.getKeyword()))
                sql.append(" and (name = ? or shortname like ? or aliasname like ? or categorydescribe like ?)");

            sql.append(" order by categoryorder desc limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getCategoryType()))
                                preparedstatement.setString(++i, query.getCategoryType());

                            if (StringUtils.isNotBlank(query.getParentId()))
                                preparedstatement.setString(++i, query.getParentId());


                            if (query.getShowIndex() > -1)
                                preparedstatement.setInt(++i, query.getShowIndex());

                            if (query.getShowType() > -1)
                                preparedstatement.setInt(++i, query.getShowType());

                            if (StringUtils.isNotBlank(query.getCategoryImage()))
                                preparedstatement.setString(++i, query.getCategoryImage());

                            if (StringUtils.isNotBlank(query.getKeyword())) {
                                preparedstatement.setString(++i, query.getKeyword());
                                preparedstatement.setString(++i, query.getKeyword());
                                preparedstatement.setString(++i, query.getKeyword());
                                preparedstatement.setString(++i, query.getKeyword());
                            }
                            preparedstatement.setInt(++i, start);
                            preparedstatement.setInt(++i, num);
                        }
                    },
                    new CategoryRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[CategoryDao] #getByParentId# error", e);
        }
        return null;
    }

    /**
     * @return
     */
    class CategoryRowMapper implements RowMapper<Category> {
        @Override
        public Category mapRow(ResultSet rs, int i) throws SQLException {
            Category category = new Category();
            category.setId(rs.getString("id"));
            category.setName(rs.getString("name"));
            category.setShortName(rs.getString("shortname"));
            category.setAliasName(rs.getString("aliasname"));
            category.setDescribe(rs.getString("categorydescribe"));
            category.setShowType(rs.getInt("showtype"));
            category.setShowIndex(rs.getInt("showindex"));
            category.setCategoryOrder(rs.getInt("categoryorder"));
            category.setParentId(rs.getString("parentid"));
            category.setCategoryType(rs.getString("categorytype"));
            category.setCategoryImage(rs.getString("categoryimage"));
            category.setCategoryTime(rs.getString("categorytime"));
            return category;
        }
    }
}
