/**
 *
 */
package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Dic;
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
public class DicDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(DicDao.class);
    @Resource
    private CategoryDao categoryDao;

    /**
     * @param dic
     * @return 0=成功  1=失败 2=已存在
     */
    public int create(final Dic dic) {
        logger.info("[dicInfoDao] #create# " + dic);
        try {
            if (this.getByName(dic.getKey()) != null) {
                return 2;
            }
            int count = jdbcTemplate.update(
                    "insert into tbl_dic(key,value) values(?,?) ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, dic.getKey());
                            pstmt.setString(++i, dic.getValue());
                        }
                    }
            );
            return 0;
        } catch (Exception e) {
            logger.error("[dicInfoDao] #create# error " + dic, e);
            return 1;
        }
    }

    public boolean update(final Dic dic) {
        logger.info("[dicInfoDao] #update# " + dic);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_dic set value=? where key=?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, dic.getValue());
                            pstmt.setString(++i, dic.getKey());
                        }
                    }
            );
            return count > 0;
        } catch (Exception e) {
            logger.error("[dicInfoDao] #update# error! " + dic, e);
            return false;
        }
    }

    public boolean deleteByName(final String key) {
        logger.info("[dicInfoDao] #deleteByName#" + key);
        try {
            int count = jdbcTemplate.update("delete from tbl_dic where key = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, key);
                        }
                    }
            );
            return count > 0;
        } catch (Exception e) {
            logger.error("[dicInfoDao] #deleteByName# error " + key, e);
        }
        return false;
    }

    public Dic getByName(final String key) {
        logger.info("[dicInfoDao] #getByName#" + key);
        try {
            List<Dic> list = jdbcTemplate.query("select * from tbl_dic where key = ? limit 1",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, key);
                        }
                    },
                    new DicRowMapper()
            );
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[dicInfoDao] #getByName# error! " + key, e);
        }
        return null;
    }

    public Map<String, String> getDicMap() {
        logger.info("[dicInfoDao] #getdicMap#");
        Map<String, String> map = new HashMap<String, String>();
        try {
            List<Dic> list = jdbcTemplate.query("select * from tbl_dic", new DicRowMapper());
            for (Dic dic : list) {
                map.put(dic.getKey(), dic.getValue());
            }
        } catch (Exception e) {
            logger.error("[dicInfoDao] #getDicMap# error! ", e);
        }
        return null;
    }

    /**
     * 根据配置对象，获取旗下的所有分类信息
     *
     * @param dic
     * @return
     */
    public List<Category> getCategoryListBydicName(final Dic dic) {
        List<Category> categoryList = new ArrayList<Category>();
        if (dic != null && StringUtils.isNotBlank(dic.getKey())) {
            for (String a : StringUtils.split(dic.getValue(), ",")) {
                categoryList.add(categoryDao.getById(a));
            }
        }
        return categoryList;
    }

    /**
     * @return
     */
    class DicRowMapper implements RowMapper<Dic> {
        @Override
        public Dic mapRow(ResultSet rs, int i) throws SQLException {
            Dic dic = new Dic();
            dic.setKey(rs.getString("key"));
            dic.setValue(rs.getString("value"));
            return dic;
        }
    }
}
