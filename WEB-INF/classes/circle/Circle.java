
package circle;

import java.util.ArrayList;
import java.sql.*;
import utility.DatabaseConnector;

public class Circle {

	final public int id_;
	final public String name_;
	final public int circle_leader_id_;
  final public int category_id_;
	final public String comment_;
	final public String mail_;
	final public String phone_;
  final public String twitter_;
	final public String facebook_;
	final public String file_;
  final public int imageid_;

	private Circle(final int id, final String name, final int circle_leader_id, final int category_id, String comment, String mail, String phone, String twitter, String facebook, String file, int imageid){
		this.id_ = id;
		this.name_ = name;
		this.circle_leader_id_ = circle_leader_id;
    this.category_id_ = category_id;
    this.comment_ = comment;
    this.mail_ = mail;
    this.phone_ = phone;
    this.twitter_ = twitter;
    this.facebook_ = facebook;
    this.file_ = file;
    this.imageid_ = imageid;
	}

	static public ArrayList<Circle> getCircles()  throws SQLException, ClassNotFoundException{
		ArrayList<Circle> ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
    
    	try{
			if(db != null){
				// SQL 文を query に格納
				Statement st = db.createStatement();
				String query = "select * from circles";
				ResultSet rs = st.executeQuery(query);
	
				ret = new ArrayList<Circle>();
				while(rs.next()){
					ret.add(new Circle(rs.getInt("id"), rs.getString("name"), rs.getInt("circle_leader_id"), rs.getInt("category_id"), rs.getInt("university_id"),rs.getString("comment"), rs.getString("mail"), rs.getString("phone"), rs.getString("twitter"), rs.getString("facebook"), rs.getString("file"), rs.getString("imageid")));
				}
	
				st.close();
				rs.close();
				db.close();
			}
		}catch(SQLException e){ ret = null;  }
		return ret;
	}

    static public ArrayList<Circle> getCircles(int id) throws SQLException, ClassNotFoundException{
	
		ArrayList<Circle> ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
    
    	try{
			if(db != null){
				// SQL 文を query に格納
				Statement st = db.createStatement();
				String query = "select * from circles where id ="+id;
				ResultSet rs = st.executeQuery(query);
	
				ret = new ArrayList<Circle>();
				while(rs.next()){
					ret.add(new Circle(rs.getInt("id"), rs.getString("name"), rs.getInt("circle_leader_id"), rs.getInt("category_id"), rs.getInt("university_id"),rs.getString("comment"), rs.getString("mail"), rs.getString("phone"), rs.getString("twitter"), rs.getString("facebook"), rs.getString("file"), rs.getString("imageid")));
				}
	
				st.close();
				rs.close();
				db.close();
			}
		}catch(SQLException e){ ret = null;  }
		return ret;


    }
}
