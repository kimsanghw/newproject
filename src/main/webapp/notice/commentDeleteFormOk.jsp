<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>

<%
	int qno = Integer.parseInt(request.getParameter("qno"));
	int nno = Integer.parseInt(request.getParameter("nno"));
	
	
	
	if(request.getMethod().equals("GET")){
		response.sendRedirect("view.jsp?nno="+nno);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	
	try{
		conn =	DBConn.conn();
		
		String sql = " UPDATE comment_q"
				   + " SET state= 'D'"
				   + "  WHERE qno = ?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,qno);
		
		psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
	
	}finally{
		DBConn.close( psmt, conn);
	}

	response.sendRedirect("view.jsp?nno="+nno);

%>