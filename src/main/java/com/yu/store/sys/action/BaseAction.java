package com.yu.store.sys.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.ParameterAware;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.yu.store.sys.util.JsContent;

/**
 * @author Kingking Yu
 *
 */
public class BaseAction extends ActionSupport implements ServletResponseAware,
		ServletRequestAware, SessionAware, ApplicationAware, ParameterAware {

	private static final long serialVersionUID = -1;
	protected HttpServletResponse response;
	protected HttpServletRequest request;
	protected Map<String, Object> session;
	protected Map<String, Object> application;
	protected Map<String, String[]> parameters;
	protected List<?> resultList = null;
	protected String info = "";
	protected String optype = "add";
	protected String[] cboMainChoice;
	protected JsContent jsContent = new JsContent();
	
	@Override
	public String execute() throws Exception {
		return super.execute();
	}

	@SuppressWarnings("deprecation")
	public String getPath() {
		return request.getRealPath("");
	}

	public List<?> getResultList() {
		return resultList;
	}

	public void setResultList(List<?> resultList) {
		this.resultList = resultList;
	}
	
	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getOptype() {
		return optype;
	}

	public void setOptype(String optype) {
		this.optype = optype;
	}

	@Override
	public void setParameters(Map<String, String[]> parameters) {
		this.parameters = parameters;
	}

	@Override
	public void setApplication(Map<String, Object> application) {
		this.application = application;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response; 

	}

	public JsContent getJsContent() {
		return jsContent;
	}

	public void setJsContent(JsContent jsContent) {
		this.jsContent = jsContent;
	}

	public String[] getCboMainChoice() {
		return cboMainChoice;
	}

	public void setCboMainChoice(String[] cboMainChoice) {
		this.cboMainChoice = cboMainChoice;
	}

}
