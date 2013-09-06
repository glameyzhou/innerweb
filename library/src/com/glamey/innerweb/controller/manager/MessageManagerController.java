package com.glamey.innerweb.controller.manager;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.dao.MessageDao;
import com.glamey.innerweb.dao.UserInfoDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Message;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.MessageDTO;
import com.glamey.innerweb.model.dto.MessageQuery;
import com.glamey.innerweb.model.dto.UserQuery;
import com.glamey.innerweb.util.WebUploadUtils;

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
    @Resource
    private UserInfoDao userInfoDao;


    //获取指定分来下的所有链接
    @RequestMapping(value = "/message-list.htm", method = RequestMethod.GET)
    public ModelAndView messageList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-message-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        UserInfo userInfo = (UserInfo) obj;

        int flag = WebUtils.getRequestParameterAsInt(request, "flag", -1);
        String from = WebUtils.getRequestParameterAsString(request, "from");
        String to = userInfo.getUserId();
        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        MessageQuery query = new MessageQuery();
        query.setKeyword(keyword);
        query.setFrom(from);
        query.setTo(to);
        query.setFlag(flag);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

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
        List<MessageDTO> messageDTOs = new ArrayList<MessageDTO>();
        Category deptCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        List<Category> deptList = categoryDao.getByParentId(deptCategory.getId(), deptCategory.getCategoryType(), 0, Integer.MAX_VALUE);
        MessageDTO dto = null;
        for (Category category : deptList) {
            UserQuery query = new UserQuery();
            query.setDeptId(category.getId());
            query.setStart(0);
            query.setNum(Integer.MAX_VALUE);
            List<UserInfo> userInfoList = userInfoDao.getUserList(query);

            dto = new MessageDTO();
            dto.setCategory(category);
            dto.setUserInfoList(userInfoList);

            messageDTOs.add(dto);
        }
        mav.addObject("messageDTOs", messageDTOs);
        mav.setViewName("mg/message/message-show");
        return mav;
    }

    @RequestMapping(value = "/message-create.htm", method = RequestMethod.POST)
    public ModelAndView messageCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String items [] = WebUtils.getRequestParameterAsStringArrs(request, "sltTarget");
        String title = WebUtils.getRequestParameterAsString(request,"title");
        String content = WebUtils.getRequestParameterAsString(request,"content");
        if(items == null || items.length == 0){
            mav.addObject("message","接收人不能为空");
            return mav ;
        }
        if(StringUtils.isBlank(title)){
            mav.addObject("message","标题不能为空");
            return mav ;
        }
        if(StringUtils.isBlank(content)){
            mav.addObject("message","内容不能为空");
            return mav ;
        }
        Message message = new Message();
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        UserInfo userInfo = (UserInfo) obj;
        message.setFrom(userInfo.getUserId());
        message.setTitle(title);
        message.setContent(content);
        message.setTos(items);
        //flag 1=delete 2=do not read 3=read
        message.setFlag(2);
        if (messageDao.create(message)) {
            mav.addObject("message", "发送成功!");
            mav.addObject("href", "mg/message/message-list.htm");
        } else {
            mav.addObject("message", "发送失败!");
        }
        return mav;
    }

    //显示消息详情
    @RequestMapping(value = "/message-detail.htm", method = RequestMethod.GET)
    public ModelAndView messageDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String messageId = WebUtils.getRequestParameterAsString(request, "messageId");
        if (StringUtils.isBlank(messageId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        messageDao.setRead(messageId);
        Message messageInfo = messageDao.getMessageById(messageId);
        mav.addObject("messageInfo", messageInfo);
        mav.setViewName("mg/message/message-detail");
        return mav;
    }

    @RequestMapping(value = "/message-pageOperate.htm", method = RequestMethod.GET)
    public ModelAndView messageOperation(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String opFlag = WebUtils.getRequestParameterAsString(request, "opFlag");
        String messagId = WebUtils.getRequestParameterAsString(request, "messageId");
        if (StringUtils.isBlank(opFlag) || StringUtils.isBlank(messagId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        /*opFlag 1=删除 2=未读 3 已读*/
        try {
            String arrays[] = StringUtils.split(messagId, ",");
            for (String array : arrays) {
                //删除
                if (StringUtils.equals(opFlag, "1")) {
                    messageDao.del(array);
                }
                //设置未读
                if (StringUtils.equals(opFlag, "2")) {
                    messageDao.setNotRead(array);
                }
                //设置已读
                if (StringUtils.equals(opFlag, "3")) {
                    messageDao.setRead(array);
                }
            }
            mav.addObject("message", "操作成功");
            mav.addObject("href", "mg/message/message-list.htm");
        } catch (Exception e) {
            mav.addObject("message", "操作失败");
        }
        return mav;
    }
}
