package com.glamey.innerweb.dao;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.glamey.framework.utils.StringTools;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.RightsInfo;
import com.glamey.innerweb.model.domain.RoleInfo;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.UserQuery;

/**
 * 用户管理
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class UserInfoDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(UserInfoDao.class);

    @Resource //针对部门列表内容的获取
    private CategoryDao categoryDao;

    /**
     * 创建权限
     *
     * @param rightsInfo
     * @return
     */
    public boolean createRights(final RightsInfo rightsInfo) {
        logger.info("[UserInfoDao] #createRights# " + rightsInfo);
        try {
            final String rightsId = StringTools.getUniqueId();
            //角色主表创建
            int count = jdbcTemplate.update(
                    "insert into tbl_rights(rights_id,rights_name,rights_desc,rights_value,rights_time) values (?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, rightsId);
                            pstmt.setString(++i, rightsInfo.getRightsName());
                            pstmt.setString(++i, rightsInfo.getRightsName());
                            pstmt.setString(++i, rightsInfo.getRightsValue());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                        }
                    });
            logger.info("[UserInfoDao] #createRights# " + count);
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #createRights# error " + rightsInfo, e);
            return false;
        }
    }

    /**
     * 删除权限
     *
     * @param rightsId
     * @return
     */
    public boolean delRights(final String rightsId) {
        logger.info("[UserInfoDao] #delRights# " + rightsId);
        try {
            int count = jdbcTemplate.update(
                    "delete from tbl_rights where rights_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            pstmt.setString(1, rightsId);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #delRights# error " + rightsId, e);
            return false;
        }
    }

    /**
     * 更新权限
     *
     * @param rightsInfo
     * @return
     */
    public boolean updateRights(final RightsInfo rightsInfo) {
        logger.info("[UserInfoDao] #updateRights# " + rightsInfo);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_rights set rights_name = ? ,rights_desc = ? ,rights_value=? ,rights_time=? where rights_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, rightsInfo.getRightsName());
                            pstmt.setString(++i, rightsInfo.getRightsDesc());
                            pstmt.setString(++i, rightsInfo.getRightsValue());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, rightsInfo.getRightsId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #updateRights# error " + rightsInfo, e);
            return false;
        }
    }

    /**
     * 通过ID获取权限内容
     *
     * @param rightsId
     * @return
     */
    public RightsInfo getRightsById(final String rightsId) {
        logger.info("[UserInfoDao] #getRightsById# " + rightsId);
        try {
            List<RightsInfo> rightsInfoList = jdbcTemplate.query("select * from tbl_rights where rights_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            pstmt.setString(1, rightsId);
                        }
                    },
                    new RightsInfoRowMapper());
            return rightsInfoList != null && rightsInfoList.size() > 0 ? rightsInfoList.get(0) : null;
        } catch (Exception e) {
            logger.info("[UserInfoDao] #getRightsById# error " + rightsId, e);
            return null;
        }
    }

    /**
     * 获取所有权限
     *
     * @param keyword
     * @param start
     * @param num
     * @return
     */
    public List<RightsInfo> getRightsList(final String keyword, final int start, final int num) {
        logger.info("[UserInfoDao] #updateRights# " + String.format("keyword=%s start=%d num=%d", keyword, start, num));
        List<RightsInfo> rightsInfoList = new ArrayList<RightsInfo>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_rights where 1 = 1 ");
            if (StringUtils.isNotBlank(keyword)) {
                sql.append(" and (rights_name like ? or rights_desc like ? or rights_value like ?) ");
            }
            sql.append(" order by rights_time desc limit ?,?");

            rightsInfoList = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(keyword)) {
                                pstmt.setString(++i, "%" + keyword + "%");
                                pstmt.setString(++i, "%" + keyword + "%");
                                pstmt.setString(++i, "%" + keyword + "%");
                            }
                            pstmt.setInt(++i, start);
                            pstmt.setInt(++i, num);
                        }
                    },
                    new RightsInfoRowMapper());
            return rightsInfoList;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #updateRights# error " + String.format("keyword=%s start=%d num=%d", keyword, start, num), e);
            return Collections.emptyList();
        }
    }

    /**
     * 通过条件查询权限的总条数
     *
     * @param keyword
     * @return
     */
    public int getRightsListCount(final String keyword) {
        logger.info("[UserInfoDao] #getRightsListCount# " + String.format("keyword=%s", keyword));
        int count;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_rights where 1 = 1 ");
            if (StringUtils.isNotBlank(keyword)) {
                sql.append(" and (rights_name like ? or rights_desc like ? or rights_value like ?) ");
                params.add("%" + keyword + "%");
                params.add("%" + keyword + "%");
                params.add("%" + keyword + "%");
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
            return count;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #getRightsListCount# error " + String.format("keyword=%s", keyword), e);
            return 0;
        }
    }

    /**
     * 创建角色
     *
     * @param roleInfo
     * @return
     */
    public boolean createRole(final RoleInfo roleInfo) {
        logger.info("[UserInfoDao] #createRole# " + roleInfo);
        try {
            final String roleId = StringTools.getUniqueId();
            //角色主表创建
            int count = jdbcTemplate.update(
                    "insert into tbl_role(role_id,role_name,role_desc,role_rights_id,role_time) values (?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, roleId);
                            pstmt.setString(++i, roleInfo.getRoleName());
                            pstmt.setString(++i, roleInfo.getRoleDesc());
                            pstmt.setString(++i, roleInfo.getRoleRightsIds());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #createRole# error " + roleInfo, e);
            return false;
        }
    }

    /**
     * 删除角色
     *
     * @param roleId
     * @return
     */
    public boolean delRole(final String roleId) {
        logger.info("[UserInfoDao] #delRole#" + roleId);
        try {
            int count = jdbcTemplate.update("delete from tbl_role where role_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, roleId);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[CategoryDao] #delRole# error!" + roleId, e);
        }
        return false;
    }

    /**
     * 更新角色内容
     *
     * @param roleInfo
     * @return
     */
    public boolean updateRole(final RoleInfo roleInfo) {
        logger.info("[UserInfoDao] #updateRole# " + roleInfo);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_role set role_name=?,role_desc=?,role_rights_id=?,role_time=? where role_id=?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, roleInfo.getRoleName());
                            pstmt.setString(++i, roleInfo.getRoleDesc());
                            pstmt.setString(++i, roleInfo.getRoleRightsIds());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, roleInfo.getRoleId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #updateRole# error " + roleInfo, e);
            return false;
        }
    }

    /**
     * 通过roleId获取角色内容
     *
     * @param roleId
     * @return
     */
    public RoleInfo getRoleById(final String roleId) {
        logger.info("[UserInfoDao] #getRoleById# roleId=" + roleId);
        RoleInfo roleInfo = new RoleInfo();
        try {
            List<RoleInfo> roleInfoList = jdbcTemplate.query("select * from tbl_role where role_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, roleId);
                        }
                    },
                    new RoleInfoRowMapper());
            roleInfo = roleInfoList != null && roleInfoList.size() > 0 ? roleInfoList.get(0) : null;
            return roleInfo;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #getRoleById# error " + roleId, e);
            return null;
        }
    }

    /**
     * 通过条件获取所有角色
     *
     * @param keyword
     * @param start
     * @param num
     * @return
     */
    public List<RoleInfo> getRoleList(final String keyword, final int start, final int num) {
        logger.info("[UserInfoDao] #getRoleList# " + String.format("keyword=%s,start=%d,num=%d", keyword, start, num));
        List<RoleInfo> roleInfoList = new ArrayList<RoleInfo>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_role where 1 = 1 ");
            if (StringUtils.isNotBlank(keyword)) {
                sql.append(" and (role_name like ? or role_desc like ? )");
            }
            sql.append(" order by role_time desc limit ?,?");
            roleInfoList = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(keyword)) {
                                preparedStatement.setString(++i, "%" + keyword + "%");
                                preparedStatement.setString(++i, "%" + keyword + "%");
                            }
                            preparedStatement.setInt(++i, start);
                            preparedStatement.setInt(++i, num);
                        }
                    },
                    new RoleInfoRowMapper());
            return roleInfoList;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #getRoleList# error " + String.format("keyword=%s,start=%d,num=%d", keyword, start, num), e);
            return Collections.emptyList();
        }
    }

    /**
     * 通过条件获所有角色的总数
     *
     * @param keyword
     * @return
     */
    public int getRoleListCount(final String keyword) {
        logger.info("[UserInfoDao] #getRoleListCount# " + String.format("keyword=%s", keyword));
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_role where 1 = 1 ");
            if (StringUtils.isNotBlank(keyword)) {
                sql.append(" and (role_name like ? or role_desc like ? )");
                params.add("%" + keyword + "%");
                params.add("%" + keyword + "%");
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
            return count;
        } catch (Exception e) {
            logger.info("[UserInfoDao] #getRoleListCount# error " + String.format("keyword=%s", keyword), e);
            return count;
        }
    }

    /**
     * 用户是否存在
     *
     * @param username
     * @return
     */
    public boolean isUserExist(final String username) {
        logger.info("[UserInfoDao] #isUserExist# " + username);
        try {
            int count = jdbcTemplate.update(
                    "select count(1) from tbl_user where user_name = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            pstmt.setString(1, username);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #isUserExist# error " + username, e);
            return false;
        }
    }

    /**
     * 创建用户
     *
     * @param userInfo
     * @return
     */
    public boolean createUser(final UserInfo userInfo) {
        logger.info("[UserInfoDao] #createUser# " + userInfo);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_user(user_id,user_name,user_passwd,user_nickname,user_phone,user_mobile,user_email,user_address,user_dept_id,user_role_id,user_islive,user_time," +
                            "user_nicknamepinyin,user_showorder,user_isincontact)" +
                            " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, userInfo.getUsername());
                            pstmt.setString(++i, userInfo.getPasswd());
                            pstmt.setString(++i, userInfo.getNickname());
                            pstmt.setString(++i, userInfo.getPhone());
                            pstmt.setString(++i, userInfo.getMobile());
                            pstmt.setString(++i, userInfo.getEmail());
                            pstmt.setString(++i, userInfo.getAddress());
                            pstmt.setString(++i, userInfo.getDeptId());
                            pstmt.setString(++i, userInfo.getRoleId());
                            pstmt.setInt(++i, userInfo.getIsLive());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, userInfo.getNicknamePinyin());
                            pstmt.setInt(++i, userInfo.getShowOrder());
                            pstmt.setInt(++i, userInfo.getShowInContact());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #createUser# error " + userInfo, e);
            return false;
        }
    }

    /**
     * 更新用户
     *
     * @param userInfo
     * @return
     */
    public boolean updateUser(final UserInfo userInfo) {
        logger.info("[UserInfoDao] #updateUser# " + userInfo);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_user set user_passwd=?,user_nickname=?,user_phone=?,user_mobile=?,user_email=?,user_address=?,user_dept_id=?,user_role_id=?,user_islive=? ,user_time=?" +
                            ",user_nicknamepinyin=?,user_showorder=?,user_isincontact=? where user_id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, userInfo.getPasswd());
                            pstmt.setString(++i, userInfo.getNickname());
                            pstmt.setString(++i, userInfo.getPhone());
                            pstmt.setString(++i, userInfo.getMobile());
                            pstmt.setString(++i, userInfo.getEmail());
                            pstmt.setString(++i, userInfo.getAddress());
                            pstmt.setString(++i, userInfo.getDeptId());
                            pstmt.setString(++i, userInfo.getRoleId());
                            pstmt.setInt(++i, userInfo.getIsLive());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, userInfo.getNicknamePinyin());
                            pstmt.setInt(++i, userInfo.getShowOrder());
                            pstmt.setInt(++i, userInfo.getShowInContact());
                            pstmt.setString(++i, userInfo.getUserId());

                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #updateUser# error " + userInfo, e);
            return false;
        }
    }

    /**
     * 删除用户
     *
     * @param userId
     * @return
     */
    public boolean delUser(final String userId) {
        logger.info("[UserInfoDao] #delUser# " + userId);
        try {
            int count = jdbcTemplate.update(
                    "delete from tbl_user where user_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            pstmt.setString(1, userId);

                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #delUser# error " + userId, e);
            return false;
        }
    }

    /**
     * 获取用户列表
     *
     * @param query
     * @return
     */
    public List<UserInfo> getUserList(final UserQuery query) {
        logger.info("[UserInfoDao] #getUserList# query=" + query);
        List<UserInfo> list = new ArrayList<UserInfo>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_user where 1=1 ");
            if (StringUtils.isNotBlank(query.getKeyword()))
                sql.append(" and (user_name like ? or user_nickname like ?) ");

            if (StringUtils.isNotBlank(query.getRoleId()))
                sql.append(" and user_role_id = ? ");

            if (query.getIsLive() > -1)
                sql.append(" and user_islive = ? ");

            if (StringUtils.isNotBlank(query.getDeptId()))
                sql.append(" and user_dept_id = ? ");

            if (query.getShowInContact() > -1)
                sql.append(" and user_isincontact = ? ");

            if (StringUtils.isNotBlank(query.getOrderByColumnName()) && StringUtils.isNotBlank(query.getOrderBy()))
                sql.append(" order by ").append(query.getOrderByColumnName()).append(" ").append(query.getOrderBy());
            else
                sql.append(" order by user_time desc ");

            sql.append(" limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getKeyword())) {
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                            }

                            if (StringUtils.isNotBlank(query.getRoleId()))
                                preparedstatement.setString(++i, query.getRoleId());

                            if (query.getIsLive() > -1)
                                preparedstatement.setInt(++i, query.getIsLive());

                            if (StringUtils.isNotBlank(query.getDeptId()))
                                preparedstatement.setString(++i, query.getDeptId());

                            if (query.getShowInContact() > -1)
                                preparedstatement.setInt(++i, query.getShowInContact());


                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new UserInfoRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[CategoryDao] #getByParentId# error", e);
            return null;
        }
    }

    /**
     * 获取符合条件的用户总数
     *
     * @param query
     * @return
     */
    public int getUserListCount(final UserQuery query) {
        logger.info("[UserInfoDao] #getUserListCount# query=" + query);
        int count = 0;
        List<Object> params = new ArrayList<Object>();
        StringBuffer sql = new StringBuffer("select count(1) as total from tbl_user where 1=1 ");
        try {
            if (StringUtils.isNotBlank(query.getKeyword())) {
                sql.append(" and (user_name like ? or user_nickname like ?) ");
                params.add("%" + query.getKeyword() + "%");
                params.add("%" + query.getKeyword() + "%");
            }

            if (StringUtils.isNotBlank(query.getRoleId())) {
                sql.append(" and user_role_id = ? ");
                params.add(query.getRoleId());
            }

            if (query.getIsLive() > -1) {
                sql.append(" and user_islive = ? ");
                params.add(query.getIsLive());
            }
            if (StringUtils.isNotBlank(query.getDeptId())) {
                sql.append(" and user_dept_id = ? ");
                params.add(query.getDeptId());
            }
            if (query.getShowInContact() > -1) {
                sql.append(" and user_isincontact = ? ");
                params.add(query.getShowInContact());
            }

            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
            return count;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #getUserListCount# error " + query, e);
            return count;
        }
    }

    /**
     * 通过ID获取用户信息
     *
     * @param userId
     * @return
     */
    public UserInfo getUserById(final String userId) {
        logger.info("[UserInfoDao] #getUserById# userId=" + userId);
        List<UserInfo> userInfoList = new ArrayList<UserInfo>();
        StringBuffer sql = new StringBuffer("select * from tbl_user where user_id = ?");
        try {
            userInfoList = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, userId);
                        }
                    },
                    new UserInfoRowMapper());
            return userInfoList != null && userInfoList.size() > 0 ? userInfoList.get(0) : null;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #getUserById# error " + userId, e);
            return new UserInfo();
        }
    }

    /**
     * 通过登录名获取对应的用户信息
     *
     * @param username
     * @return
     */
    public UserInfo getUserByName(final String username) {
        logger.info("[UserInfoDao] #getUserById# username=" + username);
        List<UserInfo> userInfoList = new ArrayList<UserInfo>();
        StringBuffer sql = new StringBuffer("select * from tbl_user where user_name = ?");
        try {
            userInfoList = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, username);
                        }
                    },
                    new UserInfoRowMapper());
            return userInfoList != null && userInfoList.size() > 0 ? userInfoList.get(0) : null;
        } catch (Exception e) {
            logger.error("[UserInfoDao] #getUserById# error " + username, e);
            return null;
        }
    }

    /**
     * 登陆校验
     *
     * @param username
     * @param passwd
     * @return
     */
    @Deprecated
    public UserInfo checkUserByLogin(final String username, final String passwd) {
        logger.info("[UserInfoDao] #checkUserByLogin# " + String.format("username=%s,passwd=%s", username, passwd));
        String sql = "select * from tbl_user where user_name = ? and user_passwd = ? limit 1";
        try {
            List<UserInfo> userInfoList = new ArrayList<UserInfo>();
            userInfoList = jdbcTemplate.query(sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, username);
                            preparedStatement.setString(1, passwd);
                        }
                    },
                    new UserInfoRowMapper());
            return userInfoList != null && userInfoList.size() > 0 ? userInfoList.get(0) : null;
        } catch (DataAccessException e) {
            logger.error("[UserInfoDao] #checkUserByLogin# error " + String.format("username=%s,passwd=$s", username, passwd));
        }
        return null;
    }

    /**
     * 重新排序
     *
     * @param userId
     * @param orderId
     * @return
     */
    public boolean setContactOrder(final String userId, final int orderId) {
        logger.info("[UserInfoDao] #setContactOrder# " + String.format("userId=%s,orderId=%d", userId, orderId));
        String sql = "update tbl_user set user_showorder = ? where user_id = ?";
        try {
            List<UserInfo> userInfoList = new ArrayList<UserInfo>();
            int count = jdbcTemplate.update(sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setInt(1, orderId);
                            preparedStatement.setString(2, userId);
                        }
                    });
            return count > 0;
        } catch (DataAccessException e) {
            logger.info("[UserInfoDao] #setContactOrder# error " + String.format("userId=%s,orderId=%d", userId, orderId), e);
        }
        return false;
    }

    class UserInfoRowMapper implements RowMapper<UserInfo> {
        @Override
        public UserInfo mapRow(ResultSet rs, int i) throws SQLException {
            UserInfo userInfo = new UserInfo();
            userInfo.setUserId(rs.getString("user_id"));
            userInfo.setUsername(rs.getString("user_name"));
            userInfo.setPasswd(rs.getString("user_passwd"));
            userInfo.setNickname(rs.getString("user_nickname"));
            userInfo.setNicknamePinyin(rs.getString("user_nicknamepinyin"));
            userInfo.setPhone(rs.getString("user_phone"));
            userInfo.setMobile(rs.getString("user_mobile"));
            userInfo.setEmail(rs.getString("user_email"));
            userInfo.setAddress(rs.getString("user_address"));
            userInfo.setRoleId(rs.getString("user_role_id"));
            userInfo.setIsLive(rs.getInt("user_islive"));
            userInfo.setTime(rs.getTimestamp("user_time"));
            userInfo.setShowInContact(rs.getInt("user_isincontact"));
            userInfo.setShowOrder(rs.getInt("user_showorder"));

            String deptId = rs.getString("user_dept_id");
            Category category = categoryDao.getById(deptId);
            userInfo.setCategory(category);
            userInfo.setDeptId(deptId);

            String roleId = userInfo.getRoleId();
            RoleInfo roleInfo = getRoleById(roleId);

            userInfo.setRoleInfo(roleInfo);

            return userInfo;
        }
    }

    class RoleInfoRowMapper implements RowMapper<RoleInfo> {
        @Override
        public RoleInfo mapRow(ResultSet rs, int i) throws SQLException {
            RoleInfo r = new RoleInfo();
            r.setRoleId(rs.getString("role_id"));
            r.setRoleName(rs.getString("role_name"));
            r.setRoleDesc(rs.getString("role_desc"));
            r.setRoleRightsIds(rs.getString("role_rights_id"));
            r.setRoleTime(rs.getTimestamp("role_time"));
            List<String> rightsList = new ArrayList<String>();
            if (StringUtils.isNotBlank(r.getRoleRightsIds())) {
                String arrays[] = StringUtils.split(r.getRoleRightsIds(), ",");
                for (String ar : arrays) {
                    rightsList.add(ar);
                }
                r.setRightsList(rightsList);
            }

            return r;
        }
    }

    @Deprecated
    class RightsInfoRowMapper implements RowMapper<RightsInfo> {
        @Override
        public RightsInfo mapRow(ResultSet rs, int i) throws SQLException {
            RightsInfo r = new RightsInfo();
            r.setRightsId(rs.getString("rights_id"));
            r.setRightsName(rs.getString("rights_name"));
            r.setRightsDesc(rs.getString("rights_desc"));
            r.setRightsValue(rs.getString("rights_value"));
            r.setRightsTime(rs.getTimestamp("rights_time"));
            return r;
        }
    }
}
