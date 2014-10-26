package com.yu.store.sys.tag;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.tagext.BodyTagSupport;

public abstract class BaseTagSupport extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	public void response(String str){
		
		try {
			pageContext.getOut().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("deprecation")
	public String getPath(){
		
		ServletRequest request = pageContext.getRequest();
		return request.getRealPath("/");
	}
}