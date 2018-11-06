<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%request.setCharacterEncoding("EUC-KR");%>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/login.css"/>
<link rel="stylesheet" href="css/w3.css">
<script language="JavaScript">
function move_list(){
	location.href="index.jsp?CONTENTPAGE=login";
}
</script>

</head>
<body>
<div style="position:absolute; left:45%; top:30%;" align="center">
	<p align="center"><h3>회원가입을 축하드립니다.</h3></p>
	<table class="w3-table-all" border='1' align="center" width='30%' height='50%'>
		<tr>
			<th class="w3-red" colspan="2"> 회원 가입 정보 </th>
		</tr>
		<tr align="left">
			<td width='45%'>ID</td>
			<td><%=id%></td>
		</tr>
		<tr align="left">
			<td>PASSWORD</td>
			<td><%=pass%></td>
		</tr>
		<tr align="left">
			<td>NAME</td>
			<td><%=name%></td>
		</tr>
		<tr align="left">
			<td>E-MAIL</td>
			<td><%=email%></td>
		</tr>
	</table>
	<p align="center"><input type="button" value="로그인" onclick="move_list()"/></p>
	
</div>
</body>
</html>