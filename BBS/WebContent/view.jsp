<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="file.FileDAO"%>
<%@ page import="file.FileImage"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>soft2020AUCTION</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
		Bbs bbs = new BbsDAO().getBbs(bbsID);
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
				<li><a>메인</a></li>
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
				style="text-align: enter; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글
							보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%">글제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID()%></td>
					</tr>
					<tr>
						<td>상태</td>

						<%
							String state = "";
							if (bbs.getBbsAvailable() == 1) {
								state = "판매중";
						%>
						<td style="color: blue"><%=state%></td>
						<%
							} else if (bbs.getBbsAvailable() == 2) {
								state = "판매완료";
						%>
						<td style="color: red"><%=state%></td>
						<%
							} else if ( bbs.getBbsAvailable() == 3) {
								state = "판매종료";
						%>
						<td style="color: red"><%=state%></td>
						<%
							}
						%>
					</tr>

					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + " 시 "
					+ bbs.getBbsDate().substring(14, 16) + " 분"%></td>
					</tr>
					<tr>
						<td>이미지</td>
						<td>
							<%
								FileImage imagefile = new FileDAO().getImagename(bbs.getBbsID());
								String name = imagefile.getFileRealName();
								if (name == null) {

									out.write("<img src=images/noimage.jpg border=" + 0 + " width=" + 640 +">");
								} else {
									String directory = application.getRealPath("/upload/") + name + "/";
									out.write("<img src=images/" + name + " border=" + 0 + " width=" + 640 + " >");
								}
							%>



						</td>

					</tr>

					<tr>
						<td>내용</td>

						<td colspan="2" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>


					</tr>




					<%
						if (userID != null && !userID.equals(bbs.getUserID()) && bbs.getBbsAvailable() == 1) {
					%>
					<tr>
						<td style="width: 20%">입찰</td>

						<%
							if (bbs.getBbsOption() == 1 && bbs.getBbsAvailable() == 1) {
						%>

						<td>판매가격 : <%=bbs.getRp()%>원
						</td>
						<td style="text-align: center;"><a
							onclick="return confirm('구매하시겠습니까?');"
							href="op1bidding.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">구매</a>
						</td>

						<%
							}
						%>



						<%
							if (bbs.getBbsOption() == 2 && bbs.getBbsAvailable() == 1) {
						%>

						<td style="text-align: center;">현재 최고가 : <%=bbs.getFirstPrice()%>원
						</td>
						<td style="text-align: center;">
							<form method="post" action="op2bidding.jsp?bbsID=<%=bbsID%>">

								<div class="form-group">
									<input type="text" class="form-control" placeholder="압찰가격"
										name="rp" maxlength="20">
								</div>
								<input type="submit" class="btn btn-primary form-control"
									value="입찰">

							</form>

						</td>

						<%
							}
						%>


						
						
						<%
							if (bbs.getBbsOption() == 3 && bbs.getBbsAvailable() == 1) {
						%>

						<td >입찰 시작가 : <%=bbs.getRp()%>원
						</td>
						<td style="text-align: center;">
							<form method="post" action="op3bidding.jsp?bbsID=<%=bbsID%>">

								<div class="form-group">
									<input type="text" class="form-control" placeholder="압찰가격"
										name="rp" maxlength="20">
								</div>
								<input type="submit" class="btn btn-primary form-control"
									value="입찰">

							</form>

						</td>

						<%
							}
						%>

					</tr>
					<%
						}
					%>




					<%
						if (bbs.getBuyuserID().equals(userID) && bbs.getBbsAvailable() == 2) {
					%>

					<tr>

						<td>판매자</td>
						<%
							UserDAO temp = new UserDAO();
								String email2 = temp.getEmail(bbs.getUserID());
						%>
						<td style="text-align: center;">입찰 금액: <%=bbs.getSecondPrice()%>
							이메일: <%=email2%></td>

					</tr>
					<%
						}
					%>




					<%
						if (bbs.getUserID().equals(userID) && bbs.getBbsAvailable() == 2) {
					%>
					<tr>
						<td>구매자</td>
						<%
							UserDAO temp = new UserDAO();
								String email = temp.getEmail(bbs.getBuyuserID());
						%>
						<td style="text-align: center;">입찰 금액: <%=bbs.getSecondPrice()%>
							이메일: <%=email%></td>

					</tr>
					<%
						}
					%>


					<%
						if (bbs.getUserID().equals(userID) && bbs.getBbsAvailable() == 3) {
					%>
					<tr>
						<td>구매자</td>
						<%
							UserDAO temp = new UserDAO();
								String email = temp.getEmail(bbs.getBuyuserID());
						%>
						<td style="text-align: center;">없음</td>

					</tr>
					<%
						}
					%>






				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if (userID != null && userID.equals(bbs.getUserID())) {
			%>
			<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?');"
				href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			
			<%
				if (userID.equals("admin")) {
			%>
			<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?');"
				href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>

		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
	<script src="js/bootstrap.js"></script>
</body>
</html>