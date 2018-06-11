package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection con ;
    private ResultSet rs;
    
    public BbsDAO() {
    	try {
        	Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("드라이버 로드 성공");
            
            con = DriverManager.getConnection( "jdbc:oracle:thin:@localhost:1521:myoracle", "eun", "hong");
            System.out.println("db연결성공");
          
        } catch (Exception e) {
            e.printStackTrace(); 
        }     
    }
    
    public int getCOUNT(int NO) { //조회
    	String SQL= "UPDATE BBS SET COUNT = COUNT + 1 WHERE NO = ? ";
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		pstmt.setInt(1, NO);
    		pstmt.executeUpdate();
    	    //rs = pstmt.executeQuery();
    	   
    	}catch (Exception e) {
    		e.printStackTrace(); 
        }
    	return -1;	
    }
    
    
    
    public int getNext() {
    	String SQL= "SELECT NO FROM BBS ORDER BY NO DESC";
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			return rs.getInt(1) + 1;
    		}
    		return 1;
    	}catch (Exception e) {
    		e.printStackTrace(); 
    	}
    	return -1;	
    }
    
    public int write(String TITLE,  String USERID, String CONTENT) {
    	String SQL= "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
    	System.out.println(USERID);
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		pstmt.setInt(1,getNext());
    		pstmt.setString(2,USERID);
    		pstmt.setString(3,TITLE);
    		pstmt.setString(4,CONTENT);
    		pstmt.setInt(5,0); 
    		pstmt.setInt(6,1);
    	    return pstmt.executeUpdate();
    	    
    	}catch (Exception e) {
    		e.printStackTrace(); 
        }
    	return -1;	
    }
    
    public ArrayList<Bbs> getList(int pageNumber){
    	String SQL= "SELECT * FROM BBS WHERE NO < ? AND BBSAVAILABLE = 1 ORDER BY NO DESC"; //LIMIT 10
    	ArrayList<Bbs> list = new ArrayList<Bbs>();
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		pstmt.setInt(1, getNext()-(pageNumber - 1) * 10 );
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	Bbs bbs = new Bbs();
    	    	bbs.setNO(rs.getInt(1));
    	    	bbs.setUSERID(rs.getString(2));
    	    	bbs.setTITLE(rs.getString(3));
    	    	bbs.setCONTENT(rs.getString(4));
    	    	bbs.setCOUNT(rs.getInt(5));
    	    	bbs.setBBSAVAILABLE(rs.getInt(6));
    	    	list.add(bbs);
    	    }
    	}catch (Exception e) {
    		e.printStackTrace(); 
        }
    	return list;
    	
    }
    
    public boolean nextPage(int pageNumber) {
    	String SQL= "SELECT * FROM BBS WHERE NO < ? AND BBSAVAILABLE = 1";
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		pstmt.setInt(1, getNext()-(pageNumber - 1) * 10 );
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	return true;
    	    }
    	}catch (Exception e) {
    		e.printStackTrace(); 
        }
    	return false;
    }
    
    public Bbs getBbs(int NO) {
    	String SQL= "SELECT * FROM BBS WHERE NO = ?";
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		pstmt.setInt(1, NO);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	Bbs bbs = new Bbs();
    	    	bbs.setNO(rs.getInt(1));
    	    	bbs.setUSERID(rs.getString(2));
    	    	bbs.setTITLE(rs.getString(3));
    	    	bbs.setCONTENT(rs.getString(4));
    	    	bbs.setCOUNT(rs.getInt(5));
    	    	bbs.setBBSAVAILABLE(rs.getInt(6));
    	    	return bbs;
    	    }
    	}catch (Exception e) {
    		e.printStackTrace(); 
        }
    	return null;
    }
    
    public int update(int NO, String TITLE, String CONTENT) {
    	String SQL= "UPDATE BBS SET TITLE = ?, CONTENT = ? WHERE NO = ?";
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		pstmt.setString(1, TITLE);
    		pstmt.setString(2, CONTENT);
    		pstmt.setInt(3, NO);
    		return pstmt.executeUpdate();
    	}catch (Exception e) {
    		e.printStackTrace(); 
        }
    	return -1;
    }
    
    public int delete(int NO) {
    	String SQL= "UPDATE BBS SET BBSAVAILABLE =0 WHERE NO = ?";
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		pstmt.setInt(1, NO);
    		return pstmt.executeUpdate();
    	}catch (Exception e) {
    		e.printStackTrace(); 
        }
    	return -1;
    }
    
    
}
    
    

