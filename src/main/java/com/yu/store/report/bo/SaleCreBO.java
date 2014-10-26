package com.yu.store.report.bo;

import java.math.BigDecimal;
import java.util.List;

import report.core.ReportCellPos;
import report.core.ReportSet;
import report.core.inter.IReportBO;
import report.core.inter.IReportSet;

import com.yu.store.bl.vo.OutStore;
import com.yu.store.report.dao.SaleCreDAO;
import com.yu.store.report.vo.SaleCre;
import com.yu.store.sys.util.Tools;

/**
 * @author Kingking Yu
 *
 */
public class SaleCreBO implements IReportBO {

	SaleCreDAO saleCreDAO = new SaleCreDAO();
	
	private int PRODUCT_INDEX = 7;

	public IReportSet getReportSet(Object[] args, Object[] param) throws Exception {
		
		ReportSet rs = new ReportSet();
		
		Object[] data = new Object[52];
		
		if(null == param[0] || null== ((String[])param[0])[0]){
			return null;
		}
		
		SaleCre saleCre = null;
		OutStore outStore = null;
		int cellCnt = 9;
		String orderId = ((String[])param[0])[0];
		String userId = ((String[])param[0])[1];
		List<OutStore> outList = saleCreDAO.queryOutStoreDtl(orderId);
		
		if(null == outList || outList.size() == 0){
			return null;
		}
		
		outStore = outList.get(0);
		String outDate = outStore.getOutDate();
		data[0] = outStore.getBuyType();//购买类别
		data[1] = "批发".equals(outStore.getBuyType()) ? "" : outStore.getBuyType();//购买类别
		data[2] = outStore.getPayType();//支付方式
		data[3] = data[2];//支付方式
		data[4] = "NO:" + outStore.getOrderId();//订单号
		data[5] = userId;//开单人员
		if(Tools.isValid(outDate)){
			outDate = outDate.substring(0, 10);
			outDate = outDate.replaceAll("-", ".");
			data[6] = outDate;//购买日期
		} else {
			data[6] = "";
		}
		String memberId = saleCreDAO.queryMemberId(orderId);
		if("".equals(memberId) || memberId == null){
			data[7] = "否";
		}
		else{
			data[7] = "是";
		}
		for(int i = 0; i < outList.size(); i++){
			OutStore os = outList.get(i);
			saleCre = saleCreDAO.querySaleCre(os.getInId());
			data[PRODUCT_INDEX + cellCnt * i + 1] = saleCre.getBrand();
			data[PRODUCT_INDEX + cellCnt * i + 2] = saleCre.getType();
			data[PRODUCT_INDEX + cellCnt * i + 3] = saleCre.getColor();
			data[PRODUCT_INDEX + cellCnt * i + 4] = saleCre.getDepSerial();
			data[PRODUCT_INDEX + cellCnt * i + 5] = os.getWarranty() == null ? "" : os.getWarranty() + "月";
			data[PRODUCT_INDEX + cellCnt * i + 6] = os.getCount();
			data[PRODUCT_INDEX + cellCnt * i + 7] = (new BigDecimal(os.getCount()).multiply(
																	  new BigDecimal(saleCre.getSalePrice()
																	  ))).toPlainString();
			data[PRODUCT_INDEX + cellCnt * i + 8] = (new BigDecimal(os.getCount()).multiply(
																	  new BigDecimal(os.getPrice()
																	  ))).toPlainString();
		}
		rs.addDatas(data);
		ReportCellPos[] rc = new ReportCellPos[52];
    	rc[0] = new ReportCellPos(7, 7);//购买类别
    	rc[1] = new ReportCellPos(33, 2);//购买类别-存根
        rc[2] = new ReportCellPos(8, 7);//支付方式
        rc[3] = new ReportCellPos(33, 4);//支付方式-存根
        rc[4] = new ReportCellPos(5, 7);//订单号
        rc[5] = new ReportCellPos(5, 1);//开单人员
        rc[6] = new ReportCellPos(6, 7);//购买日期
		rc[7] = new ReportCellPos(6, 1);//是否会员
        for(int i = 0; i < outList.size(); i++){
        	rc[PRODUCT_INDEX + cellCnt * i + 1] = new ReportCellPos(11 + i, 0);//品牌
        	rc[PRODUCT_INDEX + cellCnt * i + 2] = new ReportCellPos(11 + i, 1);//型号
        	rc[PRODUCT_INDEX + cellCnt * i + 3] = new ReportCellPos(11 + i, 2);//颜色
        	rc[PRODUCT_INDEX + cellCnt * i + 4] = new ReportCellPos(11 + i, 3);//序列号
        	rc[PRODUCT_INDEX + cellCnt * i + 5] = new ReportCellPos(11 + i, 5);//质保
        	rc[PRODUCT_INDEX + cellCnt * i + 6] = new ReportCellPos(11 + i, 6);//数量
        	rc[PRODUCT_INDEX + cellCnt * i + 7] = new ReportCellPos(11 + i, 7);//金额
        	rc[PRODUCT_INDEX + cellCnt * i + 8] = new ReportCellPos(11 + 23 + i , 7);//实售
        }
        rs.setDataPosInfo(rc);
		return rs;
	}

}
