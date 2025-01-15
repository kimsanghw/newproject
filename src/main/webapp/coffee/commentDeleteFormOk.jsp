<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>

<%
	int cno = Integer.parseInt(request.getParameter("cno"));
	int fno = Integer.parseInt(request.getParameter("fno"));
	
	
	
	if(request.getMethod().equals("GET")){
		response.sendRedirect("view.jsp?fno="+fno);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	
	try{
		conn =	DBConn.conn();
		
		String sql = " UPDATE comment_c"
				   + " SET state= 'D'"
				   + "  WHERE cno = ?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,cno);
		
		psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBConn.close( psmt, conn);
	}

	response.sendRedirect("view.jsp?fno="+fno);

%>