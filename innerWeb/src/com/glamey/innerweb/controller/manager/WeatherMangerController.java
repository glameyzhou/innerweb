package com.glamey.innerweb.controller.manager;

import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.model.dto.ChinaWeather;
import com.glamey.innerweb.model.dto.weatherinfo;
import com.google.gson.Gson;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class WeatherMangerController extends BaseController {

    @RequestMapping(value = "mg/weatcher.htm", method = RequestMethod.GET)
    @ResponseBody
    public String getWeather(HttpServletRequest request, HttpServletResponse response) {
        String cityId = WebUtils.getRequestParameterAsString(request, "cityId");
        if (StringUtils.isBlank(cityId)) {
            cityId = "101010100";//北京天气
            /*http://www.weather.com.cn/data/sk/101010100.html
            http://www.weather.com.cn/data/cityinfo/101010100.html
            http://m.weather.com.cn/data/101010100.html*/
        }
        StringBuffer result = new StringBuffer();
        if (result.length() > 0) {
            Gson gson = new Gson();
            ChinaWeather cw = gson.fromJson(result.toString(), ChinaWeather.class);
            if (cw != null) {
                weatherinfo w = cw.getWeatherinfo();
                w.setImg1("http://m.weather.com.cn/img/" + w.getImg1());
                w.setImg2("http://m.weather.com.cn/img/" + w.getImg2());

                result.append(cw.getWeatherinfo().getCity()).append("&nbsp;");
                result.append(cw.getWeatherinfo().getTemp1()).append("-");
                result.append(cw.getWeatherinfo().getTemp2()).append("&nbsp;");
                result.append(cw.getWeatherinfo().getWeather()).append("&nbsp;");
                result.append("<img src='").append(cw.getWeatherinfo().getImg1()).append("' />");
                result.append("<img src='").append(cw.getWeatherinfo().getImg2()).append("' />");
            }

        }

        String date = DateFormatUtils.format(new Date(), "yyyy年MM月dd日");
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        String week = weekDays[w];

        StringBuffer pageShow = new StringBuffer(date);
        pageShow.append("&nbsp;&nbsp;");
        pageShow.append(week);
        pageShow.append("&nbsp;&nbsp;");
        pageShow.append(result);

        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.getWriter().print(pageShow);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
