
package circle;

import java.util.ArrayList;
import java.sql.*;
import utility.DatabaseConnector;

public class Circle {

	final public int id_;
	final public String name_;
	final public int circle_leader_id_;
  	final public int category_id_;
  	final public int university_id_;
	final public String comment_;
	final public String mail_;
	final public String phone_;
  	final public String twitter_;
	final public String facebook_;
	final public String file_;
  	final public int imageid_;
  	
  	final public int NEW_CIRCLE_ID = -1;

	private Circle(final int id, final String name, final int circle_leader_id, final int category_id, final int university_id, final String comment, final String mail, final String phone, final String twitter, final String facebook, final String file, final int imageid){
		this.id_ = id;
		this.name_ = name;
		this.circle_leader_id_ = circle_leader_id;
    	this.category_id_ = category_id;
    	this.university_id_ = university_id;
    	this.comment_ = comment;
    	this.mail_ = mail;
    	this.phone_ = phone;
    	this.twitter_ = twitter;
    	this.facebook_ = facebook;
    	this.file_ = file;
    	this.imageid_ = imageid;
	}
	
	public Circle(final String name, final int circle_leader_id, final int category_id, final int university_id, final String comment, final String mail, final String phone, final String twitter, final String facebook, final String file, final int imageid){
		this.id_ = NEW_CIRCLE_ID;
		this.name_ = name;
		this.circle_leader_id_ = circle_leader_id;
    	this.category_id_ = category_id;
    	this.university_id_ = university_id;
    	this.comment_ = comment;
    	this.mail_ = mail;
    	this.phone_ = phone;
    	this.twitter_ = twitter;
    	this.facebook_ = facebook;
    	this.file_ = file;
    	this.imageid_ = imageid;
	} 
	
	public void registCircle() throws SQLException, ClassNotFoundException{
		if(this.id_ != NEW_CIRCLE_ID) return;
	
		Connection db = DatabaseConnector.connect("chef","secret");

	    PreparedStatement pst = db.prepareStatement("insert into circles ( name, circle_leader_id, category_id, university_id, comment, mail, phone, twitter, facebook, file, imageid) values (?,?,?,?,?,?,?,?,?,?,?);");
	    pst.setString(1, this.name_);
	    pst.setInt(2, this.circle_leader_id_);
	    pst.setInt(3, this.category_id_);
	    pst.setInt(4, this.university_id_);
	    pst.setString(5, this.comment_);
	    pst.setString(6, this.mail_);
	    pst.setString(7, this.phone_);
	    pst.setString(8, this.twitter_);
	    pst.setString(9, this.facebook_);
	    pst.setString(10, this.file_);
	    pst.setInt(11, this.imageid_);
	    
	    pst.executeUpdate();
	    
	}
	
	static private Circle putFromResultSet(ResultSet rs) throws SQLException{
		if(rs == null) return null;
		return new Circle(rs.getInt("id"), rs.getString("name"), rs.getInt("circle_leader_id"), rs.getInt("category_id"), rs.getInt("university_id"),rs.getString("comment"), rs.getString("mail"), rs.getString("phone"), rs.getString("twitter"), rs.getString("facebook"), rs.getString("file"), rs.getInt("imageid"));
	}
	
	static public ArrayList<Circle> getCirclesFromLeaderId(final int leader) throws SQLException, ClassNotFoundException{
		ArrayList<Circle> ret = new ArrayList<Circle>();
		
		Connection db = DatabaseConnector.connect("chef","secret");
		
		PreparedStatement pst = db.prepareStatement("select * from circles where circles.circle_leader_id=?");
		pst.setInt(1, leader);
		ResultSet rs = pst.executeQuery();
		
		
		while(rs.next()){
			ret.add(Circle.putFromResultSet(rs));
		}
		
		return ret;
	}
	
	static public Circle getCircleFromId(final int id) throws SQLException, ClassNotFoundException{
		Circle ret = null;
		
		Connection db = DatabaseConnector.connect("chef","secret");
		
		PreparedStatement pst = db.prepareStatement("select * from circles where circles.id=?");
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		rs.next();
		ret = Circle.putFromResultSet(rs);
		rs.close();
		pst.close();
		db.close();
		return ret;
	}

	static public ArrayList<Circle> getCircles()  throws SQLException, ClassNotFoundException{
		ArrayList<Circle> ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
    
		if(db != null){
			// SQL 文を query に格納
			Statement st = db.createStatement();
			String query = "select * from circles";
			ResultSet rs = st.executeQuery(query);
	
			ret = new ArrayList<Circle>();
			while(rs.next()){
				ret.add(Circle.putFromResultSet(rs));
			}
	
			st.close();
			rs.close();
			db.close();
		}
  		return ret;
	}
	
	public Circle insertNewCircle() throws SQLException, ClassNotFoundException{
		Circle ret = null;
		
		Connection db = DatabaseConnector.connect("chef","secret");
  		PreparedStatement pst = db.prepareStatement("select count(*) from circles where circles.name=? and circles.university_id=? and circles.category_id=?");
  		pst.setString(1, this.name_);
  		pst.setInt(2, this.university_id_);
  		pst.setInt(3, this.category_id_);
  		ResultSet rs = pst.executeQuery();
  		rs.next();
  		int count = rs.getInt(1);
  		
  		rs.close();
  		pst.close();
		//エラーチェック
		if(count == 0){
			//クエリ発行
			String query = "insert into circles (name, circle_leader_id, category_id, university_id,comment, mail, phone, twitter, facebook,file, imageid) values (?,?,?,?,?,?,?,?,?,?,?);";
			pst = db.prepareStatement(query);
			
			pst.setString(1, this.name_);
			pst.setInt(2, this.circle_leader_id_);
			pst.setInt(3, this.category_id_);
			pst.setInt(4, this.university_id_);
			pst.setString(5, this.comment_);
			pst.setString(6, this.mail_);
			pst.setString(7, this.phone_);
			pst.setString(8, this.twitter_);
			pst.setString(9, this.facebook_);
			pst.setString(10, this.file_);
			pst.setInt(11, this.imageid_);
			
			pst.executeUpdate();
			
			pst.close();
			
			query = "select last_insert_id() as last";
			Statement st = db.createStatement();
			rs = st.executeQuery(query);
			
			rs.next();
			int new_id = rs.getInt("LAST");
			ret = new Circle(new_id, this.name_, this.circle_leader_id_, this.category_id_, this.university_id_, this.comment_, this.mail_,  this.phone_, this.twitter_, this.facebook_, this.file_, this.imageid_);
			
			rs.close();
			st.close();
			db.close();
		}else {
		}
		return ret;
	}
}
