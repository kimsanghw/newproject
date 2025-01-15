<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>
<%  
	
	request.setCharacterEncoding("UTF-8");	

	String id = request.getParameter("id");
	
	Connection conn = null; 
	PreparedStatement psmt = null; 
	ResultSet rs = null;	
	
	try{
		
		conn = DBConn.conn();
		
		String sql = "SELECT COUNT(*) AS cnt FROM user WHERE id=?";
		
		psmt = conn.prepareStatement(sql); 
		psmt.setString(1,id); 
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			int result = rs.getInt("cnt");
			if(result > 0){
				out.print("isid"); 
			}else{
				out.print("isNotId");
			}
		}
		
	}catch(Exception e){
		e.printStackTrace();
		out.print("error"); 
	}finally{
		DBConn.close(rs, psmt, conn);
	}

%>