package com.yu.store.sys.sort;

import java.util.Comparator;

import com.yu.store.sys.vo.Menu;

public class MenuSort implements Comparator<Menu>{

	@Override
	public int compare(Menu menuA, Menu menuB) {
		
		if(null == menuA || null == menuB){
			return 0;
		}
		
		return menuA.getSeq().compareTo(menuB.getSeq());
		
	}

	
}
