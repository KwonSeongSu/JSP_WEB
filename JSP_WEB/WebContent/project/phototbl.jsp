<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%request.setCharacterEncoding("EUC-KR");%>
<%@ page import="java.util.*, java.sql.*, java.io.*, java.sql.*" %>
 
<%
int num = Integer.parseInt(request.getParameter("num"));
String sql = "";
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
 
out.clear();
out=pageContext.pushBody(); 
 
OutputStream output = response.getOutputStream();
InputStream input = null; 
 
try {
Class.forName("com.mysql.jdbc.Driver");
String jdbcUrl="jdbc:mysql://localhost:3306/wikidongyang";
String id="root";
String pass="dongyang";
 
con=DriverManager.getConnection(jdbcUrl,id,pass);
//out.println("Connection Success");
 
 
    
    sql ="select fileblob from tblboard where num=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, num);
    rs = pstmt.executeQuery();
    
    if (rs.next()) {
        input = rs.getBinaryStream("fileblob");
        int byteRead;
        while((byteRead = input.read()) != -1) {
        output.write(byteRead);
        }
        input.close();
    }
} catch(Exception e) {
    out.print(e);
} finally {
    try {if (rs != null) rs.close();} catch (Exception ex) {}
    try {if (pstmt != null) pstmt.close();} catch (Exception ex) {}
    try {if (con != null) con.close();} catch (Exception ex) {}
}
 
output.flush();
output.close();
%>