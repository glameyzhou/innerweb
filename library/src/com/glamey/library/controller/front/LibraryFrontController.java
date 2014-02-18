package com.glamey.library.controller.front;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.library.constants.SystemConstants;
import com.glamey.library.dao.*;
import com.glamey.library.model.dto.CategoryQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.LibraryInfo;
import com.glamey.library.model.dto.LibraryInfoDTO;
import com.glamey.library.model.dto.LibraryQuery;

@Controller
public class LibraryFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(LibraryFrontController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private IncludeFront includeFront;
    @Resource
    private LibraryInfoDao libraryInfoDao;
    @Resource
    private MetaInfoDao metaInfoDao ;
    @Resource
    private LibraryCollectDao collectDao;
    @Resource
    private AccessLogDao accessLogDao;

    /*获取分类下的类表*/
    @RequestMapping(value = "/library-list-{categoryId}.htm", method = RequestMethod.GET)
    public ModelAndView libList(@PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        if(StringUtils.isBlank(categoryId)){
            mav.addObject("message","无指定分类,请重新选择");
            mav.setViewName("common/message");
            return mav ;
        }

        Category category = categoryDao.getById(categoryId);
        if(category == null){
            mav.addObject("message","无指定分类,请重新选择");
            mav.setViewName("common/message");
            return mav ;
        }

        //包含页面
        mav.addAllObjects(includeFront.allInclude(request,response,session));

        /*最后一级分类，直接输出列表*/
        if(category.getHasChild() == 0){
            int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
            pageBean = new PageBean(20);
            pageBean.setCurPage(curPage);

            LibraryQuery query = new LibraryQuery();
            query.setCategoryId(categoryId);
            query.setShowIndex(1);
            query.setStart(pageBean.getStart());
            query.setNum(pageBean.getRowsPerPage());

            List<LibraryInfo> libraryInfoList = libraryInfoDao.getByQuery(query);
            pageBean.setMaxRowCount(libraryInfoDao.getCountByQuery(query));
            pageBean.setCurPage(curPage);
            pageBean.setMaxPage();
            pageBean.setPageNoList();

            mav.addObject("category",category);
            mav.addObject("libraryInfoList",libraryInfoList);
            mav.addObject("pageBean",pageBean);
            mav.setViewName("front/lib-list");
            return mav ;
        }
        /*旗下有孩子，输出此分类的所有分类、每个分类显示2列内容*/
        else {
            List<Category> childrenCategory = new ArrayList<Category>();
//            childrenCategory = categoryDao.getChildrenByPid(categoryId,CategoryConstants.CATEGORY_LIBRARY,0,Integer.MAX_VALUE) ;
            CategoryQuery categoryQuery = new CategoryQuery();
            categoryQuery.setCategoryType(CategoryConstants.CATEGORY_LIBRARY);
            categoryQuery.setParentId(categoryId);
            categoryQuery.setShowIndex(1);
            childrenCategory = categoryDao.getByQuery(categoryQuery,0,Integer.MAX_VALUE);
            category.setChildren(childrenCategory);
            List<LibraryInfoDTO> libraryInfoDTOList = new ArrayList<LibraryInfoDTO>();
            for (Category child : childrenCategory) {
                LibraryInfoDTO dto = new LibraryInfoDTO();
                dto.setCategory(child);

                LibraryQuery query = new LibraryQuery();
                query.setStart(0);
                query.setNum(12);
                query.setShowIndex(1);
                query.setCategoryId(child.getId());
                List<LibraryInfo> libraryInfoList = libraryInfoDao.getByQuery(query);
                dto.setLibraryInfoList(libraryInfoList);

                libraryInfoDTOList.add(dto);
            }

            mav.addObject("libraryInfoDTOList",libraryInfoDTOList);
            mav.addObject("category",category);
            mav.setViewName("front/lib-index");

            accessLogDao.save("library-list-" + category.getId() + ".htm","分类" + category.getName() + "列表",category.getId(),session);

            return mav ;
        }
    }

    /*最新荐读*/
    @RequestMapping(value = "/library-newest.htm", method = RequestMethod.GET)
    public ModelAndView libNewest(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #libNewest#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        //是否从最左侧的“最新荐读”点击过来的
        String src = WebUtils.getRequestParameterAsString(request,"src");
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request,response,session));

        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean(30);
        pageBean.setCurPage(curPage);

        LibraryQuery libraryQuery = new LibraryQuery();
        libraryQuery.setShowIndex(1);
        libraryQuery.setShowSugguest(1);
        libraryQuery.setStart(pageBean.getStart());
        libraryQuery.setNum(pageBean.getRowsPerPage());
        libraryQuery.setOrderColumnName(Constants.ORDERBYCOLUMNNAME_LIB_TIME);
        libraryQuery.setOrderType(Constants.ORDERBYDESC);
        /*List<LibraryInfo> libraryInfoNewestList = StringUtils.isNotBlank(src) ? libraryInfoDao.getByQuery(libraryQuery) : libraryInfoDao.getFilterByQuery(libraryQuery);
        pageBean.setMaxRowCount(StringUtils.isNotBlank(src) ? libraryInfoDao.getCountByQuery(libraryQuery) : libraryInfoDao.getCountFileterByQuery(libraryQuery));*/
        //如果是左侧过来的数据，直接查询对应的栏目“行业资讯”，反之查询所有的图书内容（最新收录类型的）
        if (StringUtils.isNotBlank(src))
            libraryQuery.setCategoryId(categoryId);
        else
            libraryQuery.setShowRecent(1);

        List<LibraryInfo> libraryInfoNewestList = libraryInfoDao.getByQuery(libraryQuery);
        pageBean.setMaxRowCount(libraryInfoDao.getCountByQuery(libraryQuery));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("libraryInfoList",libraryInfoNewestList);
        mav.addObject("pageBean",pageBean);
        mav.addObject("libraryQuery",libraryQuery);
        mav.setViewName("front/lib-newest");
        mav.addObject("src",src);

        if (StringUtils.isNotBlank(src)) {
            accessLogDao.save("library-newest.htm?src=left","最新荐读列表","",session);
        } else {
            accessLogDao.save("library-newest.htm","近期收录列表","",session);
        }


        return mav ;
    }

    //图书详情页面展示
    @RequestMapping(value = "/library-detail-{id}.htm", method = RequestMethod.GET)
    public ModelAndView libraryDetail(
            @PathVariable String id,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #libraryDetail#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "无效操作");
            mav.setViewName("common/errorPage");
            return mav;
        }
        LibraryInfo libraryInfo = libraryInfoDao.getById(id);
        mav.addObject("libraryInfo", libraryInfo);
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request,response,session));

        boolean exist = collectDao.exist(id);
        mav.addObject("exist",exist);

        mav.setViewName("front/lib-detail");
        accessLogDao.save("library-detail-" + libraryInfo.getId() + ".htm",libraryInfo.getName(),libraryInfo.getCategoryId(),session);
        return mav;
    }

    //图书馆--关于我们
    @RequestMapping(value = "/library-aboutus.htm", method = RequestMethod.GET)
    public ModelAndView aboutus(HttpServletRequest request,HttpServletResponse response,HttpSession session){
        logger.info("[front] #aboutus#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        //图书馆头部信息
        String libraryHeadTitle = metaInfoDao.getByName(SystemConstants.meta_library_title).getValue();
        String libraryHeadContent = metaInfoDao.getByName(SystemConstants.meta_library_content).getValue();
        mav.addObject("libraryHeadTitle",libraryHeadTitle);
        mav.addObject("libraryHeadContent",libraryHeadContent);

        mav.addAllObjects(includeFront.allInclude(request,response,session));

        mav.setViewName("front/lib-aboutus");

        accessLogDao.save("library-aboutus.htm","关于我们","",session);

        return mav;
    }

    //获取所有可用的分类，用来做页面树形单
    @RequestMapping(value = "/library-allCategory.htm", method = RequestMethod.POST)
    public void allCategory(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException {
        logger.info("[front] #allCategory#" + request.getRequestURI());
        StringBuffer source = new StringBuffer(1000);
        String result = "" ;
        String basePath = request.getScheme() + "://" + request.getServerName() + (request.getServerPort() == 80 ? "" : ":" + request.getServerPort()) + request.getContextPath();
        List<Category> categoryList = categoryDao.getCategoryListByType(CategoryConstants.CATEGORY_LIBRARY,1);
        for (Category category : categoryList) {
            source.append("{");
            source.append("id:\"" + category.getId() + "\",");
            source.append("pId:\"" + category.getParentId() + "\",");
            source.append("name:\"" + category.getName() + "\",");
            if(category.getHasChild() == 1){
                source.append("open:false,");
                source.append("icon:\"" + basePath + "/res/front/library/images/fenlei_con1.jpg\",");
            }else{
                source.append("icon:\"" + basePath + "/res/front/library/images/notice_list.png\",");
            }
            source.append("url:\"http://www.baidu.com\"");
            source.append("},");
        }
        if(source.toString().length()>1)
            result = source.toString().replaceAll(",$","");

//        result = "[" + result + "]" ;
        System.out.println(result);

        response.setContentType("text/json;charset=UTF-8");
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        response.setHeader("expires", "0");
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();

    }
}