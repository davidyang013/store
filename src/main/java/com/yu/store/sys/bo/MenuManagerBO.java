package com.yu.store.sys.bo;

import java.util.List;

import com.yu.store.sys.dao.MenuManagerDAO;
import com.yu.store.sys.vo.Menu;

/**
 * @author Kingking Yu
 *
 */
public class MenuManagerBO {
	
	private MenuManagerDAO menuManagerDAO = null;
	
	public void queryMaxPage(Menu menu){
		
		int maxCnt = menuManagerDAO.queryMaxPage(menu);
		int maxPage = (int)Math.ceil((double)maxCnt / menu.getPageSize());
		menu.setMaxPage((maxPage == 0 ? 1 : maxPage) + "");
	}
	
	public int queryMaxCnt(Menu menu){
		
		return menuManagerDAO.queryMaxPage(menu);
	}
	
	public List<?> queryMenuByAuth(String id){
		return menuManagerDAO.queryMenuAuth(id);
	}
	
	public List<?> queryMenu(Menu menu){
		return menuManagerDAO.queryMenu(menu);
	}
	
	public Menu queryMenuDtl(String serial){
		return menuManagerDAO.queryMenuDtl(serial);
	}
	
	public void insertMenu(Menu menu){
		menuManagerDAO.insertMenu(menu);
	}
	
	public void updateMenu(Menu menu){
		menuManagerDAO.updateMenu(menu);
	}
	
	public int updateMenuStatus(Menu menu){
		return menuManagerDAO.updateMenuStatus(menu);
	}
	
	public void deleteMenu(String[] serial){
		
		if(null == serial || serial.length <= 0){
			return;
		}
		
		for(String s : serial){
			menuManagerDAO.deleteMenu(s);
		}
	}

	public MenuManagerDAO getMenuManagerDAO() {
		return menuManagerDAO;
	}

	public void setMenuManagerDAO(MenuManagerDAO menuManagerDAO) {
		this.menuManagerDAO = menuManagerDAO;
	}

}
