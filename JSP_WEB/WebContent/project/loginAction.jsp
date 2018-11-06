<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="account.accountDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="account" class="account.accountDTO" scope="page" />
<jsp:setProperty property="id" name="account"/>
<jsp:setProperty property="pass" name="account"/>
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
			script.println("loation.href='index.jsp");
			script.println("</script>");
		}
		
		accountDAO dao = new accountDAO();
		int result = dao.login(account.getId(), account.getPass());
		if(result == 1){
			session.setAttribute("id", account.getId());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디 및 패스워드가 틀립니다. 로그인하세요.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류발생')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>