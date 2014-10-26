package com.yu.store.bl.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.bl.vo.Repair;

/**
 * @author Kingking Yu
 *
 */
public class RepairManagerDAO extends SqlMapClientDaoSupport{

	public int queryMaxPage(Repair repair){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryRepairMaxPage", repair);
	}
	
	public List<?> queryRepair(Repair repair){
		return getSqlMapClientTemplate().queryForList("bl.queryRepairAll", repair);
	}
	
	public Repair queryRepairDtl(String id){
		return (Repair)getSqlMapClientTemplate().queryForObject("bl.queryRepairDtl", id);
	}
	
	public void insertCustomer(Repair repair){
		getSqlMapClientTemplate().insert("bl.insertCustomerRepair", repair);
	}
	
	public void insertRepair(Repair repair){
		getSqlMapClientTemplate().insert("bl.insertRepair", repair);
	}
	
	public void updateCustomer(Repair repair){
		getSqlMapClientTemplate().update("bl.updateCustomerRepair", repair);
	}
	
	public void updateRepair(Repair repair){
		getSqlMapClientTemplate().update("bl.updateRepair", repair);
	}
	
	public void deleteRepair(String id){
		getSqlMapClientTemplate().delete("bl.deleteRepair", id);
	}
	
	public int searchCustomerInfoMaxPage(Repair repair){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.searchCustomerInfoMaxPage", repair);
	}
	
	public List<?> searchCustomerInfo(Repair repair){
		return getSqlMapClientTemplate().queryForList("bl.searchCustomerInfo", repair);
	}
	
	public Repair returnCustomer(Repair repair){
		return (Repair)getSqlMapClientTemplate().queryForObject("bl.searchCustomerInfo", repair);
	}
	
	public int searchBrandInfoMaxPage(Repair repair){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.searchBrandInfoMaxPage", repair);
	}
	
	public List<?> searchBrandInfo(Repair repair){
		return getSqlMapClientTemplate().queryForList("bl.searchBrandInfo", repair);
	}
	
	public void updateTransFee(Repair repair){
		getSqlMapClientTemplate().update("bl.updateTransFee", repair);
	}
}
