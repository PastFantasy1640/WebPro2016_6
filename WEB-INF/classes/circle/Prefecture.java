
package circle;


import java.util.ArrayList;
import java.sql.*;
import utility.DatabaseConnector;

public class Prefecture {

	final public int id_;
	final public String name_;


	private Prefecture(final int id, final String name){
		this.id_ = id;
		this.name_ = name;
	}

	static public ArrayList <Prefecture> getPrefectures() throws SQLException, ClassNotFoundException{
		ArrayList<Prefecture> ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
    
    	try{
			if(db != null){
			// SQL 文を query に格納
				Statement st = db.createStatement();
				String query = "select * from prefectures order by id asc";
				ResultSet rs = st.executeQuery(query);
	
				ret = new ArrayList<Prefecture>();
				while(rs.next()){
					ret.add(new Prefecture(rs.getInt("id"), rs.getString("name")));
				}
	
				st.close();
				rs.close();
				db.close();
			}
		}catch(SQLException e){ret = null;}
		
		return ret;
	}
	
	static public Prefecture getPrefectureFromID(final int id) throws SQLException, ClassNotFoundException{
		Prefecture ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
		
    	PreparedStatement pst = db.prepareStatement("select * from prefectures where prefectures.id=?");
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		if(rs.next()){
			ret = new Prefecture(rs.getInt("id"), rs.getString("name"));
		}

		rs.close();
		pst.close();
		db.close();
		
		return ret;
	}
}

