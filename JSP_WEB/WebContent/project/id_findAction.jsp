<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="account.accountDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="account" class="account.accountDTO" scope="page"/>
<jsp:setProperty property="name" name="account"/>
<jsp:setProperty property="email" name="account"/>
<!DOCTYPE html>
<html>
<head>
<title>TEST WEB</title>
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
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
		
		accountDAO dao = new accountDAO();
		String result =dao.findId(account.getName(), account.getEmail());
		if(result != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert(" + account.getName() + "님의 아이디는 "+ account.getEmail() + "입니다.");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ID를 찾을 수 없습니다. 정보를 확인해주세요.')");
			script.println("location.href='history.back()'");
			script.println("</script>");
		}
	%>
</body>
</html>