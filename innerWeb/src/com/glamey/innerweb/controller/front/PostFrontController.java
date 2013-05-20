package com.glamey.innerweb.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.*;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Post;
import com.glamey.innerweb.model.domain.PostReadInfo;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.PostQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

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
    private static ExecutorService executor = Executors.newFixedThreadPool(5);

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
        Post post = postDao.getByPostId(postId);
        mav.addObject("post", post);
        mav.addAllObjects(includeFront.linksEntrance(request, response, session));
        mav.addAllObjects(includeFront.friendlyLinks(request, response, session));

        //读过文章的人数
        List<UserInfo> postReadUserList = postReadInfoDao.getUserListByPostId(postId);
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        String userId = null;
        if (obj != null) {
            userId = ((UserInfo) obj).getUserId();
            postReadUserList.add(userInfoDao.getUserById(userId));
        }
        mav.addObject("postReadUserList", postReadUserList);


        //异步设置此内容已经被某人读过
        if (StringUtils.isNotBlank(userId)) {
            final PostReadInfo postReadInfo = new PostReadInfo();
            postReadInfo.setPostId(postId);
            postReadInfo.setUserId(userId);
            postReadInfo.setUserId(null);
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    postReadInfoDao.create(postReadInfo);
                }
            });
        } else {
            logger.info("[front] #postDetail#" + request.getRequestURI() + " 未获取到用户信息");
        }

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
        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        PostQuery query = new PostQuery();
        query.setCategoryType(categoryType);
        query.setCategoryId(categoryId);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<Post> postList = postDao.getByCategoryId(query);
        pageBean.setMaxRowCount(postDao.getCountByCategoryId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        Category categoryParent = categoryDao.getByAliasName(categoryType);
        Category category = categoryDao.getById(categoryId);

        mav.addObject("postList", postList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("category", category);

        mav.addAllObjects(includeFront.linksEntrance(request, response, session));
        mav.addAllObjects(includeFront.friendlyLinks(request, response, session));

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

        mav.addAllObjects(includeFront.linksEntrance(request, response, session));
        mav.addAllObjects(includeFront.friendlyLinks(request, response, session));

        return mav;
    }
}