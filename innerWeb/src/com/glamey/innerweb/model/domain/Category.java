/**
 * 
 */
package com.glamey.innerweb.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 系统所有分类信息
 * @author zy
 * 
 */
public class Category implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private String id;
	private String name;
	/**短名字*/
	private String shortName ;
	private String describe;
	/** 显示类型 0=列表页 1=内容页 */
	private int showType;
	/** 是否首页显示 0=否 1=是 **/
	private int showIndex;
	/** 父ID 根为0 **/
	private String parentId;
	/**分类类型*/
	private String categoryType ;
	/**分类图片*/
	private String categoryImage ;

	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getShortName() {
		return shortName;
	}


	public void setShortName(String shortName) {
		this.shortName = shortName;
	}


	public String getDescribe() {
		return describe;
	}


	public void setDescribe(String describe) {
		this.describe = describe;
	}


	public int getShowType() {
		return showType;
	}


	public void setShowType(int showType) {
		this.showType = showType;
	}


	public int getShowIndex() {
		return showIndex;
	}


	public void setShowIndex(int showIndex) {
		this.showIndex = showIndex;
	}


	public String getParentId() {
		return parentId;
	}


	public void setParentId(String parentId) {
		this.parentId = parentId;
	}


	public String getCategoryType() {
		return categoryType;
	}


	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
	}


	public String getCategoryImage() {
		return categoryImage;
	}


	public void setCategoryImage(String categoryImage) {
		this.categoryImage = categoryImage;
	}


	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,
				ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
