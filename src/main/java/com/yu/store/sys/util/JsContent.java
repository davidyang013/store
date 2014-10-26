package com.yu.store.sys.util;

/**
 * @author Kingking Yu
 *
 */
public class JsContent {

	private StringBuffer strSetValue = null;
	private StringBuffer strCallFunction = null;
	private StringBuffer strAlert = null;
	private StringBuffer strConfirm = null;
	private StringBuffer strNextMethod = null;
	private StringBuffer strExecute = null;

	public void addModifiedValue(String fieldID, String attributeName,
			String attributeValue) {
		
		if (this.strSetValue == null)
			this.strSetValue = new StringBuffer();
		this.strSetValue.append(fieldID);
		this.strSetValue.append(".");
		this.strSetValue.append(attributeName);
		this.strSetValue.append(" = '");
		this.strSetValue.append(attributeValue);
		this.strSetValue.append("';\n");
	}

	public void setCallingFunction(String function) {
		
		if (this.strCallFunction == null)
			this.strCallFunction = new StringBuffer();
		this.strCallFunction.append(function);
		this.strCallFunction.append(";\n");
	}

	public void setAlert(String alertContent) {
		
		if (this.strAlert == null){
			this.strAlert = new StringBuffer();
		}
		this.strAlert.append("alert('");
		this.strAlert.append(alertContent);
		this.strAlert.append("');\n");
	}

	public void setConfirm(String confirmContent) {
		
		if (this.strConfirm == null){
			this.strConfirm = new StringBuffer();
		}
		this.strConfirm.append("var confirmResult;\n");
		this.strConfirm.append("if(confirm('");
		this.strConfirm.append(confirmContent);
		this.strConfirm.append("') == true){\n");
		this.strConfirm.append("    confirmResult = 'true';\n");
		this.strConfirm.append("}else{\n");
		this.strConfirm.append("    confirmResult = 'false';\n");
		this.strConfirm.append("}\n");
	}

	public void setNextMethod(String nextAction, String nextMethod) {
		
		if (this.strNextMethod == null){
			this.strNextMethod = new StringBuffer();
		}
		this.strNextMethod.append("proxyRequest('");
		this.strNextMethod.append(nextAction);
		this.strNextMethod.append("', '");
		this.strNextMethod.append(nextMethod);
		this.strNextMethod.append("', ");

		if (this.strConfirm != null)
			this.strNextMethod.append("'confirmResult=' + confirmResult");
		else {
			this.strNextMethod.append("null");
		}
		this.strNextMethod.append(");\n");
	}

	public String toString() {
		
		this.strExecute = new StringBuffer();
		if (this.strSetValue != null) {
			this.strExecute.append(this.strSetValue);
		}
		if (this.strAlert != null) {
			this.strExecute.append(this.strAlert);
		}
		if (this.strCallFunction != null) {
			this.strExecute.append(this.strCallFunction);
		}
		if (this.strConfirm != null) {
			this.strExecute.append(this.strConfirm);
		}
		if (this.strNextMethod != null) {
			this.strExecute.append(this.strNextMethod);
		}
		return this.strExecute.toString();
	}

	public static void main(String[] args) {
		
		JsContent jsContent1 = new JsContent();

		jsContent1.setAlert("成功！");

		System.out.println(jsContent1.toString());
	}
}
