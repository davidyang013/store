package com.yu.store.sys.util;

public enum OutStatus {
	
	NO_OUT("0"),
	ALL_OUT("1"),
    PART_OUT("2");
    
    private final String value;

    public String getValue() {
		return value;
	}

	OutStatus(String value){
		this.value = value;
	}
}
