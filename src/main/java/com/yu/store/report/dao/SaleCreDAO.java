package com.yu.store.report.dao;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.util.List;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
import com.yu.store.bl.vo.OutStore;
import com.yu.store.report.vo.SaleCre;

/**
 * @author Kingking Yu
 *
 */
@SuppressWarnings("unchecked")
public class SaleCreDAO{
	
	private static SqlMapClient sqlMapClient = null;// 读取配置文件 
	
	public SaleCreDAO(){
		try {
			Resources.setCharset(Charset.forName("UTF-8"));
			Reader reader = Resources.getResourceAsReader("ibatis/sqlMapConfigNoSpring.xml"); 
			sqlMapClient = SqlMapClientBuilder.buildSqlMapClient(reader); 
			reader.close(); 
		} catch (IOException e) {e.printStackTrace();}; 
	} 

	public List<OutStore> queryOutStoreDtl(String id){
		List<OutStore> list = null;
		try {
			 OutStore outStore = new OutStore();
			 outStore.setOrderId(id);
			 list = sqlMapClient.queryForList("bl.queryOutStoreDtl", outStore);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public SaleCre querySaleCre(String id){
		SaleCre saleCre = null;
		try {
			saleCre = (SaleCre)sqlMapClient.queryForObject("bl.querySaleCre", id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return saleCre;
	}
	
	public String queryMemberId(String orderId){
		String memberId = null;
		try {
			memberId = (String) sqlMapClient.queryForObject("bl.queryMemberId", orderId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return memberId;
	}
}
