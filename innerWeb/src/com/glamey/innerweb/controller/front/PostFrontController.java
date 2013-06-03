package com.glamey.innerweb.controller.front;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.RegexUtils;
import com.glamey.framework.utils.WebUtils;
import com.glamey.framework.utils.tld.StringTld;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.dao.MetaInfoDao;
import com.glamey.innerweb.dao.PostDao;
import com.glamey.innerweb.dao.PostReadInfoDao;
import com.glamey.innerweb.dao.UserInfoDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.MetaInfo;
import com.glamey.innerweb.model.domain.Post;
import com.glamey.innerweb.model.domain.PostReadInfo;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.PostQuery;

@Controller
public class PostFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(PostFrontController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private PostDao postDao;
    @Resource
    private LinksDao linksDao;
    @Resource
    private MetaInfoDao metaInfoDao;
    @Resource
    private IncludeFront includeFront;
    @Resource
    private PostReadInfoDao postReadInfoDao;
    @Resource
    private UserInfoDao userInfoDao;
    //新建一个静态的线程池
//    private static ExecutorService executor = Executors.newFixedThreadPool(5);

    /**
     * 文章内容详情
     *
     * @param postId
     * @param request
     * @param response
     * @param session
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/p-{postId}.htm", method = RequestMethod.GET)
    public ModelAndView postDetail(
            @PathVariable String postId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #postDetail#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/post-detail");
        if (StringUtils.isBlank(postId)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("front/404");
            return mav;
        }
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        String userId = ((UserInfo) obj).getUserId();

        Post post = postDao.getByPostId(postId);
        mav.addObject("post", post);

        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks(request));
        mav.addObject("unReadMessage", includeFront.unReadMessage(userId));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));

        //插入已读
        final PostReadInfo postReadInfo = new PostReadInfo();
        postReadInfo.setPostId(postId);
        postReadInfo.setUserId(userId);
        postReadInfoDao.create(postReadInfo);

        //读过文章的人数
        List<UserInfo> postReadUserList = postReadInfoDao.getUserListByPostId(postId);
        mav.addObject("postReadUserList", postReadUserList);

        return mav;
    }

    /**
     * 文章分类列表
     *
     * @param categoryType
     * @param categoryId
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/pl-{categoryType}-{categoryId}.htm", method = RequestMethod.GET)
    public ModelAndView postList(
            @PathVariable String categoryType,
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/post-list");
        if (StringUtils.isBlank(categoryType) || StringUtils.isBlank(categoryId)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("front/404");
            return mav;
        }
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        UserInfo userInfo = (UserInfo) obj;
        String userId = userInfo.getUserId();

        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        PostQuery query = new PostQuery();
        query.setCategoryType(categoryType);
        query.setCategoryId(categoryId);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        Category categoryParent = categoryDao.getByAliasName(categoryType);
        Category category = categoryDao.getById(categoryId);

        //如果是各部门通知的话，需要看下是否显示搜有的内容
        if (StringUtils.equalsIgnoreCase(category.getAliasName(), CategoryConstants.CATEGORY_ALLNOTICES)) {
            MetaInfo noticeCanSee = metaInfoDao.getByName(SystemConstants.notices_can_see);
            MetaInfo noticesRoleInfo = metaInfoDao.getByName(SystemConstants.notices_who_can_see);
            //部门ID
            String whoCanSee = null;
            if (StringUtils.equalsIgnoreCase(noticeCanSee.getValue(), "0")) {
                whoCanSee = userInfo.getDeptId();
            } else {
                String roleIds = noticesRoleInfo.getValue();
                if (StringUtils.isNotBlank(roleIds)) {
                    String arrays[] = StringUtils.split(roleIds, ",");
                    if (StringTld.hasRights(Arrays.asList(arrays), userInfo.getRoleId())) {
                        whoCanSee = null; //查看所有的部门下文章
                    }
                    else{
                        whoCanSee = userInfo.getDeptId() ;
                    }
                }
            }
            query.setSource(whoCanSee);
        }
        List<Post> postList = postDao.getByCategoryId(query);
        pageBean.setMaxRowCount(postDao.getCountByCategoryId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();


        mav.addObject("postList", postList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("category", category);

        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks(request));
        mav.addObject("unReadMessage", includeFront.unReadMessage(userId));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));

        return mav;
    }

    /**
     * 根目录数据列表
     *
     * @param categoryType
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/rl-{categoryType}.htm", method = RequestMethod.GET)
    public ModelAndView rootPostList(
            @PathVariable String categoryType,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #rootPostList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/post-root-list");
        if (StringUtils.isBlank(categoryType)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("front/404");
            return mav;
        }

        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        String userId = ((UserInfo) obj).getUserId();


        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        PostQuery query = new PostQuery();
        query.setCategoryType(categoryType);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<Post> postList = postDao.getByCategoryId(query);
        pageBean.setMaxRowCount(postDao.getCountByCategoryId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        Category categoryParent = categoryDao.getByAliasName(categoryType);

        mav.addObject("postList", postList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("categoryParent", categoryParent);

        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks(request));
        mav.addObject("unReadMessage", includeFront.unReadMessage(userId));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));

        return mav;
    }
    
    //规章制度
    @RequestMapping(value = "/rules-news-{categoryId}.htm", method = RequestMethod.GET)
    public ModelAndView rulesList(
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #rootPostList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/post-rules-list");
        if (StringUtils.isBlank(categoryId)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("front/404");
            return mav;
        }

        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        String userId = ((UserInfo) obj).getUserId();

        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        PostQuery query = new PostQuery();
        query.setCategoryType(CategoryConstants.CATEGORY_NEWS);
        query.setCategoryId(categoryId);
        query.setShowIndex(1);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<Post> postList = postDao.getByCategoryId(query);
        pageBean.setMaxRowCount(postDao.getCountByCategoryId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        Category category = categoryDao.getById(categoryId);
        
        mav.addObject("postList", postList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("category", category);

        //固定内容
        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks(request));
        mav.addObject("unReadMessage", includeFront.unReadMessage(userId));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));

        return mav;
    }
    //规章制度
    @ResponseBody
    @RequestMapping(value = "/rules-download-{id}.htm", method = RequestMethod.GET)
    public ModelAndView rulesDownload(
    		@PathVariable String id,
    		HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	logger.info("[front] #rootPostList#" + request.getRequestURI());
    	ModelAndView mav = new ModelAndView("front/post-rules-download");
    	Object obj = session.getAttribute(Constants.SESSIN_USERID);
    	String userId = ((UserInfo) obj).getUserId();
    	if (StringUtils.isBlank(id)) {
    		mav.addObject("message", "操作无效");
    		mav.setViewName("front/404");
    		//固定内容
        	mav.addAllObjects(includeFront.linksEntrance());
        	mav.addAllObjects(includeFront.friendlyLinks(request));
        	mav.addObject("unReadMessage", includeFront.unReadMessage(userId));
        	mav.addAllObjects(includeFront.ofenLinks());
        	mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));
    		return mav;
    	}
    	
    	Post post = postDao.getByPostId(id);
    	
    	if(post != null && StringUtils.isNotBlank(post.getContent())){
    		String content = post.getContent();
    		List<String> rulesList = RegexUtils.getStringGoup1(content, "<a href=\"(.+?)\"\\s*target");
    		if(rulesList != null && rulesList.size() > 0){
    			String downLoadURL = rulesList.get(0);
    			String basePath = request.getScheme() + "://" + request.getServerName() + "" + (request.getServerPort() == 80 ? "" : ":" + request.getServerPort()) ;
    			String realPath = basePath + downLoadURL ;
                System.out.println(realPath);
                try {
                    response.sendRedirect(realPath);
                } catch (IOException e) {
                    e.printStackTrace();
                }
                /*try {
    				String baseName = FilenameUtils.getBaseName(realPath);
    				String extension = FilenameUtils.getExtension(realPath);
    				String fileName = baseName + "." + extension ;
    				response.reset();//可以加也可以不加  
    				response.setHeader("Content-disposition","attachment; filename="+new String(fileName.getBytes("UTF-8"),"iso8859-1"));
    				response.setHeader("Content-disposition","attachment; filename="+URLEncoder.encode(fileName, "UTF-8")); //
    				
					ServletOutputStream sos = response.getOutputStream();
    				URL url = new URL(realPath);
					URLConnection conn = url.openConnection();
					InputStream is = conn.getInputStream();
				    byte[] buff = new byte[2048]; 
				    int len = 0; 
				    while((is.read(buff, 0, buff.length)) > -1){
				    	sos.write(buff, 0, len);
				    	sos.flush();
				    }
				    is.close();
				    sos.close();
				} catch (MalformedURLException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}*/
    		}
    	}
    	return null;
    }
}