package com.glamey.innerweb.controller.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.dao.MetaInfoDao;
import com.glamey.innerweb.model.domain.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.BlowFish;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.Pinyin4jUtils;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.UserInfoDao;
import com.glamey.innerweb.model.dto.UserQuery;

/**
 * 用户管理
 * Created with IntelliJ IDEA.
 * User: zy
 */
@Controller
@RequestMapping(value = "/mg/user")
public class UserInfoManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(UserInfoManagerController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private UserInfoDao userInfoDao;
    @Resource
    private MetaInfoDao metaInfoDao ;


    /****************************************************************【开始】功能权限操作*************************************************************************/
    /**
     * 功能权限--系统功能权限列表
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/rights-list.htm", method = RequestMethod.GET)
    public ModelAndView rightsList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-rights-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        List<RightsInfo> rightsInfoList = userInfoDao.getRightsList(keyword, pageBean.getStart(), pageBean.getRowsPerPage());
        pageBean.setMaxRowCount(userInfoDao.getRightsListCount(keyword));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("rightsInfoList", rightsInfoList);
        mav.addObject("keyword", keyword);
        mav.addObject("pageBean", pageBean);
        mav.setViewName("mg/user/rights-list");
        return mav;
    }

    /**
     * 功能权限--编辑、创建页面
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/rights-show.htm", method = RequestMethod.GET)
    public ModelAndView rightsShow(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-rights-show]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        RightsInfo rightsInfo = new RightsInfo();
        String opt = "create";
        String rightsId = WebUtils.getRequestParameterAsString(request, "rightsId");
        if (StringUtils.isNotBlank(rightsId)) {
            rightsInfo = userInfoDao.getRightsById(rightsId);
            opt = "update";
        }
        mav.addObject("rightsInfo", rightsInfo);
        mav.addObject("opt", opt);
        mav.setViewName("mg/user/rights-show");
        return mav;
    }

    /**
     * 功能权限--创建
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/rights-create.htm", method = RequestMethod.POST)
    public ModelAndView rightsCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-rights-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        RightsInfo rightsInfo = new RightsInfo();

        rightsInfo.setRightsName(WebUtils.getRequestParameterAsString(request, "rightsName"));
        rightsInfo.setRightsDesc(WebUtils.getRequestParameterAsString(request, "rightsDesc"));
        rightsInfo.setRightsValue(WebUtils.getRequestParameterAsString(request, "rightsValue"));
        if (userInfoDao.createRights(rightsInfo)) {
            mav.addObject("message", "创建功能权限成功");
            mav.addObject("href", "mg/user/rights-list.htm");
        } else {
            mav.addObject("message", "创建用户失败");
        }
        return mav;
    }

    /**
     * 功能权限-更新
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/rights-update.htm", method = RequestMethod.POST)
    public ModelAndView rightsUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-rights-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String rightsId = WebUtils.getRequestParameterAsString(request, "rightsId");
        if (StringUtils.isBlank(rightsId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        RightsInfo rightsInfo = userInfoDao.getRightsById(rightsId);
        rightsInfo.setRightsName(WebUtils.getRequestParameterAsString(request, "rightsName"));
        rightsInfo.setRightsDesc(WebUtils.getRequestParameterAsString(request, "rightsDesc"));
        rightsInfo.setRightsValue(WebUtils.getRequestParameterAsString(request, "rightsValue"));

        if (userInfoDao.updateRights(rightsInfo)) {
            mav.addObject("message", "更新功能权限成功");
            mav.addObject("href", "mg/user/rights-list.htm");
        } else {
            mav.addObject("message", "更新功能权限失败");
        }
        return mav;
    }

    /**
     * 功能权限--删除
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/rights-del.htm", method = RequestMethod.GET)
    public ModelAndView rightsDel(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-rights-delete]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String rightsId = WebUtils.getRequestParameterAsString(request, "rightsId");
        if (StringUtils.isBlank(rightsId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        try {
            String arrays[] = StringUtils.split(rightsId, ",");
            for (String array : arrays) {
                logger.info("[manager-rights-delete]" + request.getRequestURI() + " rightsId=" + array + " result=" + userInfoDao.delRights(array));
            }
            mav.addObject("message", "删除功能权限成功");
        } catch (Exception e) {
            logger.error("[manager-rights-delete] error " + request.getRequestURI() + " " + rightsId);
            mav.addObject("message", "删除功能权限失败");
        }
        return mav;
    }
    /****************************************************************【结束】功能权限操作*************************************************************************/


    /****************************************************************【开始】系统角色操作*************************************************************************/
    /**
     * 系统角色操作--列表
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/role-list.htm", method = RequestMethod.GET)
    public ModelAndView roleList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-role-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        //获取符合条件的所有用户
        List<RoleInfo> roleInfoList = userInfoDao.getRoleList(keyword, pageBean.getStart(), pageBean.getRowsPerPage());
        pageBean.setMaxRowCount(userInfoDao.getRoleListCount(keyword));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("roleInfoList", roleInfoList);
        mav.addObject("keyword", keyword);
        mav.addObject("pageBean", pageBean);
        mav.setViewName("mg/user/role-list");
        return mav;
    }

    /**
     * 系统角色操作 --编辑、创建页面
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/role-show.htm", method = RequestMethod.GET)
    public ModelAndView roleShow(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-role-show]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        RoleInfo roleInfo = new RoleInfo();
        String opt = "create";
        String roleId = WebUtils.getRequestParameterAsString(request, "roleId");
        if (StringUtils.isNotBlank(roleId)) {
            roleInfo = userInfoDao.getRoleById(roleId);
            opt = "update";
            List<String> rightsInfoList = new ArrayList<String>();
            if (StringUtils.isNotBlank(roleInfo.getRoleRightsIds())) {
                String arrays[] = StringUtils.split(roleInfo.getRoleRightsIds(), ",");
                for (String array : arrays) {
                    rightsInfoList.add(array);
                }
            }
            roleInfo.setRightsList(rightsInfoList);
        }

        mav.addObject("roleInfo", roleInfo);
        mav.addObject("opt", opt);
        mav.setViewName("mg/user/role-show");

        //新闻分类
        Category categoryNews = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NEWS);
        List<Category> categoryNewsList = categoryDao.getByParentId(categoryNews.getId(), categoryNews.getCategoryType(), 0, Integer.MAX_VALUE);
        mav.addObject("categoryNews", categoryNews);
        mav.addObject("categoryNewsList", categoryNewsList);
        
        /*通知通告分类管理*/
        Category categoryNotices = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NOTICES);
        List<Category> categoryNoticesList = categoryDao.getByParentId(categoryNotices.getId(), categoryNotices.getCategoryType(), 0, Integer.MAX_VALUE);
        mav.addObject("categoryNotices", categoryNotices);
        mav.addObject("categoryNoticesList", categoryNoticesList);

        //安全管理
        Category categorySafe = categoryDao.getByAliasName(CategoryConstants.CATEGORY_SAFE);
        List<Category> categorySafeList = categoryDao.getByParentId(categorySafe.getId(), categorySafe.getCategoryType(), 0, Integer.MAX_VALUE);
        mav.addObject("categorySafe", categorySafe);
        mav.addObject("categorySafeList", categorySafeList);

        return mav;
    }

    /**
     * 系统角色操作 - 创建
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/role-create.htm", method = RequestMethod.POST)
    public ModelAndView roleCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-role-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");

        RoleInfo roleInfo = new RoleInfo();
        roleInfo.setRoleName(WebUtils.getRequestParameterAsString(request, "roleName"));
        roleInfo.setRoleDesc(WebUtils.getRequestParameterAsString(request, "roleDesc"));
        String rights[] = WebUtils.getRequestParameterAsStringArrs(request, "rightsId");
        if (rights == null || rights.length == 0) {
            mav.addObject("message", "请选择功能点");
            return mav;
        }
        StringBuffer sb = new StringBuffer();
        for (String right : rights) {
            sb.append(",").append(right);
        }
        roleInfo.setRoleRightsIds(sb.length() == 0 ? sb.toString() : sb.toString().substring(1));

        if (userInfoDao.createRole(roleInfo)) {
            mav.addObject("message", "创建系统角色成功");
            mav.addObject("href", "mg/user/role-list.htm");
        } else {
            mav.addObject("message", "创建系统角色失败");
        }
        return mav;
    }

    /**
     * 系统角色--修改
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/role-update.htm", method = RequestMethod.POST)
    public ModelAndView roleUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-role-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String roleId = WebUtils.getRequestParameterAsString(request, "roleId");
        if (StringUtils.isBlank(roleId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        RoleInfo roleInfo = userInfoDao.getRoleById(roleId);
        roleInfo.setRoleName(WebUtils.getRequestParameterAsString(request, "roleName"));
        roleInfo.setRoleDesc(WebUtils.getRequestParameterAsString(request, "roleDesc"));
        String rights[] = WebUtils.getRequestParameterAsStringArrs(request, "rightsId");
        if (rights == null || rights.length == 0) {
            mav.addObject("message", "请选择功能点");
            return mav;
        }
        StringBuffer sb = new StringBuffer();
        for (String right : rights) {
            sb.append(",").append(right);
        }
        roleInfo.setRoleRightsIds(sb.length() == 0 ? sb.toString() : sb.toString().substring(1));

        if (userInfoDao.updateRole(roleInfo)) {
            mav.addObject("message", "更新系统角色成功");
            mav.addObject("href", "mg/user/role-list.htm");
        } else {
            mav.addObject("message", "更新系统角色失败");
        }
        return mav;
    }

    /**
     * 系统角色--删除
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/role-del.htm", method = RequestMethod.GET)
    public ModelAndView roleDel(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-role-delete]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String roleId = WebUtils.getRequestParameterAsString(request, "roleId");

        try {
            String arrays[] = StringUtils.split(roleId, ",");
            for (String array : arrays) {
                logger.info("[manager-rights-delete]" + request.getRequestURI() + " roleId=" + array + " result=" + userInfoDao.delRole(array));
            }
            mav.addObject("message", "删除系统角色成功");
        } catch (Exception e) {
            logger.error("[manager-rights-delete] error " + request.getRequestURI() + " " + roleId);
            mav.addObject("message", "删除系统角色失败");
        }
        return mav;
    }
    /****************************************************************【结束】系统角色操作*************************************************************************/


    /****************************************************************【开始】系统用户操作*************************************************************************/
    /**
     * 系统用户 - 列表
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/user-list.htm", method = RequestMethod.GET)
    public ModelAndView userList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        //如果是超级管理员的话，可以查看所有的用户，其他角色只能看本部门下的所有用户
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        boolean isSuper = StringUtils.equals(userInfo.getRoleId(), Constants.sysAdminRoleId);

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean(30);
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        String roleId = WebUtils.getRequestParameterAsString(request, "roleId");
        int isLive = WebUtils.getRequestParameterAsInt(request, "isLive", -1);
        String deptId = WebUtils.getRequestParameterAsString(request, "deptId");
        UserQuery query = new UserQuery();
        query.setKeyword(keyword);
        query.setRoleId(roleId);
        query.setIsLive(isLive);
        query.setOrderByColumnName(Constants.ORDERBYCOLUMNNAME_USER);
        query.setOrderBy(Constants.ORDERBYASC);
        query.setDeptId(isSuper ? deptId : userInfo.getDeptId());
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        //获取符合条件的所有用户
        List<UserInfo> userInfoList = userInfoDao.getUserList(query);
        pageBean.setMaxRowCount(userInfoDao.getUserListCount(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        //获取所有角色
        List<RoleInfo> roleInfoList = userInfoDao.getRoleList(null, 0, Integer.MAX_VALUE);

        //获取所有部门
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        List<Category> deptInfoList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        mav.addObject("roleInfoList", roleInfoList);
        mav.addObject("userInfoList", userInfoList);
        mav.addObject("deptInfoList", deptInfoList);
        mav.addObject("query", query);
        mav.addObject("isSuper", isSuper);
        mav.addObject("pageBean", pageBean);
        mav.setViewName("mg/user/user-list");
        return mav;
    }

    /**
     * 系统用户--编辑、创建页面
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/user-show.htm", method = RequestMethod.GET)
    public ModelAndView userShow(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-show]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        UserInfo userInfoSession = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        boolean isSuper = StringUtils.equals(userInfoSession.getRoleId(), Constants.sysAdminRoleId);

        UserInfo userInfo = new UserInfo();
        String opt = "create";
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        if (StringUtils.isNotBlank(userId)) {
            userInfo = userInfoDao.getUserById(userId);
            opt = "update";
        } else {
            //默认为用户激活状态
            userInfo.setIsLive(1);
            userInfo.setDeptId(userInfoSession.getDeptId());
            userInfo.setShowInContact(1);
        }
        //获取所有角色
        List<RoleInfo> roleInfoList = userInfoDao.getRoleList(null, 0, Integer.MAX_VALUE);
        //获取所有部门
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        List<Category> deptInfoList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        mav.addObject("roleInfoList", roleInfoList);
        mav.addObject("deptInfoList", deptInfoList);
        mav.addObject("userInfo", userInfo);
        mav.addObject("opt", opt);
        mav.addObject("isSuper", isSuper);
        mav.setViewName("mg/user/user-show");
        return mav;
    }

    /**
     * 系统用户-创建
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/user-create.htm", method = RequestMethod.POST)
    public ModelAndView userCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String username = WebUtils.getRequestParameterAsString(request, "username");
        if (StringUtils.isBlank(username)) {
            mav.addObject("message", "用户名不能为空");
            return mav;
        }
        if (userInfoDao.isUserExist(username)) {
            mav.addObject("message", "用户名已存在,请更换其他重试");
            return mav;
        }

        String passwd = WebUtils.getRequestParameterAsString(request, "passwd");
        String passwdRp = WebUtils.getRequestParameterAsString(request, "passwdRp");
        if (!StringUtils.equals(passwd, passwdRp) || (StringUtils.isBlank(passwd) || StringUtils.isBlank(passwdRp))) {
            mav.addObject("message", "两次密码不一致");
            return mav;
        }
        UserInfo userInfo = new UserInfo();
        userInfo.setRoleId(WebUtils.getRequestParameterAsString(request, "roleId"));
        userInfo.setDeptId(WebUtils.getRequestParameterAsString(request, "deptId"));
        userInfo.setDuties(WebUtils.getRequestParameterAsString(request,"duties"));
        userInfo.setUsername(username);
        BlowFish bf = new BlowFish(Constants.SECRET_KEY);
        userInfo.setPasswd(bf.encryptString(passwd));
        String nickName = WebUtils.getRequestParameterAsString(request, "nickname");
        userInfo.setNickname(nickName);
        userInfo.setNicknamePinyin(Pinyin4jUtils.getPinYin(nickName));
        userInfo.setPhone(WebUtils.getRequestParameterAsString(request, "phone"));
        userInfo.setMobile(WebUtils.getRequestParameterAsString(request, "mobile"));
        userInfo.setEmail(WebUtils.getRequestParameterAsString(request, "email"));
        userInfo.setAddress(WebUtils.getRequestParameterAsString(request, "address"));
        userInfo.setIsLive(WebUtils.getRequestParameterAsInt(request, "isLive", 0));
        userInfo.setShowInContact(WebUtils.getRequestParameterAsInt(request, "showInContact", 1));
        userInfo.setShowOrder(WebUtils.getRequestParameterAsInt(request, "showOrder", 0));
        userInfo.setBirthday(WebUtils.getRequestParameterAsString(request, "birthday", DateFormatUtils.format(new Date(),"yyyy-MM-dd")));

        if (userInfoDao.createUser(userInfo)) {
            //比较变态的需求，新建用户之后，以该用户登陆系统
            mav.addObject("message", "创建系统用户成功");
            mav.addObject("href", "mg/user/user-list.htm");
        } else {
            mav.addObject("message", "创建系统用户失败");
        }
        return mav;
    }

    /**
     * 系统用户-更新
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/user-update.htm", method = RequestMethod.POST)
    public ModelAndView userUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        if (StringUtils.isBlank(userId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        UserInfo userInfo = userInfoDao.getUserById(userId);
        String roleId = WebUtils.getRequestParameterAsString(request, "roleId");
        if (StringUtils.isNotBlank(roleId)) {
            userInfo.setRoleId(roleId);
        }
        String deptId = WebUtils.getRequestParameterAsString(request, "deptId");
        if (StringUtils.isNotBlank(deptId)) {
            userInfo.setDeptId(deptId);
        }

        userInfo.setDuties(WebUtils.getRequestParameterAsString(request,"duties"));
        userInfo.setUsername(WebUtils.getRequestParameterAsString(request, "username"));
        String passwd = WebUtils.getRequestParameterAsString(request, "passwd");
        if (StringUtils.isNotBlank(passwd)) {
            BlowFish bf = new BlowFish(Constants.SECRET_KEY);
            userInfo.setPasswd(bf.encryptString(passwd));
        }
        String nickName = WebUtils.getRequestParameterAsString(request, "nickname");
        userInfo.setNickname(nickName);
        userInfo.setNicknamePinyin(Pinyin4jUtils.getPinYin(nickName));
        userInfo.setPhone(WebUtils.getRequestParameterAsString(request, "phone"));
        userInfo.setMobile(WebUtils.getRequestParameterAsString(request, "mobile"));
        userInfo.setEmail(WebUtils.getRequestParameterAsString(request, "email"));
        userInfo.setAddress(WebUtils.getRequestParameterAsString(request, "address"));
        userInfo.setIsLive(WebUtils.getRequestParameterAsInt(request, "isLive", 0));
        userInfo.setShowInContact(WebUtils.getRequestParameterAsInt(request, "showInContact", 1));
        /*userInfo.setShowOrder(WebUtils.getRequestParameterAsInt(request, "showOrder", 0));*/
        userInfo.setBirthday(WebUtils.getRequestParameterAsString(request, "birthday", DateFormatUtils.format(new Date(),"yyyy-MM-dd")));

        if (userInfoDao.updateUser(userInfo)) {
            mav.addObject("message", "更新系统用户成功");
            /*userInfo = userInfoDao.getUserById(userId);
            session.removeAttribute(Constants.SESSIN_USERID);
            session.setAttribute(Constants.SESSIN_USERID, userInfo);*/
        } else {
            mav.addObject("message", "更新系统用户失败");
        }
        return mav;
    }

    /**
     * 系统用户-删除
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/user-del.htm", method = RequestMethod.GET)
    public ModelAndView userDel(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        if (StringUtils.isBlank(userId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        try {
            String arrays[] = StringUtils.split(userId, ",");
            for (String array : arrays) {
                logger.info("[manager-rights-delete]" + request.getRequestURI() + " roleId=" + array + " result=" + userInfoDao.delUser(array));
            }
            mav.addObject("message", "删除系统用户成功");
            mav.addObject("href","mg/user/user-list.htm");
        } catch (Exception e) {
            logger.error("[manager-rights-delete] error " + request.getRequestURI() + " " + userId);
            mav.addObject("message", "删除系统用户失败");
        }

        return mav;
    }

    //查看个人信息
    @RequestMapping(value = "/user-psersonal-show.htm", method = RequestMethod.GET)
    public ModelAndView personalShow(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-personalShow]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        if (StringUtils.isBlank(userId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        UserInfo userInfo = userInfoDao.getUserById(userId);
        //获取所有角色
        List<RoleInfo> roleInfoList = userInfoDao.getRoleList(null, 0, Integer.MAX_VALUE);
        //获取所有部门
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        List<Category> deptInfoList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        mav.addObject("roleInfoList", roleInfoList);
        mav.addObject("deptInfoList", deptInfoList);
        mav.addObject("userInfo", userInfo);
        mav.addObject("opt", "update");
        mav.setViewName("mg/user/user-personal-show");
        return mav;
    }

    /*通讯录*/
    @RequestMapping(value = "/contact.htm", method = RequestMethod.GET)
    public ModelAndView userContact(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-contact]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        //如果是超级管理员，可以进行通讯录的排序设置
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        boolean isSuper = StringUtils.equals(userInfo.getRoleId(), Constants.sysAdminRoleId);

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean(30);
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        String deptId = WebUtils.getRequestParameterAsString(request, "deptId");
        UserQuery query = new UserQuery();
        query.setKeyword(keyword);
        query.setDeptId(deptId);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        query.setOrderBy(Constants.ORDERBYASC);
        query.setOrderByColumnName(Constants.ORDERBYCOLUMNNAME_SHOWORDER);
        query.setShowInContact(1);

        //获取符合条件的所有用户
        List<UserInfo> userInfoList = userInfoDao.getUserList(query);
        pageBean.setMaxRowCount(userInfoDao.getUserListCount(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        //获取所有部门
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        List<Category> deptInfoList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        /*获取通讯录头部信息*/
        MetaInfo contactHeader = metaInfoDao.getByName(SystemConstants.contact_header);
        mav.addObject("userInfoList", userInfoList);
        mav.addObject("deptInfoList", deptInfoList);
        mav.addObject("query", query);
        mav.addObject("isSuper", isSuper);
        mav.addObject("pageBean", pageBean);
        mav.addObject("contactHeader",contactHeader);
        mav.setViewName("mg/user/contact-list");
        return mav;
    }

    @RequestMapping(value = "/setContactOrder.htm", method = RequestMethod.GET)
    public ModelAndView setContactOrder(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        int orderId = WebUtils.getRequestParameterAsInt(request, "orderId", 0);

        if (userInfoDao.setContactOrder(userId, orderId)) {
            mav.addObject("message", "排序成功");
            mav.addObject("href", "mg/user/contact.htm");
        } else {
            mav.addObject("message", "排序失败，请稍后重试");
        }
        return mav;
    }

    /*通过部门查询所有的成员*/
    @ResponseBody
    @RequestMapping(value = "/getUserByDeptId.htm", method = RequestMethod.GET)
    public void getUserByDeptId(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-getUserByDeptId]" + request.getRequestURI());
        String deptId = WebUtils.getRequestParameterAsString(request, "deptId");
        UserQuery query = new UserQuery();
        query.setDeptId(deptId);
        query.setStart(0);
        query.setNum(Integer.MAX_VALUE);
        //获取符合条件的所有用户
        List<UserInfo> userInfoList = userInfoDao.getUserList(query);
        StringBuilder source = new StringBuilder();
        for (UserInfo userInfo : userInfoList) {
            source.append("<option value='").append(userInfo.getUserId()).append("'>").append(userInfo.getNickname()).append("</option>");
        }
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.getWriter().print(source);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    /****************************************************************【结束】系统用户操作*************************************************************************/

}
