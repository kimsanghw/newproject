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
	if(method.equals("GET") ){
		%>
			<script>
				alert("잘못된 접근입니다.");
				location.href="../home.jsp";
			
			</script>
		
		
		
		<%
	}else{
		int uno = (Integer)session.getAttribute("uno");
		
		request.setCharacterEncoding("UTF-8");
		int size = 10*1024*1024;
		String uploadPath = request.getServletContext().getRealPath("/upload");
		System.out.println("서버의 업로드 폴더 경로 : " + uploadPath);
		//String uploadPath = "C:\\workspace\\newproject\\src\\main\\webapp\\upload";
		MultipartRequest multi = null;
		multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String topYn = multi.getParameter("topYn"); 
		String filename = multi.getParameter("filename");
		String newFileNane = multi.getParameter("newFileNane");
		int fno = Integer.parseInt(multi.getParameter("fno"));
		
		Enumeration<?> files= multi.getFileNames();
		String phyName = "";
		String logiName = "";
		
		
		if( files != null ){
			
			String fileId = (String) files.nextElement();
			filename = multi.getOriginalFileName(fileId);
			System.out.println("파일의 원래 이름 : " + filename);
			filename = (String)multi.getFilesystemName("attach");
			filename = (String)multi.getFilesystemName(fileId);
			System.out.println("파일이 저장된 이름 : " + filename);
			
			
			
			
			if( filename != null ){
				
				String fileExtension = "";
				int dotIdx = 0;
				dotIdx = filename.lastIndexOf(".");
				if( dotIdx > 0 ){
					fileExtension = filename.substring(dotIdx).toLowerCase();
					System.out.println("첨부파일의 확장자 : " + fileExtension);
				}
				
				
				newFileNane = UUID.randomUUID().toString();
				String orgName = uploadPath + "\\" + filename;
				String newName = uploadPath + "\\" + newFileNane;
				
				File srcFile = new File(orgName);
				File targetFile = new File(newName);
				srcFile.renameTo(targetFile);	
				System.out.println("원본파일명 : " + filename);
				System.out.println("새로운파일명 : " + newFileNane);
				System.out.println("저장경로 : " + uploadPath);
			
			}
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		
		try{
			conn = DBConn.conn();
			
			
			
			String sql = " UPDATE coffee_board "
					   + "    SET title = ? "
					   + " 		 ,top_yn = ? "
					   + "       ,content = ? "
					   + "       ,filename = ? "
					   + "       ,newFileNane = ? "
					   + "  WHERE fno =? ";
			
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,title);
			psmt.setString(2,topYn);
			psmt.setString(3,content);
			psmt.setString(4,filename);
			psmt.setString(5,newFileNane);
			psmt.setInt(6,fno);
			
			int result = psmt.executeUpdate();
			
			
			if(result > 0){ %>
			
			<script>

			alert("수정되었습니다.");
			location.href="view.jsp?fno=<%=fno%>";
				
				
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


alert("수정 실패했습니다.");
location.href="list.jsp";

				
				
</script>
