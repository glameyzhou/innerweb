package com.glamey.library.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.RegexUtils;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.PostDao;
import com.glamey.library.model.domain.Post;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.PostQuery;
import org.apache.commons.lang.StringUtils;
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
import java.util.List;

@Controller
public class PostFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(PostFrontController.class);

    @Resource
    private PostDao postDao;
    @Resource
    private IncludeFront includeFront;
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

        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));

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
    @RequestMapping(value = "/pl-news", method = RequestMethod.GET)
    public ModelAndView postList(
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

        List<Post> postList = postDao.getPostList(query);
        pageBean.setMaxRowCount(postDao.getCountPostList(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("postList", postList);
        mav.addObject("pageBean", pageBean);

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