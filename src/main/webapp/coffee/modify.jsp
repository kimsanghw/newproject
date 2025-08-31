<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>
    
<%
 	int fno = Integer.parseInt(request.getParameter("fno"));
 	
 	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
 	
	
	//html영역에서 출력할 데이터 담을 변수 선언 영역
	String title = "";
	String content = "";	
	String topYn = "";
	String logiName = "";
	String phyName = "";
	String filename = "";
	String newFileNane = "";
 	
 	
 	
 	try{
 		conn = DBConn.conn();
 
 	String sql = " SELECT fno"
 			   + " ,title"
 			   + " ,content" 			   			   
 			   + " ,top_yn"
 			   + " ,date_format(c.rdate, '%Y-%m-%d') as rdate"
 			   + " ,id"
			   + " ,filename"
			   + " ,newFileNane"
 			   + " FROM coffee_board c"
 			   + " INNER JOIN user u"
 			   + " ON c.uno = u.uno"
 			   + " WHERE fno = ?";
 	
 	psmt = conn.prepareStatement(sql);
	psmt.setInt(1,fno);
	rs = psmt.executeQuery();
	
	if(rs.next()){//nno가 일치하는 한건의 데이터를 찾음
		title = rs.getString("title");
		content = rs.getString("content");		
		topYn = rs.getString("top_yn");
		filename = rs.getString("filename");
		newFileNane = rs.getString("newfileNane");
		
	
		
		
		
		
	}
 	
 	
 	}catch(Exception e){
 		e.printStackTrace();
		
 	}finally{
 		DBConn.close(rs,psmt,conn);
 		
 	}
 %>     
<%@ include file="./include/header.jsp" %>
      <section>
        <article>
            <div class="article_inner">
                <h2>coffee</h2>
                <div class="btn1">                        
                    <button type="button"  onclick="location.href='list.jsp'" class="btn">글목록</button>                   
                                
                </div>
                    <div class="content_1">        
                    <form name="modify" method="post" enctype="multipart/form-data" action="modifyOk.jsp" >          
                        <table border="1" >
                            <tr>
								<td  >제목</td>
								<td>
								<input type="text" name="title" style="width: 100%;"  value="<%= title %>"></td>
							</tr>
							<tr>
								<td >내용</td>
								<td style="padding: 0.5rem 2rem 0.5rem 1rem;" colspan="4">
									<textarea name="content" style="width: 100%; height: 10rem; outline: none; border: none; background-color: whitesmoke;" ><%= content %></textarea>
								</td>
							</tr>
						
	                        <tr>
	                            <td style="text-align: center;">첨부파일</td>
									<td style="padding: 0.5rem 2rem 0.5rem 1rem;"  colspan="5">
							 		<%if( filename != null && !filename.equals("") ){%> 
							 		<img style="width : 100px; height:100px;" src="<%= request.getContextPath() %>/upload/<%= filename %>"><br>
									<a href="<%= request.getContextPath() %>/upload/<%= filename %>"download="<%= newFileNane %>"><%= newFileNane  %></a>
									              
									<input type="file" name="attach" >
									<%}%>  
								</td>
	                        </tr>
					  
							<tr>
								<td  colspan="4" style="text-align:center;">
									<input type="submit" value="글수정하기">
									<input type="reset" value="취소">
								</td>
							</tr>
                        </table>
                        </form>
                        
                   </div>
                </div>
            </article>   
      </section>
<%@ include file="./include/footer.jsp" %>
