package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection con ;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    public UserDAO() {
    	try {
        	Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("드라이버 로드 성공");
            
            con = DriverManager.getConnection( "jdbc:oracle:thin:@localhost:1521:myoracle", "eun", "hong");
            System.out.println("db연결성공");
          
        } catch (Exception e) {
            e.printStackTrace(); 
        }     
    }
    
    public int login(String USERID , String USERPASSWORD) {
    	
    	String SQL="SELECT USERPASSWORD FROM USERS WHERE USERID=?";
    	
    	try {
    		pstmt =con.prepareStatement(SQL);
    		pstmt.setString(1, USERID);
    		rs = pstmt.executeQuery();  
    		if(rs.next()) {
    			if(rs.getString(1).equals(USERPASSWORD)) 
    				return 1; //로그인 성공
    			else
    				return 0; //비번 아니야			
    		}
    		return -1; //아이디없
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	return -2; //DB에러
    }
    
    public int join(User user) {
    	String SQL="INSERT INTO USERS VALUES (?,?,?)";
    	try {
    		pstmt = con.prepareStatement(SQL);
    		pstmt.setString(1, user.getUSERID());
    		pstmt.setString(2, user.getUSERPASSWORD());
    		pstmt.setString(3, user.getUSERNAME());
    		return pstmt.executeUpdate();
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return -1;
    }
    
    
}
