
package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.lang.ClassNotFoundException;


public class DatabaseConnector {

	static private String DATABASE_NAME = "circle_triangle_db";
	static private String DATABASE_URL = "mysql://localhost";
	static private String JDBC_DRIVER = "org.gjt.mm.mysql.Driver";
	
	static public Connection connect(final String user, final String pass){
		return DatabaseConnector.connect(user,pass,"utf-8");
	}
	

	static public Connection connect(final String user, final String pass, final String encode){
		
		Connection db = null;
		
		// JDBC ドライバのロード
    	try{
    		Class.forName(JDBC_DRIVER);
    		// データベースとの結合
    		db = DriverManager.getConnection("jdbc:" + DATABASE_URL + "/" + DATABASE_NAME + "?user=" + user + "&password=" + pass + "&useUnicode=true&characterEncoding=" + encode);
    	}
    	catch(ClassNotFoundException e){}
    	catch(SQLException e){}

		return db;
	}

}

