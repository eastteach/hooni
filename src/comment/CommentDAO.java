package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;




public class CommentDAO {
	private Connection conn;
	
	private ResultSet rs;
	
	public CommentDAO() {
		try {
			String dbURL ="jdbc:oracle:thin:@localhost:1521:xe";
			String dbID  ="hr";
			String dbPassword ="hr";
		    Class.forName( "oracle.jdbc.driver.OracleDriver");
		    conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void cominsert(Comment com) { 

		String SQL = "insert into bbs_Comment values(?,?,sysdate,commentcount_seq)";

		PreparedStatement pstmt = null;
		try {
			// 커넥션 객체 획득
			

			// java에서 sql을 실행하는 PreparedStatement객체 생성
			pstmt = conn.prepareStatement(SQL);

			// sql의 ?파라메터 매칭
			pstmt.setString(1, com.getUser_id());
			pstmt.setString(2, com.getComment_Content());
			

			// sql실행
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				// 자원 반환
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}
	
}
	


