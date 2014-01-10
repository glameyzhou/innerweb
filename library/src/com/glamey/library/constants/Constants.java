package com.glamey.library.constants;


/**
 * @author zy
 */
public class Constants {

    /**
     * 系统用户ID	session
     */
    public static final String SESSIN_USERID = "SESSION_USERID";

    /**
     * 验证码*
     */
    public static final String VERIFYCODE = "VERIFYCODE";
    /**
     * 密钥
     */
    public static final String SECRET_KEY = "<glameyzhou>";

    public static final String COOKIES_ID = "LIBRARY_COOKIES_ID" ;

    /**
     * 每页显示的条数（针对前台）
     */
    public static final int rowsPerPageFront = 20;


    /*系统超级管理员角色ID*/
    public static final String sysAdminRoleId = "zA3eem";

    /*系统角色-集团领导*/
    public static final String sysRoleIdGroupLeader = "zu2q2q" ;

    /*系统角色--普通用户*/
    public static final String sysRoleIdCommon = "yIZ732" ;

    /*游客角色ID*/
    public static final String sysTouristRoleId = "mQbMJv" ;

    public static final String sysTouristUID = "lib_Tourist_uid" ;

    public static final String sysTouristPwd = "lib_Tourist_uid" ;

    /**
     * 通告是否需要审核
     */
    public static int NOTICES_PERMIT = 1;

    public static final String ORDERBYDESC = " desc ";
    public static final String ORDERBYASC = " asc ";
    /*用户信息表-昵称拼音*/
    public static final String ORDERBYCOLUMNNAME_USER = " user_nicknamepinyin ";
    public static final String ORDERBYCOLUMNNAME_SHOWORDER = " user_showorder ";

    public static final String ORDERBYCOLUMNNAME_LIB_TIME = " lib_time " ;
    public static final String ORDERBYCOLUMNNAME_LIB_UPDATE_TIME = " lib_update_time " ;

    /*尾部友情链接显示的条数*/
    public static final int FRIENDLYLINKSCOUNT = 5;

    /*图书馆首页默认显示内容条数*/
    public static final int LIBRARYDISCOUNT = 9;
    /*微型图书馆-每月一讲-分类*/
    public static final String CATEGORY_LIBRARY_DAILY = "RrEvqi";
    /*微型图书馆-行业研究报告-分类*/
    public static final String CATEGORY_LIBRARY_HANGYEYANJIU_REPORT = "QRZrUb";
    /*微型图书馆-政研*/
    public static final String CATEGORY_LIBRARY_ZHENGYAN = "eaAr6j" ;
    /*微型图书馆-每月一讲|行业研究报告-分类--首页显示的条数*/
    public static final int CATEGORY_LIBRARY_LENGTITLE_LEN = 3 ;



    /*------------------邮件相关信息 -----------------------*/
    /**
     * 接收者
     */
    public static final String MAIL_TO = "MAIL_TO" ;
    /**
     * 接收者名称
     */
    public static final String MAIL_NICKNAME = "MAIL_NICKNAME" ;
    /**
     * 激活链接
     */
    public static final String MAIL_ACTIVE_URL = "MAIL_ACTIVEURL" ;
    /**
     * 激活随机码
     */
    public static final String MAIL_ACTIVE_RANDOM = "MAIL_ACTIVE_RANDOM" ;
}
