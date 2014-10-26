package com.yu.store.bl.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.bl.vo.Profit;

/**
 * @author Kingking Yu
 *
 */
public class ProfitManagerDAO extends SqlMapClientDaoSupport{

	public List<?> queryProductProfit(Profit profit){
		return getSqlMapClientTemplate().queryForList("bl.queryProductProfit", profit);
	}
	
	public List<?> queryProductProfitOrder(Profit profit){
		return getSqlMapClientTemplate().queryForList("bl.queryProductProfitOrder", profit);
	}
	
	public int queryProductProfitOrderMaxPage(Profit profit){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryProductProfitOrderMaxPage", profit);
	}
	
}
