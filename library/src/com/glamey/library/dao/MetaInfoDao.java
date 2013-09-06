/**
 *
 */
package com.glamey.library.dao;

import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.MetaInfo;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 全局变量数据库操作操作
 *
 * @author zy
 */
@Repository
public class MetaInfoDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(MetaInfoDao.class);
    @Resource
    private CategoryDao categoryDao;

    /**
     * @param meta
     * @return 0=成功  1=失败 2=已存在
     */
    public int create(final MetaInfo meta) {
        logger.info("[MetaInfoDao] #create# " + meta);
        try {
            if (this.getByName(meta.getName()) != null) {
                return 2;
            }
            int count = jdbcTemplate.update(
                    "insert into tbl_meta(meta_name,meta_value) values(?,?) ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, meta.getName());
                            pstmt.setString(++i, meta.getValue());
                        }
                    });
            return 0;
        } catch (Exception e) {
            logger.error("[MetaInfoDao] #create# error " + meta, e);
            return 1;
        }
    }

    public boolean update(final MetaInfo meta) {
        logger.info("[MetaInfoDao] #update# " + meta);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_meta set meta_value=? where meta_name=?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, meta.getValue());
                            pstmt.setString(++i, meta.getName());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[MetaInfoDao] #update# error! " + meta, e);
            return false;
        }
    }

    public boolean deleteByName(final String name) {
        logger.info("[MetaInfoDao] #deleteByName#" + name);
        try {
            int count = jdbcTemplate.update("delete from tbl_meta where meta_name = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, name);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[MetaInfoDao] #deleteByName# error " + name, e);
        }
        return false;
    }

    public MetaInfo getByName(final String name) {
        logger.info("[MetaInfoDao] #getByName#" + name);
        try {
            List<MetaInfo> list = jdbcTemplate.query("select * from tbl_meta where meta_name = ? limit 1",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, name);
                        }
                    },
                    new MetaRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[MetaInfoDao] #getByName# error! " + name, e);
        }
        return null;
    }

    public Map<String, String> getMetaMap() {
        logger.info("[MetaInfoDao] #getMetaMap#");
        Map<String, String> map = new HashMap<String, String>();
        try {
            List<MetaInfo> list = jdbcTemplate.query("select * from tbl_meta", new MetaRowMapper());
            for (MetaInfo metaInfo : list) {
                map.put(metaInfo.getName(), metaInfo.getValue());
            }
        } catch (Exception e) {
            logger.error("[MetaInfoDao] #getMetaMap# error! ", e);
        }
        return null;
    }

    /**
     * 根据配置对象，获取旗下的所有分类信息
     * @param metaInfo
     * @return
     */
    public List<Category> getCategoryListByMetaName(final MetaInfo metaInfo){
        List<Category> categoryList = new ArrayList<Category>();
        if (metaInfo != null && StringUtils.isNotBlank(metaInfo.getValue())) {
            for (String a : StringUtils.split(metaInfo.getValue(), ",")) {
                categoryList.add(categoryDao.getById(a));
            }
        }
        return categoryList ;
    }

    /**
     * @return
     */
    class MetaRowMapper implements RowMapper<MetaInfo> {
        @Override
        public MetaInfo mapRow(ResultSet rs, int i) throws SQLException {
            MetaInfo meta = new MetaInfo();
            meta.setName(rs.getString("meta_name"));
            meta.setValue(rs.getString("meta_value"));
            return meta;
        }
    }
}
