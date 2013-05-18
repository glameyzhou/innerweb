package com.glamey.framework.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class PageBean {
	private final int ROWSPERPAGE = 2;
	private final int INDEXCOUNTPERPAGE = 5;
	private int curPage;
	private int maxPage;
	private int maxRowCount;
	private int rowsPerPage = ROWSPERPAGE;
	private List<Integer> pageNoList;
	private int start;

	public int getStart() {
		if (getCurPage() > 0)
			this.start = ((getCurPage() - 1) * getRowsPerPage());
		else {
			this.start = 0;
		}
		return this.start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public PageBean() {
		this.curPage = 1;
		this.start = 0;
		this.rowsPerPage = ROWSPERPAGE;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getCurPage() {
		return this.curPage;
	}

	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}

	public void setMaxPage() {
		if (this.maxRowCount % this.rowsPerPage == 0)
			this.maxPage = (this.maxRowCount / this.rowsPerPage);
		else
			this.maxPage = (this.maxRowCount / this.rowsPerPage + 1);
	}

	public int getMaxPage() {
		return this.maxPage;
	}

	public void setMaxRowCount(int maxRowCount) {
		this.maxRowCount = maxRowCount;
	}

	public int getMaxRowCount() {
		return this.maxRowCount;
	}

	public int getRowsPerPage() {
		return this.rowsPerPage;
	}

	public List<Integer> getPageNoList() {
		return this.pageNoList;
	}

	public void setPageNoList() {
		List<Integer> listNo = new ArrayList<Integer>();
		if (this.maxPage <= INDEXCOUNTPERPAGE) {
			for (int i = 1; i <= this.maxPage; i++) {
				listNo.add(Integer.valueOf(i));
			}
		} else if (getCurPage() == 0) {
			for (int i = 1; i <= INDEXCOUNTPERPAGE; i++)
				listNo.add(Integer.valueOf(i));
		} else {
			for (int i = this.curPage; i < INDEXCOUNTPERPAGE + this.curPage; i++) {
				if (i <= this.maxPage) {
					listNo.add(Integer.valueOf(i));
				}
			}

			if ((listNo.size() > 0) && (listNo.size() < INDEXCOUNTPERPAGE)) {
				List<Integer> needNo = new ArrayList<Integer>();
				int diff = INDEXCOUNTPERPAGE - listNo.size();
				int co = 0;

				for (int m = ((Integer) listNo.get(0)).intValue() - diff; m <= ((Integer) listNo
						.get(0)).intValue() - diff + INDEXCOUNTPERPAGE; m++) {
					co++;
					if (co <= diff)
						needNo.add(Integer.valueOf(m));
				}
				needNo.addAll(listNo);
				listNo = needNo;
			}

		}

		this.pageNoList = listNo;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this,
				ToStringStyle.SHORT_PREFIX_STYLE);
	}
}