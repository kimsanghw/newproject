<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
      <section>
        <form action="loginOk.jsp" method="post"  >
          <table>
             <tr>
                <tr>
                 <td>
                   <h2>login</h2>
                 </td>
                </tr>
                <tr>
                 <td>
                      아이디<br>
                      <input type="text" name="id" >
                     
                 </td>
                </tr>
                <tr>
                 <td>
                      비밀번호<br>
                      <input type="password" name="pw">
                      
                 </td>
                </tr>
                <tr>
                 <td>
                     <input type="submit" value="로그인" class="btn" >
                 </td>
                </tr>
                <tr>
                 <td>계정이 없으신가요? 
                     <a href="join.jsp">회원가입</a>
                 </td>
                </tr>
          </table>
       </form>
      </section>
<%@ include file="./include/footer.jsp" %>