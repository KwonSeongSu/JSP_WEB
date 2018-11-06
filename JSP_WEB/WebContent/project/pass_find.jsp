<%@ page contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>TEST WEB_패스워드 찾기</title>
</head>
<body>
	<%
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
		}
		if(id != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있습니다.')");
			script.println("location.href='history.back()'");
			script.println("</script>");
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
		</div>
	</nav>
	
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="margin-top:20px";>
				<form method="POST" name="findPass" action="./findIdAction.jsp" onSubmit="return check_Find_Pass();">
					<center><h2>비밀번호 찾기</h2></center>
					<center>아이디와 이메일 입력</center>
				    <div class="form-group" style="margin-top:20px">
				      <input class="form-control" name="id" type="text" placeholder="아이디">
				    </div>
				    <div class="form-group">
				      <input class="form-control" name="email" type="text" placeholder="이메일">
				    </div>
					<p><button class="form-control" type="submit" value="findPass"> 아이디 찾기 </button></p>
				</form>
		    </div> 
	    </div>
	    <div class="col-lg-4"></div>
	</div>
	
	<hr>
	<h5 align="center"> Made in TEST WEB</h5>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
		function check_Find_Pass(){
			if(!document.findPass.id.value){
				alert("아이디를 입력하세요");
				return false;
			}
			if(!document.findPass.email.value){
				alert("이메일을 입력하세요");
				return false;
			}
		}
	</script>
</body>
</html>