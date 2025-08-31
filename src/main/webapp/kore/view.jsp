<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>
<%@ page import="java.util.*" %>
<%
	int kno = Integer.parseInt(request.getParameter("kno"));
 	
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
 
 	
 	List<CommentK> commentList = new ArrayList<CommentK>();
 	
 	try{
 		conn = DBConn.conn();
 		
 		String sqlHit = " UPDATE koreantraditiondessert_board"
					   + " SET hit = hit+1"
					   + " WHERE kno =?";
 		
 		psmtHit = conn.prepareStatement(sqlHit);
 		psmtHit.setInt(1,kno);
 		psmtHit.executeUpdate();
 
 	    String sql = " SELECT kno"
	 			   + " ,title"
	 			   + " ,content"
	 			   + " ,k.uno"
	 			   + " ,k.state"
	 			   + " ,top_yn"
	 			   + " ,date_format(k.rdate, '%Y-%m-%d') as rdate"
	 			   + " ,id"
	 			   + " ,hit"
	 			   + " ,filename"
				   + " ,newFileName"
	 			   + " FROM koreantraditiondessert_board k"
	 			   + " INNER JOIN user u"
	 			   + " ON k.uno = u.uno"
	 			   + " WHERE kno = ?";
 	
 		
	 	psmt = conn.prepareStatement(sql);
		psmt.setInt(1,kno);
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
		
		String sqlComment = " select k.*,u.id"
						  + " from comment_k k"
						  + " inner join user u"
						  + " on k.uno = u.uno"
						  + " where tno = ?"
					      + "   and k.state = 'E'"			  
						  + " ORDER BY k.rdate desc";
		
		psmtComment = conn.prepareStatement(sqlComment);
		psmtComment.setInt(1,kno);
		rsComment = psmtComment.executeQuery();
		
		while(rsComment.next()){
			CommentK commentK = new CommentK(
					
					rsComment.getInt("tno"),
					rsComment.getInt("kno"),
					rsComment.getInt("uno"),
					rsComment.getString("content"),
					rsComment.getString("rdate"),
					rsComment.getString("state"),
					rsComment.getString("id"));
			
			commentList.add(commentK);
			
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
                <h2>koreantraditiondessert</h2>
                <div class="btn1">                        
                    <button type="button"  onclick="location.href='list.jsp'" class="btn">글목록</button>
                    
					<button type="button" onclick="location.href='register.jsp'" class="btn">글쓰기</button> 
					  <%
					if(session.getAttribute("uno")!=null && session.getAttribute("uno").equals(uno)){%>
                    <button onclick="location.href='modify.jsp?kno=<%=kno%>'" class="btn">글수정</button>
                    <button onclick="document.deleteForm.submit();" class="btn">글삭제</button>
                    <form name="deleteForm" action="deleteOk.jsp" method="post">
	        	     <input type="hidden" name="kno" value="<%=kno%>">
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
	                            <input type="hidden" name="kno" value="<%=kno%>">
								<input type="hidden" name="tno">
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
							  	
							  
							  function updateFn(title,tno){
									submitType = "update";
									document.commentForm.content.value = title;
									document.commentForm.tno.value = tno;
								}
							  
							 
						</script>
                            
                            <table>
							<%
							for( CommentK comment : commentList ){
								
							%>
								<tr>
									<td><%=comment.getId() %></td>
									<td><%=comment.getContent()%></td>
									<td><%=comment.getRdate() %></td>
									<td>
									<%=comment.getTno()%>
										<%
										if(session.getAttribute("uno")!= null 
											&&
											session.getAttribute("uno").equals(comment.getUno())){
										%>
										<button onclick="updateFn('<%=comment.getContent()%>',<%=comment.getTno()%>)">수정</button>
										<button onclick="deleteFn('<%=comment.getTno()%>')">삭제</button>
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
							function deleteFn(Tno){
									
									document.commentDeleteForm.Tno.value = Tno;
									
									document.commentDeleteForm.submit();
								}
							
							</script>
							
							<form name="commentDeleteForm" 
								  action="commentDeleteFormOk.jsp" 
								  method="post">
								<input type="hidden" name="tno" >	
								<input type="hidden" name="kno" value="<%=kno%>">	  
							</form>
								
                        </div>
                   </div>
                </div>
            </article>   
      </section>
<%@ include file="./include/footer.jsp" %>
