package com.yu.store.bl.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.bl.vo.OutStore;

/**
 * @author Kingking Yu
 *
 */
@SuppressWarnings("unchecked")
public class OutStoreManagerDAO extends SqlMapClientDaoSupport{

	public int queryMaxPage(OutStore outStore){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryOutStoreMaxPage", outStore);
	}
	
	public List<?> queryOutStore(OutStore outStore){
		return getSqlMapClientTemplate().queryForList("bl.queryOutStoreAll", outStore);
	}
	
	public List<OutStore> queryOutStoreDtl(OutStore outStore){
		return getSqlMapClientTemplate().queryForList("bl.queryOutStoreDtl", outStore);
	}
	
	public int queryMaxOrderId(){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryMaxOrderId");
	}
	
	public int queryMaxOrderIdInMonth(){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryMaxOrderIdInMonth");
	}
	
	public void insertOutStore(OutStore outStore){
		getSqlMapClientTemplate().insert("bl.insertOutStore", outStore);
	}
	
	public void updateOutStore(OutStore outStore){
		getSqlMapClientTemplate().update("bl.updateOutStore", outStore);
	}
	
	public void updateOutStoreOrder(OutStore outStore){
		getSqlMapClientTemplate().update("bl.updateOutStoreOrder", outStore);
	}
	
	public void updateStatusOut(OutStore outStore){
		getSqlMapClientTemplate().update("bl.updateStatusOut", outStore);
	}

	public void updateMemberCredit(OutStore outStore){
		getSqlMapClientTemplate().update("bl.updateMemberCredit", outStore);
	}
	
	public void deleteOutStore(OutStore outStore){
		getSqlMapClientTemplate().delete("bl.deleteOutStore", outStore);
	}
	
}
