package com.glamey.chec_cn.model.dto;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class ChinaWeather {
    private weatherinfo weatherinfo;

    public weatherinfo getWeatherinfo() {
        return weatherinfo;
    }

    public void setWeatherinfo(weatherinfo weatherinfo) {
        this.weatherinfo = weatherinfo;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this,ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
