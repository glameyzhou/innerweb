package com.glamey.chec_cn.controller.front;

import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.ChecDao;
import com.glamey.chec_cn.dao.PostDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Post;
import com.glamey.chec_cn.model.dto.PostQuery;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

/**
 * Created by zy
 */

@Controller
public class OutsideFrontController extends BaseController {

    private static final Logger logger = Logger.getLogger(OutsideFrontController.class);
    @Autowired
    private ChecDao checDao;
    @Autowired
    private PostDao postDao;

    @RequestMapping(value = "/synchChecNews.htm", method = RequestMethod.GET)
    public ModelAndView synchChecNews(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String nodeId = WebUtils.getRequestParameterAsString(request,"nodeId");
        List<Post> checNewsList = checDao.getChecNews(null,null,nodeId);
        PrintWriter out = response.getWriter();
        response.setContentType("text/html,charset=UTF-8");
        int i = 0 ;
        for (Post post : checNewsList) {
            out.print(postDao.createReturnId(post) + "&nbsp;&nbsp;&nbsp;");
            if (i % 8 == 0)
                out.print("<br/>");
            i++;
        }
        return null;
    }
    @RequestMapping(value = "/replaceImagePath.htm", method = RequestMethod.GET)
    public ModelAndView replaceImagePath(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");
        String message = "" ;
        String k = WebUtils.getRequestParameterAsString(request, "k");
        String v = WebUtils.getRequestParameterAsString(request, "v");
        if(StringUtils.isBlank(k)){
            message = "转化失败，起始位置不能为空！" ;
            mav.addObject("message", message);
            return mav ;

        }
        PostQuery query = new PostQuery();
        query.setStart(0);
        query.setNum(Integer.MAX_VALUE);
        List<Post> list = postDao.getByQuery(query);
        for (Iterator<Post> it = list.iterator();it.hasNext();) {
            Post p = it.next();
            String content = p.getContent();
            String image = p.getFocusImage();

            if (StringUtils.isNotBlank(content) && StringUtils.contains(content,k))
                content = StringUtils.replace(content,k,v);
            if (StringUtils.isNotBlank(image) && StringUtils.contains(image,k))
                image = StringUtils.replace(image,k,v);

            p.setUpdateTime(p.getPublishTime());
            postDao.update(p);
        }
        mav.addObject("message","图片位置转化成功!");
        return null;
    }
}
