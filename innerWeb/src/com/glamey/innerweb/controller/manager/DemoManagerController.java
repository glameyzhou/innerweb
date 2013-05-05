/**
 * 
 */
package com.glamey.innerweb.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.model.domain.Category;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author zy
 *
 */
@Controller
@RequestMapping(value="/mg")
public class DemoManagerController extends BaseController {
	private static final Logger logger = Logger.getLogger(DemoManagerController.class);

	@RequestMapping(value="/demo.htm",method=RequestMethod.GET)
	public ModelAndView createShow(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[manager-demo] #demo# " + req.getRequestURI());
		/*ModelAndView mav = new ModelAndView();
        View view = new RedirectView("http://www.sina.com.cn");
        mav.setView(view);
		return mav ;*/

        resp.setStatus(HttpStatus.MOVED_PERMANENTLY.value());
        resp.setHeader("Location","http://www.sina.com.cn");
        return null;
	}


}
