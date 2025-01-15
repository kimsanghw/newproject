<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	int nno = Integer.parseInt(request.getParameter("nno"));
	int qno = Integer.parseInt(request.getParameter("qno"));
	String content = request.getParameter("content");
	
	
	if(request.getMethod().equals("GET")){
		
		response.sendRedirect("view.jsp?nno="+nno);
		
		
		
		
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn =	DBConn.conn();
		
		String sql = " UPDATE comment_q"
				   + " SET content=?"
				   + " WHERE qno=?";
		
		   
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,content);
		psmt.setInt(2,qno);
		
		
		psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close( psmt, conn);
	}

	response.sendRedirect("view.jsp?nno="+nno);
	



%>