package com.yu.store.sys.vo;

/**
 * @author Kingking Yu
 *
 */
public class RoleAuth extends Page{

	private static final long serialVersionUID = 1L;
	
	private String roleId;
	
	private String authId;

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getAuthId() {
		return authId;
	}

	public void setAuthId(String authId) {
		this.authId = authId;
	}
	
}
