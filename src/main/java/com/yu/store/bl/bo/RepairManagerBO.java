package com.yu.store.bl.bo;

import java.util.List;

import com.yu.store.bl.dao.RepairManagerDAO;
import com.yu.store.bl.vo.Repair;

/**
 * @author Julie Zhu
 *
 */
public class RepairManagerBO {
	
	RepairManagerDAO repairManagerDAO = null;
	
	public void queryMaxPage(Repair repair){
		
		int maxCnt = repairManagerDAO.queryMaxPage(repair);
		int maxPage = (int)Math.ceil((double)maxCnt / repair.getPageSize());
		repair.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public List<?> queryRepair(Repair repair){
		return repairManagerDAO.queryRepair(repair);
	}
	
	public Repair queryRepairDtl(String id){
		return repairManagerDAO.queryRepairDtl(id);
	}
	
	public void insertCustomer(Repair repair){
		repairManagerDAO.insertCustomer(repair);
	}
	
	public void updateCustomer(Repair repair){
		repairManagerDAO.updateCustomer(repair);
	}
	
	public void insertRepair(Repair repair){
		repairManagerDAO.insertRepair(repair);
	}
	
	public void updateRepair(Repair repair){
		repairManagerDAO.updateRepair(repair);
	}
	
	public void deleteRepair(String id){
		
		if(null == id){
			return;
		}else{
			repairManagerDAO.deleteRepair(id);
		}
	}
	
	public void searchCustomerInfoMaxPage(Repair repair){
		
		int maxCnt = repairManagerDAO.searchCustomerInfoMaxPage(repair);
		int maxPage = (int)Math.ceil((double)maxCnt / repair.getPageSize());
		repair.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}

	public List<?> searchCustomerInfo(Repair repair){
		return repairManagerDAO.searchCustomerInfo(repair);
	}
	
	public Repair returnCustomer(Repair repair){
		return repairManagerDAO.returnCustomer(repair);
	}
	
	public void searchBrandInfoMaxPage(Repair repair){
		
		int maxCnt = repairManagerDAO.searchBrandInfoMaxPage(repair);
		int maxPage = (int)Math.ceil((double)maxCnt / repair.getPageSize());
		repair.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public List<?> searchBrandInfo(Repair repair){
		return repairManagerDAO.searchBrandInfo(repair);
	}

	public void updateTransFee(Repair repair){
		repairManagerDAO.updateTransFee(repair);
	}
	
	public RepairManagerDAO getRepairManagerDAO() {
		return repairManagerDAO;
	}

	public void setRepairManagerDAO(RepairManagerDAO repairManagerDAO) {
		this.repairManagerDAO = repairManagerDAO;
	}
	
}
