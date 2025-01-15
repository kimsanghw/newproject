<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jspStudy.*"%>

<%

	int kno = Integer.parseInt(request.getParameter("kno"));


	if(request.getMethod().equals("GET")){
		%>
		<script>
		alert("잘못된 접근입니다.")
		location.href='view.jsp?kno=<%=kno%>';
		</script>
		<%
	}else{

		Connection conn =null;
		PreparedStatement psmt = null;
		
		try{
			
			conn = DBConn.conn();
			
			
			String sql = " UPDATE koreantraditiondessert_board"
					   + "    SET state = 'D'"
					   + "  WHERE kno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,kno);
			
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
	alert("삭제 실패했습니다.");
	location.href="view.jsp?kno=<%=kno%>";
</script>
