<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	int dno = Integer.parseInt(request.getParameter("dno"));
	int sno = Integer.parseInt(request.getParameter("sno"));
	String content = request.getParameter("content");
	
	
	if(request.getMethod().equals("GET")){
		
		response.sendRedirect("view.jsp?dno="+dno);
		
		
		
		
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn =	DBConn.conn();
		
		String sql = " UPDATE comment_d"
				   + " SET content=?"
				   + " WHERE sno=?";
		
		   
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,content);
		psmt.setInt(2,sno);
		
		
		psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close( psmt, conn);
	}

	response.sendRedirect("view.jsp?dno="+dno);
	



%>