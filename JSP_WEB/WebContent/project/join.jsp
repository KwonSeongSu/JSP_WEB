<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Test Web_회원가입</title>
</head>
<body>
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
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
			<div class="jumbotron">
			  <center><h2>회원가입</h2></center>
			  <form action="./joinAction.jsp" method="post" name="join" onSubmit="return checkIt();">
			    <div class="form-group">
			      <label for="id">ID</label>
			      <div class="row">
				      <div class="col-lg-8"><input type="text" class="form-control" name="id" placeholder="ID"></div>
				      <div class="col-lg-4"><input type="button" class="btn btn-danger form-control" value="중복확인" onclick="openConfirmid(this.form)"></div>
			      </div>
			      
			    </div>
			    <div class="form-group">
			      <label for="pass">PASSWORD</label>
			      <input type="password" class="form-control" name="pass" placeholder="PASSWORD">
			    </div>
			    <div class="form-group">
			      <label for="name">NAME</label>
			      <input type="text" class="form-control" name="name" placeholder="NAME">
			    </div>
			    <div class="form-group">
			      <label for="email">EMAIL</label>
			      <input type="text" class="form-control" name="email" placeholder="EMAIL">
			    </div>
			    <button type="submit" class="btn btn-primary form-control" value="join">JOIN</button>
			  </form>
			 </div>
		 </div>
		 <div class="col-lg-3"></div>
	</div>
	<hr>
	<h5 align="center"> Made in TEST WEB</h5>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
	function checkIt(){
		if(!document.join.id.value){
			alert("ID를 입력하세요");
			return false;
		}
		if(!document.join.pass.value){
			alert("비밀번호를 입력하세요");
			return false;
		}
		if(!document.join.name.value){
			alert("이름을 입력하세요");
			return false;
		}
		if(!document.join.email.value){
			alert("이메일을 입력하세요");
			return false;
		}
	}
	
	function openConfirmid(join){
		if(!join.id.value){
			alert("아이디를 입력하세요");
			return false;
		}
		//url과 사용자 입력 id를 조합
			url="confirmId.jsp?id=" + join.id.value;
	
			 sw=screen.availWidth;     //화면 넓이
			 sh=screen.availHeight;    //화면 높이
	
			 pw=300;    //띄울 창의 넓이
			 ph=200;    //띄울 창의 높이
	
			 ml=(sw-pw)/2;        //가운데 띄우기위한 창의 x위치
			 mt=(sh-ph)/2;         //가운데 띄우기위한 창의 y위치//새로운 윈도우를 엽니다.
			 
			 
			open(url,"confirm","width="+pw+", height="+ph+",top="+mt+",left="+ml+"toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no");
	}
	</script>
</body>
</html>