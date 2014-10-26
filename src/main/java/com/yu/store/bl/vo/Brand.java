package com.yu.store.bl.vo;

import com.yu.store.sys.vo.Page;


public class Brand extends Page{

	private static final long serialVersionUID = 1L;
	
	private String serial;//商品序列号
	
	private String brand;//品牌
	
	private String type;//型号
	
	private String warranty;//保修时长
	
	private String salePrice;//售价
	
	private String comm;//备注

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

	public String getWarranty() {
		return warranty;
	}

	public void setWarranty(String warranty) {
		this.warranty = warranty;
	}
	
	public String getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}

	public String getComm() {
		return comm;
	}

	public void setComm(String comm) {
		this.comm = comm;
	}
	
}
