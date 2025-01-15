<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>

<%
	int tno = Integer.parseInt(request.getParameter("tno"));
	int kno = Integer.parseInt(request.getParameter("kno"));
	
	
	
	if(request.getMethod().equals("GET")){
		response.sendRedirect("view.jsp?kno="+kno);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	
	try{
		conn =	DBConn.conn();
		
		String sql = " UPDATE comment_k"
				   + " SET state= 'D'"
				   + "  WHERE tno = ?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,tno);
		
		psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBConn.close( psmt, conn);
	}

	response.sendRedirect("view.jsp?kno="+kno);

%>