package com.yu.store.sys.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.sys.vo.Menu;

/**
 * @author Kingking Yu
 *
 */
public class MenuManagerDAO extends SqlMapClientDaoSupport{
	
	public int queryMaxPage(Menu menu){
		return (Integer)getSqlMapClientTemplate().queryForObject("sys.queryMenuMaxPage", menu);
	}
	
	public List<?> queryMenu(Menu menu){
		return getSqlMapClientTemplate().queryForList("sys.queryMenuAll", menu);
	}
	
	public List<?> queryMenuAuth(String id){
		return getSqlMapClientTemplate().queryForList("sys.queryMenuAuth", id);
	}
	
	public Menu queryMenuDtl(String id){
		return (Menu)getSqlMapClientTemplate().queryForObject("sys.queryMenuDtl", id);
	}
	
	public void insertMenu(Menu menu){
		getSqlMapClientTemplate().insert("sys.insertMenu", menu);
	}
	
	public void updateMenu(Menu menu){
		getSqlMapClientTemplate().update("sys.updateMenu", menu);
	}
	
	public int updateMenuStatus(Menu menu){
		return getSqlMapClientTemplate().update("sys.updateMenuStatus", menu);
	}
	
	public void deleteMenu(String id){
		getSqlMapClientTemplate().delete("sys.deleteMenu", id);
	}
}
