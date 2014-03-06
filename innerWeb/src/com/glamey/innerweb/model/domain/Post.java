/**
 * 
 */
package com.glamey.innerweb.model.domain;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 主题内容
 * 
 * @author zy
 * 
 */
public class Post implements Serializable {
	private static final long serialVersionUID = 1L;

	private String id;
	private String categoryType;
	private String categoryId;
	private Category category ;
	
	private String title ;
	private String author ;
    private String nickname ;
    //发布部门
	private String source ;
    private Category deptCategory = new Category(); ;
	private String time ;
	/*是否首页显示*/
	private int showIndex ;
	/*是否列表显示*/
	private int showList ;
	/*是否同意审核*/
	private int apply ;
	/*是否为焦点图*/
	private int focusImage ;
	/*是否为热点*/
	private int hot ;
	/*摘要*/
	private String summary ;
	/*图片*/
	private String image ;
	/*正文*/
	private String content ;

    private UserInfo userInfo = new UserInfo();

    /**
     * 是否为最新的内容（用来显示标题前边的new字眼）
     */
    private int showisNew = 0;
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getCategoryType() {
		return categoryType;
	}


	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
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


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getSource() {
		return source;
	}


	public void setSource(String source) {
		this.source = source;
	}


	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}


	public int getShowIndex() {
		return showIndex;
	}


	public void setShowIndex(int showIndex) {
		this.showIndex = showIndex;
	}


	public int getShowList() {
		return showList;
	}


	public void setShowList(int showList) {
		this.showList = showList;
	}


	public int getApply() {
		return apply;
	}


	public void setApply(int apply) {
		this.apply = apply;
	}


	public int getFocusImage() {
		return focusImage;
	}


	public void setFocusImage(int focusImage) {
		this.focusImage = focusImage;
	}


	public int getHot() {
		return hot;
	}


	public void setHot(int hot) {
		this.hot = hot;
	}


	public String getSummary() {
		return summary;
	}


	public void setSummary(String summary) {
		this.summary = summary;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public Category getDeptCategory() {
        return deptCategory;
    }

    public void setDeptCategory(Category deptCategory) {
        this.deptCategory = deptCategory;
    }

    public int getShowisNew() {
        return showisNew;
    }

    public void setShowisNew(int showisNew) {
        this.showisNew = showisNew;
    }

    @Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,
				ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
