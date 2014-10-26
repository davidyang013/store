package com.yu.store.sys.vo;

import java.io.Serializable;

/**
 * @author Kingking Yu
 *
 */
public class Page extends Base implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private int pageSize = 20;
	
	private String curPage = "1";
	
	private String maxPage = "1";
	
	private String params;
	
	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getCurPage() {
		return curPage;
	}

	public void setCurPage(String curPage) {
		try {
			Integer.parseInt(curPage);
			this.curPage = curPage;
		} catch (NumberFormatException e) {
			this.curPage = "1";
		}
	}

	public String getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(String maxPage) {
		try {
			Integer.parseInt(maxPage);
			this.maxPage = maxPage;
		} catch (NumberFormatException e) {
			this.maxPage = "1";
		}
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}
	
}
