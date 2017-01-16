/******************************/
/* author : 14231036 Shirao   */
/* (c) 2016                   */
/******************************/

package utility;

import java.sql.*;
import java.io.IOException;
import java.util.logging.Logger;
import java.security.SecureRandom;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import utility.DatabaseConnector;


/** ImageManager class manages images uploaded from users.
 */
public class ImageManager{

	////////////////////////////////////
	//  MEMBER  VARIABLES           //
	////////////////////////////////////
	public final int id_;
	public final String url_;
	
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
	public int getId(){ return this.id_; }
	public String getFileName(){ return this.url_; }

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
		this.id_ = 0;
		this.url_ = "";
	}


	final static public int FAILED_TO_LOAD_DBDC = -100;
	final static public int INVALID_ID = -101;
	final static public int THERE_IS_NO_DATA = -102;
	final static public int FAILED_TO_CLOSE_DATABASE = -103;
	final static public int ACCESS_DENIED_TO_DATABASE = -104;
	final static public int IOEXCEPTION_HAS_OCCURED = -105;


	////////////////////////////////////
	//  PUBLIC  CONSTRUCTOR         //
	////////////////////////////////////
	public ImageManager(final int id){
		//prepare the logger (but in servlet, no meaning...)
		Logger logger = Logger.getLogger("ImageManager");

		//temporary members

		int tid = -99;
		String turl = "default";

		if(id == this.IOEXCEPTION_HAS_OCCURED) {
			this.id_ = id;
			this.url_ = "default";
			return;
		}
		Connection db = null;
		try{
			db = DatabaseConnector.connect("chef","secret");
			PreparedStatement ps;
	    	if(id > 0){
		    	//get the url.
		    	ps = db.prepareStatement(QUERY_GET_IMAGE);
		    	ps.setInt(1, id);
		    	ResultSet rs = ps.executeQuery();
			    	
		    	if(rs.next()){
		    		tid = rs.getInt("id");
		    		turl = rs.getString("url");
		    	}else{
		    		//nothing data.
		    		logger.warning("Illegal id has been set.");

		    		tid = this.THERE_IS_NO_DATA;
		    	}
		    	
		    	
		    }else if(id == 0){
		   		//new addition
		    	//create url
		    	int count = 0;
			    ps = db.prepareStatement(QUERY_UNIQUE_FILENAME);
		    	do{
		    		//generate the random string.
			    	turl = ImageManager.generateRandomName();

			    	//check if it is an unique string.
			    	ps.setString(1,turl);
			    	ResultSet rs = ps.executeQuery();
			    	rs.next();
			    	count = rs.getInt("count(*)");
			    	rs.close();
	    		}while(count > 0);
			    ps.close();

	    		//UNIQUED!!!
	    		//add the image.
				ps = db.prepareStatement(QUERY_ADD_IMAGE);
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

		    	}else{
		    		tid = this.INVALID_ID;
		    		turl = "";
		    	}
		}catch(ClassNotFoundException e){
			logger.warning("access to database has denied.");
			turl = "";
			tid = this.FAILED_TO_LOAD_DBDC;
		}catch(SQLException e){
			logger.warning("access to database has denied.");
			turl = "";
			tid = this.ACCESS_DENIED_TO_DATABASE;

		}finally{
			try{
				if(db != null) db.close();
			}catch(SQLException e){
				logger.warning("failed to close the database.");
				tid = this.FAILED_TO_CLOSE_DATABASE;
			}
		}
    		
    	//setup the member variables.
    	this.id_ = tid;
    	this.url_ = turl;
	}

	public boolean isFailed(){
		return (this.id_ < 0);
	}

	private static ImageManager getDefaultImage(final String root_path, final String original_fname) throws IOException{
		ImageManager ret = new ImageManager(0);	//新規作成
		if(ret.isFailed() == false){
			//成功
			//画像をコピー
   			String filename_to = root_path + "/uploads/images/" + ret.url_;
   			String filename_from = root_path + "/uploads/images/" + original_fname;
    			
           	//Fileオブジェクトを生成する
           	FileInputStream fis = new FileInputStream(filename_from);
           	FileOutputStream fos = new FileOutputStream(filename_to);

           	//入力ファイルをそのまま出力ファイルに書き出す
           	byte buf[] = new byte[512];
          	int len;
           	while ((len = fis.read(buf)) != -1) {
           	    fos.write(buf, 0, len);
           	}

           	//終了処理
           	fos.flush();
           	fos.close();
           	fis.close();
		}
		return ret;
	}

	public static ImageManager getDefaultIcon(final String root_path) throws IOException{
		return ImageManager.getDefaultImage(root_path, "default_icon");
	}
	
	public static ImageManager getDefaultImage(final String root_path) throws IOException{
		return ImageManager.getDefaultImage(root_path, "default_image");
	}
}
