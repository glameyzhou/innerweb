package com.glamey.chec_cn.controller.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.print.attribute.standard.JobOriginatingUserName;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.chec_cn.constants.SystemConstants;
import com.glamey.chec_cn.dao.MetaInfoDao;
import com.glamey.chec_cn.model.domain.*;
import org.apache.commons.lang.StringUtils;
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
import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.UserInfoDao;
import com.glamey.chec_cn.model.dto.UserQuery;

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
    @RequestMapping(value = "/rights-list.do", method = RequestMethod.GET)
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
    @RequestMapping(value = "/rights-show.do", method = RequestMethod.GET)
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
    @RequestMapping(value = "/rights-create.do", method = RequestMethod.POST)
    public ModelAndView rightsCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-rights-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        RightsInfo rightsInfo = new RightsInfo();

        rightsInfo.setRightsName(WebUtils.getRequestParameterAsString(request, "rightsName"));
        rightsInfo.setRightsDesc(WebUtils.getRequestParameterAsString(request, "rightsDesc"));
        rightsInfo.setRightsValue(WebUtils.getRequestParameterAsString(request, "rightsValue"));
        if (userInfoDao.createRights(rightsInfo)) {
            mav.addObject("message", "创建功能权限成功");
            mav.addObject("href", "mg/user/rights-list.do");
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
    @RequestMapping(value = "/rights-update.do", method = RequestMethod.POST)
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
            mav.addObject("href", "mg/user/rights-list.do");
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
    @RequestMapping(value = "/rights-del.do", method = RequestMethod.GET)
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
    @RequestMapping(value = "/role-list.do", method = RequestMethod.GET)
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
    @RequestMapping(value = "/role-show.do", method = RequestMethod.GET)
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
                /*for (String array : arrays) {
                    rightsInfoList.add(array);
                }*/
                rightsInfoList.addAll(Arrays.asList(arrays));
            }
            roleInfo.setRightsList(rightsInfoList);
        }
        mav.addObject("roleInfo", roleInfo);
        mav.addObject("opt", opt);
        mav.setViewName("mg/user/role-show");

        /*//新闻分类
        Category categoryNews = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NEWS);
        List<Category> categoryNewsList = categoryDao.getByParentId(categoryNews.getId(), categoryNews.getCategoryType(), 0, Integer.MAX_VALUE);
        mav.addObject("categoryNews", categoryNews);
        mav.addObject("categoryNewsList", categoryNewsList);
        
        *//*通知通告分类管理*//*
        Category categoryNotices = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NOTICES);
        List<Category> categoryNoticesList = categoryDao.getByParentId(categoryNotices.getId(), categoryNotices.getCategoryType(), 0, Integer.MAX_VALUE);
        mav.addObject("categoryNotices", categoryNotices);
        mav.addObject("categoryNoticesList", categoryNoticesList);

        //安全管理
        Category categorySafe = categoryDao.getByAliasName(CategoryConstants.CATEGORY_SAFE);
        List<Category> categorySafeList = categoryDao.getByParentId(categorySafe.getId(), categorySafe.getCategoryType(), 0, Integer.MAX_VALUE);
        mav.addObject("categorySafe", categorySafe);
        mav.addObject("categorySafeList", categorySafeList);*/

        /*图书馆一级分类*/
        List<Category> libCategoryList = categoryDao.getByParentId(CategoryConstants.PARENTID,CategoryConstants.CATEGORY_LIBRARY,0,Integer.MAX_VALUE);
        mav.addObject("libCategoryList",libCategoryList);

        /*专题讨论区分类*/
        List<Category> bbsCategoryList = categoryDao.getByParentId(CategoryConstants.CATEGORY_BBS_ROOT,CategoryConstants.CATEGORY_BBS,0,Integer.MAX_VALUE);
        mav.addObject("bbsCategoryList",bbsCategoryList);

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
    @RequestMapping(value = "/role-create.do", method = RequestMethod.POST)
    public ModelAndView roleCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-role-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");

        RoleInfo roleInfo = new RoleInfo();
        roleInfo.setRoleId(StringTools.getUniqueId());
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
            mav.addObject("href", "mg/user/role-list.do");
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
    @RequestMapping(value = "/role-update.do", method = RequestMethod.POST)
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
            mav.addObject("href", "mg/user/role-list.do");
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
    @RequestMapping(value = "/role-del.do", method = RequestMethod.GET)
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
    @RequestMapping(value = "/user-list.do", method = RequestMethod.GET)
    public ModelAndView userList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        //设置论坛版主的条件
        String brandId = WebUtils.getRequestParameterAsString(request,"brandId","");

        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        boolean isSuper = userInfoDao.isSuper(userInfo);

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean(30);
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        int isLive = WebUtils.getRequestParameterAsInt(request, "isLive", -1);
        String roleId = WebUtils.getRequestParameterAsString(request,"roleId");
        UserQuery query = new UserQuery();
        query.setKeyword(keyword);
        query.setIsLive(isLive);
        query.setRoleId(roleId);
        query.setOrderByColumnName(Constants.ORDERBYCOLUMNNAME_USER);
        query.setOrderBy(Constants.ORDERBYASC);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        query.setStartTime(WebUtils.getRequestParameterAsString(request, "startTime"));
        query.setEndTime(WebUtils.getRequestParameterAsString(request, "endTime"));

        //获取符合条件的所有用户
        List<UserInfo> userInfoList = userInfoDao.getUserList(query);
        pageBean.setMaxRowCount(userInfoDao.getUserListCount(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        //获取所有角色
        List<RoleInfo> roleInfoList = userInfoDao.getRoleList(null, 0, Integer.MAX_VALUE);

        //获取所有部门
//        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
//        List<Category> deptInfoList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        mav.addObject("roleInfoList", roleInfoList);
        mav.addObject("userInfoList", userInfoList);
//        mav.addObject("deptInfoList", deptInfoList);
        mav.addObject("query", query);
        mav.addObject("isSuper", isSuper);
        mav.addObject("pageBean", pageBean);
        mav.addObject("brandId", brandId);
        mav.setViewName("mg/user/user-list");
        return mav;
    }
    @RequestMapping(value = "/user-detail.do", method = RequestMethod.GET)
    public ModelAndView userDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-detail]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        String userId = WebUtils.getRequestParameterAsString(request,"userId");
        if(StringUtils.isBlank(userId)){
            mav.setViewName("common/message");
            mav.addObject("message","查询用户不存在");
            return mav ;
        }

        UserInfo userInfo = userInfoDao.getUserById(userId);
        mav.addObject("userInfo", userInfo);
        mav.setViewName("mg/user/user-detail");
        return mav;
    }

    /**
     * 系统用户--编辑、创建页面
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/user-show.do", method = RequestMethod.GET)
    public ModelAndView userShow(HttpServletRequest request, HttpServletResponse response) {
        logger.info("[manager-user-show]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        UserInfo userInfo = new UserInfo();
        String opt = "create";
        //获取所有角色
        List<RoleInfo> roleInfoList = userInfoDao.getRoleList(null, 0, Integer.MAX_VALUE);
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        List<RoleInfo> srcRoleInfoList = new ArrayList<RoleInfo>();
        List<RoleInfo> destRoleInfoList = new ArrayList<RoleInfo>();
        if (StringUtils.isNotBlank(userId)) {
            userInfo = userInfoDao.getUserById(userId);
            destRoleInfoList.addAll(userInfo.getRoleInfoList());
            srcRoleInfoList.addAll(roleInfoList);
            for(Iterator<RoleInfo> it = srcRoleInfoList.iterator();it.hasNext();){
                RoleInfo r = it.next();
                if(destRoleInfoList.contains(r)){
                    it.remove();
                }
            }
            opt = "update";
        } else {
            //默认为用户激活状态
            userInfo.setIsLive(1);
            srcRoleInfoList.addAll(roleInfoList);
        }

        mav.addObject("srcRoleInfoList", srcRoleInfoList);
        mav.addObject("destRoleInfoList", destRoleInfoList);
        mav.addObject("userInfo", userInfo);
        mav.addObject("opt", opt);
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
    @RequestMapping(value = "/user-create.do", method = RequestMethod.POST)
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
        String roleIds [] = WebUtils.getRequestParameterAsStringArrs(request,"sltTarget");
        if(roleIds == null || roleIds.length == 0){
            mav.addObject("message", "角色必须选择一项");
            return mav;
        }
        List<String> roleIdList = Arrays.asList(roleIds);
        String question = WebUtils.getRequestParameterAsString(request ,"question");
        String answer = WebUtils.getRequestParameterAsString(request ,"answer");
        if((StringUtils.isNotBlank(question) && StringUtils.isBlank(answer))
                ||
                (StringUtils.isBlank(question) && StringUtils.isNotBlank(answer))){
            mav.addObject("message", "问题和答案都需要填写");
            return mav;
        }
        UserInfo userInfo = new UserInfo();
        userInfo.setRoleIdList(roleIdList);
        userInfo.setUsername(username);
        BlowFish bf = new BlowFish(Constants.SECRET_KEY);
        userInfo.setPasswd(bf.encryptString(passwd));
        String nickName = WebUtils.getRequestParameterAsString(request, "nickname");
        userInfo.setNickname(nickName);
        userInfo.setNicknamePinyin(Pinyin4jUtils.getPinYin(nickName));
        userInfo.setCompany(WebUtils.getRequestParameterAsString(request, "company"));
        userInfo.setDept(WebUtils.getRequestParameterAsString(request, "dept"));
        userInfo.setDuty(WebUtils.getRequestParameterAsString(request, "duty"));
        userInfo.setAddress(WebUtils.getRequestParameterAsString(request, "address"));
        userInfo.setPhone(WebUtils.getRequestParameterAsString(request, "phone"));
        userInfo.setMobile(WebUtils.getRequestParameterAsString(request, "mobile"));
        userInfo.setEmail(WebUtils.getRequestParameterAsString(request, "email"));
        userInfo.setIsLive(WebUtils.getRequestParameterAsInt(request, "isLive", 0));

        if (userInfoDao.createUser(userInfo)) {
            //比较变态的需求，新建用户之后，以该用户登陆系统
            mav.addObject("message", "创建系统用户成功");
            mav.addObject("href", "mg/user/user-list.do");
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
    @RequestMapping(value = "/user-update.do", method = RequestMethod.POST)
    public ModelAndView userUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        if (StringUtils.isBlank(userId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        UserInfo userInfo = userInfoDao.getUserById(userId);
        userInfo.setUsername(WebUtils.getRequestParameterAsString(request, "username"));
        String passwd = WebUtils.getRequestParameterAsString(request, "passwd");
        if (StringUtils.isNotBlank(passwd)) {
            BlowFish bf = new BlowFish(Constants.SECRET_KEY);
            userInfo.setPasswd(bf.encryptString(passwd));
        }


        String roleIds [] = WebUtils.getRequestParameterAsStringArrs(request,"sltTarget");
        if(roleIds == null || roleIds.length == 0){
            mav.addObject("message", "角色必须选择一项");
            return mav;
        }
        List<String> roleIdList = Arrays.asList(roleIds);
        userInfo.setRoleIdList(roleIdList);
        String nickName = WebUtils.getRequestParameterAsString(request, "nickname");
        userInfo.setNickname(nickName);
        userInfo.setNicknamePinyin(Pinyin4jUtils.getPinYin(nickName));
        userInfo.setCompany(WebUtils.getRequestParameterAsString(request, "company"));
        userInfo.setDept(WebUtils.getRequestParameterAsString(request, "dept"));
        userInfo.setDuty(WebUtils.getRequestParameterAsString(request, "duty"));
        userInfo.setAddress(WebUtils.getRequestParameterAsString(request, "address"));
        userInfo.setPhone(WebUtils.getRequestParameterAsString(request, "phone"));
        userInfo.setMobile(WebUtils.getRequestParameterAsString(request, "mobile"));
        userInfo.setEmail(WebUtils.getRequestParameterAsString(request, "email"));
        userInfo.setIsLive(WebUtils.getRequestParameterAsInt(request, "isLive", 0));

        if (userInfoDao.updateUser(userInfo)) {
            mav.addObject("message", "更新系统用户成功");
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
    @RequestMapping(value = "/user-del.do", method = RequestMethod.GET)
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
            mav.addObject("href","mg/user/user-list.do");
        } catch (Exception e) {
            logger.error("[manager-rights-delete] error " + request.getRequestURI() + " " + userId);
            mav.addObject("message", "删除系统用户失败");
        }
        return mav;
    }

    //查看个人信息
    @RequestMapping(value = "/user-personal-show.do", method = RequestMethod.GET)
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
        List<RoleInfo> roleInfoList = userInfo.getRoleInfoList();

        mav.addObject("roleInfoList", roleInfoList);
        mav.addObject("userInfo", userInfo);
        mav.addObject("opt", "update");
        mav.setViewName("mg/user/user-personal-show");

        boolean isSuper = userInfoDao.isSuper((UserInfo)session.getAttribute(Constants.SESSIN_USERID));
        mav.addObject("isSuper",isSuper);
        boolean isGroupLeader = userInfoDao.isGroupLeader((UserInfo)session.getAttribute(Constants.SESSIN_USERID));
        mav.addObject("isGroupLeader",isGroupLeader);

        return mav;
    }

    /*通过部门查询所有的成员*/
    @ResponseBody
    @RequestMapping(value = "/getUserByDeptId.do", method = RequestMethod.GET)
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

    @RequestMapping(value = "/user-setLive.do", method = RequestMethod.GET)
    public ModelAndView setLive(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        String flag = WebUtils.getRequestParameterAsString(request,"flag");
        if (StringUtils.isBlank(userId) || StringUtils.isBlank(flag)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        try {
            String arrays[] = StringUtils.split(userId, ",");
            if(userInfoDao.setUserLive(arrays,Integer.valueOf(flag))){
                message = "设置成功" ;
                mav.addObject("href","mg/user/user-list.do");
            }
            mav.addObject("message", message);
        } catch (Exception e) {
            logger.error("[manager-rights-delete] error " + request.getRequestURI() + " " + userId);
            mav.addObject("message", "设置用户属性失败");
        }
        return mav;
    }

    @RequestMapping(value = "/user-resetPasswd.do", method = RequestMethod.GET)
    public ModelAndView resetPasswd(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-user-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        if (StringUtils.isBlank(userId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        try {
            String arrays[] = StringUtils.split(userId, ",");
            if(userInfoDao.resetPasswd(userId)){
                message = "重置成功，新密码为\"adminadmin\"" ;
            }
            else{
                message = "重置失败，请稍后重试" ;
            }
            mav.addObject("message", message);
        } catch (Exception e) {
            logger.error("[manager-rights-delete] error " + request.getRequestURI() + " " + userId);
            mav.addObject("message", "重试密码失败");
        }
        return mav;
    }
    /****************************************************************【结束】系统用户操作*************************************************************************/

}
