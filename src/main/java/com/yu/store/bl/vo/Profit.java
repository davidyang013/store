package com.yu.store.bl.vo;

import com.yu.store.sys.vo.Page;


public class Profit extends Page{

	private static final long serialVersionUID = 1L;
	
	private String orderId;
	
	private String month;
	
	private String purchasePrice;
	
	private String price;
	
	private String transFee;
	
	private String actualTransFee;
	
	private String profit;
	
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getPurchasePrice() {
		return purchasePrice + "元";
	}

	public void setPurchasePrice(String purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public String getPrice() {
		return price + "元";
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getTransFee() {
		return transFee + "元";
	}

	public void setTransFee(String transFee) {
		this.transFee = transFee;
	}
	
	public String getActualTransFee() {
		return actualTransFee;
	}

	public void setActualTransFee(String actualTransFee) {
		this.actualTransFee = actualTransFee;
	}

	public String getProfit() {
		return profit + "元";
	}

	public void setProfit(String profit) {
		this.profit = profit;
	}
	
}
