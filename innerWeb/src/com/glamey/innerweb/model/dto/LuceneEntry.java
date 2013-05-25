/**
 *
 */
package com.glamey.innerweb.model.dto;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * @author zy
 */
public class LuceneEntry implements Serializable {
    private static final long serialVersionUID = -5199077197031297805L;

    /**
     * 标识
     */
    private String id ;
    /**
     * 模块ID
     */
    private String model;

    /**
     * 模块名字
     */
    private String modelName ;

    /**
     * 链接
     */
    private String href;
    /**
     * 标题
     */
    private String title;
    /**
     * 摘要
     */
    private String summary ;
    /**
     * 内容
     */
    private String content;

    private String time ;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this,
                ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
