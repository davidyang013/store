package com.yu.store.bl.bo;

import java.util.List;

import com.yu.store.bl.dao.IntoStoreManagerDAO;
import com.yu.store.bl.vo.IntoStore;
import com.yu.store.sys.util.Tools;

/**
 * @author Kingking Yu
 *
 */
public class IntoStoreManagerBO {
	
	IntoStoreManagerDAO intoStoreManagerDAO = null;
	
	public void queryMaxPage(IntoStore intoStore){
		
		int maxCnt = intoStoreManagerDAO.queryMaxPage(intoStore);
		int maxPage = (int)Math.ceil((double)maxCnt / intoStore.getPageSize());
		intoStore.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public int queryMaxCnt(IntoStore intoStore){
		
		return intoStoreManagerDAO.queryMaxPage(intoStore);
	}
	
	public List<?> queryIntoStore(IntoStore intoStore){
		return intoStoreManagerDAO.queryIntoStore(intoStore);
	}
	
	public List<?> queryIntoStoreByOut(IntoStore intoStore){
		return intoStoreManagerDAO.queryIntoStoreByOut(intoStore);
	}
	
	public IntoStore queryIntoStoreDtl(String id){
		return intoStoreManagerDAO.queryIntoStoreDtl(id);
	}
	
	public int insertIntoStore(IntoStore intoStore){
		
		//判断该独立序列号是否已被使用
		IntoStore tmp = new IntoStore();
		//没有输入独立序列号时无需判断是否已入库
		if(!Tools.isValid(intoStore.getDepSerial())){
			intoStoreManagerDAO.insertIntoStore(intoStore);
			return 1;
		}
		tmp.setDepSerial(intoStore.getDepSerial());
		List<?> res = intoStoreManagerDAO.queryIntoStore(tmp);
		if(res.size() > 0){
			return 0;
		}
		//入库
		intoStoreManagerDAO.insertIntoStore(intoStore);
		return 1;
	}
	
	public void updateIntoStore(IntoStore intoStore){
		intoStoreManagerDAO.updateIntoStore(intoStore);
	}
	
	public int deleteIntoStore(String[] ids){
		
		if(null == ids || ids.length <= 0){
			return -1;
		}
		IntoStore intoStore = new IntoStore();
		for(String id: ids){
			intoStore = queryIntoStoreDtl(id);
			if(!intoStore.getIsOutValue().equals("0")){
				return 0;
			}
			intoStoreManagerDAO.deleteIntoStore(id);
		}
		return 1;
	}
	
	public IntoStoreManagerDAO getIntoStoreManagerDAO() {
		return intoStoreManagerDAO;
	}

	public void setIntoStoreManagerDAO(IntoStoreManagerDAO intoStoreManagerDAO) {
		this.intoStoreManagerDAO = intoStoreManagerDAO;
	}
	
}
