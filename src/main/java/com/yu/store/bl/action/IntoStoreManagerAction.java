package com.yu.store.bl.action;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.bl.bo.BrandManagerBO;
import com.yu.store.bl.bo.IntoStoreManagerBO;
import com.yu.store.bl.vo.Brand;
import com.yu.store.bl.vo.IntoStore;
import com.yu.store.sys.action.BaseAction;

/**
 * @author Kingking Yu
 *
 */
public class IntoStoreManagerAction extends BaseAction implements ModelDriven<IntoStore>{

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private IntoStoreManagerBO intoStoreManagerBO = null;
	private BrandManagerBO brandManagerBO = null;
	private IntoStore intoStore = new IntoStore();

	public String query(){
		
		try {
			intoStoreManagerBO.queryMaxPage(intoStore);
			resultList = intoStoreManagerBO.queryIntoStore(intoStore);
			request.setAttribute("intoStore", intoStore);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String gotoDtl(){
		
		try {
			String id = intoStore.getId();
			//add
			if(null == id || "".equals(id.trim())){
				return "dtl";
			//update
			}else{
				intoStore = intoStoreManagerBO.queryIntoStoreDtl(id);
				request.setAttribute("intoStore", intoStore);
			}
		} catch (Exception e) {
			log.error(">>>errors in method:queryDtl()", e);
		}
		return "dtl";
	}
	
	public String insert(){
		
		int res = 0;
		
		try {
			res = intoStoreManagerBO.insertIntoStore(intoStore);
		} catch (Exception e) {
			log.error(">>>errors in method:insert()", e);
			jsContent.setAlert("入库失败");
			return "proxy";
		}
		
		if(res == 0){
			jsContent.setAlert("入库失败:此独立序列号已入库");
			return "proxy";
		}
		
		jsContent.setAlert("入库成功");
        jsContent.setCallingFunction("refresh();");
        jsContent.setCallingFunction("closeWindow();");
		return "proxy";
	}
	
	public String update(){
		
		try {
			intoStoreManagerBO.updateIntoStore(intoStore);
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
			int res = intoStoreManagerBO.deleteIntoStore(cboMainChoice);
			if(res == 1){
				info = "删除成功";
			}else if(res == 0){
				info = "无法删除(该商品已出库)";
			}else if(res == -1){
				info = "未选择删除项";
			}
		} catch (Exception e) {
			log.error(">>>errors in method:del()", e);
			info = "删除失败(该商品已出库)";
		}
		return query();
	}
	
	public String proxyBrand(){
		
		Brand b = null;
		String serial = intoStore.getSerial();
		String brand = "无关联信息";
		String type = "无关联信息";
		
		if(null == serial || "".equals(serial.trim())){
			return "proxy";
		}
		
		try {
			b = brandManagerBO.queryBrandDtl(serial);
		} catch (Exception e) {
			log.error(">>>errors in method:proxyBrand()", e);
		}
		
		if(null != b){
			brand = b.getBrand() == null ? "无关联信息" : b.getBrand();
			type = b.getType() == null ? "无关联信息" : b.getType();
		} 
		
		jsContent.setCallingFunction("proxyBrandCallback('" + brand + "','"
															+ type + "')");
		return "proxy";
	}
	
	public IntoStoreManagerBO getIntoStoreManagerBO() {
		return intoStoreManagerBO;
	}

	public void setIntoStoreManagerBO(IntoStoreManagerBO intoStoreManagerBO) {
		this.intoStoreManagerBO = intoStoreManagerBO;
	}
	
	public BrandManagerBO getBrandManagerBO() {
		return brandManagerBO;
	}

	public void setBrandManagerBO(BrandManagerBO brandManagerBO) {
		this.brandManagerBO = brandManagerBO;
	}

	@Override
	public IntoStore getModel() {
		return intoStore;
	}

}
