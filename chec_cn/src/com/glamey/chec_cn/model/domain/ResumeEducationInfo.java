/**
 * 
 */
package com.glamey.chec_cn.model.domain;

import java.io.Serializable;

/**
 * @author zy
 *
 */
public class ResumeEducationInfo implements Serializable {
	private static final long serialVersionUID = 1498860988186815500L;

	private String resumeId ;
	private int id ;
	/*
	 * 开始时间 yyyy-MM-dd
	 */
	private String start ;
	/**
	 * 结束时间 yyyy-MM-dd
	 */
	private String end ;
	/**
	 * 院校
	 */
	private String school ;
	/**
	 * 专业
	 */
	private String profession ;
	/**
	 * 学历
	 */
	private String background ;
	/**
	 * 学位
	 */
	private String egree;
	/**
	 * 学习形式
	 */
	private String category ;
	
	public String getResumeId() {
		return resumeId;
	}
	public void setResumeId(String resumeId) {
		this.resumeId = resumeId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getProfession() {
		return profession;
	}
	public void setProfession(String profession) {
		this.profession = profession;
	}
	public String getBackground() {
		return background;
	}
	public void setBackground(String background) {
		this.background = background;
	}
	public String getEgree() {
		return egree;
	}
	public void setEgree(String egree) {
		this.egree = egree;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
}
