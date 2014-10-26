package com.yu.store.sys.bo;

import java.util.List;

import com.yu.store.sys.dao.RoleManagerDAO;
import com.yu.store.sys.util.Constant;
import com.yu.store.sys.vo.Role;
import com.yu.store.sys.vo.RoleAuth;

/**
 * @author Kingking Yu
 *
 */
public class RoleManagerBO {
	
	private RoleManagerDAO roleManagerDAO = null;
	
	public void queryMaxPage(Role role){
		
		int maxCnt = roleManagerDAO.queryMaxPage(role);
		int maxPage = (int)Math.ceil((double)maxCnt / role.getPageSize());
		role.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public int queryMaxCnt(Role role){
		
		return roleManagerDAO.queryMaxPage(role);
	}
	
	public List<?> queryRole(Role role){
		return roleManagerDAO.queryRole(role);
	}
	
	public Role queryRoleDtl(String serial){
		return roleManagerDAO.queryRoleDtl(serial);
	}
	
	public List<?> queryRoleAuth(RoleAuth roleAuth){
		return roleManagerDAO.queryRoleAuth(roleAuth);
	}

	public void insertRole(Role role, String[] auths){
		insertRole(role);
		deleteRoleAuth(role);
		insertRoleAuth(auths, role.getId());
	}
	
	public void insertRole(Role role){
		roleManagerDAO.insertRole(role);
	}
	
	public void insertRoleAuth(String[] auths, String roleId){

		RoleAuth ra = new RoleAuth();
		
		if(null == auths || auths.length <= 0){
			return;
		}
		
		for(String a : auths){
			ra.setRoleId(roleId);
			ra.setAuthId(a);
			roleManagerDAO.insertRoleAuth(ra);
		}
	}
	
	public void updateRole(Role role, String[] auths){
		
		if(Constant.SYSTEM_ROLE.equals(role.getId())){
			return;
		}
		
		updateRole(role);
		deleteRoleAuth(role);
		insertRoleAuth(auths, role.getId());
	}
	
	public void updateRole(Role role){
		roleManagerDAO.updateRole(role);
	}
	
	public int updateRoleStatus(Role role){
		return roleManagerDAO.updateRoleStatus(role);
	}
	
	public void deleteRole(String[] serial){
		
		if(null == serial || serial.length <= 0){
			return;
		}
		
		for(String s : serial){
			if(Constant.SYSTEM_ROLE.equals(s)){
				continue;
			}
			roleManagerDAO.deleteRole(s);
		}
	}
	
	public void deleteRoleAuth(Role role){
		roleManagerDAO.deleteRoleAuth(role);
	}

	public RoleManagerDAO getRoleManagerDAO() {
		return roleManagerDAO;
	}

	public void setRoleManagerDAO(RoleManagerDAO roleManagerDAO) {
		this.roleManagerDAO = roleManagerDAO;
	}
	
}
