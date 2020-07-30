package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	public int comment_write(String userID, String Comment_Content) { 

		String SQL = "insert into board_ values(?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
		
			pstmt.setString(1, userID);
			pstmt.setString(2, Comment_Content);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}

