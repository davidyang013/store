package com.yu.store.sys.action;

import java.util.List;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.sys.bo.RoleManagerBO;
import com.yu.store.sys.bo.UserManagerBO;
import com.yu.store.sys.util.Constant;
import com.yu.store.sys.util.Tools;
import com.yu.store.sys.vo.Role;
import com.yu.store.sys.vo.User;
import com.yu.store.sys.vo.UserRole;

/**
 * 用户管理Action
 * @author Kingking Yu
 */
public class UserManagerAction extends BaseAction implements ModelDriven<User> {

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private UserManagerBO userManagerBO = null;
	private RoleManagerBO roleManagerBO = null;
	private List<?> userRoleList = null;
	private User user = new User();
	private Role role = new Role();
	private UserRole userRole = new UserRole();
	private String msg = null;
	
	public String toLogin() {
		request.getSession().invalidate();
		return "loginFailed";
	}

	public String login() {
		
		try {
			if (userManagerBO.updateUserStatus(user) <= 0) {
				jsContent.setAlert("用户名或密码错误！");
				setMsg("用户名或密码错误！");
				return "proxy";
			}
			request.getSession().setAttribute("loginName", user.getId());
			
		} catch (Exception e) {
			log.error(">>>errors in method:login()", e);
		}

        jsContent.setCallingFunction("gotoMain();");
		return "proxy";
	}
	
	public String gotoMain(){
		String login = (String)request.getSession().getAttribute("loginName");
		if(!Tools.isValid(login)){
			return "loginFailed";
		}
		return "loginSuccess";
	}
	
	public String updatePwd(){
		try {
			String id = (String)session.get("loginName");
			if(null == id){
				return "loginFailed";
			}
			user.setId(id);
			userManagerBO.updateUser(user);
			info = "修改成功";
		} catch (Exception e) {
			info = "修改失败";
			log.error(">>>errors in method:updatePwd()", e);
		}
		return "pwd";
	}
	
	public String query(){
		
		try {
			userManagerBO.queryMaxPage(user);
			resultList = userManagerBO.queryUser(user);
			request.setAttribute("user", user);
			request.setAttribute("noDel", Constant.SYSTEM_USER);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String gotoDtl(){
		
		try {
			String id = user.getId();
			//add
			if(null == id || "".equals(id.trim())){
				int cnt = roleManagerBO.queryMaxCnt(role);
				role.setMaxPage(cnt + "");
				resultList = roleManagerBO.queryRole(role);
				return "dtl";
			//update
			}else{
				user = userManagerBO.queryUserDtl(id);
				if(null == user){
					return null;
				}
				userRole.setUserId(user.getId());
				userRoleList = userManagerBO.queryUserRole(userRole);
				resultList = roleManagerBO.queryRole(role);
				request.setAttribute("user", user);
				request.setAttribute("userRoleList", userRoleList);
			}
		} catch (Exception e) {
			log.error(">>>errors in method:gotoDtl()", e);
		}
		return "dtl";
	}
	
	public String insert(){
		
		try {
			userManagerBO.insertUser(user, cboMainChoice);
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
			userManagerBO.updateUser(user, cboMainChoice);
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
			userManagerBO.deleteUser(cboMainChoice);
			info = "删除成功";
		} catch (Exception e) {
			log.error(">>>errors in method:del()", e);
			info = "删除失败(已有该类型的出入库商品)";
		}
		return query();
	}
	
	/*************************** getters and setters *****************************/
	public UserManagerBO getUserManagerBO() {
		return userManagerBO;
	}

	public void setUserManagerBO(UserManagerBO userManagerBO) {
		this.userManagerBO = userManagerBO;
	}
	
	public RoleManagerBO getRoleManagerBO() {
		return roleManagerBO;
	}

	public void setRoleManagerBO(RoleManagerBO roleManagerBO) {
		this.roleManagerBO = roleManagerBO;
	}
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	@Override
	public User getModel() {
		return user;
	}

}