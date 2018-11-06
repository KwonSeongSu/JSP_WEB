<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="bMgr" class="infobean.InfoMgr" />
<jsp:useBean id="bean" class="board.boardDTO" scope="session"/>
<jsp:useBean id="upBean" class="board.boardDTO"/>
<jsp:setProperty property="*" name="upBean"/>
<%
	  String nowPage = request.getParameter("nowPage");
	  //bean에 있는 pass와 upBean pass를 비교(read.jsp)
	    bMgr.updateBoard(upBean);
		String url = "index.jsp?CONTENTPAGE=Info_Read&nowPage="+nowPage+"&num="+upBean.getNum();
		response.sendRedirect(url);
%>