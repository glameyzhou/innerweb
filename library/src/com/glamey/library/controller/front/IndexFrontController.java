package com.glamey.library.controller.front;

import com.glamey.framework.utils.tld.StringTld;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.SystemConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.*;
import com.glamey.library.model.domain.*;
import com.glamey.library.model.dto.*;
import com.glamey.library.util.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

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
    @Resource
    private LinksDao linksDao ;
    @Resource
    private RollingImageDao rollingImageDao ;
    @Resource
    private AccessLogDao accessLogDao;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView indexNewest(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #indexNewest#");
        ModelAndView mav = new ModelAndView("front/index_lastest");
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
        List<Category> rootList = categoryDao.getByParentId(showIndex,CategoryConstants.PARENTID,CategoryConstants.CATEGORY_LIBRARY,0,100);
        for (Category rootCategory : rootList) {

            //列表页面不在显示“近期会展”
            if(StringUtils.equals(rootCategory.getId(),CategoryConstants.CATEGORY_JINQIHUIZHAN)){
                continue;
            }
            /*父类、子类、子类下内容*/
            LibraryInfoDTO dto = new LibraryInfoDTO();
            dto.setCategory(rootCategory);

            List<LibraryInfoDTO> libDTOList = new ArrayList<LibraryInfoDTO>();
            LibraryInfoDTO libDTO = null ;
            /*获取对应的子分类信息以及子分类下的连接数量*/
            List<Category> categoryList = categoryDao.getByParentId(showIndex,rootCategory.getId(),CategoryConstants.CATEGORY_LIBRARY,0,100);

            //如果是华电科技--华电技术的话，直接删除
            for (Iterator<Category> it = categoryList.iterator();it.hasNext();){
                Category category = it.next();
                if(/*StringUtils.equals(category.getId(),CategoryConstants.CATEGORY_HUADIANJISHU)
                        ||*/
                        StringUtils.equals(category.getId(),CategoryConstants.CATEGORY_HUADIANKEYAN)
                  ){
                    it.remove();
                }
            }
            dto.setChildrenCategory(categoryList);//设置旗下孩子的对象集合
            //用来显示孩子的模块内容，如果孩子为奇数个的话，自动减去1；
            if(!CollectionUtils.isEmpty(categoryList)){
                int categoryListSize = categoryList.size();
                if(categoryListSize > 1 && categoryListSize % 2 > 0){
                    categoryList = categoryList.subList(0,categoryListSize-1);
                }
            }
            for (Category category : categoryList) {
                libDTO = new LibraryInfoDTO();
                libDTO.setCategory(category);

                LibraryQuery query = new LibraryQuery();
                query.setShowIndex(showIndex);
                query.setCategoryId(category.getId());
                query.setStart(0);
                List<LibraryInfo> libraryInfoList;
                if(
                        /*StringUtils.equals(rootCategory.getId(),CategoryConstants.CATEGORY_ZHIMINGNENGYUANQIYE)
                        || */StringUtils.equals(rootCategory.getId(),CategoryConstants.CATEGORY_HANGYEYANJIUJIGOUXIEHUI)
                        ){
                    query.setNum(6);
                    libraryInfoList = libraryInfoDao.getByQuery(query);
                    if(libraryInfoList != null && libraryInfoList.size() > 0 ){
                        int size = libraryInfoList.size();
                        if(size == 1){
                            libraryInfoList = new ArrayList<LibraryInfo>();
                        }
                        if(size > 1 && size % 2 != 0){
                            libraryInfoList = libraryInfoList.subList(0,size - 1);
                        }
                    }
                }
                //如果是华电技术的话，取出来一条信息
                else if (StringUtils.equals(category.getId(),CategoryConstants.CATEGORY_HUADIANJISHU)) {
                    query.setNum(1);
                    libraryInfoList = libraryInfoDao.getByQuery(query);
                }
                else{
                    query.setNum(3);
                    libraryInfoList = libraryInfoDao.getByQuery(query);
                    int size = libraryInfoList.size();
                    if (!CollectionUtils.isEmpty(libraryInfoList) && size < 3) {
                        for (int i = size ; i <= 3 ; i ++) {
                            LibraryInfo info = new LibraryInfo();
                            info.setName("");
                            libraryInfoList.add(info);
                        }
                    }
                }
                libDTO.setLibraryInfoList(libraryInfoList);
                libDTOList.add(libDTO);
            }
            dto.setLibraryInfoDTOList(libDTOList);
            libraryInfoDTOList.add(dto);
        }
        mav.addObject("libraryInfoDTOList",libraryInfoDTOList);

        mav.addAllObjects(includeFront.friendlyLinks(request));

        //常用链接管理
        mav.addAllObjects(includeFront.ofenLinks());

        //近期收录（所有分类中的倒序排列top10）
        List<LibraryInfo> libraryInfoNewestList = new ArrayList<LibraryInfo>(10);
        LibraryQuery libraryQuery = new LibraryQuery();
        libraryQuery.setShowSugguest(1);
        libraryQuery.setShowIndex(1);
        libraryQuery.setShowRecent(1);
        libraryQuery.setNum(10);
        libraryQuery.setOrderMap(new LinkedHashMap<String, String>(){
            {
                put(Constants.ORDERBYCOLUMNNAME_LIB_TIME,Constants.ORDERBYDESC);
            }
        });
        libraryInfoNewestList = libraryInfoDao.getByQuery(libraryQuery);
//        libraryInfoNewestList = libraryInfoDao.getFilterByQuery(libraryQuery);
        mav.addObject("libraryInfoNewestList",libraryInfoNewestList);


        //焦点图
        List<LibraryInfo> libraryInfoFouceImageList = new ArrayList<LibraryInfo>(10);
        LibraryQuery queryFouceImage = new LibraryQuery();
        queryFouceImage.setOrderMap(new LinkedHashMap<String, String>(){
            {
                put(Constants.ORDERBYCOLUMNNAME_LIB_TIME,Constants.ORDERBYDESC);
            }
        });
        queryFouceImage.setShowIndex(1);
        queryFouceImage.setNum(6);
        queryFouceImage.setType(2);
        queryFouceImage.setIsFocusImage(1);
        libraryInfoFouceImageList = libraryInfoDao.getByQuery(queryFouceImage);

        queryFouceImage.setType(3);
        libraryInfoFouceImageList.addAll(libraryInfoDao.getByQuery(queryFouceImage));
        //做时间的排序
        Collections.sort(libraryInfoFouceImageList,new Comparator<LibraryInfo>() {
            @Override
            public int compare(LibraryInfo o1, LibraryInfo o2) {
                return o1.getTime().before(o2.getTime()) ? -1 : 0;
            }
        });

        if(libraryInfoFouceImageList != null && libraryInfoFouceImageList.size() >6){
            libraryInfoFouceImageList = libraryInfoFouceImageList.subList(0,6);
        }
        mav.addObject("libraryInfoFouceImageList",libraryInfoFouceImageList);

        //滚动图片
        RollingImageQuery rollingImageQuery = new RollingImageQuery();
        rollingImageQuery.setValid(1);
        rollingImageQuery.setStart(0);
        rollingImageQuery.setNum(10);
        List<RollingImageInfo> rollingImageInfoList = rollingImageDao.getByParentId(rollingImageQuery) ;
        mav.addObject("rollingImageInfoList",rollingImageInfoList);


        //近期会展（ID）
        List<String> jinqihuizhan_ids =  new ArrayList<String>();
        Category category_jiqihuizhan = categoryDao.getById(CategoryConstants.CATEGORY_JINQIHUIZHAN);
        if(category_jiqihuizhan != null && StringUtils.isNotBlank(category_jiqihuizhan.getId())){
            List<Category> a = categoryDao.getByParentId(1,CategoryConstants.CATEGORY_JINQIHUIZHAN,CategoryConstants.CATEGORY_LIBRARY,0,100);
            for (Category category : a) {
                jinqihuizhan_ids.add(category.getId());
            }
        }
        LibraryQuery jiqihuizhan = new LibraryQuery();
        jiqihuizhan.setStart(0);
        jiqihuizhan.setNum(5);
        jiqihuizhan.setShowIndex(1);
        jiqihuizhan.setShowImage(1);
        jiqihuizhan.setCategoryIds(jinqihuizhan_ids);
        List<LibraryInfo> jinqihuizhan_libs = libraryInfoDao.getByQuery(jiqihuizhan);
        mav.addObject("jinqihuizhan_libs",jinqihuizhan_libs);

        //华电科技--华电技术
        LibraryQuery huadianjishu = new LibraryQuery();
        huadianjishu.setStart(0);
        huadianjishu.setNum(1);
        huadianjishu.setShowIndex(1);
        huadianjishu.setShowImage(1);
        huadianjishu.setCategoryId(CategoryConstants.CATEGORY_HUADIANJISHU);
        List<LibraryInfo> huadianjishu_libs = libraryInfoDao.getByQuery(huadianjishu);
        mav.addObject("huadianjishu_libs",huadianjishu_libs);

        //华电科技--中国华电科研----->修改为《政策研究》 modify by zy 20140211(暂时不修改)
        LibraryQuery huadiankeyan = new LibraryQuery();
        huadiankeyan.setStart(0);
        huadiankeyan.setNum(1);
        huadiankeyan.setShowIndex(1);
        huadiankeyan.setShowImage(1);
//        huadiankeyan.setCategoryId(CategoryConstants.CATEGORY_ZHENGCEYANJIU);
        huadiankeyan.setCategoryId(CategoryConstants.CATEGORY_HUADIANKEYAN);
        List<LibraryInfo> huadiankeyan_libs = libraryInfoDao.getByQuery(huadiankeyan);
        mav.addObject("huadiankeyan_libs",huadiankeyan_libs);


        //是否有最新的通知公告
        boolean isHasNotice = false;
        PostQuery query = new PostQuery();
        query.setIsValid(1);
        query.setStartTime(DateFormatUtils.format(DateUtils.getDay(new Date(), -6), "yyyy-MM-dd") + " 00:00:00"); //七天之内
        query.setStart(0);
        query.setNum(1);
        query.setCategoryId(CategoryConstants.CATEGORY_TONGZHIGONGGAO);
        List<Post> postList = postDao.getPostList(query);
        if (!CollectionUtils.isEmpty(postList))
            isHasNotice = true;
        mav.addObject("isHasNotice",isHasNotice);
        accessLogDao.save("index.htm","首页","",session);
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

        accessLogDao.save("contact-us.htm","联系我们","",session);
        return mav ;
    }
}