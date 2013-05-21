package com.glamey.innerweb.controller.front;

import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.dao.MetaInfoDao;
import com.glamey.innerweb.dao.PostDao;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.PostDTO;
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
    @Resource
    private MetaInfoDao metaInfoDao;
    @Resource
    private IncludeFront includeFront;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #index#");
        ModelAndView mav = new ModelAndView("front/index");

        //集团、院系入口
        mav.addAllObjects(includeFront.linksEntrance(request, response, session));
        //常用链接
        mav.addObject(SystemConstants.popular_Links,includeFront.getMetaByName(SystemConstants.popular_Links));

        //四个板块
        //第一板块
        List<PostDTO> area1PostDTOList = postDao.getDtoByMetaName(SystemConstants.AREA_1);
        mav.addObject("area1PostDTOList", area1PostDTOList);


        //第二板块
        List<PostDTO> area2PostDTOList = postDao.getDtoByMetaName(SystemConstants.AREA_2);
        mav.addObject("area2PostDTOList", area2PostDTOList);

        //第三板块
        List<PostDTO> area3PostDTOList = postDao.getDtoByMetaName(SystemConstants.AREA_3);
        mav.addObject("area3PostDTOList", area3PostDTOList);

        //第四板块
        List<PostDTO> area4PostDTOList = postDao.getDtoByMetaName(SystemConstants.AREA_4);
        mav.addObject("area4PostDTOList", area4PostDTOList);

        //友情链接
        mav.addAllObjects(includeFront.friendlyLinks(request, response, session));

        //常用链接
        mav.addObject(SystemConstants.page_foot,includeFront.getMetaByName(SystemConstants.page_foot));
        return mav;
    }
}