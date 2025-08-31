<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>
<%@ page import="java.util.*" %>
<%
	int dno = Integer.parseInt(request.getParameter("dno"));
 	
 	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	PreparedStatement psmtHit = null;	
	PreparedStatement psmtComment = null;
	ResultSet rsComment = null;
	
	
	
	String filename = "";
	String newFileName = "";
	String title = "";
	String content = "";
	String state = "";
	String topYn = "";
	String rdate = "";
	String id = "";
	int hit = 0;
 	int uno = 0;
 
 	
 	List<CommentD> commentList = new ArrayList<CommentD>();
 	
 	try{
 		conn = DBConn.conn();
 		
 		String sqlHit = " UPDATE dessert_board"
					   + " SET hit = hit+1"
					   + " WHERE dno =?";
 		
 		psmtHit = conn.prepareStatement(sqlHit);
 		psmtHit.setInt(1,dno);
 		psmtHit.executeUpdate();
 
 	    String sql = " SELECT dno"
	 			   + " ,title"
	 			   + " ,content"
	 			   + " ,d.uno"
	 			   + " ,d.state"
	 			   + " ,top_yn"
	 			   + " ,date_format(d.rdate, '%Y-%m-%d') as rdate"
	 			   + " ,id"
	 			   + " ,hit"
	 			   + " ,filename"
				   + " ,newFileName"
	 			   + " FROM dessert_board d"
	 			   + " INNER JOIN user u"
	 			   + " ON d.uno = u.uno"
	 			   + " WHERE dno = ?";
 	
 		
	 	psmt = conn.prepareStatement(sql);
		psmt.setInt(1,dno);
		rs = psmt.executeQuery();
	
		if(rs.next()){
			title = rs.getString("title");
			content = rs.getString("content");
			state = rs.getString("state");
			topYn = rs.getString("top_yn");
			rdate = rs.getString("rdate");
			id = rs.getString("id");
			hit = rs.getInt("hit");
			filename = rs.getString("filename");
			newFileName = rs.getString("newFileName");
			uno = rs.getInt("uno");
		
		String sqlComment = " select d.*,u.id"
						  + " from comment_d d"
						  + " inner join user u"
						  + " on d.uno = u.uno"
						  + " where sno = ?"
					      + "   and d.state = 'E'"			  
						  + " ORDER BY d.rdate desc";
		
		psmtComment = conn.prepareStatement(sqlComment);
		psmtComment.setInt(1,dno);
		rsComment = psmtComment.executeQuery();
		
		while(rsComment.next()){
			CommentD commentD = new CommentD(
					
					rsComment.getInt("sno"),
					rsComment.getInt("dno"),
					rsComment.getInt("uno"),
					rsComment.getString("content"),
					rsComment.getString("rdate"),
					rsComment.getString("state"),
					rsComment.getString("id"));
			
			commentList.add(commentD);
			
		}
		
	}
		
		
 	
 	
 	}catch(Exception e){
 		e.printStackTrace();
		
 	}finally{
 		DBConn.close(psmtHit,null);
		DBConn.close(rsComment,psmtComment,null);
 		DBConn.close(rs,psmt,conn);
 		
 	}
 %> 
<%@ include file="./include/header.jsp" %>
 
<section>
        <article>
            <div class="article_inner">
                <h2>dessert</h2>
                <div class="btn1">                        
                    <button type="button"  onclick="location.href='list.jsp'" class="btn">글목록</button>
                    
					<button type="button" onclick="location.href='register.jsp'" class="btn">글쓰기</button> 
					  <%
					if(session.getAttribute("uno")!=null && session.getAttribute("uno").equals(uno)){%>
                    <button onclick="location.href='modify.jsp?dno=<%=dno%>'" class="btn">글수정</button>
                    <button onclick="document.deleteForm.submit();" class="btn">글삭제</button>
                    <form name="deleteForm" action="deleteOk.jsp" method="post">
	        	     <input type="hidden" name="dno" value="<%=dno%>">
	                </form>
	                <%
		            }
	                %>
                   
                </div>
                    <div class="content_">              
                    <table border="1" style="border-top: solid #D8D8D8 ;">
                        <tr>
                            <td style="width: 50px;" >제목</td>
                            <td colspan="5"><%= title %></td>
                        </tr>
                        <tr>
                            <td style="width: 50px;">작성자</td>
                            <td style="width: 100px;"><%=id %></td>
                            <td style="width: 50px;">작성일</td>
                            <td style="width: 50px;"><%= rdate %></td>
                            <td style="width: 50px;">조회수</td>
                            <td style="width: 50px;"><%= hit %></td>
                        </tr>  
                        <tr>
                            <td style="text-align: center;">내용</td>
								<td style="padding: 0.5rem 2rem 0.5rem 1rem;" colspan="5">
									<textarea name="content" style="width: 100%; height: 10rem; outline: none; border: none; background-color: whitesmoke; " ><%=content%></textarea>
								</td>
                        </tr>
                         <tr>
                            <td style="text-align: center;">첨부파일</td>
							<td style="padding: 0.5rem 2rem 0.5rem 1rem;"  colspan="5">
                         <%		if( filename != null && !filename.equals("") )
								{
									
					   %>               
								<img style="width : 100px; height:100px;" src="<%= request.getContextPath() %>/upload/<%= filename %>"><br>
								<a href="<%= request.getContextPath() %>/upload/<%= filename %>"download="<%= newFileName %>"><%= newFileName  %></a>
								<%-- <img style="width : 100px; height:100px;" src="down.jsp?phyName=<%= newFilename %>&logiName=<%= filename %>"><br>
								<a href="down.jsp?phyName=<%= newFilename %>&logiName=<%= filename %>"><%= filename %></a>--%>
							
						<%		}	%>  
							</td>
                        </tr>               
                    </table>
                    
                    

                    
                        <div>
                        	<form method="post" name="commentForm">
	                            <table  style="border-top: solid #D8D8D8 ;">
	                            <tr>
                                    <td>댓글</td>
                               	</tr>
                               	<tr>
	                            <td width="50px"><%= id %></td>
	                            <td>
	                            <input type="hidden" name="dno" value="<%=dno%>">
								<input type="hidden" name="sno">
								<input type="text" name="content" size="80">
								<button type="button" onclick="submitComment()">저장</button>
								</td>
	                            </tr>   
	                            </table>
                            </form>
                            <script>
                    		let submitType = "insert";
							  function submitComment()	{
								  let loginUno = '<%=session.getAttribute("uno")%>';
								  if(loginUno != 'null'){
										if(submitType == 'insert'){
											document.commentForm.action
												= "commentRegisterOk.jsp"
										}else if(submitType == 'update'){
											
											document.commentForm.action
											= "commentModifyOk.jsp"
										}
										
										document.commentForm.submit();
									}else{
										alert("로그인 후 사용할 수 있습니다.");
									}
									
								}
							  	
							  
							  function updateFn(title,sno){
									submitType = "update";
									document.commentForm.content.value = title;
									document.commentForm.sno.value = sno;
								}
							  
							 
						</script>
                            
                            <table>
							<%
							for( CommentD comment : commentList ){
								
							%>
								<tr>
									<td><%=comment.getId() %></td>
									<td><%=comment.getContent()%></td>
									<td><%=comment.getRdate() %></td>
									<td>
									<%=comment.getSno()%>
										<%
										if(session.getAttribute("uno")!= null 
											&&
											session.getAttribute("uno").equals(comment.getUno())){
										%>
										<button onclick="updateFn('<%=comment.getContent()%>',<%=comment.getSno()%>)">수정</button>
										<button onclick="deleteFn('<%=comment.getSno()%>')">삭제</button>
										<%
										}
										%>
										
									</td>
								</tr>
							<%	
							}
							%>
							</table>	
							<script>
							function deleteFn(Sno){
									
									document.commentDeleteForm.Sno.value = sno;
									
									document.commentDeleteForm.submit();
								}
							
							</script>
							
							<form name="commentDeleteForm" 
								  action="commentDeleteFormOk.jsp" 
								  method="post">
								<input type="hidden" name="sno" >	
								<input type="hidden" name="dno" value="<%=dno%>">	  
							</form>
								
                        </div>
                   </div>
                </div>
            </article>   
      </section>
<%@ include file="./include/footer.jsp" %>
