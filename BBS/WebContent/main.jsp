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
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">중고거래</a></li>
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
		<% 
			if(userID != null){
				%>
				<p>로그인 계정: <%=userID %></p>
				<% 
			}
		%>
		
		
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>물건을 팔고 싶은  유저는 중고거래에 글을 작성하면 됩니다. <br> 이 사이트에서는 판매하는 방식을 여러가지 지원합니다.</p>
				<p>첫번째는 일반적은 판매금액제시입니다. <br> 판매자는 물건의 금액을 올리고 구매자가 구입을 누른다면 거래됩니다.</p>
				<p>두번째로 최고가공개입찰경매입니다. <br> 판매자는 경매 시작가를 적으면 구매자는 자신이 살려는 금액을 입력합니다.
				 <br>최고가르 입찰한 구매자는 물건을 구매합니다</p>
				<p>세번째로 차고가 봉인입찰 입찰경매입니다. <br> 판매자는 경매 시작가를 적으면 구매자는 자신이 살려는 금액을 입력합니다.
				 <br>입찰 금액은 비공개되며 최고가로 입찰한 구매자는 두번째로 높을 가격으로  입찰한 가격으로 물건을 구매합니다</p>
				<p><a class="btn btn-primary btn-pull" href="bbs.jsp" role="button">게시물 보러가기</a></p>
			</div>
		</div>
	</div>
	<!--  
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/1.jpg">
				</div>
				<div class="item">
					<img src="images/2.jpg">
				</div>
				<div class="item">
					<img src="images/3.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	-->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
	</script>
	<script src="js/bootstrap.js"></script>
</body>
</html>