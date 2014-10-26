package com.yu.store.bl.vo;

import com.yu.store.sys.vo.Page;


public class Repair extends Page{

	private static final long serialVersionUID = 1L;
	
	/******************  售后表    ***********************/
	private String id;//维修ID
	
	private String orderId;//订单号
	
	private String price;//预估维修金额
	
	private String actualPrice;//实际维修金额 
	
	private String repairStatus;//维修状态
	
	private String customerId;//客户id
	
	private String repairSerialA;//返修运费单号
	
	private String repairFeeA;//返修运费金额
	
	private String repairSerialB;//送修运费单号
	
	private String repairFeeB;//送修运费金额

	private String repairSerialC;//送修回件单号
	
	private String repairFeeC;//送修回件金额
	
	private String repairSerialD;//返修回寄单号
	
	private String repairFeeD;//返修回寄金额
	
	private String repairSerialX;//返修单号
	
	private String repairFeeX;//返修金额
	
	private String repairFeeABCD;//收取运费的合计数
	
	private String actualRepairFee;//实际运费
	
	/******************  出库表    ***********************/
	
	private String purchaseDate;//购买日期
	
	/******************  商品表    ***********************/
	
	private String brand;//品牌
	
	private String type;//型号
	
	private String warranty;//保修时长
	
	/******************  入库表    ***********************/
	
	private String color;//颜色
	
	private String headsetSerial;//耳机序列号

	private String appearance;//外观
	
	private String operator;//操作员
	
	private String establishDate;//操作时间
	
	private String status;//系统保留字段
	
	private String status2;//系统保留字段2
	
	/******************  客户表    ***********************/
	
	private String name;//客户姓名
	
	private String phone;//联系方式
	
	private String address;//联系地址
	
	private String wangwangId;//旺旺
	
	/******************  会员表    ***********************/
	private String memberId;//会员id

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

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getActualPrice() {
		return actualPrice;
	}

	public void setActualPrice(String actualPrice) {
		this.actualPrice = actualPrice;
	}

	public String getRepairStatus() {
		return repairStatus;
	}

	public void setRepairStatus(String repairStatus) {
		this.repairStatus = repairStatus;
	}

	public String getRepairSerialA() {
		return repairSerialA;
	}

	public void setRepairSerialA(String repairSerialA) {
		this.repairSerialA = repairSerialA;
	}

	public String getRepairFeeA() {
		return repairFeeA;
	}

	public void setRepairFeeA(String repairFeeA) {
		this.repairFeeA = repairFeeA;
	}

	public String getRepairSerialB() {
		return repairSerialB;
	}

	public void setRepairSerialB(String repairSerialB) {
		this.repairSerialB = repairSerialB;
	}

	public String getRepairFeeB() {
		return repairFeeB;
	}

	public void setRepairFeeB(String repairFeeB) {
		this.repairFeeB = repairFeeB;
	}

	public String getRepairSerialC() {
		return repairSerialC;
	}

	public void setRepairSerialC(String repairSerialC) {
		this.repairSerialC = repairSerialC;
	}

	public String getRepairFeeC() {
		return repairFeeC;
	}

	public void setRepairFeeC(String repairFeeC) {
		this.repairFeeC = repairFeeC;
	}

	public String getRepairSerialD() {
		return repairSerialD;
	}

	public void setRepairSerialD(String repairSerialD) {
		this.repairSerialD = repairSerialD;
	}

	public String getRepairFeeD() {
		return repairFeeD;
	}

	public void setRepairFeeD(String repairFeeD) {
		this.repairFeeD = repairFeeD;
	}

	public String getRepairSerialX() {
		return repairSerialX;
	}

	public void setRepairSerialX(String repairSerialX) {
		this.repairSerialX = repairSerialX;
	}

	public String getRepairFeeX() {
		return repairFeeX;
	}

	public void setRepairFeeX(String repairFeeX) {
		this.repairFeeX = repairFeeX;
	}

	public String getActualRepairFee() {
		return actualRepairFee;
	}

	public void setActualRepairFee(String actualRepairFee) {
		this.actualRepairFee = actualRepairFee;
	}

	public String getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(String purchaseDate) {
		this.purchaseDate = purchaseDate;
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

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getHeadsetSerial() {
		return headsetSerial;
	}

	public void setHeadsetSerial(String headsetSerial) {
		this.headsetSerial = headsetSerial;
	}

	public String getAppearance() {
		return appearance;
	}

	public void setAppearance(String appearance) {
		this.appearance = appearance;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getEstablishDate() {
		return establishDate;
	}

	public void setEstablishDate(String establishDate) {
		this.establishDate = establishDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatus2() {
		return status2;
	}

	public void setStatus2(String status2) {
		this.status2 = status2;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getWangwangId() {
		return wangwangId;
	}

	public void setWangwangId(String wangwangId) {
		this.wangwangId = wangwangId;
	}

	public String getRepairFeeABCD() {
		return repairFeeABCD;
	}

	public void setRepairFeeABCD(String repairFeeABCD) {
		this.repairFeeABCD = repairFeeABCD;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getWarranty() {
		return warranty;
	}

	public void setWarranty(String warranty) {
		this.warranty = warranty;
	}
	
}
