package com.yu.store.sys.vo;

/**
 * @author Kingking Yu
 *
 */
public class Menu extends Page{
	
	private static final long serialVersionUID = 1L;

	private String id;
	
	private String name;
	
	private String url;
	
	private String parentId;
	
	private String seq;
	
	public Menu(){}
	
	public Menu(String name, String url){
		
		this.name = name;
		this.url = url;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

}
