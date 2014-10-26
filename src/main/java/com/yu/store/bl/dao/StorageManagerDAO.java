package com.yu.store.bl.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.bl.vo.Storage;

/**
 * @author Kingking Yu
 *
 */
public class StorageManagerDAO extends SqlMapClientDaoSupport{

	public int queryMaxPage(Storage storage){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryStorageMaxPage", storage);
	}
	
	public List<?> queryStorage(Storage storage){
		return getSqlMapClientTemplate().queryForList("bl.queryStorageAll", storage);
	}
	
	public int queryEachMaxPage(Storage storage){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryStorageEachMaxPage", storage);
	}
	
	public List<?> queryStorageEach(Storage storage){
		return getSqlMapClientTemplate().queryForList("bl.queryStorageEachAll", storage);
	}
	
	public Double calcPrice(Storage storage){
		return (Double) getSqlMapClientTemplate().queryForObject("bl.calcPrice", storage);
	}
	
	public Double calcCount(Storage storage){
		return (Double) getSqlMapClientTemplate().queryForObject("bl.calcCount", storage);
	}
	
	public Double calcTotal(Storage storage){
		return (Double) getSqlMapClientTemplate().queryForObject("bl.calcTotal", storage);
	}
	
}
