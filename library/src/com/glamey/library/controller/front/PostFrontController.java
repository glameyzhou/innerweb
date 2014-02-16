package com.glamey.library.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.RegexUtils;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.AccessLogDao;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.PostDao;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.Post;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.PostQuery;
import com.glamey.library.util.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
public class PostFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(PostFrontController.class);

    @Resource
    private PostDao postDao;
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private IncludeFront includeFront;
    @Resource
    private AccessLogDao accessLogDao;
    //新建一个静态的线程池
//    private static ExecutorService executor = Executors.newFixedThreadPool(5);

    /**
     * 文章内容详情
     *
     * @param postId
     * @param request
     * @param response
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/p-{postId}.htm", method = RequestMethod.GET)
    public ModelAndView postDetail(
            @PathVariable String postId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[front] #postDetail#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/post-detail");
        if (StringUtils.isBlank(postId)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("common/errorPage");
            return mav;
        }
        Post post = postDao.getByPostId(postId);
        mav.addObject("post", post);

        Category category = categoryDao.getById(post.getCategoryId());
        mav.addObject("category", category);

        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));

        accessLogDao.save("p-" + postId + ".htm",post.getTitle(),post.getCategoryId(),session);
        return mav;
    }

    /**
     * 文章分类列表
     *
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/post-{categoryId}.htm", method = RequestMethod.GET)
    public ModelAndView postList(
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/post-list");
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));
        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        PostQuery query = new PostQuery();
        query.setIsValid(1);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        query.setCategoryId(categoryId);

        List<Post> postList = postDao.getPostList(query);
        pageBean.setMaxRowCount(postDao.getCountPostList(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        Category category = categoryDao.getById(categoryId);

        mav.addObject("postList", postList);
        mav.addObject("category", category);
        mav.addObject("pageBean", pageBean);

        accessLogDao.save("post-" + category.getId() + ".htm","分类" + category.getName() + "列表",category.getId(),session);

        return mav;
    }
    /**
     * 首页通知公告的弹出层
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/post-popdiv.htm", method = RequestMethod.GET)
    public ModelAndView postPopDivv(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postPopDivv#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/include/post-list-popdiv");

        PostQuery query = new PostQuery();
        query.setIsValid(1);
        query.setStartTime(DateFormatUtils.format(DateUtils.getDay(new Date(),-7),"yyyy-MM-dd HH:mm:ss"));
        query.setEndTime(DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
        query.setStart(0);
        query.setNum(15);
        query.setCategoryId(CategoryConstants.CATEGORY_TONGZHIGONGGAO);

        List<Post> postList = postDao.getPostList(query);
        mav.addObject("postList", postList);

        return mav;
    }

    //规章制度下载
    @ResponseBody
    @RequestMapping(value = "/rules-download-{id}.htm", method = RequestMethod.GET)
    public ModelAndView rulesDownload(
            @PathVariable String id,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #rootPostList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/post-rules-download");
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        String userId = ((UserInfo) obj).getUserId();
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("common/errorPage");
            //固定内容
            mav.addAllObjects(includeFront.allInclude(request,response,session));
            return mav;
        }

        Post post = postDao.getByPostId(id);

        if (post != null && StringUtils.isNotBlank(post.getContent())) {
            String content = post.getContent();
            List<String> rulesList = RegexUtils.getStringGoup1(content, "<a href=\"(.+?)\"\\s*target");
            if (rulesList != null && rulesList.size() > 0) {
                String downLoadURL = rulesList.get(0);
                String basePath = request.getScheme() + "://" + request.getServerName() + "" + (request.getServerPort() == 80 ? "" : ":" + request.getServerPort());
                String realPath = basePath + downLoadURL;
                System.out.println(realPath);
                try {
                    response.sendRedirect(realPath);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
}