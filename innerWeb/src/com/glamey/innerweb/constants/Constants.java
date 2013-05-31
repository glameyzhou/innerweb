package com.glamey.innerweb.constants;

/**
 * 
 * @author zy
 *
 */
public class Constants {

	/**
	 * 系统用户ID	session
	 */
	public static final String SESSIN_USERID = "SESSION_USERID" ;
	
	/**验证码**/
	public static final String VERIFYCODE = "VERIFYCODE" ;
    /**
     * 密钥
     */
    public static final String SECRET_KEY = "<glameyzhou>" ;

    /**
     * 每页显示的条数（针对前台）
     */
    public static final int rowsPerPageFront = 20 ;


    /*系统超级管理员角色ID*/
    public static final String sysAdminRoleId = "zA3eem" ;
    
    /**
     * 通告是否需要审核
     */
    public static int NOTICES_PERMIT = 1 ;

    public static final String ORDERBYDESC = " desc " ;
    public static final String ORDERBYASC = " asc " ;
    /*用户信息表-昵称拼音*/
    public static final String ORDERBYCOLUMNNAME_USER = " user_nicknamepinyin ";
    public static final String ORDERBYCOLUMNNAME_SHOWORDER = " user_showorder ";
}
