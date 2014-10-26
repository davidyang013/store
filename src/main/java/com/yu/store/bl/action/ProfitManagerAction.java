package com.yu.store.bl.action;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.bl.bo.ProfitManagerBO;
import com.yu.store.bl.vo.Profit;
import com.yu.store.sys.action.BaseAction;

/**
 * @author Kingking Yu
 *
 */
public class ProfitManagerAction extends BaseAction implements ModelDriven<Profit>{

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private ProfitManagerBO profitManagerBO = null;
	private Profit profit = new Profit();

	public String query(){
		
		try {
			profit.setPageSize(12);
			resultList = profitManagerBO.queryProfit(profit);
			request.setAttribute("profit", profit);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String queryEach(){
		
		try {
			profit.setPageSize(15);
			profitManagerBO.queryProductProfitOrderMaxPage(profit);
			resultList = profitManagerBO.queryProductProfitOrder(profit);
			request.setAttribute("profit", profit);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "each";
	}
	
	public ProfitManagerBO getProfitManagerBO() {
		return profitManagerBO;
	}

	public void setProfitManagerBO(ProfitManagerBO profitManagerBO) {
		this.profitManagerBO = profitManagerBO;
	}
	
	@Override
	public Profit getModel() {
		return profit;
	}

}
