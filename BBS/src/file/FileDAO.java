package file;
import file.FileImage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class FileDAO {
	private Connection conn;
	private ResultSet rs;
	
	public FileDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1279";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public int upload(int bbsID ,String fileName,String fileRealNmae) {
		String SQL = "INSERT INTO FILE VALUES (?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1,bbsID);
			pstmt.setString(2,fileName);
			pstmt.setString(3,fileRealNmae);
			return pstmt.executeUpdate();
				
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public FileImage getImagename(int bbsID) {
		String SQL = "SELECT * FROM FILE WHERE bbsID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs= pstmt.executeQuery();
			if(rs.next())
			{
				FileImage fileImage = new FileImage();
				fileImage.setBbsID(rs.getInt(1));
				fileImage.setFileName(rs.getString(2));
				fileImage.setFileRealName(rs.getString(3));
				return fileImage;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	
	
	
}
