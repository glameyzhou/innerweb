package com.glamey.library.controller.front;

import com.glamey.framework.utils.tld.StringTld;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.SystemConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.LibraryInfoDao;
import com.glamey.library.dao.MetaInfoDao;
import com.glamey.library.dao.PostDao;
import com.glamey.library.model.domain.*;
import com.glamey.library.model.dto.LibraryInfoDTO;
import com.glamey.library.model.dto.LibraryQuery;
import com.glamey.library.model.dto.PostDTO;
import com.glamey.library.model.dto.PostQuery;
import org.apache.commons.lang.StringUtils;
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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class IndexFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(IndexFrontController.class);

    @Resource
    private PostDao postDao;
    @Resource
    private MetaInfoDao metaInfoDao;
    @Resource
    private IncludeFront includeFront;
    @Resource
    private CategoryDao categoryDao ;
    @Resource
    private LibraryInfoDao libraryInfoDao ;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #index#");
        ModelAndView mav = new ModelAndView("front/index");
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        UserInfo userInfo = (UserInfo) obj;

        //图书馆头部信息
        String libraryHeadTitle = metaInfoDao.getByName(SystemConstants.meta_library_title).getValue();
        String libraryHeadContent = metaInfoDao.getByName(SystemConstants.meta_library_content).getValue();
        mav.addObject("libraryHeadTitle",libraryHeadTitle);
        mav.addObject("libraryHeadContent",libraryHeadContent);
        mav.addAllObjects(includeFront.allInclude(request,response,session));

        //图书馆内容
        int showIndex = 1 ;/*首页显示*/
        List<LibraryInfoDTO> libraryInfoDTOList = new ArrayList<LibraryInfoDTO>();
        List<Category> rootList = categoryDao.getByParentId(showIndex,CategoryConstants.PARENTID,CategoryConstants.CATEGORY_LIBRARY,0,8);
        for (Category rootCategory : rootList) {
            /*父类、子类、子类下内容*/
            LibraryInfoDTO dto = new LibraryInfoDTO();
            dto.setCategory(rootCategory);

            List<LibraryInfoDTO> libDTOList = new ArrayList<LibraryInfoDTO>();
            LibraryInfoDTO libDTO = null ;
            /*获取对应的子分类信息以及子分类下的连接数量*/
            List<Category> categoryList = categoryDao.getByParentId(showIndex,rootCategory.getId(),CategoryConstants.CATEGORY_LIBRARY,0,2);
            //不足两个的话进行数据补录
            int countCategory = categoryList != null ? categoryList.size() : 0 ;
            int diffCategory = 2 - countCategory ;
            for(int i = 0 ; i < diffCategory ; i ++){
                Category category = new Category();
                category.setName("");
                category.setId(CategoryConstants.CATEGORY_UNKNOW);
                categoryList.add(category);
            }

            for (Category category : categoryList) {
                libDTO = new LibraryInfoDTO();
                libDTO.setCategory(category);

                LibraryQuery query = new LibraryQuery();
                query.setShowIndex(showIndex);
                query.setCategoryId(category.getId());
                query.setStart(0);
				/*query.setNum(StringUtils.equals(rootCategory.getId(),Constants.CATEGORY_LIBRARY_DAILY)
                        || StringUtils.equals(rootCategory.getId(),Constants.CATEGORY_LIBRARY_HANGYEYANJIU_REPORT)
                        || StringUtils.equals(rootCategory.getId(),Constants.CATEGORY_LIBRARY_ZHENGYAN)
						? Constants.CATEGORY_LIBRARY_LENGTITLE_LEN
						: Constants.LIBRARYDISCOUNT);*/
                query.setNum(3);
                List<LibraryInfo> libraryInfoList = libraryInfoDao.getByQuery(query);
                //不足三个的话进行数据补录
                int count = libraryInfoList != null ? libraryInfoList.size() : 0 ;
                int diff = 3 - count ;
                for (int i = 0 ; i < diff ; i ++){
                    LibraryInfo li = new LibraryInfo();
                    li.setName("");
                    libraryInfoList.add(li);
                }
                libDTO.setLibraryInfoList(libraryInfoList);

                libDTOList.add(libDTO);
            }
            dto.setLibraryInfoDTOList(libDTOList);
            libraryInfoDTOList.add(dto);
        }
        mav.addObject("libraryInfoDTOList",libraryInfoDTOList);

        mav.addAllObjects(includeFront.friendlyLinks(request));
        return mav;
    }

    @RequestMapping(value = "/errorPage.htm", method = RequestMethod.GET)
    public ModelAndView errorPage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("common/message.jsp");
        mav.addObject("message","请求的内容不存在，返回首页");
        String port = request.getServerPort() == 80 ? "" : ":" + request.getServerPort();
        String basePath = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath() + "/";
        mav.addObject("href",basePath);
        return mav ;
    }


    @RequestMapping(value = "/contact-us.htm", method = RequestMethod.GET)
    public ModelAndView contactUS(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("front/contact-us");
        MetaInfo metaInfo = metaInfoDao.getByName(SystemConstants.meta_contact_us);
        mav.addObject("contactusContent",metaInfo.getValue());
        mav.addAllObjects(includeFront.allInclude(request,response,session));
        return mav ;
    }
}