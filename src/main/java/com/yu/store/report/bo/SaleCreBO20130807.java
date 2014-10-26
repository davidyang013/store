package com.yu.store.report.bo;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

import report.core.ReportCellPos;
import report.core.ReportSet;
import report.core.inter.IReportBO;
import report.core.inter.IReportSet;

import com.yu.store.bl.vo.OutStore;
import com.yu.store.report.dao.SaleCreDAO;
import com.yu.store.report.vo.SaleCre;

/**
 * @author Kingking Yu
 *
 */
public class SaleCreBO20130807 implements IReportBO {

	SaleCreDAO saleCreDAO = new SaleCreDAO();

	public IReportSet getReportSet(Object[] args, Object[] param) throws Exception {
		
		ReportSet rs = new ReportSet();
		
		Object[] data = new Object[51];
		
		if(null == param[0] || null== ((String[])param[0])[0]){
			return null;
		}
		
		SaleCre saleCre = null;
		OutStore outStore = null;
		int cellCnt = 9;
		String orderId = ((String[])param[0])[0];
		List<OutStore> outList = saleCreDAO.queryOutStoreDtl(orderId);
		if(null == outList || outList.size() == 0){
			return null;
		}
		outStore = outList.get(0);
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
		Calendar now = Calendar.getInstance(TimeZone.getTimeZone("GMT+08:00"));
		data[0] = outStore.getBuyType();//购买类别
		data[1] = "批发".equals(outStore.getBuyType()) ? "" : outStore.getBuyType();//购买类别
		data[2] = outStore.getPayType();//支付方式
		data[3] = data[2];//支付方式
		data[4] = "NO:" + outStore.getOrderId();//订单号
		data[5] = sdf.format(now.getTime());//日期
		for(int i = 0; i < outList.size(); i++){
			OutStore os = outList.get(i);
			saleCre = saleCreDAO.querySaleCre(os.getInId());
			data[5 + cellCnt * i + 1] = saleCre.getBrand();
			data[5 + cellCnt * i + 2] = saleCre.getType();
			data[5 + cellCnt * i + 3] = saleCre.getColor();
			data[5 + cellCnt * i + 4] = saleCre.getDepSerial();
			data[5 + cellCnt * i + 5] = os.getWarranty() == null ? "" : os.getWarranty() + "月";
			data[5 + cellCnt * i + 6] = os.getCount();
			data[5 + cellCnt * i + 7] = os.getSalePrice();
			data[5 + cellCnt * i + 8] = (new BigDecimal(os.getCount()).multiply(
																	  new BigDecimal(saleCre.getSalePrice()
																	  ))).toPlainString();
			data[5 + cellCnt * i + 9] = (new BigDecimal(os.getCount()).multiply(
																	  new BigDecimal(os.getPrice()
																	  ))).toPlainString();
		}
		rs.addDatas(data);
		ReportCellPos[] rc = new ReportCellPos[51];
    	rc[0] = new ReportCellPos(0, 11);//购买类别
    	rc[1] = new ReportCellPos(2, 7);//购买类别
        rc[2] = new ReportCellPos(3, 7);//支付方式
        rc[3] = new ReportCellPos(12, 10);//支付方式
        rc[4] = new ReportCellPos(2, 3);//订单号
        rc[5] = new ReportCellPos(14, 11);//日期
        for(int i = 0; i < outList.size(); i++){
        	rc[5 + cellCnt * i + 1] = new ReportCellPos(5 + i, 0);//品牌
        	rc[5 + cellCnt * i + 2] = new ReportCellPos(5 + i, 1);//型号
        	rc[5 + cellCnt * i + 3] = new ReportCellPos(5 + i, 2);//颜色
        	rc[5 + cellCnt * i + 4] = new ReportCellPos(5 + i, 3);//序列号
        	rc[5 + cellCnt * i + 5] = new ReportCellPos(5 + i, 4);//质保
        	rc[5 + cellCnt * i + 6] = new ReportCellPos(5 + i, 5);//数量
        	rc[5 + cellCnt * i + 7] = new ReportCellPos(5 + i, 6);//单价
        	rc[5 + cellCnt * i + 8] = new ReportCellPos(5 + i, 7);//金额
        	rc[5 + cellCnt * i + 9] = new ReportCellPos(1 + (i * 2), 11);//实售
        }
        rs.setDataPosInfo(rc);
		return rs;
	}

}
