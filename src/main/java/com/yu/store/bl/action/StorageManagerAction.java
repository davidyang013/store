package com.yu.store.bl.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.bl.bo.StorageManagerBO;
import com.yu.store.bl.vo.Storage;
import com.yu.store.sys.action.BaseAction;
import com.yu.store.sys.util.Tools;

/**
 * @author Kingking Yu
 *
 */
public class StorageManagerAction extends BaseAction implements ModelDriven<Storage>{

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private StorageManagerBO storageManagerBO = null;
	private Storage storage = new Storage();

	public String query(){
		
		try {
			storageManagerBO.queryMaxPage(storage);
			resultList = storageManagerBO.queryStorage(storage);
			request.setAttribute("storage", storage);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String queryEach(){
		
		if(!Tools.isValid(storage.getSerial()) || 
			!Tools.isValid(storage.getInDate()) || 
			!Tools.isValid(storage.getColor())){
			return null;
		}
		
		try {
			decode();
			storage.setPageSize(15);
			storageManagerBO.queryEachMaxPage(storage);
			resultList = storageManagerBO.queryStorageEach(storage);
			request.setAttribute("storage", storage);
		} catch (Exception e) {
			log.error(">>>errors in method:queryEach()", e);
		}
		return "each";
	}

	public String queryCalc(){
		
		try {
			decode();
			request.setAttribute("storage", storage);
		} catch (Exception e) {
			log.error(">>>errors in method:queryCalc()", e);
		}
		return "calc";
	}
	
	public String proxyCalc(){
		
		String result = "0";
		
		if(!Tools.isValid(storage.getRadioCalc())){
			return "proxy";
		}
		
		try {
			result = storageManagerBO.calculate(storage);
		} catch (Exception e) {
			log.error(">>>errors in method:proxyCalc()", e);
		}
		
		jsContent.setCallingFunction("proxyCalcCallback('" + result + "')");
		return "proxy";
	}
	
	private void decode(){
		try {
			if(Tools.isValid(storage.getColor())){
				storage.setColor((URLDecoder.decode(storage.getColor(), "UTF-8")));
			}
			if(Tools.isValid(storage.getType())){
				storage.setType((URLDecoder.decode(storage.getType(), "UTF-8")));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	public StorageManagerBO getStorageManagerBO() {
		return storageManagerBO;
	}

	public void setStorageManagerBO(StorageManagerBO storageManagerBO) {
		this.storageManagerBO = storageManagerBO;
	}
	
	@Override
	public Storage getModel() {
		return storage;
	}

}
