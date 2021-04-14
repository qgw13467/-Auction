<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>soft2020AUCTION</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}

		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		
		String bid1=request.getParameter("rp");
		int bid=Integer.parseInt(bid1);
		BbsDAO bbsDAO = new BbsDAO();
		Bbs bbs=bbsDAO.getBbs(bbsID);
		int result=-1;
		if(bid>bbs.getFirstPrice()){
			result=bbsDAO.op3_1(bbsID,bid,userID);
			
		}else if(bid>bbs.getSecondPrice()){
			
			result=bbsDAO.op3_2(bbsID,bid);
		}
		if(bid<bbs.getRp()){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('더 높은 가격을 입찰하세요.')");
			script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입찰에 실패했습니다..')");
			script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
			script.println("</script>");
		} 
		
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입찰하였습니다')");
			script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
			script.println("</script>");
		}
	%>
</body>
</html>