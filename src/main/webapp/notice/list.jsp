<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	PreparedStatement psmtTotal = null;
	ResultSet rsTotal = null;
	
	int nowPage = 1;
	
	if(request.getParameter("nowPage") != null){
		
		nowPage 
		= Integer.parseInt(request.getParameter("nowPage"));
	}
	
	try{
		conn = DBConn.conn();
		
		String sqlTotal = "SELECT COUNT(*) AS total "
						+ "  FROM notice_board n"
						+ " INNER JOIN user u"
						+ "  ON n.uno = u.uno"
				        + " WHERE n.state = 'E'"; 	
		
				if(searchType != null && !searchType.equals("")){
					if(searchType.equals("title")){
						sqlTotal += " AND title like CONCAT('%',?,'%')";
					}else if(searchType.equals("id")){
						sqlTotal += "  AND id like CONCAT('%',?,'%')";
					}
				}
				
				psmtTotal = conn.prepareStatement(sqlTotal);
				if(searchType != null && !searchType.equals("null")){
					psmtTotal.setString(1,searchValue);
				}
				rsTotal = psmtTotal.executeQuery();
						
				int total = 0;
						
				if(rsTotal.next()){
					total = rsTotal.getInt("total");
				}
				
				PagingUtil paging = new PagingUtil(nowPage,total,3);
				
		        String sql = " SELECT nno"
						   + "       ,title"
						   + "       ,id"
						   + "       ,date_format(n.rdate, '%Y-%m-%d') as rdate"
						   + "       ,hit"
						   + "   FROM notice_board n"
						   + " INNER JOIN user u"
				           + "     ON n.uno = u.uno"
				           + " WHERE n.state = 'E'";     
				
				if(searchType != null && !searchType.equals("")){ 
					if(searchType.equals("title")){
						sql += " AND title like CONCAT('%',?,'%')";
					}else if(searchType.equals("id")){
						sql += "  AND id like CONCAT('%',?,'%')";
					}
				}
				
					sql += " ORDER BY n.rdate desc";
				    sql += " limit ?, ?";		
						
				psmt = conn.prepareStatement(sql);
				if(searchType != null && !searchType.equals("null")){
					psmt.setString(1,searchValue);
					psmt.setInt(2,paging.getStart());
					psmt.setInt(3,paging.getPerPage());
				}else{
					psmt.setInt(1,paging.getStart());
					psmt.setInt(2,paging.getPerPage());
				}
						
				rs = psmt.executeQuery();
		
		
%>
<%@ include file="./include/header.jsp" %>
	      <section>
	        <article>
	          <div class="article_inner" >
	            <h2>noticeboard</h2>
	            <div class="content_inner" >	            	
	              <form action="list.jsp" method="get">
	                <select  name="searchType">
	                  <option value="title" <%=searchType!=null&&searchType.equals("title")?"selected":"" %>>제목</option>
	                  <option value="id" <%=searchType!=null&&searchType.equals("id")?"selected":"" %>>작성자</option>
	                </select>
	                <input type="text" name="searchValue" value="<%=searchValue!=null?searchValue:""%>">
	                <button>검색</button>	                
	              </form>
					<div style="margin 5px; padding-left: 20px; ">
					 <% if(session.getAttribute("authorization")!=null &&session.getAttribute("authorization").equals("A")){%>
						<button class="btn1" onclick="location.href='register.jsp'">공지사항등록</button>
					 <% } %>
					</div> 
	              <table class="boardtable">
	                <thead>
	                  <tr>
	                    <th>번호</th>
	                    <th>제목</th>
	                    <th>작성자</th>
	                    <th>등록일</th>
	                    <th>조회수</th>
	                  </tr>
	                </thead>
	                	
	                <tbody>
	                <%
						while(rs.next()){ 
						int nno = rs.getInt("nno");
						String title = rs.getString("title");
						String id = rs.getString("id");
						String rdate = rs.getString("rdate");
						int hit = rs.getInt("hit");
				    %>
	                  <tr>
	                    <td><%=nno %></td>
	                    <td><a href="view.jsp?nno=<%=nno %>"><%=title %></a></td>
	                    <td><%= id %></td>
	                    <td><%= rdate %></td>
	                    <td><%= hit %></td>
	                  </tr>
	                <%	
		            }
	                %>
	                </tbody>
	              </table>
	            </div>
	            
	            <div class="paging_inner">
	             <%
					if(paging.getStartPage() > 1){
						
				%>
					
					<a href="list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"> &lt; </a>
				<%
					}
				
					for(int i= paging.getStartPage();
							i<=paging.getEndPage(); i++){
						if(i == nowPage){
						%>
						<strong><%= i %></strong>
						<%
						}else{
						%>
						<a href="list.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>
						<%	
						}
					}
					
					if(paging.getLastPage()>paging.getEndPage()){
						
						%>
						<a href="list.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>
						<%
					}
					
				%>
	            </div>
	          </div>
	          
	        </article>
	      </section>
<%@ include file="./include/footer.jsp" %>
<%				
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBConn.close(rs,psmt,conn);
	}
	
%>

