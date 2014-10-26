package com.yu.store.sys.bo;

import java.util.List;

import com.yu.store.sys.dao.UserManagerDAO;
import com.yu.store.sys.util.Constant;
import com.yu.store.sys.vo.User;
import com.yu.store.sys.vo.UserRole;

/**
 * @author Kingking Yu
 *
 */
public class UserManagerBO {
	
	private UserManagerDAO userManagerDAO = null;
	
	public void queryMaxPage(User user){
		
		int maxCnt = userManagerDAO.queryMaxPage(user);
		int maxPage = (int)Math.ceil((double)maxCnt / user.getPageSize());
		user.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public List<?> queryUser(User user){
		return userManagerDAO.queryUser(user);
	}
	
	public User queryUserDtl(String serial){
		return userManagerDAO.queryUserDtl(serial);
	}
	
	public List<?> queryUserRole(UserRole userRole){
		return userManagerDAO.queryUserRole(userRole);
	}
	
	public void insertUser(User user, String[] roles){
		insertUser(user);
		deleteUserRole(user);
		insertUserRole(roles, user.getId());
	}
	
	public void insertUser(User user){
		userManagerDAO.insertUser(user);
	}
	
	public void insertUserRole(String[] roles, String userId){

		UserRole ur = new UserRole();
		
		if(null == roles || roles.length <= 0){
			return;
		}
		
		for(String r : roles){
			ur.setUserId(userId);
			ur.setRoleId(r);
			userManagerDAO.insertUserRole(ur);
		}
	}
	
	public void updateUser(User user, String[] roles){
		
		if(Constant.SYSTEM_USER.equals(user.getId())){
			return;
		}
		
		updateUser(user);
		deleteUserRole(user);
		insertUserRole(roles, user.getId());
	}
	
	public void updateUser(User user){
		userManagerDAO.updateUser(user);
	}
	
	public int updateUserStatus(User user){
		return userManagerDAO.updateUserStatus(user);
	}
	
	public void deleteUser(String[] serial){
		
		if(null == serial || serial.length <= 0){
			return;
		}
		
		for(String s : serial){
			if(Constant.SYSTEM_USER.equals(s)){
				continue;
			}
			userManagerDAO.deleteUser(s);
		}
	}
	
	public void deleteUserRole(User user){
			userManagerDAO.deleteUserRole(user);
	}

	public UserManagerDAO getUserManagerDAO() {
		return userManagerDAO;
	}

	public void setUserManagerDAO(UserManagerDAO userManagerDAO) {
		this.userManagerDAO = userManagerDAO;
	}
	
}
