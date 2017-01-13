
package user;

import java.util.ArrayList;
import java.sql.*;
import utility.DatabaseConnector;

public class User {

	final public int uuid_;
	final public String id_;
	final public int university_id_;
	final public int sex_;
	final private byte password_[];
	final private byte salt_[];
	final private static byte pepper_[] = {0xf2, 0x2a, 0x4d, 0x00, 0x7b, 0xec, 0xa4, 0xcc}; 
	final public String mail_;
	final public String twitter_;
	final public String facebook_;
	final public int icon_id_;


	private User(final int uuid, final String id, final int university_id, final int sex, final byte password[], final byte salt[], final String mail, final String twitter, final String facebook,final int icon_id){
		this.uuid_ = uuid;
		this.id_ = id;
		this.university_id_ = university_id_;
		this.sex_ = sex;
		this.password_ = password;
		this.salt_ = salt;
		this.mail_ = mail;
		this.twitter_ = twitter;
		this.facebook_ = facebook;
		this.icon_id_ = icon_id;
	}

	public User(final String id, final int university_id, final int sex, final String password_str, final String mail, final String twitter, final String facebook){
		this.uuid_ = -1;	//means temporary User instance. unavailable data for database.
		this.id_ = id;
		this.university_id_ = university_id_;
		this.sex_ = sex;
		this.mail_ = mail;
		this.twitter_ = twitter;
		this.facebook_ = facebook;

		this.password_ = new byte[32];

		//generate password
		//*first generate salt
		char[] passCharAry = password.toCharArray();
     	byte[] hashedSalt = getHashedSalt(System.currentTimeMillis().toString());
 
     	PBEKeySpec keySpec = new PBEKeySpec(passCharAry, hashedSalt, 1000, 256;
 
     	SecretKeyFactory skf;
     	try {
     		skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
         } catch (NoSuchAlgorithmException e) {
             throw new RuntimeException(e);
         }
 
        SecretKey secretKey;
        try {
            secretKey = skf.generateSecret(keySpec);
        } catch (InvalidKeySpecException e) {
            throw new RuntimeException(e);
        }
        byte[] passByteAry = secretKey.getEncoded();
 
        // 生成されたバイト配列を16進数の文字列に変換
        StringBuilder sb = new StringBuilder(64);
        for (byte b : passByteAry) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();


		this.password_ = password;
		this.salt_ = salt;
		this.icon_id_ = icon_id;
	}

	static public ArrayList<Category> getCategories()  throws SQLException, ClassNotFoundException{
		ArrayList<Category> ret = null;

		Connection db = DatabaseConnector.connect("chef","secret");
    
		if(db != null){
			// SQL 文を query に格納
			Statement st = db.createStatement();
			String query = "select * from categories";
			ResultSet rs = st.executeQuery(query);
					ret = new ArrayList<Category>();
			while(rs.next()){
				ret.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getInt("type")));
			}
					st.close();
			rs.close();
			db.close();
		}
		return ret;
	}
}
