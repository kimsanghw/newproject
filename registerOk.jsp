<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="jspStudy.*" %>



<%	//method get이면 다른 페이지로 튕겨내기
	String method = request.getMethod();
	if(method.equals("GET") || session.getAttribute("uno") == null){
		%>
			<script>
				alert("잘못된 접근입니다.");
				location.href="register.jsp";
			
			</script>
		
		
		
		<%
	}else{
		int uno = (Integer)session.getAttribute("uno");
		
		String topYn = "";
		int size = 10*1024*1024;
		//String uploadPath = "C:\\workspace\\newproject\\src\\main\\webapp\\upload";
		//실제 실행되고 있는 웹서버에서 폴더의 '실제 경로'
		String uploadPath = request.getServletContext().getRealPath("/upload");
		System.out.println("서버의 업로드 폴더 경로 : " + uploadPath);
		
		MultipartRequest multi = null;
		
		try{
			multi = new MultipartRequest( request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy() );
		}catch( Exception e){
			System.out.println(e);
			response.sendRedirect(request.getContextPath()+"/../home.jsp"); return;
		}
		// ※※※※※ request가 아니라 multi에게 요청해야 합니다 ※※※※※
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		
		// 파일 이름의 목록을 받아옵니다
		Enumeration<?> files= multi.getFileNames();

		// DB의 게시글 테이블에 논리파일명, 물리파일명 컬럼이 둘다 있을 경우 
		String phyName = "";
		String logiName = "";
		
		// 파일 이름의 목록이 있으면
		if( files != null ){
			// 파일 이름과 객체를 가져옴
			String fileId = (String) files.nextElement();
			String filename = multi.getOriginalFileName(fileId);
			System.out.println("파일의 원래 이름 : " + filename);
			// 물리 저장소에 저장된 실제 파일 이름을 가져옴
			filename = (String)multi.getFilesystemName("attach");
			filename = (String)multi.getFilesystemName(fileId);
			System.out.println("파일이 저장된 이름 : " + filename);
			// 파일 이름이 있으면
			if( filename != null ){
				//String etc[] = filename.split("\\.");
				//String newFileName = UUID.randomUUID().toString()+"."+etc[etc.length-1];
				// 원본 파일명과, 새로운 파일명을 확인
				String fileExtension = "";
				int dotIdx = 0;
				dotIdx = filename.lastIndexOf(".");
				if( dotIdx > 0 ){
					fileExtension = filename.substring(dotIdx).toLowerCase();
					System.out.println("첨부파일의 확장자 : " + fileExtension);
				}
				String newFileNane = UUID.randomUUID().toString();
				String orgName = uploadPath + "\\" + filename;
				String newName = uploadPath + "\\" + newFileNane;
				// File객체를 이용하여, 저장된 파일의 이름을 변경
				File srcFile = new File(orgName);
				File targetFile = new File(newName);
				srcFile.renameTo(targetFile);	// 실제로 파일명이 변경
				System.out.println("원본파일명 : " + filename);
				System.out.println("새로운파일명 : " + newFileNane);
				System.out.println("저장경로 : " + uploadPath);
				phyName = newFileNane;
				logiName = filename;
				
			}
		}
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		
		try{
			conn = DBConn.conn();
			
			
			
			String sql = " INSERT INTO coffee_board( "
					   + "                    uno"
					   + "                   ,title"
					   + "                   ,content "
					   + "                   ,filename"
					   + "                   ,newFileNane"
					   + "                  )VALUES("
					   + "                         ?"
					   + "                       ,?" 	
					   + "                       ,?"
					   + "                       ,?"
					   + "                       ,?"
					   + "                        )";
			
			
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,uno);
			psmt.setString(2,title);
			psmt.setString(3,content);
			psmt.setString(4,phyName);
			psmt.setString(5,logiName);
					
			int result = psmt.executeUpdate();
			
			
			if(result > 0){ %>
			
			<script>

				alert("등록이 완료되었습니다");
				location.href="list.jsp";
				
				
			</script>
				
			<%}
			
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			
			DBConn.close(psmt, conn);
		}
		
		
	}
	


%>


<script>

	alert("등록이 실패하었습니다");
	location.href="register.jsp";
				
				
</script>