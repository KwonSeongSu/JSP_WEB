<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<html>
<head>
<title>��Ű���� �������</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
	if((session.getAttribute("id") != null) || (session.getAttribute("manId") != null)){
%>
<br/><h2 align="center">��Ű���� ��������</h2>
<div align="center">
<br/>
<table width="80%" cellspacing="0" cellpadding="3">
	<tr>
		<td bgcolor="84F399" height="25" align="center">����ϱ�</td>
	</tr>
</table>
<br/>
<form name="postFrm" method="post" action="Info_PostProc.jsp" enctype="multipart/form-data">
<table width="80%" cellspacing="0" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table border="0" width="100%" align="center">
			<tr>
				<td width="10%">�� ��</td>
				<td width="90%">
				<input type="text" name="name" size="10" maxlength="8"></td>
			</tr>
			<tr>
				<td width="10%">�� ��</td>
				<td width="90%">
				<input type="text" name="subject" size="50" maxlength="30"></td>
			</tr>
			<tr>
				<td width="10%">�� ��</td>
				<td width="90%"><textarea name="content" rows="10" cols="50" wrap="hard"></textarea></td>
			</tr>
			<tr>
			 <tr>
     			<td width="10%">�̹���</td> 
     			<td width="90%" ><input type="file" name="filename" size="50" maxlength="50"></td>
    		</tr>
 			<tr>
 				<td>����Ÿ��</td>
 				<td> HTML<input type=radio name="contentType" value="HTTP" >&nbsp;&nbsp;&nbsp;
  			 	TEXT<input type=radio name="contentType" value="TEXT" checked>
  			 	</td>
 			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					 <input type="submit" value="���">
					 <input type="reset" value="�ٽþ���">
					 <input type="button" value="����Ʈ" onClick="javascript:location.href='index.jsp?CONTENTPAGE=Info_List'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>
</div>
<%}else { %>
<script type="text/javascript">
		<!--
			alert("�α��� �� �̿밡���մϴ�.");
			location.href="index.jsp?CONTENTPAGE=login";
		//-->
		</script>
<%} %>
</body>
</html>