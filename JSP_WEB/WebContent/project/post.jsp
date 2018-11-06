<%@ page contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("EUC-KR");%>
<html>
<head>
<title>위키동양 질문게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<br/>
	<h2>위키동양 질문게시판</h2><br/>
<table width="80%" cellspacing="0" cellpadding="3">
	<tr>
		<td bgcolor="84F399" height="25" align="center">질문게시판 등록</td>
	</tr>
</table>
<br/>
<form name="postFrm" method="post" action="postProc.jsp" enctype="multipart/form-data">
<table width="80%" cellspacing="0" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table border="0" width="100%" align="center">
			<tr>
				<td width="10%">성 명</td>
				<td width="90%">
				<input type="text" name="name" size="10" maxlength="8"></td>
			</tr>
			<tr>
				<td width="10%">제 목</td>
				<td width="90%">
				<input type="text" name="subject" size="50" maxlength="30"></td>
			</tr>
			<tr>
				<td width="10%">내 용</td>
				<td width="90%"><textarea name="content" rows="10" cols="50"></textarea></td>
			</tr>
			<tr>
				<td width="10%">비밀 번호</td>
				<td width="90%"><input type="password" name="pass" size="15" maxlength="15"></td>
			</tr>
			<tr>
			 <tr>
     			<td width="10%">이미지</td> 
     			<td width="90%" ><input type="file" name="filename" size="50" maxlength="50"></td>
    		</tr>
 			<tr>
 				<td>내용타입</td>
 				<td> HTML<input type=radio name="contentType" value="HTTP" >&nbsp;&nbsp;&nbsp;
  			 	TEXT<input type=radio name="contentType" value="TEXT" checked>
  			 	</td>
 			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					 <input type="submit" value="등록">
					 <input type="reset" value="다시쓰기">
					 <input type="button" value="리스트" onClick="javascript:location.href='index.jsp?CONTENTPAGE=list'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>
</div>
</body>
</html>