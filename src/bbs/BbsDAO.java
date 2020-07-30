package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn;
	
	private ResultSet rs;
	
	public BbsDAO() {
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
	//현재의 시간을 가져오는 함수
	//현재의 시간을 가져오는 함수
	          public int getNext() {
	        	  String SQL = "select bbsID from bbs order by bbsID desc";
	          try {
	        	  PreparedStatement pstmt = conn.prepareStatement(SQL);
	        	  rs = pstmt.executeQuery();
	        	  if(rs.next()) {
	        		  return rs.getInt(1) +1;
	        	  }
	        	  return 1;
	          } catch (Exception e) {
	        	  e.printStackTrace();
	          }
	              return -1;
	          }

			

				//실제로 글을 작성하는 함수

				public int write(String bbsTitle, String userID, String bbsContent) { 

					String SQL = "insert into bbs values(?, ?, ?, sysdate, ?, ?)";

					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						
						pstmt.setInt(1, getNext());

						pstmt.setString(2, bbsTitle);

						pstmt.setString(3, userID);

						pstmt.setString(4, bbsContent);
						
						pstmt.setInt(5, 1);

						return pstmt.executeUpdate();

						

					} catch (Exception e) {

						e.printStackTrace();

					}

					return -1; //데이터베이스 오류

				}
				public ArrayList<Bbs> getList(int pageNumber){
					String SQL = "SELECT * FROM (SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC) WHERE ROWNUM <= 10";
					ArrayList<Bbs> list = new ArrayList<Bbs>();
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, getNext() - (pageNumber -1) *10);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							Bbs bbs= new Bbs();
							bbs.setBbsID(rs.getInt(1));
							bbs.setBbsTitle(rs.getString(2));
							bbs.setUserID(rs.getString(3));
							bbs.setBbsDate(rs.getString(4));
							bbs.setBbsContent(rs.getString(5));
							bbs.setBbsAvailable(rs.getInt(6));
							list.add(bbs);
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					return list;
				}

				public boolean nextPage(int pageNumber) {
					String SQL = "select * from bbs where bbsid <? and bbsAvailable= 1";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, getNext()- (pageNumber-1)*10);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							return true;
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					return false;
				}
				
				public Bbs getBbs(int bbsID) {
					  String SQL = "select * from bbs where bbsID=? ";
			          try {
			        	  PreparedStatement pstmt = conn.prepareStatement(SQL);
			        	  pstmt.setInt(1, bbsID);
			        	  rs = pstmt.executeQuery();
			        	  if(rs.next()) {
			        		  Bbs bbs = new Bbs();
			        		  bbs.setBbsID(rs.getInt(1));
			        		  bbs.setBbsTitle(rs.getString(2));
			        		  bbs.setUserID(rs.getString(3));
			        		  bbs.setBbsDate(rs.getString(4));
			        		  bbs.setBbsContent(rs.getString(5));
			        		  bbs.setBbsAvailable(rs.getInt(6));
			        		  return bbs;
			        	  }
			        	 
			          } catch (Exception e) {
			        	  e.printStackTrace();
			          }
			              return null;
			          }
				public int update(int bbsID, String bbsTitle, String bbsContent) {
					String SQL = "update bbs set bbsTitle =? , bbsContent = ? where bbsID = ?";

					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);						
						pstmt.setString(1, bbsTitle);
						pstmt.setString(2, bbsContent);				
						pstmt.setInt(3, bbsID);
						return pstmt.executeUpdate();	
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					return -1; //데이터베이스 오류
					
				}
				public int delete(int bbsID) {
					String SQL = "update bbs set bbsAvailable =0 where bbsID =? ";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);								
						pstmt.setInt(1, bbsID);
						return pstmt.executeUpdate();	
					} catch (Exception e) {
						e.printStackTrace();
					}
					return -1; //데이터베이스 오류
				}
				
				
				
	}
				
				
  











