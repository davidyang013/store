package com.yu.store.bl.vo;

import com.yu.store.sys.util.Tools;
import com.yu.store.sys.vo.Page;


public class IntoStore extends Page{

	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String serial;
	
	private String brand;
	
	private String type;
	
	private String depSerial;
	
	private String supply;
	
	private String inDate;
	
	private String color;
	
	private String count;
	
	private String salePrice;
	
	private String purchasePrice;
	
	private String isOut;
	
	private String comm;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
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

	public String getDepSerial() {
		if(Tools.isValid(depSerial)){
			return depSerial.trim();
		}
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

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}

	public String getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(String purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public String getIsOut() {
		
		if("0".equals(isOut)){
			return "未出库";
		}
		if("1".equals(isOut)){
			return "已出库";
		}
		if("2".equals(isOut)){
			return "部分出库";
		}
		return "未知";
	}
	
	public String getIsOutValue() {
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
	
}
