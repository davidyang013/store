package com.yu.store.sys.action;

import java.util.List;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.sys.bo.MenuManagerBO;
import com.yu.store.sys.bo.RoleManagerBO;
import com.yu.store.sys.util.Constant;
import com.yu.store.sys.vo.Menu;
import com.yu.store.sys.vo.Role;
import com.yu.store.sys.vo.RoleAuth;

/**
 * 角色管理Action
 * @author Kingking Yu
 */
public class RoleManagerAction extends BaseAction implements ModelDriven<Role> {

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private RoleManagerBO roleManagerBO = null;
	private MenuManagerBO menuManagerBO = null;
	private List<?> roleAuthList = null;
	private Role role = new Role();
	private Menu menu = new Menu();
	private RoleAuth roleAuth = new RoleAuth();
	
	public String query(){
		try {
			roleManagerBO.queryMaxPage(role);
			resultList = roleManagerBO.queryRole(role);
			request.setAttribute("role", role);
			request.setAttribute("noDel", Constant.SYSTEM_ROLE);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String gotoDtl(){
		
		try {
			String id = role.getId();
			//add
			if(null == id || "".equals(id.trim())){
				resultList = menuManagerBO.queryMenu(menu);
				return "dtl";
			//update
			}else{
				roleAuth.setRoleId(role.getId());
				roleAuthList = roleManagerBO.queryRoleAuth(roleAuth);
				role = roleManagerBO.queryRoleDtl(id);
				resultList = menuManagerBO.queryMenu(menu);
				request.setAttribute("role", role);
				request.setAttribute("roleAuthList", roleAuthList);
			}
		} catch (Exception e) {
			log.error(">>>errors in method:gotoDtl()", e);
		}
		return "dtl";
	}
	
	public String insert(){
		
		try {
			roleManagerBO.insertRole(role, cboMainChoice);
		} catch (Exception e) {
			log.error(">>>errors in method:insert()", e);
			jsContent.setAlert("插入失败");
			return "proxy";
		}
		jsContent.setAlert("插入成功");
        jsContent.setCallingFunction("refresh();");
        jsContent.setCallingFunction("closeWindow();");
		return "proxy";
	}
	
	public String update(){
		
		try {
			roleManagerBO.updateRole(role, cboMainChoice);
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
			roleManagerBO.deleteRole(cboMainChoice);
			info = "删除成功";
		} catch (Exception e) {
			log.error(">>>errors in method:del()", e);
			info = "删除失败(已有该类型的出入库商品)";
		}
		return query();
	}
	
	/*************************** getters and setters *****************************/
	public RoleManagerBO getRoleManagerBO() {
		return roleManagerBO;
	}

	public void setRoleManagerBO(RoleManagerBO roleManagerBO) {
		this.roleManagerBO = roleManagerBO;
	}
	
	public MenuManagerBO getMenuManagerBO() {
		return menuManagerBO;
	}

	public void setMenuManagerBO(MenuManagerBO menuManagerBO) {
		this.menuManagerBO = menuManagerBO;
	}

	@Override
	public Role getModel() {
		return role;
	}

}