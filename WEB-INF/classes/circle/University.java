
package circle;

import java.util.ArrayList;
import java.sql.*;
import utility.DatabaseConnector;

public class University {

	final public int id_;
	final public String name_;
	final public String name1_;
	final public int prefecture_id_;


	private University(final int id, final String name, final String name1, final int prefecture_id){
		this.id_ = id;
		this.name_ = name;
		this.name1_ = name1;
		this.prefecture_id_ = prefecture_id;
	}

	static public ArrayList<University> getUniversities() throws SQLException, ClassNotFoundException{
		ArrayList<University> ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
		
    	
		//if(db != null){
		// SQL 文を query に格納
			Statement st = db.createStatement();
			String query = "select * from universities";
			ResultSet rs = st.executeQuery(query);
			ret = new ArrayList<University>();
			while(rs.next()){
				ret.add(new University(rs.getInt("id"), rs.getString("name"), rs.getString("name1"),rs.getInt("prefecture_id")));
			}
			rs.close();
			st.close();
			db.close();
		//}
		
		return ret;
	}
    
       	static public ArrayList<University> getUniversities(int id) throws SQLException, ClassNotFoundException{
		ArrayList<University> ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
		
    	
		//if(db != null){
		// SQL 文を query に格納
			Statement st = db.createStatement();
			String query = "select * from universities where id="+id;
			ResultSet rs = st.executeQuery(query);
			ret = new ArrayList<University>();
			while(rs.next()){
				ret.add(new University(rs.getInt("id"), rs.getString("name"), rs.getString("name1"),rs.getInt("prefecture_id")));
			}
			rs.close();
			st.close();
			db.close();
		//}
		
		return ret;
	}

       
}
