
package circle;

import java.util.ArrayList;
import java.sql.*;
import utility.DatabaseConnector;

public class Category {

	final public int id_;
	final public String name_;


	private Category(final int id, final String name){
		this.id_ = id;
		this.name_ = name;
	}

	static public ArrayList<Category> getCategories()  throws SQLException, ClassNotFoundException{
		ArrayList<Category> ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
    
    	try{
			if(db != null){
				// SQL 文を query に格納
				Statement st = db.createStatement();
				String query = "select * from categories";
				ResultSet rs = st.executeQuery(query);
	
				ret = new ArrayList<Category>();
				while(rs.next()){
				    ret.add(new Category(rs.getInt("id"), rs.getString("name")));
				}
	
				st.close();
				rs.close();
				db.close();
			}
		}catch(SQLException e){ ret = null;	}
		return ret;
	}
}
