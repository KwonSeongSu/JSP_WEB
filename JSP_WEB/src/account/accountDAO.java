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
	
	//�α��� �޼ҵ�
	public int login(String id, String pass){
		String sql = "select pass from member where id=?";
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1).equals(pass))
					return 1; //ID ����
			}
			return 0;
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	// ���������� �������� select()
	public ArrayList<accountDTO> memberSearch() {
		String sql = "select * from member";
		ArrayList<accountDTO> datas = new ArrayList<accountDTO>();	//��ü �˻� �����͸� �����ϱ� ���� ArrayList
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			// �˻��� �����ͼ� ��ŭ ������ ���� Product ��ü�� ����� �̸� �ٽ� ArrayList �� �߰���.
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
	
	//���̵� ���翩�� Ȯ��.
	public int idConfirm(String id){		
		try{
			String sql = "select id from member where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				return 1; //�ش� ���̵� ����. ���Ұ�.
			
			return 0;	//���̵� ��밡��
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	//���̵� ã��
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
	
	//��й�ȣ ã��
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
	
	// ȸ������ ������ �����ϴ� insert()
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
	
	// ȸ�������� �����ϴ� delete()
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
	
	// ������ ������ ��ǰ������ ������Ʈ �ϴ� �޼���
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

