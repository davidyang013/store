package com.yu.store.sys.vo;

/**
 * @author Kingking Yu
 *
 */
public class UserRole extends Page{
	
	private static final long serialVersionUID = 1L;
	
	private String userId;
	
	private String roleId;
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	
}
