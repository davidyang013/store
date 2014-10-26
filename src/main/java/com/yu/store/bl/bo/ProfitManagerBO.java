package com.yu.store.bl.bo;

import java.util.List;

import com.yu.store.bl.dao.ProfitManagerDAO;
import com.yu.store.bl.vo.Profit;
import com.yu.store.sys.util.Tools;

/**
 * @author Kingking Yu
 *
 */
public class ProfitManagerBO {
	
	ProfitManagerDAO profitManagerDAO = null;
	
	public List<?> queryProfit(Profit profit){
		
		return profitManagerDAO.queryProductProfit(profit);
	}
	
	public List<?> queryProductProfitOrder(Profit profit){
		
		setConDate(profit);
		return profitManagerDAO.queryProductProfitOrder(profit);
	}
	
	public void queryProductProfitOrderMaxPage(Profit profit){

		setConDate(profit);
		int maxCnt = profitManagerDAO.queryProductProfitOrderMaxPage(profit);
		int maxPage = (int)Math.ceil((double)maxCnt / profit.getPageSize());
		profit.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	private void setConDate(Profit profit){
		
		String month = profit.getMonth();
		if(Tools.isValid(month)){
			month += "-01";
			profit.setBeginDate(month);
			month = Tools.addMonth(month, 1, "yyyy-MM-dd");
			profit.setEndDate(Tools.addDay(month, -1, "yyyy-MM-dd"));
		}
	}
	
	public ProfitManagerDAO getProfitManagerDAO() {
		return profitManagerDAO;
	}

	public void setProfitManagerDAO(ProfitManagerDAO profitManagerDAO) {
		this.profitManagerDAO = profitManagerDAO;
	}
	
}
