package account;
import java.sql.*;
import java.util.*;

public class accountDAO {
	Connection conn;
	ResultSet rs;
	PreparedStatement pstmt;

	public accountDAO(){
		try {
			String dbId = "root";
			String dbPasswd = "dongyang";
			String dbURL = "jdbc:mysql://localhost/wikidongyang?autoReconnect=true&useSSL=false";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbId, dbPasswd);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//로그인 메소드
	public int login(String id, String pass){
		String sql = "select pass from member where id=?";
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1).equals(pass))
					return 1; //ID 존재
			}
			return 0;
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	// 가입정보를 가져오는 select()
	public ArrayList<accountDTO> memberSearch() {
		String sql = "select * from member";
		ArrayList<accountDTO> datas = new ArrayList<accountDTO>();	//전체 검색 데이터를 전달하기 위한 ArrayList
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			// 검색된 데이터수 만큼 루프를 돌며 Product 객체를 만들고 이를 다시 ArrayList 에 추가함.
			while(rs.next()) {
				accountDTO m = new accountDTO();
				m.setId(rs.getString("id"));
				m.setPass(rs.getString("pass"));
				m.setName(rs.getString("name"));
				m.setEmail(rs.getString("email"));
				datas.add(m);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return datas;
	}
	
	//아이디 존재여부 확인.
	public int idConfirm(String id){		
		try{
			String sql = "select id from member where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				return 1; //해당 아이디 존재. 사용불가.
			
			return 0;	//아이디 사용가능
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	//아이디 찾기
	public String findId(String name, String email){
		String id = null;
		
		try{
			String sql = "select id from member where name=? and email=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,name);
			pstmt.setString(2,email);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				id = rs.getString("id"); 
		}catch(Exception e){
			e.printStackTrace();
		}
		return id;
	}
	
	//비밀번호 찾기
	public String findPass(String id, String email){
		String pass = null;
		String sql = "select pass from member where id=? and email=?";
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2,email);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				pass = rs.getString(1); 
				
		}catch(Exception e){
			e.printStackTrace();
		}
		return pass;
	}
	
	// 회원가입 정보를 저장하는 insert()
	public void insert(accountDTO bean) {
		try {
			String sql = "insert into member values(?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPass());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getEmail());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 회원정보를 삭제하는 delete()
	public int del(String id, String compass) {
		int result=0;

		try {
			String sql = "select pass from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				String pass=rs.getString("pass");
				if(pass.equalsIgnoreCase(compass)){
					sql="delete from member where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,id);
					result=pstmt.executeUpdate();
				}
			}else{
				result = -1;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 수정한 정보로 상품정보를 업데이트 하는 메서드
	public int update(accountDTO bean) {
		int result=0;
		
		try {
			String sql = "update member set pass=?, addr=?, email=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getPass());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getEmail());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}	
}

