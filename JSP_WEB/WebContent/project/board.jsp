<%@ page contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.boardDTO" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.util.Vector" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>TEST WEB_게시판</title>
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
	
	<%	
		int totalRecord=0; //전체레코드수
		int numPerPage=10; // 페이지당 레코드 수 
		int pagePerBlock=1;  //블럭당 페이지수 
		  
		int totalPage=0; //전체 페이지 수
		int totalBlock=0;  //전체 블럭수 
		
		int nowPage=1; // 현재페이지
		int nowBlock=1;  //현재블럭
		  
		int start=0; //디비의 select 시작번호
		int end=10; //시작번호로 부터 가져올 select 갯수
		  
		int listSize=0; //현재 읽어온 게시물의 수
	
		String keyWord = "", keyField = "";
		Vector<boardDTO> vlist = null;
		boardDAO dao = new boardDAO();
		if (request.getParameter("keyWord") != null) {
			keyWord = request.getParameter("keyWord");
			keyField = request.getParameter("keyField");
		}
	
		if (request.getParameter("reload") != null){
			if(request.getParameter("reload").equals("true")) {
				keyWord = "";
				keyField = "";
			}
		}
		
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		 start=(nowPage * numPerPage)-numPerPage;
		 end= start+numPerPage;
		 
		totalRecord = dao.getTotalCount(keyField, keyWord);	//전체 게시글 수
		totalPage =(int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
		nowBlock= (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
		  
		totalBlock =(int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
	%>
	
	<div class=container>
		<h2 align="center">BOARD</h2>
		<div align="right" style="margin-bottom:10px">
			Total : <%=totalRecord%>Articles(<font color="red"><%=nowPage%>/<%=totalPage%>Pages</font>)
		</div>
		<%
			  vlist = dao.getBoardList(keyField, keyWord, start, end);
			  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
			  if (vlist.isEmpty()) {
		%>
			<div align="center" style="height:200px; padding:100px">
				등록된 게시물이 없습니다.
			</div>
		<%
			  } else {
		%>
			<div align="center">
				  <table class="table" style="text-align:center">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align:center">제 목</th>
							<th style="background-color: #eeeeee; text-align:right">작성자</th>
							<th style="background-color: #eeeeee; text-align:right">조회수</th>
							<th style="background-color: #eeeeee; text-align:right">작성일</th>
						</tr>
					</thead>
					<tbody>
						<%
						  for (int i = 0;i<numPerPage; i++) {
							if (i == listSize) break;
							boardDTO dto = vlist.get(i);
							int num = dto.getNum();
							String name = dto.getName();
							String subject = dto.getSubject();
							int count = dto.getCount();
							String regdate = dto.getRegdate();
						%>
							<tr>
								<td colspan="2">
								  <a href="javascript:read('<%=num%>')"><%=subject%></a>
								</td>
								<td align="right"><%=name%></td>
								<td align="right"><%=count%></td>
								<td align="right"><%=regdate%></td>
							</tr>
						<%
							}
						%>
					</tbody>
				</table> 
			</div>
		<%
			}
		%>
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-4" align="center">
				<%
					int pageStart = (nowBlock -1) * pagePerBlock + 1 ; //하단 페이지 시작번호
					int pageEnd = ((pageStart + pagePerBlock ) < totalPage) ?  (pageStart + pagePerBlock): totalPage+1; //하단 페이지 끝번호
					
					if(totalPage !=0){
						if (nowBlock > 1) {
				%>
					  		<a href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%> 
					  		<%for ( ; pageStart < pageEnd; pageStart++){%>
		 			     	<a href="javascript:pageing('<%=pageStart %>')"> 
		 					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
		 					[<%=pageStart %>] 
		 					<%if(pageStart==nowPage) {%></font> <%}%></a> 
							<%}%>
							<%if (totalBlock > nowBlock ) {%>
							<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
						<%}%> 
				<%
					}
				%>
			</div>
			<div class="col-sm-4" align="right">
				<a href="board_post.jsp">[글쓰기]</a> 
				<a href="index.jsp">[처음으로]</a>
			</div>
		</div>
		<div align="center">
			<form  name="searchFrm"  method="post" action="./board.jsp">
				<table border="0">
			 		<tr>
			  			<td align="center" valign="bottom">
			   				<select name="keyField" size="1" >
			    				<option value="name"> 이 름</option>
			    				<option value="subject"> 제 목</option>
			    				<option value="content"> 내 용</option>
			   				</select>
			   				<input type="text" size="16" name="keyWord">
			   				<input type="button"  value="찾기" onClick="javascript:check()">
			   				<input type="hidden" name="nowPage" value="1">
			  			</td>
			 		</tr>
				</table>
			</form>
		</div>
		
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true"> 
			<input type="hidden" name="nowPage" value="1">
		</form>
		<form name="readFrm" method="post">
			<input type="hidden" name="num"> 
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField%>"> 
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
	</div>
	<hr>
	<h5 align="center"> Made in TEST WEB</h5>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
		function pageing(page) {
			document.readFrm.nowPage.value = page;
			document.readFrm.submit();
		}
		
		function block(value){
			 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
			 document.readFrm.submit();
		} 
		
		function read(num){
			document.readFrm.num.value=num;
			document.readFrm.action="index.jsp?CONTENTPAGE=Info_Read";
			document.readFrm.submit();
		}
		
		function check() {
		     if (document.searchFrm.keyWord.value == "") {
		   alert("검색어를 입력하세요.");
		   document.searchFrm.keyWord.focus();
		   return;
		     }
		  document.searchFrm.submit();
		 }
	</script>
</body>
</html>