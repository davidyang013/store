package com.yu.store.bl.action;

import java.util.List;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.bl.bo.MemberManagerBO;
import com.yu.store.bl.vo.Member;
import com.yu.store.sys.action.BaseAction;

/**
 * @author Julie Zhu
 *
 */
public class MemberManagerAction extends BaseAction implements ModelDriven<Member>{

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private MemberManagerBO memberManagerBO = null;
	private Member member = new Member();

	public String query(){
		try {
			memberManagerBO.queryMaxPage(member);
			resultList = memberManagerBO.queryMember(member);
			request.setAttribute("member", member);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String gotoDtl(){
		
		try {
			String id = member.getId();
			//add
			if(null == id || "".equals(id.trim())){
				return "dtl";
			//update
			}else{
				member = memberManagerBO.queryMemberDtl(id);
				request.setAttribute("member", member);
			}
		} catch (Exception e) {
			log.error(">>>errors in method:queryDtl()", e);
		}
		return "dtl";
	}
	
	public String insert(){
		
		try {
			Member tmpMember = memberManagerBO.queryMemberDtl(member.getId());
			if(null != tmpMember){
				jsContent.setAlert("该会员号已维护");
				return "proxy";
			}
			member.setOperator((String)session.get("loginName"));
			memberManagerBO.insertMember(member);
			memberManagerBO.insertCustomer(member);
			
		} catch (Exception e) {
			log.error(">>>errors in method:insert()", e);
			jsContent.setAlert("保存失败");
			return "proxy";
		}
		jsContent.setAlert("保存成功");
        jsContent.setCallingFunction("refresh();");
        jsContent.setCallingFunction("closeWindow();");
		return "proxy";
	}
	
	public String update(){
		
		try {
			member.setOperator((String)session.get("loginName"));
			memberManagerBO.updateMember(member);
		} catch (Exception e) {
			log.error(">>>errors in method:update()", e);
			jsContent.setAlert("修改失败");
			return "proxy";
		}
		jsContent.setAlert("修改成功");
		jsContent.setCallingFunction("refresh();");
        jsContent.setCallingFunction("closeWindow();");
		return "proxy";
	}

	public String del(){
		String tmpName = null;
		String tmpRepairName = null;
		try {
			for(int i = 0; i<cboMainChoice.length; i++){
				List<?> tmpMemberList = memberManagerBO.queryOutStoreByMember(cboMainChoice[i]);
				List<?> tmpRepairMemberList = memberManagerBO.queryRepairByMember(cboMainChoice[i]);
				if(null != tmpMemberList && tmpMemberList.size()!= 0){
					tmpName = ((Member)(tmpMemberList.get(0))).getId();
				}
				if(null != tmpRepairMemberList && tmpRepairMemberList.size()!= 0){
					tmpRepairName = ((Member)(tmpRepairMemberList.get(0))).getId();
				}
			}
			
			if(null != tmpName){
				info = tmpName + "已有购买记录!";
				return query();
			}
			if(null != tmpRepairName){
				info = tmpRepairName + "已有售后记录!";
				return query();
			}
			memberManagerBO.deleteMember(cboMainChoice);
			info = "删除成功";
		} catch (Exception e) {
			log.error(">>>errors in method:del()", e);
			info = "删除失败";
		}
		return query();
	}
	
	public MemberManagerBO getMemberManagerBO() {
		return memberManagerBO;
	}

	public void setMemberManagerBO(MemberManagerBO memberManagerBO) {
		this.memberManagerBO = memberManagerBO;
	}

	@Override
	public Member getModel() {
		return member;
	}

}
