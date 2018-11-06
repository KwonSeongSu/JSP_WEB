<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head>
<%@page import="board.boardDTO"%>
<jsp:useBean id="bMgr" class="infobean.InfoMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");	//�˻��ʵ�
	  String keyWord = request.getParameter("keyWord");	//�˻���
	  bMgr.upCount(num);//��ȸ�� ����
	  boardDTO bean = bMgr.getBoard(num);//�ش� ��ȣ�� �Խù� ��������
	  String name = bean.getName();		//�ش� ������ get�޼ҵ带 ���ؼ� ������ ������ �ִ´�
	  String subject = bean.getSubject();
      String regdate = bean.getRegdate();
	  String content = bean.getContent();
	  String filename = bean.getFilename();
	  int filesize = bean.getFilesize();
	  int count = bean.getCount();
	  session.setAttribute("bean", bean);//�Խù��� ���ǿ� ����  jsp���� ����� ���ؼ� ���Ǽ���
%>
<title>��Ű���� �����Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list(){
	 	document.listFrm.action="index.jsp?CONTENTPAGE=Info_List";	//����Ʈ ��ư�� ������ ����Ʈ�� �̵��� �Ѵ�.
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
<h2 align="center">��Ű���� ��������</h2>
<table align="center" width="70%" border=0 cellspacing="3" cellpadding="0">
 <tr>
  <td bgcolor="#a6ff4d" height="25" align="center">���б�</td>
 </tr>
 <tr>
  <td colspan="2">
   <table border="0" cellpadding="3" cellspacing="0" width=100%> 
    <tr> 
  <td align="center" bgcolor="#DDDDDD" width="10%"> �� �� </td>
  <td bgcolor="#FFFFE8"><%=name%></td>
  <td align="center" bgcolor="#DDDDDD" width=10%> ��ϳ�¥ </td>
  <td bgcolor="#FFFFE8"><%=regdate%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#DDDDDD"> �� ��</td>
    <td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
   </tr>
   <tr> 
     <td align="center" bgcolor="#DDDDDD">�̹���</td>
     <td bgcolor="#FFFFE8" colspan="3">
     <% if( filename !=null && !filename.equals("")) {%> <!-- ÷������ ��Ͽ��ο� ���� �ٸ��� ǥ�õȴ�. -->
  		<%=filename%>&nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font>  
  		 <%} else{%> ��ϵ� �̹����� �����ϴ�.<%}%>
     </td>
   </tr>
   <tr> 
    <td colspan="4"><br/><%if(filename != null) {%>
    <p width="100%"><img align="left" id="photoImage" src="photoinfo.jsp?num=<%=num%>" width="100"/><%=content%></p>
    <%}else{%>
     <p width="100%"><%=content%></p>
     <%} %></td>		<!-- �������� ������ ǥ�õȴ�. -->
   </tr>
   <tr>
    <td colspan="4" align="right">
     	��ȸ��  <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align="center" colspan="2"> 
 <hr/>
 [ <a href="javascript:list()" >����Ʈ</a> | 
 <a href="index.jsp?CONTENTPAGE=Info_Update&nowPage=<%=nowPage%>&num=<%=num%>" >�� ��</a> ]<br>
  </td>
 </tr>
</table>

<form name="downFrm" action="Info_Download.jsp" method="post">
	<input type="hidden" name="filename">	<!--  ÷�����Ͽ� ���� ó���� �ϴ� download.jsp���Ϸ� �̵��Ѵ�. hidden ������ �ʰ� ������ ó���Ѵ�.-->
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