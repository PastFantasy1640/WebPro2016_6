
package community;

import java.util.ArrayList;
import java.sql.*;
import utility.DatabaseConnector;

public class University {

	final public int id_;
	final public String name_;
	final public String name1_;


	private University(final int id, final String name, final String name1_){
		this.id_ = id;
		this.name_ = name;
		this.name1_ = name1;
	}

	static public ArrayList<University> getUniversities(){
		ArrayList<University> ret = null;

		Connection db = DatabaseConnector.connect("chef","pass");
    
		if(db != null){
		// SQL •¶‚ð query ‚ÉŠi”[
			Statement st = db.createStatement();
			String query = "select * from universities";
			ResultSet rs = st.executeQuery(query);

			ret = new ArrayList<University>();
			while(rs.next()){
				ret.add(new University(rs4.getString("id"), rs4.getString("name"), rs4.getString("name1")));
			}

			rs.close();
			query.close();
			db.close();
		}
		return ret;
	}
}
