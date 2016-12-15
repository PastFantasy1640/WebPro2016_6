/******************************/
/* author : 14231036 Shirao   */
/* (c) 2016                   */
/******************************/



package utility;

import java.sql.*;
import java.util.logging.Logger;

/** ImageManager class manages images uploaded from users.
 */
public class ImageManager{

	private final int id;
	private final String url;
	private final String alt;
	
	private final String QUERY_GET_IMAGE = "select * from images where images.id=?;";
	private final String QUERY_ADD_IMAGE = "insert into images (url, alt) values (?, ?);"; 

	public int getId(){ return this.id; }
	public String getUrl(){ return this.url; }
	public String getAlt(){ return this.alt; }
	
	private ImageManager(final int id, final String url, final String alt){
		this.id = id;
		this.url = url;
		this.alt = alt;
	}
	
	public ImageManager(final int id, final String alt = ""){
    			
    	this.prepareDB();
    	
		Logger logger = Logger.getLogger("ImageManager");
		
		int tid = 0;
		String turl = "";
		String talt = "Failed to get the image data.";
		
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
		    		talt = rs.getString("alt");
		    	}else{
		    		logger.warning("Illegal id has been set.");
		    	}
		    	
		    	
	    	}else{
	    		//new addition
	    		//create url
	    		//TO DO##############################################################
	    		
	    	}
		}catch(SQLException e){
			logger.warning("access to database has denied.");
		}finally{
			try{
				if(db != null) db.close();
			}catch(SQLException e){
				logger.warning("failed to close the database.");
			}
		}
    	
	}

	private boolean prepareDB(){
	
		Logger logger = Logger.getLogger("ImageManager");
	
		boolean res = false;
		try{
    		Class.forName("org.gjt.mm.mysql.Driver");
    		res = true;
    	}catch(ClassNotFoundException e){
    		logger.warning("DB Driver not found exception has occured. EXCEPTION:" + e.toString());
    	}
    	
    	return res;
	}


	static public ImageManager getImage(final int id){
		//return the image data and informations.
		return new ImageManager(id);
	}
	
	/** update an image.
	 *@param want_id 0:add a new image. else:update the exising image.
	 *@return new id and url. if id is 0, didn't update successfully.
	 */
	static public ImageManager updateImage(final int want_id, final String alt = ""){
		
	}

}