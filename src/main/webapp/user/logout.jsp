<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	//세션 초기화
	session.invalidate();
//	response.sendRedirect(request.getContextPath()+"home.jsp");//메인페이지로이동
	response.sendRedirect(request.getContextPath());//메인페이지로이동
%>