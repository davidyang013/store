package com.yu.store.sys.vo;

import java.io.Serializable;

/**
 * @author Kingking Yu
 *
 */
public class Base implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String beginDate;
	
	private String endDate;
	
	private String radioCalc;

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getRadioCalc() {
		return radioCalc;
	}

	public void setRadioCalc(String radioCalc) {
		this.radioCalc = radioCalc;
	}
	
}
