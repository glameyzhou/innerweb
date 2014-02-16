package com.glamey.library.controller.manager;

import com.glamey.framework.utils.*;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.*;
import com.glamey.library.model.domain.*;
import com.glamey.library.model.dto.BBSPostQuery;
import com.glamey.library.model.dto.BBSReplyQuery;
import com.glamey.library.model.dto.LibraryQuery;
import com.glamey.library.util.DateUtils;
import com.glamey.library.util.WebUploadUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 论坛帖子后台管理
 * <p/>
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/mg/bbs")
public class BBSPostManagerController extends BaseController {

    private static final Logger logger = Logger.getLogger(BBSPostManagerController.class);
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private LibraryInfoDao libraryDao;
    @Resource
    private WebUploadUtils uploadUtils;
    @Resource
    private BBSPostDao bbsPostDao;
    @Resource
    private BBSReplyDao bbsReplyDao;
    @Resource
    private UserInfoDao userInfoDao;

    /*所有主帖*/
    @RequestMapping(value = "/post-list.htm", method = RequestMethod.GET)
    public ModelAndView postList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/bbs/post-list");

        pageBean = new PageBean();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        Category category = categoryDao.getBySmpleId(categoryId);

        int showTop = WebUtils.getRequestParameterAsInt(request,"showTop",-1);
        int showGreat = WebUtils.getRequestParameterAsInt(request,"showGreat",-1);
        int showPopular = WebUtils.getRequestParameterAsInt(request,"showPopular",-1);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        /*String today = DateFormatUtils.format(new Date(),"yyyy-MM-dd");
        String startTime = WebUtils.getRequestParameterAsString(request, "startTime", today + " 00:00:00");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime",today + " 23:59:59");*/

        String startTime = WebUtils.getRequestParameterAsString(request, "startTime");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime");

        BBSPostQuery query = new BBSPostQuery();
        query.setCategoryId(categoryId);
        query.setShowTop(showTop);
        query.setShowGreat(showGreat);
        query.setShowPopular(showPopular);
        query.setKw(keyword);
        query.setPublishStartTime(startTime);
        query.setPublishEndTime(endTime);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<BBSPost> bbsPostList = bbsPostDao.getByQuery(query);
        pageBean.setMaxRowCount(bbsPostDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("bbsPostList", bbsPostList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.addObject("category", category);
        return mav;
    }

    /*设置主帖的删除、置顶、精华等等操作*/
    @RequestMapping(value = "/post-setSelectContent.htm", method = RequestMethod.GET)
    public ModelAndView setSelectContent(HttpServletRequest request) {
        //type=delete,showTop,showGreat
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        String postIds = WebUtils.getRequestParameterAsString(request, "id");
        String type = WebUtils.getRequestParameterAsString(request,"type");
        String itemValue = WebUtils.getRequestParameterAsString(request,"itemValue");

        if (StringUtils.isBlank(itemValue) || StringUtils.isBlank(postIds) || StringUtils.isBlank(type)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        String arrays [] = StringUtils.split(postIds,",");
        if(arrays == null || arrays.length == 0){
            mav.addObject("message", "请选择您需要操作的主帖");
            return mav;
        }
        try {
            //删除
            if (StringUtils.equals(type,"delete")) {
                for (String id : arrays) {
                    logger.info(String.format("[bbs] post-delete postId=%s,result=%s",id,bbsPostDao.deleteById(id)));
                }
            }
            //置顶、精华
            else {
                logger.info(String.format("[bbs] post-setUpdateProperties postIds=%s,type=%s,itemValue=%s",
                        Arrays.deepToString(arrays),type,itemValue,
                        bbsPostDao.update(Arrays.asList(arrays),type,Integer.valueOf(itemValue))));
            }

            mav.addObject("message", "操作成功");
            mav.addObject("href", "mg/bbs/post-list.htm?categoryId=" + categoryId);

        } catch (Exception e) {
            mav.addObject("message", "设置失败");
            logger.error(String.format("[bbs] post-setUpdateProperties error,postIds=%s,type=%s,itemValue=%s",
                    Arrays.deepToString(arrays),type,itemValue),e);
        }
        return mav;
    }

    /*版主列表*/
    @RequestMapping(value = "/brand-manager.htm", method = RequestMethod.GET)
    public ModelAndView brandManagerShow() {
        ModelAndView mav = new ModelAndView("mg/bbs/brand-manager");
        UserInfo userInfo1 = bbsPostDao.getBBSManager(CategoryConstants.CATEGORY_BBS_MEITANQINGJIELIYONG);
        UserInfo userInfo2 = bbsPostDao.getBBSManager(CategoryConstants.CATEGORY_BBS_QUYUNENGYUAN);

        Category category1 = categoryDao.getBySmpleId(CategoryConstants.CATEGORY_BBS_MEITANQINGJIELIYONG);
        Category category2 = categoryDao.getBySmpleId(CategoryConstants.CATEGORY_BBS_QUYUNENGYUAN);
        mav.addObject("userInfo1",userInfo1);
        mav.addObject("userInfo2",userInfo2);
        mav.addObject("category1",category1);
        mav.addObject("category2",category2);
        return mav;
    }

    /*设置版主*/
    @RequestMapping(value = "/brand-manager-set.htm", method = RequestMethod.GET)
    public ModelAndView brandManagerSet(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");

        String brandId = WebUtils.getRequestParameterAsString(request,"brandId");
        String userId = WebUtils.getRequestParameterAsString(request,"userId");

        UserInfo userInfo = userInfoDao.getUserSimpleById(userId);
        Category category = categoryDao.getBySmpleId(brandId);

        String msg = bbsPostDao.setBBSManager(brandId,userId) ? "成功" : "失败";
        mav.addObject("message", "设置 " + userInfo.getNickname() + " 为 " + category.getName() + " 版主" + msg);
        mav.addObject("href", "mg/bbs/brand-manager.htm");

        return mav;
    }

    /*主帖-回帖列表*/
    @RequestMapping(value = "/reply-list.htm", method = RequestMethod.GET)
    public ModelAndView replyLis(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/bbs/reply-list");

        String postId = WebUtils.getRequestParameterAsString(request,"postId");
        BBSPost bbsPost = bbsPostDao.getPostById(postId);

        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        Category category = categoryDao.getBySmpleId(categoryId);

        pageBean = new PageBean();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        /*String today = DateFormatUtils.format(new Date(),"yyyy-MM-dd");
        String startTime = WebUtils.getRequestParameterAsString(request, "startTime", today + " 00:00:00");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime",today + " 23:59:59");*/
        String startTime = WebUtils.getRequestParameterAsString(request, "startTime");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime");

        BBSReplyQuery query = new BBSReplyQuery();
        query.setPostId(postId);
        query.setKw(keyword);
        query.setPublishStartTime(startTime);
        query.setPublishEndTime(endTime);
        query.setKw(keyword);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<BBSReply> bbsReplyList = bbsReplyDao.getByQuery(query);
        pageBean.setMaxRowCount(bbsReplyDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("bbsReplyList", bbsReplyList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.addObject("category", category);
        mav.addObject("bbsPost", bbsPost);
        return mav;
    }
    /*设置回帖内容*/
    @RequestMapping(value = "/reply-setSelectContent.htm", method = RequestMethod.GET)
    public ModelAndView replySetSelectContent(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        String replyIds = WebUtils.getRequestParameterAsString(request, "replyId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");

        if (StringUtils.isBlank(categoryId) || StringUtils.isBlank(replyIds) || StringUtils.isBlank(postId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        String arrays [] = StringUtils.split(replyIds,",");
        if(arrays == null || arrays.length == 0){
            mav.addObject("message", "请选择您需要操作的帖子");
            return mav;
        }
        try {
            //删除
            for (String id : arrays) {
                logger.info(String.format("[bbs] reply-delete categoryId=%s,replyId=%s,postId=%s,result=%s",categoryId,id,postId,bbsReplyDao.deleteById(id,postId)));
            }

            mav.addObject("message", "删除成功");
            mav.addObject("href", "mg/bbs/reply-list.htm?categoryId=" + categoryId + "&postId=" +  postId);

        } catch (Exception e) {
            mav.addObject("message", "设置失败");
            logger.error(String.format("[bbs] reply-delete categoryId=%s,replyIds=%s,postId=%s",categoryId,replyIds,postId),e);
        }
        return mav;
    }

    /*主帖-修改界面*/
    @RequestMapping(value = "/post-show.htm", method = RequestMethod.GET)
    public ModelAndView postShow(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/bbs/post-show");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        Category category = categoryDao.getBySmpleId(categoryId);
        BBSPost bbsPost = bbsPostDao.getPostById(postId);

        mav.addObject("category", category);
        mav.addObject("bbsPost", bbsPost);
        return mav;
    }

    /*主帖-修改*/
    @RequestMapping(value = "/post-update.htm", method = RequestMethod.POST)
    public ModelAndView postUpdate(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        try {
            String title = WebUtils.getRequestParameterAsString(request,"title");
            String userId = WebUtils.getRequestParameterAsString(request,"userId");
            String publishTime = WebUtils.getRequestParameterAsString(request,"publishTime");
//        String updateTime = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
            int showTop = WebUtils.getRequestParameterAsInt(request, "showTop", 0);
            int showGreat = WebUtils.getRequestParameterAsInt(request,"showGreat",0);
            String content = WebUtils.getRequestParameterAsString(request,"content");

            BBSPost bbsPost = bbsPostDao.getPostById(postId);
            bbsPost.setTitle(title);
            bbsPost.setUserId(userId);
            bbsPost.setPublishTime(DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));
            bbsPost.setUpdateTime(new Date());
            bbsPost.setShowTop(showTop);
            bbsPost.setShowGreat(showGreat);
            bbsPost.setContent(content);

            bbsPostDao.update(bbsPost);
            mav.addObject("message", "修改成功");
            mav.addObject("href", "mg/bbs/post-list.htm?categoryId=" + categoryId);
        } catch (Exception e) {
            mav.addObject("message", "修改失败");
            logger.error(String.format("[bbs] post-update error categoryId=%s,postId=%s",categoryId,postId),e);
        }
        return mav;
    }

    /*回帖-修改界面*/
    @RequestMapping(value = "/reply-show.htm", method = RequestMethod.GET)
    public ModelAndView replyShow(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/bbs/reply-show");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        String replyId = WebUtils.getRequestParameterAsString(request, "replyId");
        Category category = categoryDao.getBySmpleId(categoryId);
        BBSPost bbsPost = bbsPostDao.getPostById(postId);
        BBSReply bbsReply = bbsReplyDao.getReplyById(replyId);

        mav.addObject("category", category);
        mav.addObject("bbsPost", bbsPost);
        mav.addObject("bbsReply", bbsReply);
        return mav;
    }

    /*回帖-修改*/
    @RequestMapping(value = "/reply-update.htm", method = RequestMethod.POST)
    public ModelAndView replyUpdate(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        String replyId = WebUtils.getRequestParameterAsString(request, "replyId");
        try {
            String publishTime = WebUtils.getRequestParameterAsString(request,"publishTime");
//        String updateTime = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
            String content = WebUtils.getRequestParameterAsString(request,"content");

            BBSReply bbsReply = bbsReplyDao.getReplyById(replyId);
            bbsReply.setPublishTime(DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));
            bbsReply.setUpdateTime(new Date());
            bbsReply.setContent(content);

            bbsReplyDao.update(bbsReply);
            mav.addObject("message", "修改成功");
            mav.addObject("href", "mg/bbs/reply-list.htm?categoryId=" + categoryId + "&postId=" + postId);
        } catch (Exception e) {
            mav.addObject("message", "修改失败");
            logger.error(String.format("[bbs] post-update error categoryId=%s,postId=%s,replyId=%s",categoryId,postId,replyId),e);
        }
        return mav;
    }

    /*通过父类获取所有的子类信息*/
    @ResponseBody
    @RequestMapping(value = "/getCateListBypid.htm", method = RequestMethod.GET)
    public void getCategoryListByPid(HttpServletRequest request, HttpServletResponse response) {
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String cateId = WebUtils.getRequestParameterAsString(request,"cateId");
        List<Category> categoryList = null;
        if (StringUtils.isNotBlank(pid)) {
            categoryList = categoryDao.getByParentId(pid, CategoryConstants.CATEGORY_LIBRARY, 0, Integer.MAX_VALUE);
        } else {
            categoryList = new ArrayList<Category>();
        }
        StringBuffer source = new StringBuffer();
        for (Category category : categoryList) {
            source.append("<option value=\"").append(category.getId()).append("\"")
                    .append(StringUtils.equals(cateId,category.getId()) ? " selected=\"selected\" " : "")
                    .append(">").append(category.getName()).append("</option>");
        }
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.getWriter().print(source);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/library-create.htm", method = RequestMethod.POST)
    public ModelAndView libraryCreate(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");

        int showIndex = WebUtils.getRequestParameterAsInt(request,"showIndex",-1);
        int type = WebUtils.getRequestParameterAsInt(request, "type", 1);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");

        LibraryInfo lib = new LibraryInfo();
        lib.setType(type);
        lib.setCategoryId(categoryId);
        lib.setShowIndex(showIndex);
        String time = WebUtils.getRequestParameterAsString(request, "time");
        if (StringUtils.isBlank(time))
            time = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
        java.text.DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            lib.setTime(format.parse(time));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        if (StringUtils.isBlank(categoryId)) {
            mav.addObject("message", "分类不能为空");
            return mav;
        }

        String orderString = WebUtils.getRequestParameterAsString(request,"order");
        if(StringUtils.isBlank(orderString) || !orderString.matches("\\d+")){
            mav.addObject("message", "排序不能为空，且为数字");
            return mav;
        }
        lib.setOrder(Integer.valueOf(orderString));
        lib.setShowFocusimage(WebUtils.getRequestParameterAsInt(request,"showFouceImage",0)); /*是否显示焦点图*/
        lib.setShowSugguest(WebUtils.getRequestParameterAsInt(request,"showSugguest",1));

        if (type == 1) {
            String name = WebUtils.getRequestParameterAsString(request, "name");
            String url = WebUtils.getRequestParameterAsString(request, "url");
            if (StringUtils.isBlank(name) || StringUtils.isBlank(url)) {
                mav.addObject("message", "不能为空");
                return mav;
            }
            lib.setName(name);
            lib.setUrl(url);
        }
        if (type == 2) {
            String contentName = WebUtils.getRequestParameterAsString(request, "contentName");
            String content = WebUtils.getRequestParameterAsString(request, "content");
            if (StringUtils.isBlank(contentName) || StringUtils.isBlank(content)) {
                mav.addObject("message", "指定名称、内容不能为空");
                return mav;
            }
            lib.setName(contentName);
            lib.setContent(content);

            //TODO 从内容中提取正文中的图片，放置到libImage属性中
            //if(lib.getShowFocusimage() == 1){
                String libImage = getContentImage(request,lib.getContent()) ;
                if(StringUtils.isNotBlank(libImage)){
                    lib.setImage(libImage);
                }
            //}
        }
        if (type == 3) {
        	UploadInfo ui = uploadUtils.doUpload(request, response);
            if (ui.getResultCode() != 0)
                return ui.getModelAndView();
            if (StringUtils.isNotBlank(ui.getFilePath()))
                lib.setImage(ui.getFilePath());
            
            String url = WebUtils.getRequestParameterAsString(request, "urlImage");
            String imageName = WebUtils.getRequestParameterAsString(request,"imageName");
            if (StringUtils.isBlank(url) || StringUtils.isBlank(imageName)) {
                mav.addObject("message", "指定名称、URL不能为空");
                return mav;
            }
            lib.setUrl(url);
            lib.setName(imageName);
        }

        if (libraryDao.create(lib)) {
            mav.addObject("message", "创建成功");
            mav.addObject("href", "mg/library/library-list.htm?categoryId=" + categoryId);
        } else {
            mav.addObject("message", "创建失败");
        }
        return mav;
    }

    @RequestMapping(value = "/library-update.htm", method = RequestMethod.POST)
    public ModelAndView libraryUpdate(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        int showIndex = WebUtils.getRequestParameterAsInt(request,"showIndex",-1);
        int type = WebUtils.getRequestParameterAsInt(request, "type", 1);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(categoryId)) {
            mav.addObject("message", "分类不能为空");
            return mav;
        }

        String orderString = WebUtils.getRequestParameterAsString(request,"order");
        if(StringUtils.isBlank(orderString) || !orderString.matches("\\d+")){
            mav.addObject("message", "排序不能为空，且为数字");
            return mav;
        }
        int showFouceImge = WebUtils.getRequestParameterAsInt(request,"showFouceImage",0);
        LibraryInfo lib = libraryDao.getById(id);
        lib.setOrder(Integer.valueOf(orderString));
        lib.setType(type);
        lib.setCategoryId(categoryId);
        lib.setShowIndex(showIndex);
        lib.setShowFocusimage(showFouceImge);
        lib.setShowSugguest(WebUtils.getRequestParameterAsInt(request,"showSugguest",1));
        String time = WebUtils.getRequestParameterAsString(request, "time");
        if (StringUtils.isBlank(time))
            time = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
        java.text.DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            lib.setTime(format.parse(time));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        if (type == 1) {
            String name = WebUtils.getRequestParameterAsString(request, "name");
            String url = WebUtils.getRequestParameterAsString(request, "url");
            if (StringUtils.isBlank(name) || StringUtils.isBlank(url)) {
                mav.addObject("message", "不能为空");
                return mav;
            }
            lib.setName(name);
            lib.setUrl(url);
        }
        if (type == 2) {
            String contentName = WebUtils.getRequestParameterAsString(request, "contentName");
            String content = WebUtils.getRequestParameterAsString(request, "content");
            if (StringUtils.isBlank(contentName) || StringUtils.isBlank(content)) {
                mav.addObject("message", "指定名称、内容不能为空");
                return mav;
            }
            lib.setName(contentName);
            lib.setContent(content);

            //TODO 从内容中提取正文中的图片，放置到libImage属性中
            //if(lib.getShowFocusimage() == 1){
                String libImage = getContentImage(request,lib.getContent()) ;
                if(StringUtils.isNotBlank(libImage)){
                    lib.setImage(libImage);
                }
            //}

        }
        if (type == 3) {
            UploadInfo ui = uploadUtils.doUpload(request, response);
            if (ui.getResultCode() == 2)
                return ui.getModelAndView();
            if (StringUtils.isNotBlank(ui.getFilePath()))
                lib.setImage(ui.getFilePath());

            String url = WebUtils.getRequestParameterAsString(request, "urlImage");
            String imageName = WebUtils.getRequestParameterAsString(request,"imageName");
            if (StringUtils.isBlank(url) || StringUtils.isBlank(imageName)) {
                mav.addObject("message", "URL不能为空");
                return mav;
            }
            lib.setUrl(url);
            lib.setName(imageName);
        }
        lib.setOrder(WebUtils.getRequestParameterAsInt(request,"order",0));

        if (libraryDao.update(lib)) {
            mav.addObject("message", "更新成功");
            mav.addObject("href", "mg/library/library-list.htm?categoryId=" + categoryId);
        } else {
            mav.addObject("message", "更新失败");
        }
        return mav;
    }

    @RequestMapping(value = "/library-del.htm", method = RequestMethod.GET)
    public ModelAndView libraryDel(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        String ids = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isNotBlank(ids)) {
            String arrays[] = StringUtils.split(ids, ",");
            try {
                for (String array : arrays) {
                    logger.info(String.format("[library-del] id=%s result=%s", array, libraryDao.deleteById(array)));
                }
                mav.addObject("message", "删除成功");
                mav.addObject("href", "mg/library/library-list.htm");
            } catch (Exception e) {
                mav.addObject("message", "删除失败");
                logger.error("[library-del] error!", e);
            }
        }
        return mav;
    }

    /*删除链接中的图片信息*/
    @RequestMapping(value = "/library-delImage.htm", method = RequestMethod.GET)
    public ModelAndView delImage(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-rolling-delete-images]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要操作的内容");
            return mav;
        }
        LibraryInfo info = libraryDao.getById(id);
        info.setImage("");
        if (!libraryDao.update(info)) {
            message = "图片删除失败,请稍后重试!";
        } else {
            message = "图片删除成功.";
        }
        mav.addObject("message", message);
        return mav;
    }

    /*将指定的图书转移到指定的分类下--展现页面*/
    @RequestMapping(value = "/library-move2Cate-show.htm", method = RequestMethod.GET)
    public ModelAndView move2Cate_show(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/library/move2Cate-show");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        //获取指定的所有图书
        String ids = WebUtils.getRequestParameterAsString(request, "id");
        //获取所有的分类
        List<Category> libCateList = categoryDao.getCategoryListByType(CategoryConstants.CATEGORY_LIBRARY,1);

        mav.addObject("libCateList",libCateList);
        mav.addObject("libIds",ids);
        return mav;
    }

    /*将指定的图书转移到指定的分类下*/
    @RequestMapping(value = "/library-move2Cate-do.htm", method = RequestMethod.POST)
    public ModelAndView move2Cate_do(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String libIds = WebUtils.getRequestParameterAsString(request, "libIds");
        String cateId = WebUtils.getRequestParameterAsString(request,"cateId");
        if (StringUtils.isBlank(libIds) || StringUtils.isBlank(cateId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        String arrays [] = StringUtils.split(libIds,",");
        if(arrays == null || arrays.length == 0){
            mav.addObject("message", "请选择要转移的图书");
            return mav;
        }

        if(libraryDao.move2CateDo(arrays,cateId)){
            mav.addObject("message", "转移成功");
            mav.addObject("href", "mg/library/library-list.htm?categoryId=" + cateId);
        }
        else{
            mav.addObject("message", "转移失败");
        }
        return mav;
    }


    //分类转移合并--展现页面
    @RequestMapping(value = "/library-merge-show.htm", method = RequestMethod.GET)
    public ModelAndView mergeShow(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/library/merge-show");
        //获取所有的分类
        List<Category> libCateList = categoryDao.getCategoryListByType(CategoryConstants.CATEGORY_LIBRARY,1);
        mav.addObject("libCateList",libCateList);
        return mav;
    }

    //分类转移合并--执行
    @RequestMapping(value = "/library-merge-do.htm", method = RequestMethod.POST)
    public ModelAndView mergeDo(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");

        String srcCateId = WebUtils.getRequestParameterAsString(request,"srcCateId");
        String destCateId = WebUtils.getRequestParameterAsString(request,"destCateId");

        Category srcCategory = categoryDao.getById(srcCateId);
        Category destCategory = categoryDao.getById(destCateId);

        if(categoryDao.cateMerge(srcCateId,destCateId)){
            message = "已成功将分类\"" + srcCategory.getName() + "\" 转移合并到\"" + destCategory.getName()+ "\"" ;
        }
        else{
            message = "分类转移合并失败" ;
        }
        mav.addObject("message",message);
        return mav;
    }


    /**
     * 获取正文中的图片信息
     * @param source
     * @return
     */
    private static String getContentImage(HttpServletRequest request, String source){
        if(StringUtils.isBlank(source)){
            return null ;
        }
        String image = null ;
        String reg = "<img\\s*.+?src=[\"|'| ](.+?(jpg|jpeg|png|bmp|gif|ico))[\"|'| ].+?>" ;
        List<String> images = RegexUtils.getStringGoup1(source, reg);
        if(images != null && images.size() > 0){
            /*int size = images.size();
            image = images.get(size - 1);*/
            image = images.get(0);

            if(image.toLowerCase().startsWith("http")){
                return image ;
            }
            String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() ;
            return basePath + image ;
        }
        return image ;
    }
}
