<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>
<%
request.setCharacterEncoding("UTF-8");
String methodType = request.getMethod();

if(methodType.equals("GET")){
	%>
	<script>
		alert("잘못된 접근입니다");
		location.href= "login.jsp";
	</script>
<%	
}else {
	//parameter은 String으로만 받을수 있다.
	
	String id = request.getParameter("id");
	String password = request.getParameter("pw");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	int age = Integer.parseInt(request.getParameter("age"));
	String gender = request.getParameter("gender");
	String interest = request.getParameter("interest");
	String rdate = request.getParameter("rdate");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBConn.conn();
		
		String sql = " INSERT INTO user( id"
				   + "                  , password "
				   + "                  , age"
				   + "                  , name "
				   + "                  , email "
				   + "                  , gender"
				   + "                  , interest)values( "
				   + "           ?"
				   + "         , ?"
				   + "         , ?"
				   + "         , ?"
				   + "         , ?"
				   + "         , ?"
				   + "         , ?"
				   + " )";	
				   
				   
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,id);
	    psmt.setString(2,password);
	    psmt.setInt(3,age);
	    psmt.setString(4,name);
	    psmt.setString(5,email);
	    psmt.setString(6,gender);
	    psmt.setString(7,interest);
	    
	    int result = psmt.executeUpdate();
		
	    
	    
	%>

<%@ include file="./include/header.jsp" %>
<section style="width: 200px; margin:80px 750px;">
        <table>
            <tr>
                <td>
                    회원가입이 완료되었습니다.<br><br><br>

                    로그인하시겠습니까?<br><br>
                    <button  type="button" onclick="location.href='login.jsp'" class="btn">로그인</button>
                </td>
            </tr>
        </table>
      </section>

<%@ include file="./include/footer.jsp" %>
<% }catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBConn.close( psmt, conn);
		
	}
	
}
%>