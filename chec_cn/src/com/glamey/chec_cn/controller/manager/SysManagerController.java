/**
 *
 */
package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.MetaInfoDao;
import com.glamey.chec_cn.dao.UserInfoDao;
import com.glamey.chec_cn.model.domain.MetaInfo;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 后台管理系统--系统设置
 *
 * @author zy
 */
@Controller
@RequestMapping(value = "/mg/sys")
public class SysManagerController extends BaseController {

    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private MetaInfoDao metaInfoDao;
    @Autowired
    private UserInfoDao userInfoDao;

    @RequestMapping(value = "/sys-list.do", method = RequestMethod.GET)
    public String managerHome(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        return "mg/sys/index";
    }

    @RequestMapping(value = "/meta/{name}/meta-show.do", method = RequestMethod.GET)
    public ModelAndView metaShow(
            @PathVariable String name,
            HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/meta-show");
        if (StringUtils.isBlank(name)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("common/message");
            return mav;
        }
        MetaInfo metaInfo = metaInfoDao.getByName(name);
        mav.addObject("metaInfo", metaInfo);
        return mav;
    }

    /**
     * 系统配置修改
     * mg/sys/meta/popular_Links/meta-show.do
     */
    @RequestMapping(value = "/meta/{name}/meta-update.do", method = RequestMethod.POST)
    public ModelAndView metaUpdate(
            @PathVariable String name,
            HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/meta-show");
        String value = WebUtils.getRequestParameterAsString(request, "value");
        if (StringUtils.isBlank(name)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        MetaInfo metaInfo = new MetaInfo();
        metaInfo.setName(name);
        metaInfo.setValue(value);
        if (metaInfoDao.update(metaInfo)) {
            mav.addObject("message", "修改成功");
        } else {
            mav.addObject("message", "修改失败");
        }
        mav.addObject("metaInfo", metaInfo);
        return mav;
    }
}
