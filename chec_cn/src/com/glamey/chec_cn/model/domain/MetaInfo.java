package com.glamey.chec_cn.model.domain;

import java.io.Serializable;

/**
 * 全局系统变量对象
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class MetaInfo implements Serializable {

	private static final long serialVersionUID = 5280120721851184908L;
	private String name ;
    private String value ;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "MetaInfo{" +
                "name='" + name + '\'' +
                ", value='" + value + '\'' +
                '}';
    }
}
