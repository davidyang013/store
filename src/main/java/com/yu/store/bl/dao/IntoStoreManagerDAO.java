package com.yu.store.bl.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.bl.vo.IntoStore;

/**
 * @author Kingking Yu
 *
 */
public class IntoStoreManagerDAO extends SqlMapClientDaoSupport{

	public int queryMaxPage(IntoStore intoStore){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryIntoStoreMaxPage", intoStore);
	}
	
	public List<?> queryIntoStore(IntoStore intoStore){
		return getSqlMapClientTemplate().queryForList("bl.queryIntoStoreAll", intoStore);
	}
	
	public List<?> queryIntoStoreByOut(IntoStore intoStore){
		return getSqlMapClientTemplate().queryForList("bl.queryIntoStoreByOut", intoStore);
	}
	
	public IntoStore queryIntoStoreDtl(String id){
		return (IntoStore)getSqlMapClientTemplate().queryForObject("bl.queryIntoStoreDtl", id);
	}
	
	public void insertIntoStore(IntoStore intoStore){
		getSqlMapClientTemplate().insert("bl.insertIntoStore", intoStore);
	}
	
	public void updateIntoStore(IntoStore intoStore){
		getSqlMapClientTemplate().update("bl.updateIntoStore", intoStore);
	}
	
	public void deleteIntoStore(String intoStore){
		getSqlMapClientTemplate().delete("bl.deleteIntoStore", intoStore);
	}
}
