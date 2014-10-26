package com.yu.store.sys.vo;

/**
 * @author Kingking Yu
 *
 */
public class Role extends Page{
	
	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String name;
	
	private String userId;

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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}
