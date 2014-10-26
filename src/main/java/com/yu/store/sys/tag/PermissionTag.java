package com.yu.store.sys.tag;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.yu.store.sys.util.Tools;
import com.yu.store.sys.vo.Menu;

/**
 * 
 * @author Kingking Yu
 *
 */
public class PermissionTag extends BaseTagSupport {

	private static final long serialVersionUID = 1L;
	
	private String menuId;

	@Override
	public int doStartTag() throws JspException {
		
		HttpSession session = ((HttpServletRequest)pageContext.getRequest()).getSession();
		List<?> menuList = (List<?>)session.getAttribute("menuList");
		
		if(null == menuList || menuList.size() == 0 || !Tools.isValid(menuId)){
			return TagSupport.SKIP_BODY;
		}
		
		for(int i = 0; i < menuList.size(); i++){
			
			Menu m = (Menu)menuList.get(i);
			if(menuId.equals(m.getId())){
				return TagSupport.EVAL_BODY_INCLUDE;
			}
		}
		
		return TagSupport.SKIP_BODY;
	}
	
	public void release() {
		super.release();
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	
}