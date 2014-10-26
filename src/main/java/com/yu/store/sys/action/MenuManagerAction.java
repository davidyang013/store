package com.yu.store.sys.action;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.sys.bo.MenuManagerBO;
import com.yu.store.sys.vo.Menu;

/**
 * 菜单管理Action
 * @author Kingking Yu
 */
public class MenuManagerAction extends BaseAction implements ModelDriven<Menu> {

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private MenuManagerBO menuManagerBO = null;
	private Menu menu = new Menu();
	
	public String query(){
		
		try {
			String id = (String)session.get("loginName");
			
			if(null == id){
				return "left";
			}
			
			resultList = menuManagerBO.queryMenuByAuth(id);
			session.put("menuList", resultList);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "left";
	}
	
	/*************************** getters and setters *****************************/
	public MenuManagerBO getMenuManagerBO() {
		return menuManagerBO;
	}

	public void setMenuManagerBO(MenuManagerBO menuManagerBO) {
		this.menuManagerBO = menuManagerBO;
	}
	
	@Override
	public Menu getModel() {
		return menu;
	}

}