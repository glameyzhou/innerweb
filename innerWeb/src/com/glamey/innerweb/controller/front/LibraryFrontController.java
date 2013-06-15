package com.glamey.innerweb.controller.front;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LibraryInfoDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.LibraryInfo;
import com.glamey.innerweb.model.dto.LibraryInfoDTO;
import com.glamey.innerweb.model.dto.LibraryQuery;

@Controller
public class LibraryFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(LibraryFrontController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private IncludeFront includeFront;
    @Resource
    private LibraryInfoDao libraryInfoDao;

    /*微型图书馆首页*/
    @RequestMapping(value = "/library.htm", method = RequestMethod.GET)
    public ModelAndView library(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        List<LibraryInfoDTO> libraryInfoDTOList = new ArrayList<LibraryInfoDTO>();
        List<Category> rootList = categoryDao.getByParentId(CategoryConstants.PARENTID,CategoryConstants.CATEGORY_LIBRARY,0,Integer.MAX_VALUE);
        for (Category rootCategory : rootList) {
            /*父类、子类、子类下内容*/
            LibraryInfoDTO dto = new LibraryInfoDTO();
            dto.setCategory(rootCategory);

            List<LibraryInfoDTO> libDTOList = new ArrayList<LibraryInfoDTO>();
            LibraryInfoDTO libDTO = null ;
            /*获取对应的子分类信息以及子分类下的连接数量*/
            List<Category> categoryList = categoryDao.getByParentId(rootCategory.getId(),CategoryConstants.CATEGORY_LIBRARY,0,Integer.MAX_VALUE);
            for (Category category : categoryList) {
                libDTO = new LibraryInfoDTO();
                libDTO.setCategory(category);

                LibraryQuery query = new LibraryQuery();
                query.setCategoryId(category.getId());
                query.setStart(0);
				query.setNum(StringUtils.equals(rootCategory.getId(),Constants.CATEGORY_LIBRARY_DAILY) || StringUtils.equals(rootCategory.getId(),Constants.CATEGORY_LIBRARY_HANGYEYANJIU_REPORT)
						? Constants.CATEGORY_LIBRARY_LENGTITLE_LEN
						: Constants.LIBRARYDISCOUNT);
                List<LibraryInfo> libraryInfoList = libraryInfoDao.getByQuery(query);
                libDTO.setLibraryInfoList(libraryInfoList);

                libDTOList.add(libDTO);
            }
            dto.setLibraryInfoDTOList(libDTOList);
            libraryInfoDTOList.add(dto);
        }
        mav.addObject("libraryInfoDTOList",libraryInfoDTOList);
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request,response,session));
        mav.setViewName("front/lib-index");
        return mav;
    }
    /*library-0-0-0.htm*/
    @RequestMapping(value = "/library_{pCategoryId}_{categoryId}_{showImage}.htm", method = RequestMethod.GET)
    public ModelAndView libList(
            @PathVariable String pCategoryId,
            @PathVariable String categoryId,
            @PathVariable int showImage,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        System.out.println(String.format("pid=%s,cid=%s,showImage=%d",pCategoryId,categoryId,showImage));
        if (StringUtils.equalsIgnoreCase(categoryId, "0")) {
            categoryId = null;
        }
        List<String> categoryIds = new ArrayList<String>();
        if (!StringUtils.equalsIgnoreCase(pCategoryId, "0") && StringUtils.equalsIgnoreCase(categoryId, "0")) {
            List<Category> categoryList = categoryDao.getByParentId(pCategoryId, CategoryConstants.CATEGORY_LIBRARY, 0, Integer.MAX_VALUE);
            for (Category category : categoryList) {
                categoryIds.add(category.getId());
            }
            categoryId = null;
        }
        Category pCategory = categoryDao.getById(pCategoryId);
        Category category = categoryDao.getById(categoryId);
        if(pCategory == null){
            pCategory = new Category();
            pCategory.setId("0");
        }
        if(category == null){
            category = new Category();
            category.setId("0");
        }



        pageBean = new PageBean(60);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        LibraryQuery query = new LibraryQuery();
        query.setCategoryId(categoryId);
        query.setCategoryIds(categoryIds);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        query.setShowImage(showImage);

        List<LibraryInfo> libraryInfos = libraryInfoDao.getByQuery(query);
        pageBean.setMaxRowCount(libraryInfoDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("pageBean", pageBean);
        mav.addObject("libraryInfos", libraryInfos);
        mav.addObject("query", query);
        mav.addObject("pCategory", pCategory);
        mav.addObject("category", category);

        //包含页面
        mav.addAllObjects(includeFront.allInclude(request,response,session));

        //查看分类是否为图片分类,如果是的话，列表显示需要使用图片类型;如果是图片类型，并且数量少于四个的话，需要进行补录空白
        boolean isImage = false ;
        int len = libraryInfos.size() ;
        for(LibraryInfo info : libraryInfos){
            if(info.getType() == 3){
                isImage = true ;
                break;
            }
        }
        for(int i = 0 ; i < 4- len ; i ++ ){
            LibraryInfo info = new LibraryInfo();
            info.setImage("");
            info.setUrl("");
            libraryInfos.add(info);
        }

        mav.addObject("isImage",isImage);
        mav.setViewName("front/lib-list");
        return mav;
    }

    @RequestMapping(value = "/library-detail-{id}.htm", method = RequestMethod.GET)
    public ModelAndView libraryDetail(
            @PathVariable String id,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "无效操作");
            mav.setViewName("404");
            return mav;
        }

        LibraryInfo info = libraryInfoDao.getById(id);
        mav.addObject("info", info);

        //包含页面
        mav.addAllObjects(includeFront.allInclude(request,response,session));

        mav.setViewName("front/lib-detail");
        return mav;
    }
}