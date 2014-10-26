package com.yu.store.bl.vo;

import com.yu.store.sys.vo.Page;


public class Storage extends Page{

	private static final long serialVersionUID = 1L;
	
	private String serial;
	
	private String depSerial;
	
	private String brand;
	
	private String type;
	
	private String supply;
	
	private String warranty;
	
	private String inDate;
	
	private String color;
	
	private String purchasePrice;
	
	private String salePrice;
	
	private String count;

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

	public String getSupply() {
		return supply;
	}

	public void setSupply(String supply) {
		this.supply = supply;
	}

	public String getWarranty() {
		return warranty;
	}

	public void setWarranty(String warranty) {
		this.warranty = warranty;
	}

	public String getInDate() {
		return inDate;
	}

	public void setInDate(String inDate) {
		this.inDate = inDate;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
	public String getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(String purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public String getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}
	
}
