/**
 * 
 */
package com.glamey.chec_cn.model.domain;

import java.io.Serializable;

/**
 * @author zy
 * 
 */
public class ResumeWorkInfo implements Serializable {
	private static final long serialVersionUID = 1498860988186815500L;

	private String resumeId;
	private int id;
	/*
	 * 开始时间 yyyy-MM-dd
	 */
	private String start;
	/**
	 * 结束时间 yyyy-MM-dd
	 */
	private String end;
	/**
	 * 工作单位
	 */
	private String company;
	/**
	 * 岗位
	 */
	private String station;
	/**
	 * 证明人
	 */
	private String provePerson;
	/**
	 * 联系方式
	 */
	private String contact;
	/**
	 * 职责
	 */
	private String responsibility;
	/**
	 * 离职原因
	 */
	private String leaveReason;

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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station;
	}

	public String getProvePerson() {
		return provePerson;
	}

	public void setProvePerson(String provePerson) {
		this.provePerson = provePerson;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getResponsibility() {
		return responsibility;
	}

	public void setResponsibility(String responsibility) {
		this.responsibility = responsibility;
	}

	public String getLeaveReason() {
		return leaveReason;
	}

	public void setLeaveReason(String leaveReason) {
		this.leaveReason = leaveReason;
	}
}
