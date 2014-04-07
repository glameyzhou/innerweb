package com.glamey.chec_cn.controller.manager;

import com.glamey.framework.utils.WebUtils;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.model.dto.ChinaWeather;
import com.glamey.chec_cn.model.dto.weatherinfo;
import com.google.gson.Gson;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Calendar;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class WeatherMangerController extends BaseController {

    @RequestMapping(value = "weather.htm", method = RequestMethod.GET)
    @ResponseBody
    public String getWeather(HttpServletRequest request, HttpServletResponse response) {
        String cityId = WebUtils.getRequestParameterAsString(request, "cityId");
        if (StringUtils.isBlank(cityId)) {
            cityId = "101010100";//北京天气
            /*http://www.weather.com.cn/data/sk/101010100.html
            http://www.weather.com.cn/data/cityinfo/101010100.html
            http://m.weather.com.cn/data/101010100.html*/
        }
        StringBuffer source = new StringBuffer();
        URL requestURL;
        try {
            requestURL = new URL("http://www.weather.com.cn/data/cityinfo/" + cityId +".html");
            HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
            InputStream is = conn.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
            String line ;
            while((line = br.readLine()) != null){
                source.append(line).append(System.getProperty("line.separator"));
            }
            br.close();
            is.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        StringBuilder first = new StringBuilder();
        if (source.length() > 0) {
            Gson gson = new Gson();
            ChinaWeather cw = gson.fromJson(source.toString(), ChinaWeather.class);
            if (cw != null) {
                weatherinfo w = cw.getWeatherinfo();
                w.setImg1("http://m.weather.com.cn/img/" + w.getImg1());
                w.setImg2("http://m.weather.com.cn/img/" + w.getImg2());

                first.append(cw.getWeatherinfo().getCity()).append("&nbsp;");
                first.append("<img src='").append(cw.getWeatherinfo().getImg1()).append("' />&nbsp;");
                first.append("<img src='").append(cw.getWeatherinfo().getImg2()).append("' />&nbsp;");
                first.append(cw.getWeatherinfo().getWeather()).append("&nbsp;");
                first.append(cw.getWeatherinfo().getTemp1()).append("~");
                first.append(cw.getWeatherinfo().getTemp2());
            }
        }
        String date = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        String week = weekDays[w];

        StringBuffer pageShow = new StringBuffer();
        pageShow.append("今天是:");
        pageShow.append(date);
        pageShow.append("&nbsp;&nbsp;(");
        pageShow.append(week);
        pageShow.append(")&nbsp;&nbsp;");
        pageShow.append(first);

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
