package com.yu.store.bl.except;

public class OrderCheckException extends Exception {

	private static final long serialVersionUID = 1L;
	
	public OrderCheckException(){}
	
	public OrderCheckException(String msg){
		super(msg);
	}

}
