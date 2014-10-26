package com.yu.store.sys.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

/**
 * @author Kingking Yu
 *
 */
public class MainFilter implements Filter{

	private Logger log = Logger.getLogger(this.getClass().getName());

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)  
	            throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		String url = req.getServletPath();
		String param = req.getQueryString();
		Object loginName = session.getAttribute("loginName");
		
		if(null == loginName){
			chain.doFilter(req, res);
			return;
		}
		
		req.setCharacterEncoding("UTF-8");
		chain.doFilter(req, res);  
		log.info("请求路径url:" + url + "?" + param);
	}

	@Override
	public void destroy() {
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}
}
