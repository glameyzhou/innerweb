package com.glamey.library.controller.manager;

import com.glamey.framework.utils.*;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.LibraryInfoDao;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.LibraryInfo;
import com.glamey.library.model.domain.UploadInfo;
import com.glamey.library.model.dto.LibraryQuery;
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
import java.util.Date;
import java.util.List;

/**
 * 微型图书馆后台控制管理
 * <p/>
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/mg/library")
public class LibraryManagerController extends BaseController {

    private static final Logger logger = Logger.getLogger(LibraryManagerController.class);
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private LibraryInfoDao libraryDao;
    @Resource
    private WebUploadUtils uploadUtils;

    /*通过父ID，列举所有的分类信息*/
    @RequestMapping(value = "/category-list.htm", method = RequestMethod.GET)
    public ModelAndView categoryList(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/library/category-list");
        String pid = WebUtils.getRequestParameterAsString(request, "pid", "0");
        Category pCategory = new Category();
        if (!StringUtils.equalsIgnoreCase(pid, "0")) {
            pCategory = categoryDao.getById(pid);
        }
        List<Category> categoryList = categoryDao.getByParentId(pid, CategoryConstants.CATEGORY_LIBRARY, 0, Integer.MAX_VALUE);
        mav.addObject("pid", pid);
        mav.addObject("pCategory", pCategory);
        mav.addObject("categoryList", categoryList);
        return mav;
    }

    /*分类修改、创建页面*/
    @RequestMapping(value = "/category-show.htm", method = RequestMethod.GET)
    public ModelAndView categoryShow(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/library/category-show");
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String opt = "create";
        Category category = new Category();
        if (StringUtils.isNotBlank(id)) {
            category = categoryDao.getById(id);
            opt = "update";
        }
        mav.addObject("category", category);
        mav.addObject("opt", opt);
        mav.addObject("pid", pid);
        return mav;
    }

    /*创建分类*/
    @RequestMapping(value = "/category-create.htm", method = RequestMethod.POST)
    public ModelAndView categoryCreate(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String aliasName = Pinyin4jUtils.getPinYin(name);
        String shortName = WebUtils.getRequestParameterAsString(request, "shortName");
        String desc = WebUtils.getRequestParameterAsString(request, "describe");
        int showIndex = WebUtils.getRequestParameterAsInt(request, "showIndex", 1);
        int showInTree = WebUtils.getRequestParameterAsInt(request, "showInTree", 1);
        int treeorder = WebUtils.getRequestParameterAsInt(request, "treeOrder", 0);
        int categoryOrder = WebUtils.getRequestParameterAsInt(request, "categoryOrder", 0);
        Category category = new Category();
        category.setParentId(pid);
        category.setName(name);
        category.setShortName(shortName);
        category.setAliasName(aliasName);
        category.setDescribe(desc);
        category.setShowIndex(showIndex);
        category.setShowInTree(showInTree);
        category.setTreeOrder(treeorder);
        category.setCategoryOrder(categoryOrder);
        category.setCategoryType(CategoryConstants.CATEGORY_LIBRARY);
        category.setCategoryTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
        category.setHasChild(0);

        //新增分类的时候，同时需要进行更新父节点下边是否有孩子
        String uniqueId = categoryDao.createReturnId(category);
        if (StringUtils.isNotBlank(uniqueId)) {
            category = categoryDao.getById(uniqueId);
            mav.addObject("message", "分类添加成功");
            mav.addObject("href", "mg/library/category-list.htm?pid=" + category.getParentId());
        } else {
            mav.addObject("message", "分类添加失败,请重试");
        }
        return mav;
    }

    /*更新分类*/
    @RequestMapping(value = "/category-update.htm", method = RequestMethod.POST)
    public ModelAndView categoryUpdate(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "无效操作");
            return mav;
        }
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String aliasName = Pinyin4jUtils.getPinYin(name);
        String shortName = WebUtils.getRequestParameterAsString(request, "shortName");
        String desc = WebUtils.getRequestParameterAsString(request, "describe");
        int showIndex = WebUtils.getRequestParameterAsInt(request, "showIndex", 1);
        int showInTree = WebUtils.getRequestParameterAsInt(request, "showInTree", 1);
        int treeorder = WebUtils.getRequestParameterAsInt(request, "treeOrder", 0);
        int categoryOrder = WebUtils.getRequestParameterAsInt(request, "categoryOrder", 0);
        Category category = categoryDao.getById(id);
        category.setParentId(pid);
        category.setName(name);
        category.setShortName(shortName);
        category.setAliasName(aliasName);
        category.setDescribe(desc);
        category.setShowIndex(showIndex);
        category.setShowInTree(showInTree);
        category.setTreeOrder(treeorder);
        category.setCategoryOrder(categoryOrder);
        category.setCategoryType(CategoryConstants.CATEGORY_LIBRARY);
        boolean result = categoryDao.update(category);
        if (result) {
            mav.addObject("message", "分类修改成功");
            mav.addObject("href", "mg/library/category-list.htm?pid=" + category.getParentId());
        } else {
            mav.addObject("message", "分类修改失败,请重试");
        }
        return mav;
    }

    /*删除分类*/
    @RequestMapping(value = "/category-del.htm", method = RequestMethod.GET)
    public ModelAndView categoryDel(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String pid = WebUtils.getRequestParameterAsString(request, "pid", "0");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "无效操作");
            return mav;
        }
        Category category = categoryDao.getById(id);
        if(category.getHasChild() == 1){
            mav.addObject("message","需要先删除子分类");
            return mav ;
        }
        if (categoryDao.deleteById(id, CategoryConstants.CATEGORY_LIBRARY)) {
            mav.addObject("message", "分类删除成功");
            mav.addObject("href", "mg/library/category-list.htm?pid=" + pid);
        } else {
            mav.addObject("message", "分类删除失败,请重试");
        }
        return mav;
    }

    /*所有信息*/
    @RequestMapping(value = "/library-list.htm", method = RequestMethod.GET)
    public ModelAndView libraryList(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/library/library-list");

        pageBean = new PageBean();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        int showIndex = WebUtils.getRequestParameterAsInt(request,"showIndex",-1);
        int type = WebUtils.getRequestParameterAsInt(request, "type", -1);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        int focusImage = WebUtils.getRequestParameterAsInt(request,"showFocusimage",-1);
        int showSugguest = WebUtils.getRequestParameterAsInt(request,"showSugguest",-1);

        LibraryQuery query = new LibraryQuery();
        query.setType(type);
        query.setCategoryId(categoryId);
        query.setKeyword(keyword);
        query.setShowIndex(showIndex);
        query.setIsFocusImage(focusImage);
        query.setShowSugguest(showSugguest);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<LibraryInfo> libraryList = libraryDao.getByQuery(query);
        pageBean.setMaxRowCount(libraryDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("libraryList", libraryList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);

        //所有分类
        List<Category> categoryList = categoryDao.getChildrenByPid(CategoryConstants.PARENTID, CategoryConstants.CATEGORY_LIBRARY, 0, Integer.MAX_VALUE);
        mav.addObject("children",categoryList);

        Category category = categoryDao.getById(categoryId);
        mav.addObject("category", category);
        return mav;
    }

    /*展示修改、创建页面*/
    @RequestMapping(value = "/library-show.htm", method = RequestMethod.GET)
    public ModelAndView libraryShow(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/library/library-show");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        //分类信息
        List<Category> categoryParentList = categoryDao.getByParentId("0", CategoryConstants.CATEGORY_LIBRARY, 0, Integer.MAX_VALUE);
        List<Category> categoryList = new ArrayList<Category>();
        String opt = "create";
        LibraryInfo info = new LibraryInfo();
        if (StringUtils.isNotBlank(id)) {
            info = libraryDao.getById(id);
            opt = "update";
            categoryList = categoryDao.getByParentId(info.getCategoryId(), CategoryConstants.CATEGORY_LIBRARY, 0, Integer.MAX_VALUE);
        } else {
            info.setType(-1);
            info.setShowSugguest(0);
            //默认显示当前分类
            Category category = new Category();
            category.setId(WebUtils.getRequestParameterAsString(request,"categoryId"));
            category.setParentId(WebUtils.getRequestParameterAsString(request,"pid"));
            info.setCategory(category);
            info.setCategoryId(category.getId());
            info.setTime(new Date());
        }
        mav.addObject("opt", opt);
        mav.addObject("lib", info);
        mav.addObject("categoryParentList", categoryParentList);
        mav.addObject("categoryList", categoryList);

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


    /*设置图书的属性*/
    @RequestMapping(value = "/library-setSelectContent.htm", method = RequestMethod.GET)
    public ModelAndView setSelectContent(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
//        ?id=" + values + "&category=" + category + "&type=" + type?
//        http://library.chdi.ac.cn/mg/library/library-list.htm?categoryId=rUnI7v
        String libIds = WebUtils.getRequestParameterAsString(request, "id");
        String category = WebUtils.getRequestParameterAsString(request,"category");
        String type = WebUtils.getRequestParameterAsString(request,"type");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        if (StringUtils.isBlank(libIds) || StringUtils.isBlank(category) || StringUtils.isBlank(type)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        String arrays [] = StringUtils.split(libIds,",");
        if(arrays == null || arrays.length == 0){
            mav.addObject("message", "请选择您需要操作的图书");
            return mav;
        }

        List<LibraryInfo> libraryInfoList = new ArrayList<LibraryInfo>();
        for (String id : arrays) {
            LibraryInfo libraryInfo = new LibraryInfo();
            libraryInfo.setId(id);
            libraryInfoList.add(libraryInfo);
        }
        if (libraryDao.update(libraryInfoList,category,Integer.valueOf(type))) {
            mav.addObject("message", "设置成功");
            mav.addObject("href", "mg/library/library-list.htm?categoryId=" + categoryId);
        }
        else{
            mav.addObject("message", "设置失败");
        }
        return mav;
    }
}
