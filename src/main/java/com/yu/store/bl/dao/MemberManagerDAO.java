package com.yu.store.bl.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.yu.store.bl.vo.Member;

/**
 * @author Kingking Yu
 *
 */
public class MemberManagerDAO extends SqlMapClientDaoSupport{

	public int queryMaxPage(Member member){
		return (Integer)getSqlMapClientTemplate().queryForObject("bl.queryMemberMaxPage", member);
	}
	
	public List<?> queryMember(Member member){
		return getSqlMapClientTemplate().queryForList("bl.queryMemberAll", member);
	}
	
	public Member queryMemberDtl(String id){
		return (Member)getSqlMapClientTemplate().queryForObject("bl.queryMemberDtl", id);
	}
	
	public void insertMember(Member member){
		getSqlMapClientTemplate().insert("bl.insertMember", member);
	}
	
	public void insertCustomer(Member member){
		getSqlMapClientTemplate().insert("bl.insertCustomer", member);
	}
	
	public void updateCustomer(Member member){
		getSqlMapClientTemplate().update("bl.updateCustomer", member);
	}
	
	public void updateMember(Member member){
		getSqlMapClientTemplate().update("bl.updateMember", member);
	}
	
	public void deleteMember(String id){
		getSqlMapClientTemplate().delete("bl.deleteMember", id);
	}
	
	public List<?> queryOutStoreByMember(String id){
		return getSqlMapClientTemplate().queryForList("bl.queryOutStoreByMember", id);
	}
	
	public List<?> queryRepairByMember(String id){
		return getSqlMapClientTemplate().queryForList("bl.queryRepairByMember", id);
	}
}
