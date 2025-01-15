<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jspStudy.*"%>

<%

	int dno = Integer.parseInt(request.getParameter("dno"));


	if(request.getMethod().equals("GET")){
		%>
		<script>
		alert("잘못된 접근입니다.")
		location.href='view.jsp?dno=<%=dno%>';
		</script>
		<%
	}else{

		Connection conn =null;
		PreparedStatement psmt = null;
		
		try{
			
			conn = DBConn.conn();
			
			
			String sql = " UPDATE dessert_board"
					   + "    SET state = 'D'"
					   + "  WHERE dno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,dno);
			
			int result = psmt.executeUpdate();
			
			if(result>0){
				//삭제 성공
				%>
				<script>
					alert("삭제되었습니다.");
					location.href="list.jsp";
				</script>
				<%
			}
			
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBConn.close(psmt, conn);
		}
	
	}

%>
<script>
	alert("삭제에 실패했습니다.");
	location.href="view.jsp?dno=<%=dno%>";
</script>
