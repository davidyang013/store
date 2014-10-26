package com.yu.store.sys.except;

public class PrimaryKeyException extends Exception {

	private static final long serialVersionUID = 1L;
	
	public PrimaryKeyException(){}
	
	public PrimaryKeyException(String msg){
		super(msg);
	}

}
