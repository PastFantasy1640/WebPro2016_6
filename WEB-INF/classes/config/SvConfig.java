package config;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import config.NoValueProperty;

public class SvConfig{

    final private Properties config = new Properties();

    //Keys
    final private String DB_KEY = "db_name";

    /** コンストラクタ。コンストラクタ内で設定ファイルを読み込みます。失敗すると例外を投げます。 
     * @throws 
     */
    public SvConfig() throws IOException{
        //InputStream inputStream = new FileInputStream(new File("configs.properties"));
	//config.load(inputStream);
    }

    /** データベース名を取得します。
     * @return データベース名
     */
    public String getDBName() throws NoValueProperty{
        String res = config.getProperty(this.DB_KEY);
        if(res == null) throw new NoValueProperty(this.DB_KEY);
        return res;
    }
}
