package com.glamey.chec_cn.controller.front;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.constants.LuceneConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.*;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.PeriodicalInfo;
import com.glamey.chec_cn.model.domain.Post;
import com.glamey.chec_cn.model.dto.LuceneEntry;
import com.glamey.chec_cn.model.dto.PeriodicalQuery;
import com.glamey.chec_cn.model.dto.PostQuery;
import com.glamey.chec_cn.util.LuceneUtils;
import com.glamey.framework.utils.FileUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.LockObtainFailedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.wltea.analyzer.lucene.IKQueryParser;
import org.wltea.analyzer.lucene.IKSimilarity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class PostFrontController extends BaseController {

    @Autowired
    private UserInfoDao userInfoDao;
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private LinksDao linksDao;
    @Autowired
    private PeriodicalDao periodicalDao;

    private LuceneUtils lu = new LuceneUtils();
    private static Directory directory = null;
    private static IndexSearcher isearcher = null;

    @RequestMapping(value = {"/band-{rootCategoryName}.htm"}, method = RequestMethod.GET)
    public ModelAndView bandCategoryPage(
            @PathVariable String rootCategoryName,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/band/band");
        if (StringUtils.isBlank(rootCategoryName)) {
            return pageNotFound(request, response);
        }
        Category rootCategory = categoryDao.getByAliasName(rootCategoryName);
        if (rootCategory == null || StringUtils.isBlank(rootCategory.getId())) {
            return pageNotFound(request, response);
        }
        List<Category> categoryList = categoryDao.getByParentId(1, rootCategory.getId(), rootCategory.getCategoryType(), 0, Integer.MAX_VALUE);
        String curCategory = WebUtils.getRequestParameterAsString(request, "cate");
        Category defaultCategory = new Category();

        if (StringUtils.isBlank(curCategory)) {
            if (!CollectionUtils.isEmpty(categoryList)) {
                defaultCategory = categoryList.get(0);
            }
        } else {
            defaultCategory = categoryDao.getById(curCategory);
        }

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean(Constants.rowsPerPageFront);
        pageBean.setCurPage(curPage);
        PostQuery postQuery = new PostQuery();
        postQuery.setCategoryId(defaultCategory.getId());
        postQuery.setCategoryType(defaultCategory.getCategoryType());

        //列表显示
        if (defaultCategory.getShowType() == 0) {
            postQuery.setShowList(1);
            postQuery.setStart(pageBean.getStart());
            postQuery.setNum(pageBean.getRowsPerPage());
            postQuery.setOrderMap(new LinkedHashMap<String, String>(){
                {
                    put(Constants.ORDERBYCOLUMNNAME_POST_ORDER,Constants.ORDERBYDESC);
                    put(Constants.ORDERBYCOLUMNNAME_POST_PUBLIS_TIME,Constants.ORDERBYDESC);
                }
            });
        }
        //详情显示
        else {
            postQuery.setStart(0);
            postQuery.setNum(1);
        }
        List<Post> postList = postDao.getByQuery(postQuery);
        pageBean.setMaxRowCount(postDao.getCountByQuery(postQuery));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("rootCategory", rootCategory);
        mav.addObject("categoryList", categoryList);
        mav.addObject("defaultCategory", defaultCategory);
        mav.addObject("postList", postList);
        mav.addObject("pageBean", pageBean);
        return mav;
    }

    @RequestMapping(value = {"/post-{rootCategoryName}-{curCategoryId}-{postId}.htm"}, method = RequestMethod.GET)
    public ModelAndView brandPostList(
            @PathVariable String rootCategoryName,
            @PathVariable String curCategoryId,
            @PathVariable String postId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/band/post");

        if (StringUtils.isBlank(rootCategoryName) || StringUtils.isBlank(curCategoryId) || StringUtils.isBlank(postId)) {
            return pageNotFound(request, response);
        }

        Category rootCategory = categoryDao.getByAliasName(rootCategoryName);
        List<Category> categoryList = categoryDao.getByParentId(1, rootCategory.getId(), rootCategory.getCategoryType(), 0, Integer.MAX_VALUE);

        if (rootCategory == null || StringUtils.isBlank(rootCategory.getId())) {
            return pageNotFound(request, response);
        }
        Post postInfo = postDao.getByPostId(postId);
        Category defaultCategory = postInfo.getCategory();
        mav.addObject("rootCategory", rootCategory);
        mav.addObject("categoryList", categoryList);
        mav.addObject("postInfo", postInfo);
        mav.addObject("defaultCategory", defaultCategory);
        return mav;
    }

    @RequestMapping(value = "/search.htm", method = RequestMethod.GET)
    public ModelAndView search(
            @RequestParam(value = "kw", required = false, defaultValue = "") String kw,
            @RequestParam(value = "curPage", required = false, defaultValue = "1") String pg) throws Exception {

        ModelAndView mav = new ModelAndView("front/band/search");
        int curPage = Integer.parseInt(pg);
        kw = StringTools.converISO2UTF8(kw);
        kw = StringEscapeUtils.unescapeHtml(kw);
        pageBean = new PageBean(Constants.rowsPerPageFront);
        pageBean.setCurPage(curPage);
        List<LuceneEntry> entries = new ArrayList<LuceneEntry>();
        FileUtils.mkdirs(LuceneConstants.INDEXDIR);
        try {
            directory = FSDirectory.open(LuceneConstants.INDEXDIR);
            isearcher = new IndexSearcher(directory);
            isearcher.setSimilarity(new IKSimilarity());
            String fieldNames[] = {LuceneConstants.flTitle, LuceneConstants.flSummary, LuceneConstants.flContent};
            Query query = IKQueryParser.parseMultiField(fieldNames, kw);
            TopScoreDocCollector topCollector = TopScoreDocCollector.create(isearcher.maxDoc(), true);
            isearcher.search(query, topCollector);

            int maxRowCount = topCollector.getTotalHits();
            pageBean.setMaxRowCount(maxRowCount);
            pageBean.setMaxPage();
            pageBean.setPageNoList();

            ScoreDoc docs[] = topCollector.topDocs(pageBean.getStart(), pageBean.getRowsPerPage()).scoreDocs;
            LuceneEntry entry = null;
            String title = "";
            for (ScoreDoc sDoc : docs) {
                entry = new LuceneEntry();
                Document doc = isearcher.doc(sDoc.doc);
                title = doc.get(LuceneConstants.flTitle);
                // 高亮显示
                title = LuceneUtils.getHighlighter(query, doc, LuceneConstants.flTitle, kw, null, null);
                entry.setId(doc.get(LuceneConstants.flID));
                entry.setModel(doc.get(LuceneConstants.flModel));
                entry.setHref(doc.get(LuceneConstants.flHref));
                entry.setTitle(title);
                entry.setContent(doc.get(LuceneConstants.flContent));
                entry.setTime(doc.get(LuceneConstants.flTime));
                entries.add(entry);
            }
        } catch (CorruptIndexException e) {
            e.printStackTrace();
        } catch (LockObtainFailedException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (isearcher != null)
                try {
                    isearcher.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            if (directory != null) {
                try {
                    directory.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        mav.addObject("entries", entries);
        mav.addObject("pageBean", pageBean);
        mav.addObject("kw", StringEscapeUtils.escapeHtml(kw));
        mav.addObject("kw_input", kw);
        return mav;
    }

    @RequestMapping(value = {"/business.htm"}, method = RequestMethod.GET)
    public ModelAndView business(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/band/business");

        Category rootCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_BUSINESS);
        if (rootCategory == null || StringUtils.isBlank(rootCategory.getId())) {
            return pageNotFound(request, response);
        }
        List<Category> categoryList = categoryDao.getByParentId(1, rootCategory.getId(), rootCategory.getCategoryType(), 0, Integer.MAX_VALUE);

        mav.addObject("rootCategory", rootCategory);
        mav.addObject("categoryList", categoryList);
        return mav;
    }

    /*资质荣誉*/
    @RequestMapping(value = {"/introduce-zzry.htm"}, method = RequestMethod.GET)
    public ModelAndView introduceZZRY(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/band/introduce-zzry");

        Category rootCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_INTRODUCE);
        if (rootCategory == null || StringUtils.isBlank(rootCategory.getId())) {
            return pageNotFound(request, response);
        }
        List<Category> categoryList = categoryDao.getByParentId(1, rootCategory.getId(), rootCategory.getCategoryType(), 0, Integer.MAX_VALUE);
        Category defaultCategory = categoryDao.getById(CategoryConstants.CATEGORY_ID_ZIZHIRONGYU);
        List<Category> defaultChild = categoryDao.getByParentId(1,defaultCategory.getId(),defaultCategory.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("rootCategory", rootCategory);
        mav.addObject("categoryList", categoryList);
        mav.addObject("defaultCategory", defaultCategory);
        mav.addObject("defaultChild", defaultChild);
        return mav;
    }

    /*中国华电工程期刊*/
    @RequestMapping(value = {"/periodical.htm"}, method = RequestMethod.GET)
    public ModelAndView periodicalIndex(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/band/periodical-index");
        int years = WebUtils.getRequestParameterAsInt(request,"years",-1);
        PeriodicalQuery query = new PeriodicalQuery();
        query.setYearsStart(years);
        query.setYearsEnd(years == -1 ? -2 : years);
        query.setStart(0);
        query.setNum(Integer.MAX_VALUE);

        List<PeriodicalInfo> list = periodicalDao.getByQuery(query);

        PeriodicalInfo periodical = new PeriodicalInfo();
        if (!CollectionUtils.isEmpty(list))
            periodical = list.get(0);

        mav.addObject("periodical", periodical);
        mav.addObject("list", list);
        return mav;
    }
    /*中国华电工程期刊-detail*/
    @RequestMapping(value = {"/periodical-{periodicalId}.htm"}, method = RequestMethod.GET)
    public ModelAndView periodicalDetail(
            @PathVariable String periodicalId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/band/periodical-detail");
        if (StringUtils.isBlank(periodicalId)) {
            mav.setViewName("common/message");
            mav.addObject("message","访问的内容不存在，请稍后重试!");
            return mav;
        }
        PeriodicalInfo periodical = periodicalDao.getById(periodicalId);
        List<Integer> yearsList = periodicalDao.getYearsList();
        mav.addObject("periodical", periodical);
        mav.addObject("yearsList", yearsList);
        return mav;
    }

    /*中国华电工程期刊-目录*/
    @RequestMapping(value = {"/periodical/summary-{periodicalId}.htm"}, method = RequestMethod.GET)
    public ModelAndView periodicalSummary(
            @PathVariable String periodicalId) throws Exception {
        ModelAndView mav = new ModelAndView("front/band/periodical-summary");
        if (StringUtils.isBlank(periodicalId)) {
            mav.setViewName("common/message");
            mav.addObject("message","访问的内容不存在，请稍后重试!");
            return mav;
        }
        PeriodicalInfo periodical = periodicalDao.getById(periodicalId);
        mav.addObject("periodical", periodical);
        return mav;
    }

    /*public static void main(String[] args) {
        System.out.println(StringEscapeUtils.escapeHtml("kw=\"><script>confirm(3263)</script>"));
        System.out.println(StringEscapeUtils.unescapeHtml(StringEscapeUtils.escapeHtml("kw=\"><script>confirm(3263)</script>")));
    }*/
}
