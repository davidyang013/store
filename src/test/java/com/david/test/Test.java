package com.david.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Test {

	public static Connection getConn(){
		Connection conn=null;
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(  
                    "jdbc:oracle:thin:@192.168.1.111:1521:orcl", "orcl", "orcl");
			System.out.print(conn);
		}catch(Exception e){
			System.out.println("connection fialed...");
		}finally{
			if(null!=conn){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return conn;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		getConn();
	}

}
