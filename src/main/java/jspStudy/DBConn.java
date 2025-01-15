package jspStudy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConn {
	public static final String URL= "jdbc:mysql://localhost:3306/newproject";
	public static final String USER = "tester";
	public static final String PASSWORD = "ezen";
	
	public static Connection conn() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection( URL, USER, PASSWORD);
	}
	
	
	//close�����ε�
	public static void close(ResultSet rs, PreparedStatement psmt, Connection conn) throws Exception {
		if(rs != null) rs.close();
		if(psmt != null) psmt.close();
		if(conn != null) conn.close();
		
	}
	
	public static void close(PreparedStatement psmt, Connection conn) throws Exception{
		if(psmt != null) psmt.close();
		if(conn != null) conn.close();
	}
	
	
}
