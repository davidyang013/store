package com.yu.store.bl.action;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.bl.bo.BrandManagerBO;
import com.yu.store.bl.vo.Brand;
import com.yu.store.sys.action.BaseAction;

/**
 * @author Kingking Yu
 *
 */
public class BrandManagerAction extends BaseAction implements ModelDriven<Brand>{

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private BrandManagerBO brandManagerBO = null;
	private Brand brand = new Brand();

	public String query(){
		try {
			brandManagerBO.queryMaxPage(brand);
			resultList = brandManagerBO.queryBrand(brand);
			request.setAttribute("brand", brand);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String gotoDtl(){
		
		try {
			String serial = brand.getSerial();
			//add
			if(null == serial || "".equals(serial.trim())){
				return "dtl";
			//update
			}else{
				brand = brandManagerBO.queryBrandDtl(serial);
				request.setAttribute("brand", brand);
			}
		} catch (Exception e) {
			log.error(">>>errors in method:queryDtl()", e);
		}
		return "dtl";
	}
	
	public String insert(){
		
		try {
			Brand tmpBrand = brandManagerBO.queryBrandDtl(brand.getSerial());
			if(null != tmpBrand){
				jsContent.setAlert("该商品序列号已维护");
				return "proxy";
			}
			brandManagerBO.insertBrand(brand);
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
			brandManagerBO.updateBrand(brand);
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
			brandManagerBO.deleteBrand(cboMainChoice);
			info = "删除成功";
		} catch (Exception e) {
			log.error(">>>errors in method:del()", e);
			info = "删除失败(已有该类型的出入库商品)";
		}
		return query();
	}
	
	public BrandManagerBO getBrandManagerBO() {
		return brandManagerBO;
	}

	public void setBrandManagerBO(BrandManagerBO brandManagerBO) {
		this.brandManagerBO = brandManagerBO;
	}

	@Override
	public Brand getModel() {
		return brand;
	}

}
