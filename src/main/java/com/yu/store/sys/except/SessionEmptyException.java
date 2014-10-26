package com.yu.store.sys.except;

public class SessionEmptyException extends Exception {

	private static final long serialVersionUID = 1L;
	
	public SessionEmptyException(){}
	
	public SessionEmptyException(String msg){
		super(msg);
	}

}
