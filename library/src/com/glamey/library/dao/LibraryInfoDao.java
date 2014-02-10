/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.LibraryInfo;
import com.glamey.library.model.dto.LibraryQuery;
import com.glamey.library.model.dto.LuceneEntry;
import com.glamey.library.util.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

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
                    "insert into tbl_library(lib_id,lib_category_id,lib_type,lib_name,lib_focusimage,lib_url,lib_content,lib_image,lib_time,lib_order,lib_showindex,lib_sugguest,lib_update_time) " +
                            " values(?,?,?,?,?,?,?,?,?,?,?,?,now())",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i,info.getCategoryId());
                            pstmt.setInt(++i,info.getType());
                            pstmt.setString(++i, info.getName());
                            pstmt.setInt(++i, info.getShowFocusimage());
                            pstmt.setString(++i, info.getUrl());
                            pstmt.setString(++i, info.getContent());
                            pstmt.setString(++i, info.getImage());
                            pstmt.setTimestamp(++i, new Timestamp(info.getTime().getTime()));
                            pstmt.setInt(++i, info.getOrder());
                            pstmt.setInt(++i, info.getShowIndex());
                            pstmt.setInt(++i, info.getShowSugguest());
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
                    "update tbl_library set lib_category_id=?,lib_type=?,lib_name=?,lib_focusimage=?,lib_url=?,lib_content=?,lib_image=?,lib_order = ?,lib_showindex=?,lib_sugguest=?,lib_time=?,lib_update_time = now() where lib_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i,info.getCategoryId());
                            pstmt.setInt(++i, info.getType());
                            pstmt.setString(++i, info.getName());
                            pstmt.setInt(++i, info.getShowFocusimage());
                            pstmt.setString(++i, info.getUrl());
                            pstmt.setString(++i, info.getContent());
                            pstmt.setString(++i, info.getImage());
                            pstmt.setInt(++i, info.getOrder());
                            pstmt.setInt(++i, info.getShowIndex());
                            pstmt.setInt(++i, info.getShowSugguest());
                            pstmt.setTimestamp(++i, new Timestamp(info.getTime().getTime()));
                            pstmt.setString(++i, info.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LibraryInfoDao] #update# error " + info, e);
            return false;
        }
    }

    public boolean update(final List<LibraryInfo> libraryInfoList,String category,final int type) {
        logger.info("[LibraryInfoDao] #update# " + libraryInfoList);
        try {
            String sql = "";
            if (StringUtils.equals(category,"suggest")) {
               sql = "update tbl_library set lib_sugguest=?,lib_update_time = now() where lib_id = ?";
            }
            if (StringUtils.equals(category,"focus")) {
               sql = "update tbl_library set lib_focusimage=?,lib_update_time = now() where lib_id = ?";
            }
            if (StringUtils.equals(category,"index")) {
               sql = "update tbl_library set lib_showindex=?,lib_update_time = now() where lib_id = ?";
            }
            if (StringUtils.isNotBlank(sql) && !CollectionUtils.isEmpty(libraryInfoList))
                 jdbcTemplate.batchUpdate(
                            sql,
                            new BatchPreparedStatementSetter() {
                                @Override
                                public void setValues(PreparedStatement pstmt, int i) throws SQLException {
                                    LibraryInfo info = libraryInfoList.get(i);
                                    int j = 0;
                                    pstmt.setInt(++j, type);
                                    pstmt.setString(++j, info.getId());
                                }
                                @Override
                                public int getBatchSize() {
                                    return libraryInfoList.size();
                                }
                            }
                 );
            return true;
        } catch (Exception e) {
            logger.error("[LibraryInfoDao] #update# error", e);
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
                String psql = "" ;
                for(int i = 0 ; i < size ; i ++){
                    psql += "," + "?" ;
                }
                psql = StringUtils.isNotBlank(psql) ? psql.substring(1) : "" ;
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

            if (query.getIsFocusImage() > -1)
                sql.append(" and lib_focusimage = ? ");

            if (query.getShowSugguest() > -1)
                sql.append(" and lib_sugguest = ? ");

            if(StringUtils.isNotBlank(query.getOrderColumnName()) && StringUtils.isNotBlank(query.getOrderType())){
                sql.append(" order by ").append(query.getOrderColumnName()).append(query.getOrderType()) ;
            }else{
                sql.append(" order by lib_order desc ");
            }

            sql.append(" limit ?,? ");

        	
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

                            if (query.getIsFocusImage() > -1)
                                preparedstatement.setInt(++i,query.getIsFocusImage());

                            if (query.getShowSugguest() > -1)
                                preparedstatement.setInt(++i,query.getShowSugguest());


                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                            System.out.println(preparedstatement.toString());
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
                String psql = "" ;
                for(String p : query.getCategoryIds()){
                    psql += "," + "?" ;
                    params.add(p);
                }
                psql = StringUtils.isNotBlank(psql) ? psql.substring(1) : "" ;
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
            if (query.getIsFocusImage() > -1){
                sql.append(" and lib_focusimage = ? ");
                params.add(query.getIsFocusImage());
            }

            if (query.getShowSugguest() > -1){
                sql.append(" and lib_sugguest = ? ");
                params.add(query.getShowSugguest());
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
            info.setShowFocusimage(rs.getInt("lib_focusimage"));
            info.setUrl(rs.getString("lib_url"));
            info.setContent(rs.getString("lib_content"));
            info.setImage(rs.getString("lib_image"));
            info.setTime(rs.getTimestamp("lib_time"));
            info.setShowisNew(DateUtils.isDiffDays(10, info.getTime()) ? 1 : 0);
            info.setOrder(rs.getInt("lib_order"));
            info.setShowIndex(rs.getInt("lib_showindex"));
            info.setShowSugguest(rs.getInt("lib_sugguest"));
            info.setUpdateTime(rs.getTimestamp("lib_update_time"));
            Category category = categoryDao.getById(info.getCategoryId());
            info.setCategory(category);

            return info;
        }
    }

    /**
     * 将指定的文章转移到指定分类下
     *
     * @param libIds
     * @param targetCateId
     * @return
     */
    public boolean move2CateDo(final String [] libIds,final String targetCateId) {
        List<Category> list = new ArrayList<Category>();
        try {

            String sql = "update tbl_library set lib_category_id = ? where lib_id = ?" ;
            int total [] = jdbcTemplate.batchUpdate(sql,new BatchPreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
                    preparedStatement.setString(1,targetCateId);
                    preparedStatement.setString(2,libIds[i]);
                }
                @Override
                public int getBatchSize() {
                    return libIds.length ;
                }
            }) ;
            return total.length > 0 ;
        } catch (Exception e) {
            logger.error("[CategoryDao] #move2CateDo# error " + Arrays.deepToString(libIds) + " " + targetCateId, e);
        }
        return false;
    }

    public List<LuceneEntry> getLibraryLuceneEntry(){
        List<LuceneEntry> entries = new ArrayList<LuceneEntry>(1000);
        try {
            LuceneEntry entry = null;
            List<LibraryInfo> libraryInfoList = new ArrayList<LibraryInfo>();
            String sql = "select lib_id,lib_name,lib_type,lib_time,lib_url from tbl_library" ;
            libraryInfoList = jdbcTemplate.query(sql,
                    new RowMapper<LibraryInfo>() {
                        @Override
                        public LibraryInfo mapRow(ResultSet resultSet, int i) throws SQLException {
                            LibraryInfo info = new LibraryInfo();
                            info.setId(resultSet.getString("lib_id"));
                            info.setName(resultSet.getString("lib_name"));
                            info.setType(resultSet.getInt("lib_type"));
                            info.setUrl(resultSet.getString("lib_url"));
                            info.setTime(resultSet.getTimestamp("lib_time"));
                            info.setShowisNew(DateUtils.isDiffDays(10,info.getTime()) ? 1 : 0);
                            return info ;
                        }
                    });
            for (LibraryInfo obj : libraryInfoList) {
                entry = new LuceneEntry();
                entry.setId(obj.getId());
                entry.setModel("lib_" + obj.getType());
                if(obj.getType() == 1 || obj.getType() == 3){
                    entry.setHref(obj.getUrl());
                }else{
                    entry.setHref("library-detail-" + entry.getId() + ".htm");
                }
                entry.setTitle(obj.getName());
                entry.setContent(obj.getContent());
                entry.setTime(DateFormatUtils.format(obj.getTime(), "yyyy-MM-dd HH:mm:ss"));
                entries.add(entry);
            }
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return entries ;
    }
}
