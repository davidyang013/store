package com.yu.store.bl.bo;

import java.util.List;

import com.yu.store.bl.dao.StorageManagerDAO;
import com.yu.store.bl.vo.Storage;
import com.yu.store.sys.util.Tools;

/**
 * @author Kingking Yu
 *
 */
public class StorageManagerBO {
	
	StorageManagerDAO storageManagerDAO = null;
	
	public void queryMaxPage(Storage storage){
		
		int maxCnt = storageManagerDAO.queryMaxPage(storage);
		int maxPage = (int)Math.ceil((double)maxCnt / storage.getPageSize());
		storage.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public int queryMaxCnt(Storage storage){
		
		return storageManagerDAO.queryMaxPage(storage);
	}
	
	public List<?> queryStorage(Storage storage){
		return storageManagerDAO.queryStorage(storage);
	}
	
	public void queryEachMaxPage(Storage storage){
		
		int maxCnt = storageManagerDAO.queryEachMaxPage(storage);
		int maxPage = (int)Math.ceil((double)maxCnt / storage.getPageSize());
		storage.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public List<?> queryStorageEach(Storage storage){
		return storageManagerDAO.queryStorageEach(storage);
	}
	
	public String calculate(Storage storage){
		
		if("1".equals(storage.getRadioCalc())){
			
			return Tools.money2Str(storageManagerDAO.calcPrice(storage), 2);
			
		}else if("2".equals(storage.getRadioCalc())){
			
			return (int)(double)storageManagerDAO.calcCount(storage) + "件";
			
		}else if("3".equals(storage.getRadioCalc())){
			
			return Tools.money2Str(storageManagerDAO.calcTotal(storage), 2);
			
		}else{
			
			return "警告!非法操作!";
			
		}
	}
	
	public StorageManagerDAO getStorageManagerDAO() {
		return storageManagerDAO;
	}

	public void setStorageManagerDAO(StorageManagerDAO storageManagerDAO) {
		this.storageManagerDAO = storageManagerDAO;
	}
	
}
