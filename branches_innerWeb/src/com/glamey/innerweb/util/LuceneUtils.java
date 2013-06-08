/**
 *
 */
package com.glamey.innerweb.util;

import com.glamey.framework.utils.FileUtils;
import com.glamey.innerweb.constants.LuceneConstants;
import com.glamey.innerweb.model.dto.LuceneEntry;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.*;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.LockObtainFailedException;
import org.wltea.analyzer.lucene.IKAnalyzer;
import org.wltea.analyzer.lucene.IKQueryParser;
import org.wltea.analyzer.lucene.IKSimilarity;

import java.io.IOException;
import java.io.StringReader;
import java.util.Date;
import java.util.List;

/**
 * @author zy
 */
public class LuceneUtils extends LuceneConstants {
    private static final Logger log = Logger.getLogger(LuceneUtils.class);
    private static Analyzer analyzer = new IKAnalyzer();
    private static Directory directory = null;
    private static IndexWriter iwriter = null;
    private static IndexSearcher isearcher = null;
    private static TokenStream tokenStream = null;

    static {
        FileUtils.mkdirs(INDEXDIR);
    }

    /**
     * 创建索引
     *
     * @param isCreate 是否创建新的索引，false:创建增量索引
     * @param entries  要创建的实体对象集合
     */
    public void createIndex(boolean isCreate, List<LuceneEntry> entries) {
        try {
            Date startTime = new Date();
            directory = FSDirectory.open(INDEXDIR);
            iwriter = new IndexWriter(directory, analyzer, isCreate, IndexWriter.MaxFieldLength.LIMITED);
            Document doc = null;
            for (LuceneEntry entry : entries) {
                doc = new Document();
                doc.add(new Field(flID, String.valueOf(entry.getId()), Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field(flModel, entry.getModel(), Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field(flModelName, entry.getModelName(), Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field(flHref, entry.getHref(), Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field(flTime, entry.getTime(), Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field(flTitle, StringUtils.isBlank(entry.getTitle()) ? "" : entry.getTitle(), Field.Store.YES, Field.Index.ANALYZED));
                doc.add(new Field(flSummary, StringUtils.isBlank(entry.getSummary()) ? "" : entry.getSummary(), Field.Store.YES, Field.Index.ANALYZED));
                doc.add(new Field(flContent, StringUtils.isBlank(entry.getContent()) ? "" : entry.getContent(), Field.Store.YES, Field.Index.ANALYZED));
                iwriter.addDocument(doc);
            }
            iwriter.optimize();
            iwriter.close();
        } catch (CorruptIndexException e) {
            e.printStackTrace();
        } catch (LockObtainFailedException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (directory != null)
                try {
                    directory.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }
    }

    /**
     * 根据关键字进行查询
     *
     * @param keyword
     * @param start
     * @param num
     * @author ZY
     */
    public void search(String keyword, int start, int num) {
        try {
            directory = FSDirectory.open(INDEXDIR);
            isearcher = new IndexSearcher(directory);
            isearcher.setSimilarity(new IKSimilarity());
            String fieldNames[] = {flTitle,flSummary, flContent};
            Query query = IKQueryParser.parseMultiField(fieldNames, keyword);
            Filter filter = null;
            TopScoreDocCollector topCollector = TopScoreDocCollector.create(isearcher.maxDoc(), true);
            isearcher.search(query, filter, topCollector);
            if (log.isDebugEnabled())
                log.debug(" hits " + topCollector.getTotalHits());
            ScoreDoc docs[] = topCollector.topDocs(start, num).scoreDocs;

            LuceneEntry entry = null;
            String title = "";
            for (ScoreDoc sDoc : docs) {
                entry = new LuceneEntry();
                if (log.isDebugEnabled())
                    log.debug("ScoreDoc.score: " + sDoc.score);

                Document doc = isearcher.doc(sDoc.doc);
                if (log.isDebugEnabled())
                    log.debug("Document boost : " + doc.getBoost());

                title = doc.get(flTitle);
                // 高亮显示
                title = getHighlighter(query, doc, flTitle, keyword, null, null);
                entry.setId(doc.get(flID));
                entry.setModel(doc.get(flModel));
                entry.setModelName(doc.get(flModelName));
                entry.setHref(doc.get(flHref));
                entry.setTitle(title);
                entry.setContent(doc.get(flContent));
                entry.setTime(doc.get(flTime));
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
    }

    /**
     * <p>高亮显示</p>
     *
     * @param query   查询对象
     * @param doc     单个文档
     * @param preTag  高亮前缀
     * @param postTag 高亮后缀
     * @return java.lang.String
     */
    public static String getHighlighter(Query query, Document doc, String fieldName, String keyword, String preTag, String postTag) {
        String hString = "";
        if (StringUtils.isBlank(preTag))
            preTag = "<font color=\"red\">";
        if (StringUtils.isBlank(postTag))
            postTag = "</font>";
        SimpleHTMLFormatter simpleHtmlFormatter = new SimpleHTMLFormatter(preTag, postTag);
        Highlighter highlighter = new Highlighter(simpleHtmlFormatter, new QueryScorer(query));
        if (analyzer == null)
            analyzer = new IKAnalyzer();
        tokenStream = analyzer.tokenStream(fieldName, new StringReader(doc.get(fieldName)));
        try {
            hString = highlighter.getBestFragment(tokenStream, doc.get(fieldName));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InvalidTokenOffsetsException e) {
            e.printStackTrace();
        }
        hString = IKQueryParser.getHighlightString(keyword, doc.get(fieldName), preTag, postTag);
        return hString;
    }

    public void updateIndex() {

    }

    /**
     * 删除指定的索引，一般情况下都是删除ID对应的字段
     *
     * @param indexId
     * @param fieldName
     * @author ZY
     * @date 2010-11-6 下午05:48:02
     */
    public void deleteIndex(String indexId, String fieldName) {
        if (StringUtils.isBlank(fieldName))
            fieldName = flID;
        try {
            directory = FSDirectory.open(INDEXDIR);
            IndexReader reader = IndexReader.open(directory, false);
            Term term = new Term(fieldName, indexId);
            reader.deleteDocuments(term);
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (directory != null)
                try {
                    directory.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }
    }
}
