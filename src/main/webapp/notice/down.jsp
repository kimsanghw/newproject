<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	
	request.setCharacterEncoding("UTF-8");
	String filename = request.getParameter("filename");
	String newFilename = request.getParameter("newFilename");
	if( filename == null || filename.equals("") ||
			newFilename == null || newFilename.equals("") ) {
		response.sendRedirect("home.jsp");
	}
	
	System.out.println("원본 파일명 : " + filename);
	System.out.println("실제 파일명 : " + newFilename);
	
	
	
	String uploadPath = "C:\\workspace\\newproject\\src\\main\\webapp\\upload";
	newFilename = uploadPath + "\\" + newFilename;
	
	response.setContentType("application/octet-stream");
	
	filename = URLEncoder.encode(filename, "UTF-8");
	
	response.setHeader("Content-Disposition", "attachment; filename=" + filename );
	
	System.out.println(newFilename);
	System.out.println(filename);
	
	
	File file = new File(newFilename);
	
	FileInputStream fileIn = new FileInputStream(file);
	
	ServletOutputStream ostream = response.getOutputStream();
	
	byte[] outputByte = new byte[4096];
	
	while(fileIn.read(outputByte, 0, 4096 ) != -1){
		ostream.write(outputByte, 0, 4096);
	}
	fileIn.close();
	
	ostream.flush();
	ostream.close();
%>