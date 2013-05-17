package com.glamey.innerweb.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.dao.MessageDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Links;
import com.glamey.innerweb.model.domain.Message;
import com.glamey.innerweb.model.domain.UploadInfo;
import com.glamey.innerweb.model.dto.LinksQuery;
import com.glamey.innerweb.model.dto.MessageQuery;
import com.glamey.innerweb.util.WebUploadUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * 站内信管理
 * Created with IntelliJ IDEA.
 * User: zy
 * Date: 13-5-4 上午12:08
 */
@Controller
@RequestMapping(value = "/mg/message")
public class MessageManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(MessageManagerController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private LinksDao linksDao;
    @Resource
    private MessageDao messageDao ;
    @Resource
    private WebUploadUtils uploadUtils;

    /*获取指定分来下的所有链接*/
    @RequestMapping(value = "/message-list.htm", method = RequestMethod.GET)
    public ModelAndView linksList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-message-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        int curPage = WebUtils.getRequestParameterAsInt(request,"curPage",1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        int flag = WebUtils.getRequestParameterAsInt(request,"flag",-1);
        String from = WebUtils.getRequestParameterAsString(request,"from");
        String to = WebUtils.getRequestParameterAsString(request,"to");
        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        MessageQuery query = new MessageQuery();
        query.setKeyword(keyword);
        query.setFrom(from);
        query.setTo(to);
        query.setFlag(flag);

        List<Message> messageList = messageDao.getMessageList(query);
        pageBean.setMaxRowCount(messageDao.getCountMessageList(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("messageList", messageList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.setViewName("mg/message/message-list");
        return mav;
    }

    @RequestMapping(value = "/message-show.htm", method = RequestMethod.GET)
    public ModelAndView linksShow(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        //TODO 获取到所有的部门及其下边的人数
        //session.getAttribute(Constants.SESSIN_USERID);
        mav.addObject("","");
        mav.setViewName("mg/message/message-show");
        return mav;
    }

    @RequestMapping(value = "/message-create.htm", method = RequestMethod.POST)
    public ModelAndView linksCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");

        if (true) {
            mav.addObject("message", "links create success!");
        } else {
            mav.addObject("message", "links create failure!");
        }
        return mav;
    }

    /*链接删除*/
    @RequestMapping(value = "/{aliasName}/links-del.htm", method = RequestMethod.GET)
    public ModelAndView linksDel(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        if (StringUtils.isBlank(linksId)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        try {
            String linksIdArray[] = StringUtils.split(linksId, ",");
            for (String s : linksIdArray) {
                logger.info("[links-del] linksId=" + s + linksDao.deleteById(s));
            }
            mav.addObject("message", "delete the links success!");
        } catch (Exception e) {
            logger.info("[links-del] error " + e);
            mav.addObject("message", "delete the links failure!");
        }
        mav.addObject("categoryParent", categoryParent);
        return mav;
    }

}
