<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">

<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
<title>soft2020AUCTION</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">soft2020AUCTION 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">중고거래</a></li>
			</ul>

			<%
				if (userID == null) {
			%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>

			<%
				} else {
			%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
				}
			%>
		</div>
	</nav>

	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">판매방식</th>
						<th style="background-color: #eeeeee; text-align: center;">가격</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">상태</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);

						BbsDAO da = new BbsDAO();
						String daytemp = da.getDate();
						String d = daytemp.substring(14, 16);
						int today = Integer.parseInt(daytemp.substring(14, 16));
						//int today=Integer.parseInt(daytemp.substring(8,10));	//분단위 제출시 일단위로 변경할것 8~10

						for (int i = 0; i < list.size(); i++) {
							String op = "";
							if (list.get(i).getBbsOption() == 1) {
								op = "일반판매";
							} else if (list.get(i).getBbsOption() == 2) {
								op = "공개 최고가";
							} else if (list.get(i).getBbsOption() == 3) {
								op = "봉인 차고가";
							}

							if (list.get(i).getBbsAvailable() == 1&&list.get(i).getBbsOption() != 1) {

								int day = Integer.parseInt(list.get(i).getBbsDate().substring(14, 16));
								//int day = Integer.parseInt(list.get(i).getBbsDate().substring(8, 10));	
								int check = today - day;

								
								if (check * check > 2) { //종료시간
									da.checkdate2(list.get(i).getBbsID());
								}
								if (check * check > 2 && list.get(i).getBuyuserID().equals("admin")) {
									da.checkdate(list.get(i).getBbsID());
								}
								

							}
					%>
					<tr>

						<td style="text-align: center;"><%=list.get(i).getBbsID()%></td>
						<td style="text-align: center;"><a
							href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"> <%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td style="text-align: center;"><a
							href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=op%></a></td>
						<td style="text-align: center;"><a
							href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getRp()%>원</a></td>
						<td style="text-align: center;"><%=list.get(i).getUserID()%></td>
						<td style="text-align: center;"><%=list.get(i).getBbsDate().substring(0, 11)
				/*+ list.get(i).getBbsDate().substring(11, 13) + " 시 " + list.get(i).getBbsDate().substring(14, 16) +" 분" */%></td>

						<%
							String state = "";
								if (list.get(i).getBbsAvailable() == 1) {
									state = "판매중";
						%>
						<td style="text-align: center; color: blue"><%=state%></td>
						<%
							} else if (list.get(i).getBbsAvailable() == 2) {
									state = "판매완료";
						%>
						<td style="text-align: center; color: red"><%=state%></td>
						<%
							} else if (list.get(i).getBbsAvailable() == 3) {
									state = "판매종료";
						%>
						<td style="text-align: center; color: red"><%=state%></td>
						<%
							}
						%>



					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
			<%
				if (pageNumber != 1) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
			%>
			
			
			<% 
				if (bbsDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
	<script src="js/bootstrap.js"></script>
</body>
</html>