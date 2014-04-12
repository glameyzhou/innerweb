package com.glamey.chec_cn.constants;


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


    /*------------------列表排序 -----------------------*/
    public static final String ORDERBYDESC = " desc ";
    public static final String ORDERBYASC = " asc ";
    public static final String ORDERBYCOLUMNNAME_USER = " user_nicknamepinyin ";
    public static final String ORDERBYCOLUMNNAME_SHOWORDER = " user_showorder ";

    public static final String ORDERBYCOLUMNNAME_POST_PUBLIS_TIME = " post_publish_time " ;
    public static final String ORDERBYCOLUMNNAME_POST_UPDATE_TIME = " post_update_time " ;
    public static final String ORDERBYCOLUMNNAME_POST_ORDER = " post_order " ;
    public static final String ORDERBYCOLUMNNAME_POST_TOPORDER = " post_toporder " ;



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
