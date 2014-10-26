package com.yu.store.bl.vo;

import com.yu.store.sys.vo.Page;

public class OutStore extends Page{

	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String orderId;
	
	private String inId;
	
	private String price;
	
	private String outDate;
	
	private String transSerial;
	
	private String transFee;

	private String actualTransFee;
	
	private String transCompany;
	
	private String salePrice;
	
	private String warranty;
	
	private String payType;
	
	private String buyType;
	
	private String operator;

	/*************入库信息参数*************/
	private String serial;
	
	private String depSerial;
	
	private String supply;
	
	private String color;
	
	private String count;
	
	private String inDate;
	
	private String isOut;
	
	private String comm;
	
	/*************商品信息参数*************/
	private String brand;
	
	private String type;
	/*************会员信息参数*************/
	private String memberId;
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getInId() {
		return inId;
	}

	public void setInId(String inId) {
		this.inId = inId;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getOutDate() {
		return outDate;
	}

	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}

	public String getTransSerial() {
		return transSerial;
	}

	public void setTransSerial(String transSerial) {
		this.transSerial = transSerial;
	}

	public String getTransFee() {
		return transFee;
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

	public String getTransCompany() {
		return transCompany;
	}

	public void setTransCompany(String transCompany) {
		this.transCompany = transCompany;
	}
	
	public String getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}

	public String getWarranty() {
		return warranty;
	}

	public void setWarranty(String warranty) {
		this.warranty = warranty;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getBuyType() {
		return buyType;
	}

	public void setBuyType(String buyType) {
		this.buyType = buyType;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}

	public String getDepSerial() {
		return depSerial;
	}

	public void setDepSerial(String depSerial) {
		this.depSerial = depSerial;
	}

	public String getSupply() {
		return supply;
	}

	public void setSupply(String supply) {
		this.supply = supply;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getInDate() {
		return inDate;
	}

	public void setInDate(String inDate) {
		this.inDate = inDate;
	}

	public String getIsOut() {
		return isOut;
	}

	public void setIsOut(String isOut) {
		this.isOut = isOut;
	}

	public String getComm() {
		return comm;
	}

	public void setComm(String comm) {
		this.comm = comm;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
}
