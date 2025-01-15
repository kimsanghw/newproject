<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>


<%
String methodType = request.getMethod(); 
if(methodType.equals("GET")){
%>
	<script>
		alert("잘못된 접근입니다");
		location.href= "login.jsp";
	</script>
<%	
} else{

		String id = request.getParameter("id");
		String password = request.getParameter("pw");
		String name = request.getParameter("name");

	    Connection conn =null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    
	    
	    try{
	    	
	    	conn = DBConn.conn();
	    	
	    	String sql = " SELECT *"
	    				+ " FROM user"
	    				+ " WHERE id = ?"
	    			    + " AND password = ?";
	    			    
	    	
	    	
	    	psmt = conn.prepareStatement(sql);
	    	psmt.setString(1,id);
	    	psmt.setString(2,password);
	    	
	    	
	    	rs = psmt.executeQuery();
	    	
	    	if(rs.next()){
	    		
	    		name = rs.getString("name");
	    		int uno = rs.getInt("uno");
	    		String authorization = rs.getString("authorization");
	    		
	    		
	    		session.setAttribute("name",name); 
	    		session.setAttribute("uno",uno);
	    		session.setAttribute("authorization",authorization);
	    		
	    		
	    		%>
	    		<%@ include file="./include/header.jsp" %>
	    		<section style="width: 200px; margin:80px 750px;">
			        <table style="opacity: 1;">
			            <tr>
			                <td>
			                    로그인이 완료되었습니다.<br><br><br>
			                    처음 화면으로 돌아가시겠습니까?<br><br>
			                    <button type="button" onclick="location.href='../home.jsp'" class="btn">처음으로</button>
			                </td>
			            </tr>
			        </table>
			      </section>
	    		 <%@ include file="./include/footer.jsp" %>
<%
	    	}else{
	    		%>
	    		<script>
	    			alert("로그인에 실패했습니다");
	    			location.href="login.jsp";
	    		</script>
	    		<%
	    	}
	    } catch(Exception e){
	    	e.printStackTrace();
	    	%>
    		<script>
    			alert("로그인에 실패했습니다");
    			location.href="login.jsp";
    		</script>
    		<%
	    }finally{
	    	DBConn.close(rs, psmt, conn);
	    }

}
%>

			

