/******************************/
/* author : 14231036 Shirao   */
/* (c) 2016                   */
/******************************/



package utility;

import java.sql.*;
import java.util.logging.Logger;
import java.security.SecureRandom;


/** ImageManager class manages images uploaded from users.
 */
public class ImageManager{

	private final int id;
	private final String url;
	
	private final String QUERY_GET_IMAGE = "select * from images where images.id=?;";
	private final String QUERY_ADD_IMAGE = "insert into images (url) values (?);"; 
	private final String QUERY_UNIQUE_FILENAME = "select count(*) from images where images.url=?";
	private final String QUERY_LAST_ID = "select last_insert_id() as LAST;";

	public int getId(){ return this.id; }
	public String getUrl(){ return this.url; }

	private String generateRandomName(final int id){
		SecureRandom random = new SecureRandom();
		byte bytes[] = new byte[20];
		random.nextBytes(bytes);

		String ret = "img";
		for(byte b: bytes){
			char c = (char)('a' + ((int)b % 26));
			ret += c;
		}

		ret += Integer.toString(id);

		return ret;
	}


	private ImageManager(final int id, final String url){
		this.id = id;
		this.url = url;
	}
	
/*	public ImageManager(final int id){
		this.ImageManager(id,"");
	}
*/

	public ImageManager(final int id){
    			
		Logger logger = Logger.getLogger("ImageManager");

    		boolean res = false;
		try{
    			Class.forName("org.gjt.mm.mysql.Driver");
    			res = true;
    		}catch(ClassNotFoundException e){
    			logger.warning("DB Driver not found exception has occured. EXCEPTION:" + e.toString());
    		}
    	
		
		int tid = 0;
		String turl = "";
		
		Connection db = null;
    		try{
		    	db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");
	    	
		    	if(id > 0){
			    	//get
			    	PreparedStatement ps = db.prepareStatement(QUERY_GET_IMAGE);
			    	ps.setInt(1, id);
			    	ResultSet rs = ps.executeQuery();
			    	
			    	if(rs.next()){
			    		tid = rs.getInt("id");
			    		turl = rs.getString("url");
			    	}else{
			    		logger.warning("Illegal id has been set.");
			    	}
		    	
		    	
		    	}else{
		    		//new addition
		    		//create url
		    		int count = 0;
		    		do{
			    		turl = this.generateRandomName(id);
			    		PreparedStatement ps = db.prepareStatement(QUERY_UNIQUE_FILENAME);
			    		ps.setString(1,turl);
			    		ResultSet rs = ps.executeQuery();

			    		count = rs.getInt("count(*)");

	    			}while(count > 0);
				
				PreparedStatement ps = db.prepareStatement(QUERY_ADD_IMAGE);
			    	ps.setString(1,turl);
			    	ResultSet rs = ps.executeQuery();

			    	ps = db.prepareStatement(QUERY_LAST_ID);
			    	rs = ps.executeQuery();
			    	tid = rs.getInt("LAST");


		    	}
		}catch(SQLException e){
			logger.warning("access to database has denied.");
			tid = 0;
			turl = "";
		}finally{
			try{
				if(db != null) db.close();
			}catch(SQLException e){
				logger.warning("failed to close the database.");
			}
		}
    	
    		this.id = tid;
    		this.url = turl;
	}


}