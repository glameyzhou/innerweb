package com.glamey.library.controller.manager;

import com.glamey.framework.utils.FileUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.LuceneConstants;
import com.glamey.library.constants.SystemConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.controller.front.IncludeFront;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.PostDao;
import com.glamey.library.model.domain.Post;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.LuceneEntry;
import com.glamey.library.model.dto.PostQuery;
import com.glamey.library.util.LuceneUtils;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.LockObtainFailedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.wltea.analyzer.lucene.IKQueryParser;
import org.wltea.analyzer.lucene.IKSimilarity;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 全文索引管理
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class LuceneManagerController extends BaseController {

    @Resource
    private PostDao postDao;
    @Resource
    private CategoryDao categoryDao ;
    @Resource
    private IncludeFront includeFront;

    private LuceneUtils lu = new LuceneUtils();
    private static Directory directory = null;
    private static IndexSearcher isearcher = null;


    //创建索引
    @RequestMapping(value = "/lucene/build.htm", method = RequestMethod.GET)
    @ResponseBody
    public void luceneBuild(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        List<LuceneEntry> entries = new ArrayList<LuceneEntry>();
        LuceneEntry entry = null;

        //Post-news内容
        PostQuery queryNews = new PostQuery();
        queryNews.setCategoryType(CategoryConstants.CATEGORY_NEWS);
        queryNews.setStart(0);
        queryNews.setNum(Integer.MAX_VALUE);
        List<Post> newsList = postDao.getByCategoryId(queryNews);
        for (Post obj : newsList) {
            entry = new LuceneEntry();
            entry.setId(obj.getId());
            entry.setModel(obj.getCategoryId());
            entry.setModelName(obj.getCategory().getShortName());
            entry.setHref("p-" + entry.getId() + ".htm");
            entry.setTitle(obj.getTitle());
            entry.setContent(obj.getContent());
            entry.setTime(obj.getTime());
            entries.add(entry);
        }
        
      //Post-notices内容
        PostQuery queryNotices = new PostQuery();
        queryNews.setCategoryType(CategoryConstants.CATEGORY_NOTICES);
        queryNotices.setStart(0);
        queryNotices.setNum(Integer.MAX_VALUE);
        List<Post> noticesList = postDao.getByCategoryId(queryNotices);
        for (Post obj : noticesList) {
            entry = new LuceneEntry();
            entry.setId(obj.getId());
            entry.setModel(obj.getCategoryId());
            entry.setModelName(obj.getCategory().getShortName());
            entry.setHref("p-" + entry.getId() + ".htm");
            entry.setTitle(obj.getTitle());
            entry.setContent(obj.getContent());
            entry.setTime(obj.getTime());
            entries.add(entry);
        }
        String result = "";
        try {
            lu.createIndex(true, entries);
            result = "ok";
        } catch (Exception e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            result = "failure";
        }
        response.getWriter().print(result);
    }

    //创建索引页面
    @RequestMapping(value = "/lucene/show.htm", method = RequestMethod.GET)
    public ModelAndView luceneShow(
            HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mg/sys/lucene-show");
        mav.addAllObjects(modelMap);
        return mav;
    }

    //全站搜索
    @RequestMapping(value = "/search.htm", method = RequestMethod.GET)
    public ModelAndView search(
            @RequestParam(value = "kw", required = false, defaultValue = "") String kw,
            @RequestParam(value = "curPage", required = false, defaultValue = "1") String pg,
            HttpServletRequest request, HttpServletResponse response,HttpSession session, ModelMap modelMap) throws Exception {

        ModelAndView mav = new ModelAndView();
        String viewName = "front/post-search";
        int curPage = Integer.parseInt(pg);
        kw = StringTools.converISO2UTF8(kw);

        pageBean = new PageBean(Constants.rowsPerPageFront);
        pageBean.setCurPage(curPage);
        List<LuceneEntry> entries = new ArrayList<LuceneEntry>();
        FileUtils.mkdirs(LuceneConstants.INDEXDIR);
        try {
            directory = FSDirectory.open(LuceneConstants.INDEXDIR);
            isearcher = new IndexSearcher(directory);
            isearcher.setSimilarity(new IKSimilarity());
            String fieldNames[] = {LuceneConstants.flTitle,LuceneConstants.flSummary, LuceneConstants.flContent};
            Query query = IKQueryParser.parseMultiField(fieldNames, kw);
            TopScoreDocCollector topCollector = TopScoreDocCollector.create(isearcher.maxDoc(), true);
            isearcher.search(query, topCollector);

            int maxRowCount = topCollector.getTotalHits();
            pageBean.setMaxRowCount(maxRowCount);
            pageBean.setMaxPage();
            pageBean.setPageNoList();


            ScoreDoc docs[] = topCollector.topDocs(pageBean.getStart(), pageBean.getRowsPerPage()).scoreDocs;
//            System.out.println("docs=" + Arrays.deepToString(docs));
            LuceneEntry entry = null;
            String title = "";
            for (ScoreDoc sDoc : docs) {
                entry = new LuceneEntry();
                Document doc = isearcher.doc(sDoc.doc);
                title = doc.get(LuceneConstants.flTitle);
                // 高亮显示
//				title = LuceneUtils.getHighlighter(query, doc, LuceneConstants.flTitle, kw, null,null);
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
        modelMap.put("entries", entries);
        modelMap.put("pageBean", pageBean);
        modelMap.put("kw", kw);
        mav.setViewName(viewName);
        mav.addAllObjects(modelMap);

        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        String userId = ((UserInfo) obj).getUserId();
        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks(request));
        mav.addObject("unReadMessage", includeFront.unReadMessage(userId));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));
        
        return mav;
    }

}
