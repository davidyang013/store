package com.yu.store.bl.vo;

import com.yu.store.sys.vo.Page;


public class Member extends Page{

	private static final long serialVersionUID = 1L;
	
	/******************  会员表    ***********************/
	private String id;//会员卡号
	
	private String credit;//积分
	
	private String vipType;//vip选项
	
	private String operator;//操作人
	
	private String establishDate;//建档日期
	
	/******************  客户表    ***********************/
	
	private String customerId;//客户编号
	
	private String name;//客户姓名
	
	private String wangwangId;//旺旺
	
	private String birthday;//生日
	
	private String phone;//联系方式
	
	private String address;//联系地址
	
	private String postcode;//邮政编码
	
	
	/******************  出库表    ***********************/
	
	private String price;//消费金额
	
	private String outDate;//消费日期

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCredit() {
		return credit;
	}

	public void setCredit(String credit) {
		this.credit = credit;
	}

	public String getVipType() {
		return vipType;
	}

	public void setVipType(String vipType) {
		this.vipType = vipType;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWangwangId() {
		return wangwangId;
	}

	public void setWangwangId(String wangwangId) {
		this.wangwangId = wangwangId;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
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

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
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
	
}
