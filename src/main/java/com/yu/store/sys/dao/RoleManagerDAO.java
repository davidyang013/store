package com.yu.store.sys.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.sys.vo.Role;
import com.yu.store.sys.vo.RoleAuth;

/**
 * @author Kingking Yu
 *
 */
public class RoleManagerDAO extends SqlMapClientDaoSupport{
	
	public int queryMaxPage(Role role){
		return (Integer)getSqlMapClientTemplate().queryForObject("sys.queryRoleMaxPage", role);
	}
	
	public List<?> queryRole(Role role){
		return getSqlMapClientTemplate().queryForList("sys.queryRoleAll", role);
	}
	
	public Role queryRoleDtl(String id){
		return (Role)getSqlMapClientTemplate().queryForObject("sys.queryRoleDtl", id);
	}
	
	public List<?> queryRoleAuth(RoleAuth roleAuth){
		return getSqlMapClientTemplate().queryForList("sys.queryRoleAuthAll", roleAuth);
	}
	
	public void insertRole(Role role){
		getSqlMapClientTemplate().insert("sys.insertRole", role);
	}
	
	public void insertRoleAuth(RoleAuth ra){
		getSqlMapClientTemplate().insert("sys.insertRoleAuth", ra);
	}
	
	public void updateRole(Role role){
		getSqlMapClientTemplate().update("sys.updateRole", role);
	}
	
	public int updateRoleStatus(Role role){
		return getSqlMapClientTemplate().update("sys.updateRoleStatus", role);
	}
	
	public void deleteRole(String id){
		getSqlMapClientTemplate().delete("sys.deleteRole", id);
	}
	
	public void deleteRoleAuth(Role role){
		getSqlMapClientTemplate().delete("sys.deleteRoleAuth", role);
	}
}
