package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import user.User;
public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) 
	{
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		
		try 
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) 
			{
				if(rs.getString(1).contentEquals(userPassword))
					return 1;
				else
					return 0; 
			}
			return -1; 
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return -2; 
	}
	
	public int join(User user)
	{
		String SQL = "INSERT INTO USER (userID, userPassword, userName,  userEmail) VALUES (?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		
		}
		return -1; 
	}
	
	
	public String getEmail(String userID ) {
		String SQL = "SELECT userEmail  FROM USER WHERE userID  = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs= pstmt.executeQuery();
			if(rs.next())
			{
				String email="";
				User user = new User();
				user.setUserEmail(rs.getString(1));
				email=user.getUserEmail();
				
				
				return email;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	
	
}
