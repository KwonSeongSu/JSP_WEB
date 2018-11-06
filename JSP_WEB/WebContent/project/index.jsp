<%@ page contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>TEST WEB</title>
</head>
<body>
	<%
		String id = null;
		if (session.getAttribute("id") != null) {
			id = (String)session.getAttribute("id");
		}
	%>
	<!-- nav 웹페이지의 전반적인 구조를 볼 수 있음. -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<!-- <button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button> -->
			<a class="navbar-brand" href="index.jsp">TEST WEB_MAIN</a>
		</div>
		<div class="collapase navbar-collapse" id="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="index.jsp">메인</a></li> <!-- active를 통해 현제 활성화 페이지 확인가능 -->
				<li><a href="board.jsp">게시판</a></li>
			</ul>
			<%
				if(id == null){	//세션이 없는 경우 로그인 페이지 보임.(로그인한 사용자)
			%>
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-extended="false">접속하기<span class="caret"><!-- caret은 아이콘 --></span></a>
							<ul class="dropdown-menu">
								<li><a href="login.jsp">로그인</a></li>
								<li><a href="join.jsp">회원가입</a></li>
							</ul>
						</li>
					</ul>
			<%
				} else {
			%>
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-extended="false">회원관리<span class="caret"><!-- caret은 아이콘 --></span></a>
							<ul class="dropdown-menu">
								<li><a href="logout.jsp">로그아웃</a></li>
							</ul>
						</li>
					</ul>
			<%
				}
			%>
			
		</div>
	</nav>
	<div class="container">
	  <div class="jumbotron" style="margin:20px;">
	    <div class="card-body">추천글</div>
	  </div>
	  <div class="jumbotron" style="margin:20px;">
	    <div class="card-body">질문 게시판</div>
	  </div>
	</div>
	
	<hr>
	<h5 align="center">TEST WEB</h5>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>