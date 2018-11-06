<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head>
<%@page import="board.boardDTO"%>
<jsp:useBean id="bMgr" class="infobean.InfoMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");	//검색필드
	  String keyWord = request.getParameter("keyWord");	//검색어
	  bMgr.upCount(num);//조회수 증가
	  boardDTO bean = bMgr.getBoard(num);//해당 번호의 게시물 가져오기
	  String name = bean.getName();		//해당 값들을 get메소드를 통해서 각각의 변수에 넣는다
	  String subject = bean.getSubject();
      String regdate = bean.getRegdate();
	  String content = bean.getContent();
	  String filename = bean.getFilename();
	  int filesize = bean.getFilesize();
	  int count = bean.getCount();
	  session.setAttribute("bean", bean);//게시물을 세션에 저장  jsp에서 사용을 위해서 세션설정
%>
<title>위키동양 질문게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list(){
	 	document.listFrm.action="index.jsp?CONTENTPAGE=Info_List";	//리스트 버튼을 누르면 리스트로 이동을 한다.
	    document.listFrm.submit();
	 } 
	
	function down(filename){
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
</script>
</head>
<body>
<br/>
<h2 align="center">위키동양 정보공유</h2>
<table align="center" width="70%" border=0 cellspacing="3" cellpadding="0">
 <tr>
  <td bgcolor="#a6ff4d" height="25" align="center">글읽기</td>
 </tr>
 <tr>
  <td colspan="2">
   <table border="0" cellpadding="3" cellspacing="0" width=100%> 
    <tr> 
  <td align="center" bgcolor="#DDDDDD" width="10%"> 이 름 </td>
  <td bgcolor="#FFFFE8"><%=name%></td>
  <td align="center" bgcolor="#DDDDDD" width=10%> 등록날짜 </td>
  <td bgcolor="#FFFFE8"><%=regdate%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#DDDDDD"> 제 목</td>
    <td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
   </tr>
   <tr> 
     <td align="center" bgcolor="#DDDDDD">이미지</td>
     <td bgcolor="#FFFFE8" colspan="3">
     <% if( filename !=null && !filename.equals("")) {%> <!-- 첨부파일 등록여부에 따라서 다른게 표시된다. -->
  		<%=filename%>&nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font>  
  		 <%} else{%> 등록된 이미지가 없습니다.<%}%>
     </td>
   </tr>
   <tr> 
    <td colspan="4"><br/><%if(filename != null) {%>
    <p width="100%"><img align="left" id="photoImage" src="photoinfo.jsp?num=<%=num%>" width="100"/><%=content%></p>
    <%}else{%>
     <p width="100%"><%=content%></p>
     <%} %></td>		<!-- 컨텐츠의 내용이 표시된다. -->
   </tr>
   <tr>
    <td colspan="4" align="right">
     	조회수  <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align="center" colspan="2"> 
 <hr/>
 [ <a href="javascript:list()" >리스트</a> | 
 <a href="index.jsp?CONTENTPAGE=Info_Update&nowPage=<%=nowPage%>&num=<%=num%>" >수 정</a> ]<br>
  </td>
 </tr>
</table>

<form name="downFrm" action="Info_Download.jsp" method="post">
	<input type="hidden" name="filename">	<!--  첨부파일에 대한 처리를 하는 download.jsp파일로 이동한다. hidden 보이지 않고 정보만 처리한다.-->
</form>

<form name="listFrm" method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<%if(!(keyWord==null || keyWord.equals("null"))){ %>	
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>
</body>
</html>