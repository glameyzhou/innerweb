package com.glamey.library.controller.manager;

import com.glamey.framework.utils.FileUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.LuceneConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.controller.front.IncludeFront;
import com.glamey.library.dao.LibraryInfoDao;
import com.glamey.library.dao.PostDao;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.LuceneEntry;
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
import org.springframework.jdbc.core.JdbcTemplate;
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
    private IncludeFront includeFront;
    @Resource
    private PostDao postDao ;
    @Resource
    private LibraryInfoDao libraryInfoDao ;

    private LuceneUtils lu = new LuceneUtils();
    private static Directory directory = null;
    private static IndexSearcher isearcher = null;

    //创建索引
    @RequestMapping(value = "/lucene/build.htm", method = RequestMethod.GET)
    @ResponseBody
    public void luceneBuild(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        List<LuceneEntry> entries = new ArrayList<LuceneEntry>(1000);
        //Post-news内容
        entries.addAll(postDao.getPostLuceneEntry());
        //图书馆内容
        entries.addAll(libraryInfoDao.getLibraryLuceneEntry());

        String result = "";
        try {
            lu.createIndex(true, entries);
            result = "ok";
        } catch (Exception e) {
            e.printStackTrace();
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

        ModelAndView mav = new ModelAndView("front/search");
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
				title = LuceneUtils.getHighlighter(query, doc, LuceneConstants.flTitle, kw, null,null);
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
        mav.addAllObjects(modelMap);

        mav.addAllObjects(includeFront.allInclude(request,response,session));
        return mav;
    }

}
