package com.yu.store.bl.bo;

import java.util.List;

import com.yu.store.bl.dao.MemberManagerDAO;
import com.yu.store.bl.vo.Member;

/**
 * @author Julie Zhu
 *
 */
public class MemberManagerBO {
	
	MemberManagerDAO memberManagerDAO = null;
	
	public void queryMaxPage(Member member){
		
		int maxCnt = memberManagerDAO.queryMaxPage(member);
		int maxPage = (int)Math.ceil((double)maxCnt / member.getPageSize());
		member.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public List<?> queryMember(Member member){
		return memberManagerDAO.queryMember(member);
	}
	
	public Member queryMemberDtl(String id){
		return memberManagerDAO.queryMemberDtl(id);
	}
	
	public void insertMember(Member member){
		memberManagerDAO.insertMember(member);
	}
	
	public void insertCustomer(Member member){
		memberManagerDAO.insertCustomer(member);
	}
	
	public void updateMember(Member member){
		
		memberManagerDAO.updateMember(member);
		memberManagerDAO.updateCustomer(member);
	}
	
	public void deleteMember(String[] id){
		
		if(null == id || id.length <= 0){
			return;
		}
		
		for(String s : id){
			memberManagerDAO.deleteMember(s);
		}
	}
	
	public List<?> queryOutStoreByMember(String id){
		return memberManagerDAO.queryOutStoreByMember(id);
	}

	public List<?> queryRepairByMember(String id){
		return memberManagerDAO.queryRepairByMember(id);
	}
	
	public MemberManagerDAO getMemberManagerDAO() {
		return memberManagerDAO;
	}

	public void setMemberManagerDAO(MemberManagerDAO memberManagerDAO) {
		this.memberManagerDAO = memberManagerDAO;
	}
	
}
