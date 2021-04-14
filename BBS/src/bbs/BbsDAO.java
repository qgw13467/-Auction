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
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1279";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
						
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; 
	}
	
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; 
						
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int write(String bbsTitle, String userID, String bbsContent,int bbsOption,int rp) {
		String SQL = "INSERT INTO BBS(bbsID ,bbsTitle ,userID ,bbsDate ,bbsContent ,"
				+ "bbsOption ,rp, buyuserID  ,firstPrice ,secondPrice,bbsAvailable ) VALUES (?, ?, ?, ?, ?,? ,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1,  getNext());
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  userID);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,bbsOption);
			pstmt.setInt(7,rp);
			pstmt.setString(8,  "admin");
			pstmt.setInt(9,  rp);
			pstmt.setInt(10,  rp);
			pstmt.setInt(11,  1);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int findID(String bbsTitle, String userID, String bbsContent,int bbsOption,int rp) {
		 {
				String SQL = "SELECT bbsID FROM BBS(bbsTitle ,userID ,bbsContent ,bbsOption ,rp ) WHERE (?, ?, ?, ?, ?)";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1,  bbsTitle);
					pstmt.setString(2,  userID);
					pstmt.setString(3,  bbsContent);
					pstmt.setInt(4,  bbsOption);
					pstmt.setInt(5,  rp);
					
					rs= pstmt.executeQuery();
					if(rs.next())
					{
						Bbs bbs = new Bbs();
						bbs.setBbsID(rs.getInt(1));
						
						return bbs.getBbsID();
					}
					
				} catch(Exception e) {
					e.printStackTrace();
				}
				return -1; 
			}
	}
	
	
	public ArrayList<Bbs> getList(int pageNumber)
	{
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable <>0 ORDER BY bbsID DESC LIMIT 10";
		
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsOption(rs.getInt(6));
				bbs.setRp(rs.getInt(7));
				bbs.setBuyuserID(rs.getString(8));
				bbs.setFirstPrice(rs.getInt(9));
				bbs.setSecondPrice(rs.getInt(10));
				bbs.setBbsAvailable(rs.getInt(11));
				list.add(bbs);
			}
						
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber)
	{
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable <>0";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false; 
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs= pstmt.executeQuery();
			if(rs.next())
			{
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsOption(rs.getInt(6));
				bbs.setRp(rs.getInt(7));
				bbs.setBuyuserID(rs.getString(8));
				bbs.setFirstPrice(rs.getInt(9));
				bbs.setSecondPrice(rs.getInt(10));
				bbs.setBbsAvailable(rs.getInt(11));
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  bbsContent);
			pstmt.setInt(3,  bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int op1(int bbsID,String buyuserID ) {
		String SQL = "UPDATE BBS SET buyuserID  = ?, bbsAvailable  = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1,  buyuserID);
			pstmt.setInt(2,  2);
			pstmt.setInt(3,  bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int op2(int bbsID,int rp,String buyuserID ) {
		String SQL = "UPDATE BBS SET buyuserID  = ?,secondPrice   = ?, firstPrice   = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1,  buyuserID);
			pstmt.setInt(2,  rp);
			pstmt.setInt(3,  rp);
			pstmt.setInt(4,  bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int op3_1(int bbsID,int rp,String buyuserID ) {
		String SQL = "UPDATE BBS SET secondPrice =firstPrice ,buyuserID  = ?, firstPrice   = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1,  buyuserID);
			pstmt.setInt(2,  rp);
			pstmt.setInt(3,  bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	public int op3_2(int bbsID,int rp ) {
		String SQL = "UPDATE BBS SET  secondPrice = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			
			pstmt.setInt(1,  rp);
			pstmt.setInt(2,  bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	
	public int checkdate(int bbsID ) {
		String SQL = "UPDATE BBS SET  bbsAvailable  = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1,  3);
			pstmt.setInt(2,  bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	
	public int checkdate2(int bbsID ) {
		String SQL = "UPDATE BBS SET  bbsAvailable  = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1,  2);
			pstmt.setInt(2,  bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}
