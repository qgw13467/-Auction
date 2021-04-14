<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
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
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">soft2020AUCTION 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a>메인</a></li>
				<li class="active"><a href="bbs.jsp">중고거래</a></li>
			</ul>
			
			<%
				if(userID == null){

			%>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>	
				</li>
			</ul>
			
			<%
			}
			else
			{
				
			%>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>	
				</li>
			</ul>
			
			<%
			}
			%>
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
			
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped" style="text-align:enter; border : 1px solid #dddddd;">
					
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글쓰기 양식</th>
						</tr>
					
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="3000" style="height:350px;"></textarea></td>	
						</tr>
						
						
						<tr>
							<td>
								<div class="form-group" style="text-align:center">
									<div class="btn-group" data-toggle="buttons">
										<label class="btn btn-primary active">
											<input type="radio" name="bbsOption" autocomplete="off" value=1 checked>일반
										</label>
										<label class="btn btn-primary">
											<input type="radio" name="bbsOption" autocomplete="off" value=2 >공개 최고가
										</label>
										<label class="btn btn-primary">
											<input type="radio" name="bbsOption" autocomplete="off" value=3 >봉인 차고가
										</label>
									</div>
								</div>
							</td>
						</tr>
						
						
						
						
						<tr>
							<td><input type="text" class="form-control" placeholder="가격" name="rp" value="0" maxlength="1000"></td>
						</tr>
						
					
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			
			</form>
			
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
	</script>
	<script src="js/bootstrap.js"></script>
</body>
</html>





						
						
					






