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
    private MessageDao messageDao;
    @Resource
    private WebUploadUtils uploadUtils;

    //获取指定分来下的所有链接
    @RequestMapping(value = "/message-list.htm", method = RequestMethod.GET)
    public ModelAndView messageList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-message-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        int flag = WebUtils.getRequestParameterAsInt(request, "flag", -1);
        String from = WebUtils.getRequestParameterAsString(request, "from");
        String to = WebUtils.getRequestParameterAsString(request, "to");
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
    public ModelAndView messageShow(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        //TODO 获取到所有的部门及其下边的人数
        //session.getAttribute(Constants.SESSIN_USERID);
        mav.addObject("", "");
        mav.setViewName("mg/message/message-show");
        return mav;
    }

    @RequestMapping(value = "/message-create.htm", method = RequestMethod.POST)
    public ModelAndView messageCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");

        if (true) {
            mav.addObject("message", "links create success!");
        } else {
            mav.addObject("message", "links create failure!");
        }
        return mav;
    }
    //显示消息详情
    @RequestMapping(value = "/message-detail.htm", method = RequestMethod.GET)
    public ModelAndView messageDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String messageId = WebUtils.getRequestParameterAsString(request,"messageId");
        if(StringUtils.isBlank(messageId)){
            mav.addObject("message","操作无效");
            return mav ;
        }
        Message messageInfo = messageDao.getMessageById(messageId);
        mav.addObject("messageInfo",messageInfo);
        return mav;
    }

    @RequestMapping(value = "/message-pageOperate.htm",method = RequestMethod.GET)
    public ModelAndView messageOperation(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String opFlag = WebUtils.getRequestParameterAsString(request, "opFlag");
        String messagId = WebUtils.getRequestParameterAsString(request, "messageId");
        if (StringUtils.isNotBlank(opFlag) || StringUtils.isBlank(messagId)) {
            mav.addObject("messge", "操作无效");
            return mav;
        }
        try {
            String arrays[] = StringUtils.split(messagId, ",");
            for (String array : arrays) {
                //删除
                if (StringUtils.equals(opFlag, "1")) {
                    messageDao.messageOperation(opFlag, messagId);
                }
                //设置已读
                if (StringUtils.equals(opFlag, "2")) {
                    messageDao.messageOperation(opFlag, messagId);
                }
                //设置未读
                if (StringUtils.equals(opFlag, "3")) {
                    messageDao.messageOperation(opFlag, messagId);
                }
            }
            mav.addObject("message", "操作成功");
        } catch (Exception e) {
            mav.addObject("message", "操作失败");
        }
        return mav;
    }
}
