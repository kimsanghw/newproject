<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>

<%
	int sno = Integer.parseInt(request.getParameter("sno"));
	int dno = Integer.parseInt(request.getParameter("dno"));
	
	
	
	if(request.getMethod().equals("GET")){
		response.sendRedirect("view.jsp?dno="+dno);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	
	try{
		conn =	DBConn.conn();
		
		String sql = " UPDATE comment_d"
				   + " SET state= 'D'"
				   + "  WHERE sno = ?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,sno);
		
		psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBConn.close( psmt, conn);
	}

	response.sendRedirect("view.jsp?dno="+dno);

%>