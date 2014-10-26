package com.yu.store.bl.bo;

import java.util.List;

import com.yu.store.bl.dao.BrandManagerDAO;
import com.yu.store.bl.vo.Brand;

/**
 * @author Kingking Yu
 *
 */
public class BrandManagerBO {
	
	BrandManagerDAO brandManagerDAO = null;
	
	public void queryMaxPage(Brand brand){
		
		int maxCnt = brandManagerDAO.queryMaxPage(brand);
		int maxPage = (int)Math.ceil((double)maxCnt / brand.getPageSize());
		brand.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public List<?> queryBrand(Brand brand){
		return brandManagerDAO.queryBrand(brand);
	}
	
	public Brand queryBrandDtl(String serial){
		return brandManagerDAO.queryBrandDtl(serial);
	}
	
	public void insertBrand(Brand brand){
		brandManagerDAO.insertBrand(brand);
	}
	
	public void updateBrand(Brand brand){
		brandManagerDAO.updateBrand(brand);
	}
	
	public void deleteBrand(String[] serial){
		
		if(null == serial || serial.length <= 0){
			return;
		}
		
		for(String s : serial){
			brandManagerDAO.deleteBrand(s);
		}
	}
	
	public BrandManagerDAO getBrandManagerDAO() {
		return brandManagerDAO;
	}

	public void setBrandManagerDAO(BrandManagerDAO brandManagerDAO) {
		this.brandManagerDAO = brandManagerDAO;
	}
	
}
