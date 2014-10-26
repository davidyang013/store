package com.yu.store.sys.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.sys.vo.User;
import com.yu.store.sys.vo.UserRole;

/**
 * @author Kingking Yu
 *
 */
public class UserManagerDAO extends SqlMapClientDaoSupport{
	
	public int queryMaxPage(User user){
		return (Integer)getSqlMapClientTemplate().queryForObject("sys.queryUserMaxPage", user);
	}
	
	public List<?> queryUser(User user){
		return getSqlMapClientTemplate().queryForList("sys.queryUserAll", user);
	}
	
	public User queryUserDtl(String id){
		return (User)getSqlMapClientTemplate().queryForObject("sys.queryUserDtl", id);
	}
	
	public List<?> queryUserRole(UserRole userRole){
		return getSqlMapClientTemplate().queryForList("sys.queryUserRoleAll", userRole);
	}
	
	public void insertUser(User user){
		getSqlMapClientTemplate().insert("sys.insertUser", user);
	}
	
	public void insertUserRole(UserRole ur){
		getSqlMapClientTemplate().insert("sys.insertUserRole", ur);
	}
	
	public void updateUser(User user){
		getSqlMapClientTemplate().update("sys.updateUser", user);
	}
	
	public int updateUserStatus(User user){
		return getSqlMapClientTemplate().update("sys.updateUserStatus", user);
	}
	
	public void deleteUser(String id){
		getSqlMapClientTemplate().delete("sys.deleteUser", id);
	}
	
	public void deleteUserRole(User user){
		getSqlMapClientTemplate().delete("sys.deleteUserRole", user);
	}
}
