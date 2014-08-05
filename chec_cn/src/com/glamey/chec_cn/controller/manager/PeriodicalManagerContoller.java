package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.PeriodicalDao;
import com.glamey.chec_cn.model.domain.PeriodicalInfo;
import com.glamey.chec_cn.model.domain.UploadInfo;
import com.glamey.chec_cn.model.dto.PeriodicalQuery;
import com.glamey.chec_cn.util.UploadType;
import com.glamey.chec_cn.util.WebUploadUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.RegexUtils;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * 期刊管理
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/mg/periodical")
public class PeriodicalManagerContoller extends BaseController {
    public static final Logger logger = Logger.getLogger(PeriodicalManagerContoller.class);

    @Autowired
    private WebUploadUtils uploadUtils;
    @Autowired
    private PeriodicalDao periodicalDao;

    @RequestMapping(value = "/list.do", method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("mg/periodical/list");
        //请求参数获取
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "kw");
        keyword = StringTools.converISO2UTF8(keyword);
        int yearsStart = WebUtils.getRequestParameterAsInt(request, "yearsStart", 2000);
        int yearsEnd = WebUtils.getRequestParameterAsInt(request, "yearsEnd", 2015);

        PeriodicalQuery query = new PeriodicalQuery();
        query.setKw(keyword);
        query.setYearsStart(yearsStart);
        query.setYearsEnd(yearsEnd);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<PeriodicalInfo> list = periodicalDao.getByQuery(query);
        pageBean.setMaxRowCount(periodicalDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("list", list);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        return mav;
    }

    @RequestMapping(value = "/show.do", method = RequestMethod.GET)
    public ModelAndView show(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/periodical/show");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String opt = "create";
        PeriodicalInfo periodical = new PeriodicalInfo();
        periodical.setCreateTime(new Date());
        if (StringUtils.isNotBlank(id)) {
            periodical = periodicalDao.getById(id);
            opt = "update";
        }
        mav.addObject("opt", opt);
        mav.addObject("periodical", periodical);
        return mav;
    }

    @RequestMapping(value = "/create.do", method = RequestMethod.POST)
    public ModelAndView postCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        PeriodicalInfo info = new PeriodicalInfo();
        /*图片上传*/
        UploadInfo uploadImage = uploadUtils.doUpload(request, response, UploadType.IMAGE, "pdfImage");
        if (uploadImage.getResultCode() == 2)
            return uploadImage.getModelAndView();
        if (StringUtils.isNotBlank(uploadImage.getFilePath()))
            info.setImages(uploadImage.getFilePath());

        /*附件上传*/
        UploadInfo uploadPdf = uploadUtils.doUpload(request, response, UploadType.PDF, "pdfFile");
        if (uploadPdf.getResultCode() == 2)
            return uploadPdf.getModelAndView();
        if (StringUtils.isNotBlank(uploadPdf.getFilePath())) {
            info.setFileSize(uploadPdf.getFileSize());
            info.setFileName(uploadPdf.getFileName());
            info.setFilePath(uploadPdf.getFilePath());
        }
        String title = WebUtils.getRequestParameterAsString(request, "title");
        String summary = WebUtils.getRequestParameterAsString(request, "summary");
        int years = WebUtils.getRequestParameterAsInt(request, "years", -1);
        int periodical = WebUtils.getRequestParameterAsInt(request, "periodical", 0);
        int periodicalAll = WebUtils.getRequestParameterAsInt(request, "periodicalAll", 0);

        info.setTitle(title);
        info.setSummary(summary);
        info.setYears(years);
        info.setPeriodical(periodical);
        info.setPeriodicalAll(periodicalAll);


        String returnId = periodicalDao.createReturnId(info);
        if (StringUtils.isBlank(returnId)) {
            message = "期刊新增失败";
        } else {
            message = "期刊新增成功.";
            mav.addObject("href", "mg/periodical/list.do");
        }
        mav.addObject("message", message);
        return mav;
    }

    @RequestMapping(value = "/update.do", method = RequestMethod.POST)
    public ModelAndView update(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        PeriodicalInfo info = periodicalDao.getById(id);
        /*图片上传*/
        UploadInfo uploadImage = uploadUtils.doUpload(request, response, UploadType.IMAGE, "image");
        if (uploadImage.getResultCode() == 2)
            return uploadImage.getModelAndView();
        if (StringUtils.isNotBlank(uploadImage.getFilePath()))
            info.setImages(uploadImage.getFilePath());

        /*附件上传*/
        UploadInfo uploadPdf = uploadUtils.doUpload(request, response, UploadType.PDF, "file");
        if (uploadPdf.getResultCode() == 2)
            return uploadPdf.getModelAndView();
        if (StringUtils.isNotBlank(uploadPdf.getFilePath())) {
            info.setFileSize(uploadPdf.getFileSize());
            info.setFileName(uploadPdf.getFileName());
            info.setFilePath(uploadPdf.getFilePath());
        }
        String title = WebUtils.getRequestParameterAsString(request, "title");
        String summary = WebUtils.getRequestParameterAsString(request, "summary");
        int years = WebUtils.getRequestParameterAsInt(request, "years", -1);
        int periodical = WebUtils.getRequestParameterAsInt(request, "periodical", 0);
        int periodicalAll = WebUtils.getRequestParameterAsInt(request, "periodicalAll", 0);

        info.setTitle(title);
        info.setSummary(summary);
        info.setYears(years);
        info.setPeriodical(periodical);
        info.setPeriodicalAll(periodicalAll);

        if (!periodicalDao.update(info)) {
            message = "期刊更新失败,请稍后重试!";
        } else {
            message = "期刊更新成功.";
            mav.addObject("href", "mg/periodical/list.do");
        }
        mav.addObject("message", message);
        return mav;
    }

    @RequestMapping(value = "/del.do", method = RequestMethod.GET)
    public ModelAndView del(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "cant's find the content!");
            return mav;
        }
        try {
            String linksIdArray[] = StringUtils.split(id, ",");
            for (String s : linksIdArray) {
                logger.info("[periodical-del] id=" + s + periodicalDao.deleteById(s));
            }
            mav.addObject("message", "删除成功!");
            mav.addObject("href", "mg/periodical/list.do");
        } catch (Exception e) {
            logger.info("[links-del] error " + e);
            mav.addObject("message", "删除失败!");
        }
        return mav;
    }
    @RequestMapping(value = "/getMax.do", method = RequestMethod.POST)
    public ModelAndView getPeriodicalMax(HttpServletRequest request,HttpServletResponse response) {
        StringBuilder values = new StringBuilder("");
        String title = request.getParameter("title");
        if (StringUtils.isNotBlank(title)) {
            String regex = "(\\d+)年";
            String result = RegexUtils.getGroup1(title,regex);
            if (StringUtils.isNotBlank(result) && NumberUtils.isNumber(result.trim())) {
                int max [] = periodicalDao.getMaxPeriodical(Integer.valueOf(result.trim()));
                values.append(Integer.valueOf(result.trim())).append(",").append(max[0]).append(",").append(max[1]);
            }
            else {
                values.append("0,0,0");
            }
        }
        else {
            values.append("0,0,0");
        }

        try {
            response.getWriter().print(values);
            response.getWriter().close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }
}
