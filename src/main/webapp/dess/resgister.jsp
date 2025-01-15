<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
      <section>
        <article>
            <div class="article_inner">
                <h2>dessert</h2>
                <div class="btn1">                        
                    <button type="button"  onclick="location.href='list.jsp'" class="btn">글목록</button>                   
                                
                </div>
                    <div class="content_1">        
                    <form name="resgister" method="post" enctype="multipart/form-data" action="resgisterOk.jsp" >          
                        <table border="1" >
                            <tr>
								<td  >제목</td>
								<td><input type="text" name="title" style="width: 100%;" ></td>
								
							</tr>
							<tr>
								<td >내용</td>
								<td style="padding: 0.5rem 2rem 0.5rem 1rem;" colspan="4">
									<textarea name="content" style="width: 100%; height: 10rem; outline: none; border: none; background-color: whitesmoke;" ></textarea>
								</td>
							</tr>
							<tr>
								<td >첨부파일</td>
								<td style="padding: 0.5rem 2rem 0.5rem 1rem;" colspan="4"><br>
									<input type="file" name="attach" >
								</td>
							</tr>
							<tr>
								<td  colspan="4" style="text-align:center;">
									<input type="submit" value="작성완료">
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