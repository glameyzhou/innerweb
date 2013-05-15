package com.glamey.innerweb.controller.front;

import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.dao.PostDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Post;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class IndexFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(IndexFrontController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private PostDao postDao;
    @Resource
    private LinksDao linksDao;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #index#");
        ModelAndView mav = new ModelAndView("front/index");
        /**
         * 1、用户信息
         * 2、用户消息
         * 3、通知(公司、部门)
         * 4、新闻分类内容列表
         * 5、快捷入口(总院、集团)
         * 6、友情链接
         * 7、页尾(footer)
         */
        List<Category> categoryList = categoryDao.getByParentId("0", CategoryConstants.CATEGORY_NEWS, 0, Integer.MAX_VALUE);
        for (Category category : categoryList) {
            System.out.println(category);
        }
        return mav;
    }
}