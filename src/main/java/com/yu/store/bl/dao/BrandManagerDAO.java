package com.yu.store.bl.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.bl.vo.Brand;

/**
 * @author Kingking Yu
 *
 */
public class BrandManagerDAO extends SqlMapClientDaoSupport{

	public int queryMaxPage(Brand brand){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryBrandMaxPage", brand);
	}
	
	public List<?> queryBrand(Brand brand){
		return getSqlMapClientTemplate().queryForList("bl.queryBrandAll", brand);
	}
	
	public Brand queryBrandDtl(String serial){
		return (Brand)getSqlMapClientTemplate().queryForObject("bl.queryBrandDtl", serial);
	}
	
	public void insertBrand(Brand brand){
		getSqlMapClientTemplate().insert("bl.insertBrand", brand);
	}
	
	public void updateBrand(Brand brand){
		getSqlMapClientTemplate().update("bl.updateBrand", brand);
	}
	
	public void deleteBrand(String serial){
		getSqlMapClientTemplate().delete("bl.deleteBrand", serial);
	}
}
