package com.yu.store.sys.vo;

/**
 * @author Kingking Yu
 *
 */
public class User extends Page{

	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String name;
	
	private String pwd;
	
	private String loginDate;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}
	
}
