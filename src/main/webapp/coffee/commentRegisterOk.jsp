<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	int fno = Integer.parseInt(request.getParameter("fno"));

	if(request.getMethod().equals("GET")){
		%>
		<script>
			alert("잘못된 접근입니다");
			location.href="view.jsp?fno=<%=fno%>";
		</script>
		
	<%}else {
		
		String content = request.getParameter("content");
		int uno = (Integer)session.getAttribute("uno");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		
		try{
			conn =	DBConn.conn();
			
			String sql = " INSERT INTO comment_c( "
					   + "         uno"
					   + "        ,fno"
					   + "        ,content"
					   + " ) VALUES("
					   + "         ?"
					   + "        ,?"
					   + "        ,?"
					   + " )";	
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,uno);
			psmt.setInt(2,fno);
			psmt.setString(3,content);
			
			int result = psmt.executeUpdate();
			
			
			
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			DBConn.close( psmt, conn);
			
		}
		
		response.sendRedirect("view.jsp?fno="+fno);
	}




%>