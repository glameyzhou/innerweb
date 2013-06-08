/**
 * 
 */
package com.glamey.innerweb.model.domain;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * @author zy
 *
 */
public class LibraryInfo implements Serializable {
	private static final long serialVersionUID = -4602365176206792577L;
	
	private String id ;
	/**
	 * 分类ID
	 */
	private String categoryId ;
	
	private Category category ;
	/**
	 * 1  名称、URL
	 * 2 名称、自定义内容，点击之后跳入自己的内容页面
	 * 3 上传图片、URL
	 */
	private int type ;
	/**
	 * 显示名称
	 */
	private String name ;
	/**
	 * 指定URL
	 */
	private String url ;
	
	/**
	 * 指定内容
	 */
	private String content ;
	/**
	 * 上传图片
	 */
	private String image ;
	/**
	 * 操作时间
	 */
	private Date time ;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCategoryId() {
		return categoryId;
	}
	
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	
	public Category getCategory() {
		return category;
	}
	
	public void setCategory(Category category) {
		this.category = category;
	}
	
	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}

}
