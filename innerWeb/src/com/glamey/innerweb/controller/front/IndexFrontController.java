package com.glamey.innerweb.controller.front;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.framework.utils.HttpConnection;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.tld.StringTld;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.MetaInfoDao;
import com.glamey.innerweb.dao.PostDao;
import com.glamey.innerweb.model.domain.MetaInfo;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.PostDTO;

@Controller
public class IndexFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(IndexFrontController.class);

    @Resource
    private PostDao postDao;
    @Resource
    private MetaInfoDao metaInfoDao;
    @Resource
    private IncludeFront includeFront;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #index#");
        ModelAndView mav = new ModelAndView("front/index");
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        UserInfo userInfo = (UserInfo) obj;

        //集团、院系入口
        mav.addAllObjects(includeFront.linksEntrance());
        //常用链接
        mav.addAllObjects(includeFront.ofenLinks());

        //未读站内信
        mav.addObject("unReadMessage", includeFront.unReadMessage(userInfo.getUserId()));

        //关于各部门通告是否显示所有人看
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
                } else {
                    whoCanSee = userInfo.getDeptId();
                }
            }
        }
        //四个板块
        //第一板块
        List<PostDTO> area1PostDTOList = postDao.getDtoByMetaName(SystemConstants.AREA_1, whoCanSee);
        mav.addObject("area1PostDTOList", area1PostDTOList);


        //第二板块
        List<PostDTO> area2PostDTOList = postDao.getDtoByMetaName(SystemConstants.AREA_2, whoCanSee);
        mav.addObject("area2PostDTOList", area2PostDTOList);

        //第三板块
        List<PostDTO> area3PostDTOList = postDao.getDtoByMetaName(SystemConstants.AREA_3, whoCanSee);
        mav.addObject("area3PostDTOList", area3PostDTOList);

        //第四板块
        List<PostDTO> area4PostDTOList = postDao.getDtoByMetaName(SystemConstants.AREA_4, whoCanSee);
        mav.addObject("area4PostDTOList", area4PostDTOList);

        //友情链接
        mav.addAllObjects(includeFront.friendlyLinks(request));

        //尾部页面
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));
        return mav;
    }
}