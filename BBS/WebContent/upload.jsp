<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import ="com.oreilly.servlet.MultipartRequest"%>
<%@page import ="java.io.File"%>
<%@ page import="file.FileDAO" %>
<%@ page import="bbs.BbsDAO" %>

<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>soft2020AUCTION</title>
</head>
<body> 
	<%
		String userID = null;
		if(session.getAttribute("userID") != null)
		{
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}	
		else
		{
			
			try{
				
				BbsDAO bbsDAO = new BbsDAO();
				String directory=application.getRealPath("/images/");
				int ind=bbsDAO.getNext();
				
				int maxSize=1024*1024*100;
				String encoding ="UTF-8";
				
				
				MultipartRequest multipartRequest=new MultipartRequest(request,directory,maxSize,encoding, 
						new DefaultFileRenamePolicy());
				
				String fileName=null;
				fileName= multipartRequest.getOriginalFileName("file");
				String fileRealName=multipartRequest.getFilesystemName("file");
				
				FileDAO file=new FileDAO();
				file.upload(ind,fileName,fileRealName);
				//ind+" "+fileRealName+" "+fileName
					
				
				
				
			}
			catch(Exception  e){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('파일 업로드 실패')");
				script.println("</script>"); 
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
				e.printStackTrace();
			}
			
			
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'write2.jsp'");
			script.println("</script>");
				
		}
	%>
</body>
</html>