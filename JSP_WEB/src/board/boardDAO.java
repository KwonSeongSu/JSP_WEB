package board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class boardDAO {	
	private static final String  SAVEFOLDER = "C:/Jsp/Infoboard";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;

	Connection conn;
	ResultSet rs;
	PreparedStatement pstmt;
	
	public boardDAO() {
		String dbID = "root";
		String dbPasswd = "dongyang";
		String dbURL = "jdbc:mysql://localhost/wikidongyang?autoReconnect=true&useSSL=false";

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPasswd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 리스트
	public Vector<boardDTO> getBoardList(String keyField, String keyWord, int start, int end) {
		Vector<boardDTO> vlist = new Vector<boardDTO>();
		try {
			if(keyField.equals("empty")){
				String sql = "select * from InfoBoard where subject like ? order by num desc, pos limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}else if (keyWord.equals("null") || keyWord.equals("")) {
				String sql = "select * from InfoBoard order by num desc, pos limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				String sql = "select * from  InfoBoard where " + keyField + " like ? order by num desc, pos limit ? , ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardDTO dto = new boardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setPos(rs.getInt("pos"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setCount(rs.getInt("count"));
				vlist.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return vlist;
	}
	
	//총 게시물수
	public int getTotalCount(String keyField, String keyWord) {
		int totalCount = 0;
		try {
			if(keyField.equals("null") || keyWord.equals("")){
				String sql = "select count(num) from InfoBoard where subject like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}else if (keyWord.equals("null") || keyWord.equals("")) {
				String sql = "select count(num) from InfoBoard";
				pstmt = conn.prepareStatement(sql);
			} else {
				String sql = "select count(num) from  InfoBoard where " + keyField + " like ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	// 게시물 입력
	public void insertBoard(HttpServletRequest req) {
		String sql = null;
		MultipartRequest multi = null;
		int filesize = 0;
		String filename = null;
		FileInputStream inputStream=null;
		try {
			sql = "select max(num)  from InfoBoard";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 1;
			if (rs.next())
				ref = rs.getInt(1) + 1;
			File file = new File(SAVEFOLDER);
			if (!file.exists())
				file.mkdirs();
			multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			}
			String content = multi.getParameter("content");
	
			if(multi.getFilesystemName("filename") != null){
				File f= multi.getFile("filename");
				inputStream=new FileInputStream(f);
			}
			
			if(multi.getFilesystemName("filename") != null){
				sql = "insert InfoBoard(name,content,subject,regdate,count,filename,filesize,fileblob) values(?, ?, ?,now(),0,?, ?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, content);
				pstmt.setString(3, multi.getParameter("subject"));
				pstmt.setString(4, filename);
				pstmt.setInt(5, filesize);
				pstmt.setBlob(6, inputStream);
				pstmt.executeUpdate();
			}else{
				sql = "insert InfoBoard(name,content,subject,regdate,count) values(?, ?, ?,now(),0)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, content);
				pstmt.setString(3, multi.getParameter("subject"));
				pstmt.executeUpdate();	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 게시물 리턴
	public boardDTO getBoard(int num) {
		boardDTO bean = new boardDTO();
		try {
			String sql = "select * from InfoBoard where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return bean;
	}

	// 조회수 증가
	public void upCount(int num) {
		String sql = "update InfoBoard set count=count+1 where num=?";
		try {			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시물 수정
		public void updateBoard(boardDTO bean) {
			MultipartRequest multi = null;
			String sql = "update InfoBoard set name=?,subject=?,content=? where num=?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bean.getName());
				pstmt.setString(2, bean.getSubject());
				pstmt.setString(3, bean.getContent());
				pstmt.setInt(4, bean.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
	//페이징 및 블럭 테스트를 위한 게시물 저장 메소드 
	public void post1000(){
		String sql = "insert InfoBoard(name,content,subject,pos,regdate,count,filename,filesize) values('aaa', 'bbb', 'ccc', 0, now(), 0, null, 0);";
		try {
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i < 1000; i++) {
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteBoard(int num) {
		String sql = null;
		try {
			sql = "select filename from InfoBoard where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next() && rs.getString(1) != null) {
				if (!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
				}
			}
			sql = "delete from InfoBoard where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//조회수가 가장높은 글을 추출하는 메소드
	public boardDTO choice() {
		boardDTO choiceText=new boardDTO();
		String sql="select * from InfoBoard where count = (select max(count) from InfoBoard)";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				choiceText.setNum(rs.getInt("num"));
				choiceText.setName(rs.getString("name"));
				choiceText.setSubject(rs.getString("subject"));
				choiceText.setContent(rs.getString("content"));
				choiceText.setPos(rs.getInt("pos"));
				choiceText.setRegdate(rs.getString("regdate"));
				choiceText.setCount(rs.getInt("count"));
				choiceText.setFilename(rs.getString("filename"));
				choiceText.setFilesize(rs.getInt("filesize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return choiceText;
	}
}
