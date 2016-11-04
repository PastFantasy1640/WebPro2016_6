package config;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import javax.servlet.*;
import javax.servlet.http.*;

import config.NoValueProperty;

public class SvConfig{

    private Properties config = new Properties();

    //Keys
    final private String DB_KEY = "db_name";

    /** Constructor. If there is no configuration file, this function throws IOException. 
     * @throws 
     */
    public SvConfig() throws IOException{
        //InputStream inputStream = new FileInputStream(new File("configs.properties"));
	//config.load(inputStream);
    }

    /** Get the database name.
     * @return the database name.
     */
    public String getDBName() throws NoValueProperty{
        String res = config.getProperty(this.DB_KEY);
        if(res == null) throw new NoValueProperty(this.DB_KEY);
        return res;
    }
    
    public String getCurrentlyPath(){
    	return new File(".").getAbsoluteFile().getParent();
    }
    
}
