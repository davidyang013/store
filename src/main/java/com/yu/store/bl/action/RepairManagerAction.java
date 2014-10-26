package com.yu.store.bl.action;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.bl.bo.RepairManagerBO;
import com.yu.store.bl.vo.Repair;
import com.yu.store.sys.action.BaseAction;

/**
 * @author Julie Zhu
 *
 */
public class RepairManagerAction extends BaseAction implements ModelDriven<Repair>{

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private RepairManagerBO repairManagerBO = null;
	
	private Repair repair = new Repair();

	public String query(){
		try {
			repairManagerBO.queryMaxPage(repair);
			resultList = repairManagerBO.queryRepair(repair);
			request.setAttribute("repair", repair);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String gotoDtl(){
		
		try {
			String id = repair.getId();
			//add
			if(null == id || "".equals(id.trim())){
				return "dtl";
			//update
			}else{
				repair = repairManagerBO.queryRepairDtl(id);
				request.setAttribute("repair", repair);
			}
		} catch (Exception e) {
			log.error(">>>errors in method:queryDtl()", e);
		}
		return "dtl";
	}
	
	public String insert(){
		
		try {
			repair.setOperator((String)session.get("loginName"));
			//判断是否存在customerId是否有值(有值需要根据customerId去更新customer信息;没值需要往customer_info表插入一条新记录)
			String customerId = repair.getCustomerId();
			if("".equals(customerId)){
				repairManagerBO.insertCustomer(repair);
			}else{
				repairManagerBO.updateCustomer(repair);
			}
			repairManagerBO.insertRepair(repair);
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
			repair.setOperator((String)session.get("loginName"));
			repairManagerBO.updateCustomer(repair);
			repairManagerBO.updateRepair(repair);
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
		
		try {
				repairManagerBO.deleteRepair(repair.getId());
				info = "删除成功";
		} catch (Exception e) {
			log.error(">>>errors in method:del()", e);
			info = "删除失败";
		}
		return query();
	}
	
	public String searchAllCustomerInfo(){
		try {
			repair.setPageSize(15);
			repairManagerBO.searchCustomerInfoMaxPage(repair);
			resultList = repairManagerBO.searchCustomerInfo(repair);
			request.setAttribute("repair", repair);
		} catch (Exception e) {
			log.error(">>>errors in method:searchAllCustomerInfo()", e);
		}
		return "searchCustomerInfo";
	}
	
	
	public String searchAllBrandInfo(){
		
	    try {
	    	repair.setPageSize(15);
			repairManagerBO.searchBrandInfoMaxPage(repair);
			resultList = repairManagerBO.searchBrandInfo(repair);
			request.setAttribute("repair", repair);
		} catch (Exception e) {
			log.error(">>>errors in method:searchAllBrandInfo", e);
		}
		return "searchBrandInfo";
	}
	
	public String repairTransFee(){
		
		try {
			String id = repair.getId();
			repair.setId(id);
			String repairStatus = repair.getRepairStatus();
			if("update".equals(repairStatus)){
				repair = repairManagerBO.queryRepairDtl(id);
				request.setAttribute("repair", repair);
				return "actualFee";
			}
			repair = repairManagerBO.queryRepairDtl(id);
//			String repairStatus = repair.getRepairStatus();
//			repair.setRepairStatus(repairStatus);
			request.setAttribute("repair", repair);
		} catch (Exception e) {
			log.error(">>>errors in method:repairTransFee()", e);
		}
		return "repairTransFee";
	}
	
	public String updateTransFee(){
		
		try {
			repair.setOperator((String)session.get("loginName"));
			repairManagerBO.updateTransFee(repair);
		} catch (Exception e) {
			log.error(">>>errors in method:updateTransFee()", e);
		}
		jsContent.setCallingFunction("refresh();");
        jsContent.setCallingFunction("closeWindow();");
		return "proxy";
	}
	public RepairManagerBO getRepairManagerBO() {
		return repairManagerBO;
	}

	public void setRepairManagerBO(RepairManagerBO repairManagerBO) {
		this.repairManagerBO = repairManagerBO;
	}

	@Override
	public Repair getModel() {
		return repair;
	}
}
