<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	int kno = Integer.parseInt(request.getParameter("kno"));
	int tno = Integer.parseInt(request.getParameter("tno"));
	String content = request.getParameter("content");
	
	
	if(request.getMethod().equals("GET")){
		
		response.sendRedirect("view.jsp?kno="+kno);
		
		
		
		
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn =	DBConn.conn();
		
		String sql = " UPDATE comment_k"
				   + " SET content=?"
				   + " WHERE tno=?";
		
		   
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,content);
		psmt.setInt(2,tno);
		
		
		psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBConn.close( psmt, conn);
	}

	response.sendRedirect("view.jsp?kno="+kno);
	



%>