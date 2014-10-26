package com.yu.store.bl.bo;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import org.apache.log4j.Logger;

import com.yu.store.bl.dao.BrandManagerDAO;
import com.yu.store.bl.dao.IntoStoreManagerDAO;
import com.yu.store.bl.dao.OutStoreManagerDAO;
import com.yu.store.bl.except.OrderCheckException;
import com.yu.store.bl.vo.Brand;
import com.yu.store.bl.vo.IntoStore;
import com.yu.store.bl.vo.OutStore;
import com.yu.store.sys.except.SessionEmptyException;
import com.yu.store.sys.util.OutStatus;
import com.yu.store.sys.util.Tools;

/**
 * @author Kingking Yu
 *
 */
public class OutStoreManagerBO {
	
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private OutStoreManagerDAO outStoreManagerDAO = null;
	
	private IntoStoreManagerDAO intoStoreManagerDAO = null;

	private BrandManagerDAO brandManagerDAO = null;
	
	public void queryMaxPage(OutStore outStore){
		
		int maxCnt = outStoreManagerDAO.queryMaxPage(outStore);
		int maxPage = (int)Math.ceil((double)maxCnt / outStore.getPageSize());
		outStore.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public int queryMaxCnt(OutStore outStore){
		
		return outStoreManagerDAO.queryMaxPage(outStore);
	}
	
	public List<?> queryOutStore(OutStore outStore){
		return outStoreManagerDAO.queryOutStore(outStore);
	}
	
	public List<OutStore> queryOutStoreDtl(OutStore outStore){
		
		//获取出库商品详细信息
		List<OutStore> outList = outStoreManagerDAO.queryOutStoreDtl(outStore);
		
		if(null == outList || outList.size() == 0){
			return null;
		}
		
		//在出库对象中填充商品品牌型号信息
		for(int i = 0; i < outList.size(); i++){
			OutStore os = outList.get(i);
			IntoStore is = intoStoreManagerDAO.queryIntoStoreDtl(os.getInId());
			os.setDepSerial(is.getDepSerial());
			os.setColor(is.getColor());
			if(!Tools.isValid(is.getSerial())){
				continue;
			}
			Brand b = brandManagerDAO.queryBrandDtl(is.getSerial());
			os.setBrand(b.getBrand());
			os.setType(b.getType());
		}
		
		return outList;
	}
	
	/**
	 * 出库操作
	 * @param outStore
	 * @param paramList
	 * @throws Exception
	 */
	public void insertOutStore(OutStore outStore, List<OutStore> paramList) throws Exception{
		
		List<?> retList = null;
		Brand brand = null;
		String orderId = "0";
		IntoStore intoStore = new IntoStore();
		//Session 过期
		if(null == outStore.getOperator()){
			throw new SessionEmptyException("用户尚未登录");
		}
		Date start = new Date();
	    synchronized(this){
	    	//生成订单编号
	    	orderId = getOrderId();
			for(OutStore param : paramList){
				//设置出库信息
				outStore.setOrderId(orderId);
				outStore.setPrice(Tools.isValid(param.getPrice()) ? param.getPrice() : "0");
				outStore.setInId(param.getInId());
				outStore.setCount(param.getCount());
				outStore.setTransCompany(param.getTransCompany());
				outStore.setTransFee(Tools.isValid(param.getTransFee()) ? param.getTransFee() : "0");
				outStore.setTransSerial(param.getTransSerial());
				//出库时记录售价及保修时长
				intoStore = intoStoreManagerDAO.queryIntoStoreDtl(param.getInId());
				brand = brandManagerDAO.queryBrandDtl(intoStore.getSerial());
				if(null != brand){
					outStore.setSalePrice(brand.getSalePrice());
					outStore.setWarranty(brand.getWarranty());
				}
				//释放内存
				brand = null;
				intoStore = null;
				//校验库存
				intoStore = new IntoStore();
				intoStore.setId(param.getInId());
				retList = intoStoreManagerDAO.queryIntoStoreByOut(intoStore);
				
				if(null == retList || retList.size() == 0){
					throw new OrderCheckException("库存不足");
				}
				intoStore = (IntoStore)retList.get(0);
				int res = Tools.compareTwoStr(intoStore.getCount(), outStore.getCount());
				//库存不足
				if(res < 0){
					throw new OrderCheckException("库存不足");
				}
				if(res == 0){
					//全部出库
					outStore.setIsOut(OutStatus.ALL_OUT.getValue());
				}else{
					//部分出库
					outStore.setIsOut(OutStatus.PART_OUT.getValue());
				}
				outStoreManagerDAO.insertOutStore(outStore);
				outStoreManagerDAO.updateStatusOut(outStore);
				outStoreManagerDAO.updateMemberCredit(outStore);
			}
	    }
		Date end = new Date();
		log.info("出库用时:" + (end.getTime() - start.getTime()) + "毫秒");
	}
	
	/**
	 * 自动生成订单编号
	 * @return
	 * @throws OrderCheckException
	 */
	private String getOrderId() throws OrderCheckException{
		
		String orderId = "0";
		String curDate = null;
		int maxOrderId = 0;
		int dbMonth = 0, month = 0;
		OutStore tmp = new OutStore();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMM");
		Calendar now = Calendar.getInstance(TimeZone.getTimeZone("GMT+08:00"));
		
		//获取订单号
		maxOrderId = outStoreManagerDAO.queryMaxOrderId();
		dbMonth = Integer.parseInt((maxOrderId + "").substring(2, 4));
		month = now.get(Calendar.MONTH) + 1;
		curDate = sdf.format(now.getTime());
		maxOrderId = Integer.parseInt(curDate + (maxOrderId + "").substring(4, 7));
		
		//每月订单号后三位清零
		if(dbMonth < month){
			maxOrderId = Integer.parseInt(curDate) * 1000;
		}else if(dbMonth > month){
			//系统时间被回退,此时去数据库中搜索当月最大订单号
			maxOrderId = outStoreManagerDAO.queryMaxOrderIdInMonth();
		}
		
		//库存编号生成错误
		if((maxOrderId + "").length() != 7){
			throw new OrderCheckException("库存编号(长度)生成错误");
		}
		
		//当月库存编号已满编(判断后三位)
		if("999".equals((maxOrderId + "").substring(4, 7))){
			throw new OrderCheckException("当月库存编号已满编");
		}
		
		orderId = (maxOrderId + 1) + "";
		//判断该订单号是否重复,重复则提示信息
		tmp.setOrderId(orderId);
		List<?> orders = outStoreManagerDAO.queryOutStoreDtl(tmp);
		
		if(null != orders && orders.size() != 0){
			throw new OrderCheckException("生成订单号重复");
		}
		
		return orderId;
	}
	
	public void updateOutStore(OutStore outStore){
		outStoreManagerDAO.updateOutStore(outStore);
	}
	
	public void updateOutStoreOrder(OutStore outStore){
		outStoreManagerDAO.updateOutStoreOrder(outStore);
	}
	
	public int deleteOutStore(String id){
		
		if(!Tools.isValid(id)){
			return 0;
		}
		
		OutStore os = new OutStore();
		OutStore osTmp = new OutStore();
		os.setOrderId(id);
		List<OutStore> outList = outStoreManagerDAO.queryOutStoreDtl(os);
		//删除出库订单
		outStoreManagerDAO.deleteOutStore(os);
		//修改入库表中出库标志
		for(int i = 0; i < outList.size(); i++){
			
			os = outList.get(i);
			osTmp.setInId(os.getInId());
			List<?> tmpList = outStoreManagerDAO.queryOutStoreDtl(osTmp);
			
			if(null == tmpList || tmpList.size() == 0){
				os.setIsOut(OutStatus.NO_OUT.getValue());
			}else{
				os.setIsOut(OutStatus.PART_OUT.getValue());
			}
			
			outStoreManagerDAO.updateStatusOut(os);
		}
		return 1;
	}
	
	public OutStoreManagerDAO getOutStoreManagerDAO() {
		return outStoreManagerDAO;
	}

	public void setOutStoreManagerDAO(OutStoreManagerDAO outStoreManagerDAO) {
		this.outStoreManagerDAO = outStoreManagerDAO;
	}

	public IntoStoreManagerDAO getIntoStoreManagerDAO() {
		return intoStoreManagerDAO;
	}

	public void setIntoStoreManagerDAO(IntoStoreManagerDAO intoStoreManagerDAO) {
		this.intoStoreManagerDAO = intoStoreManagerDAO;
	}

	public BrandManagerDAO getBrandManagerDAO() {
		return brandManagerDAO;
	}

	public void setBrandManagerDAO(BrandManagerDAO brandManagerDAO) {
		this.brandManagerDAO = brandManagerDAO;
	}
	
}
