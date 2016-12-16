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

	////////////////////////////////////
	//  MEMBER  VARIABLES           //
	////////////////////////////////////
	private final int id;
	private final String url;
	
	////////////////////////////////////
	//  QUERT  STRINGS              //
	////////////////////////////////////
	private final String QUERY_GET_IMAGE = "select * from images where images.id=?;";
	private final String QUERY_ADD_IMAGE = "insert into images (url) values (?);"; 
	private final String QUERY_UNIQUE_FILENAME = "select count(*) from images where images.url=?";
	private final String QUERY_LAST_ID = "select last_insert_id() as LAST;";

	////////////////////////////////////
	//  GET  ACCESSOR                //
	////////////////////////////////////
	public int getId(){ return this.id; }
	public String getFileName(){ return this.url; }

	/////////////////////////////////////
	//  PRIVATE  FUNCTIONS          //
	/////////////////////////////////////
	private static String generateRandomName(){
		SecureRandom random = new SecureRandom();
		byte bytes[] = new byte[26];
		random.nextBytes(bytes);

		String ret = "img";
		for(byte b: bytes){
			char c = (char)('a' + ((int)b & 0x0f));
			ret += c;
		}
		return ret;
	}

	private ImageManager(){
		this.id = 0;
		this.url = "";
	}

	////////////////////////////////////
	//  PUBLIC  CONSTRUCTOR         //
	////////////////////////////////////
	public ImageManager(final int id){
		//prepare the logger (but in servlet, no meaning...)
		Logger logger = Logger.getLogger("ImageManager");

		//temporary members
		int tid = 0;
		String turl = "";

		//load the db driver
		try{
    			Class.forName("org.gjt.mm.mysql.Driver");
    		}catch(ClassNotFoundException e){
    			logger.warning("DB Driver not found exception has occured. EXCEPTION:" + e.toString());
    			
    			this.id = tid;
    			this.url = turl;
    			return;
    		}
    	
		//Connection		
		Connection db = null;

    		try{
    			//Connecting to Database.
    			//circle_triangle_db (database) : images (table)
		    	db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");
		    	
		    	if(id > 0){
			    	//get the url.
			    	PreparedStatement ps = db.prepareStatement(QUERY_GET_IMAGE);
			    	ps.setInt(1, id);
			    	ResultSet rs = ps.executeQuery();
			    	
			    	if(rs.next()){
			    		tid = rs.getInt("id");
			    		turl = rs.getString("url");
			    	}else{
			    		//nothing data.
			    		logger.warning("Illegal id has been set.");
			    	}
		    	
		    	
		    	}else{
		    		//new addition
		    		//create url
		    		int count = 0;
		    		do{
		    			//generate the random string.
			    		turl = ImageManager.generateRandomName();

			    		//check if it is an unique string.
			    		PreparedStatement ps = db.prepareStatement(QUERY_UNIQUE_FILENAME);
			    		ps.setString(1,turl);
			    		ResultSet rs = ps.executeQuery();
			    		rs.next();
			    		count = rs.getInt("count(*)");
			    		ps.close();
			    		rs.close();
	    			}while(count > 0);

	    			//UNIQUED!!!
	    			//add the image.
				PreparedStatement ps = db.prepareStatement(QUERY_ADD_IMAGE);
			    	ps.setString(1,turl);
				ps.executeUpdate();
		    		ps.close();

		    		//get the image's id.
			    	ps = db.prepareStatement(QUERY_LAST_ID);
			    	ResultSet rs = ps.executeQuery();
			    	rs.next();
			    	tid = rs.getInt("LAST");

		    		ps.close();
		    		rs.close();

		    	}
		}catch(SQLException e){
			logger.warning("access to database has denied.");
			turl = "";
		}finally{
			try{
				if(db != null) db.close();
			}catch(SQLException e){
				logger.warning("failed to close the database.");
			}
		}
    		
    		//setup the member variables.
    		this.id = tid;
    		this.url = turl;
	}


}