<%@ page contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>TEST WEB_로그인</title>
</head>
<body>
	<%
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
		}
		if(id == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용가능합니다.')");
			script.println("location.href='login.jsp'");
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
					aria-extended="false">회원관리<span class="caret"><!-- caret은 아이콘 --></span></a>
					<ul class="dropdown-menu">
						<li><a href="logout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>

	<div class="container">
		<form name="postFrm" method="post" action="board_postAction.jsp" enctype="multipart/form-data">
		    <table class="table" style="background-color: #eeeeee; text-align:center; border: 1px solid #dddddd">
				<thead> <!-- 테이블 제목 -->
					<tr>
						<th colspan="2" style="text-align: center;"><h2>Posting</h2></th> <!-- 2개의 열을 사용 -->
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="10%" style="vertical-align:middle">제목</td> 
						<td width="90%"><input type="text" class="form-control" name="kssTitle" maxlength="50"/></td>
					</tr>
					<tr>
						<td width="10%" style="vertical-align:middle">이미지</td> 
	   						<td width="90%" ><input type="file" name="filename" size="50" maxlength="50"></td>
					</tr>
					<tr>
						<td width="10%" style="vertical-align:middle">내용</td> 
						<td width="90%"><textarea class="form-control" name="kssContent" maxlength="2048" style="height:350px"></textarea></td>
					</tr>
				</tbody>	
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기"/>
		</form>
	</div>
	
	<hr>
	<h5 align="center"> Made in TEST WEB</h5>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
	function checkIt(){
		if(!document.login.id.value){
			alert("ID를 입력하세요");
			return false;
		}
		if(!document.login.pass.value){
			alert("비밀번호를 입력하세요");
			return false;
		}
	}
	</script>
</body>
</html>