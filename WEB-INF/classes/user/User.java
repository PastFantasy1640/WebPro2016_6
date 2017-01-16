
package user;

import java.util.ArrayList;
import java.sql.*;
import utility.DatabaseConnector;
import static utility.StringUtil.NonNullString;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class User {

	final public static int NEW_USER_UUID = -1;
	final public static int MALE = 0;
	final public static int FEMALE = 1;
	final public static int NOINFO = -1;
	final private static String pepper_ = "I have a pen. I have an apple. Ah^~ ApplePen!";
	final private static int DEFAULT_STRETCH_COUNT = 1000;
	
	
	final public int uuid_;
	final public String id_;
	final public int university_id_;
	final public int sex_;
	final private String password_;
	final public String salt_;
	final private int stretch_count_;
	final public String mail_;
	final public String twitter_;
	final public String facebook_;
	final public int icon_id_;

	private static String getSHA256(String target) {
		MessageDigest md = null;
		StringBuffer buf = new StringBuffer();
		try {
			md = MessageDigest.getInstance("SHA-256");
			md.update(target.getBytes());
			byte[] digest = md.digest();

			for (int i = 0; i < digest.length; i++) {
				buf.append(String.format("%02x", digest[i]));
			}

		} catch (NoSuchAlgorithmException e) {
			return "";
		}
	
		return buf.toString();
	}

	
	private static String getHashedPassword(final String password_str, final String salt, final int stretch_count){
		//*stretching
		String hash = password_str;
		for(int i = 0; i < stretch_count ;i++){
			hash = User.getSHA256(hash + salt + User.pepper_);
		}
		return hash;
	}

	private User(final int uuid, final String id, final int university_id, final int sex, final String hashed_password, final String salt,final int stretch_count, final String mail, final String twitter, final String facebook,final int icon_id){
		this.uuid_ = uuid;
		this.id_ = id;
		this.university_id_ = university_id;
		this.sex_ = sex;
		this.password_ = hashed_password;
		this.salt_ = salt;
		this.mail_ = mail;
		this.twitter_ = twitter;
		this.facebook_ = facebook;
		this.icon_id_ = icon_id;
		this.stretch_count_ = stretch_count;
	}
	
	
	public User(final String id, final int university_id, final int sex, final String password_str, final String mail, final String twitter, final String facebook, final int icon_id){
		this.uuid_ = NEW_USER_UUID;	//means temporary User instance. unavailable data for database.
		this.id_ = NonNullString(id);
		this.university_id_ = university_id;
		this.sex_ = sex;
		this.mail_ = NonNullString(mail);
		this.twitter_ = NonNullString(twitter);
		this.facebook_ = NonNullString(facebook);

		this.stretch_count_ = this.DEFAULT_STRETCH_COUNT;

		String hash = NonNullString(password_str);
		
		if(hash.length() >= 8 && hash.length() < 32) {
			this.salt_ = String.valueOf(System.currentTimeMillis());
			hash = this.getHashedPassword(hash, this.salt_,this.stretch_count_);
		}else{
			hash = "";
			this.salt_ = "";
		}
		
		this.password_ = hash;
		this.icon_id_ = icon_id;
	}
	
	public boolean isUniqueID(){
		//クエリ発行
		if(this.id_.length() < 4 || this.id_.length() >= 16) return false;
		try{
			Connection db = DatabaseConnector.connect("chef","secret");
			String query = "select count(*) cnt from users where users.id=?";
			PreparedStatement pst = db.prepareStatement(query);
			pst.setString(1, this.id_);
			ResultSet rs = pst.executeQuery();
		
			rs.next();
		
			if(rs.getInt("cnt") == 0) return true;	//未登録
		
		}catch(SQLException | ClassNotFoundException e){
		}
		return false;
	}
	
	public boolean isValidPassword(){
		//エラーチェック
		return !this.salt_.equals("");
	}
	
	public boolean isValidParameter(){
		if(this.sex_ != MALE && this.sex_ != FEMALE && this.sex_ != NOINFO) return false;
		if(this.salt_ == null) return false;
		if(this.uuid_ != NEW_USER_UUID) return false;
		
		return true;
	}
	
	/** 新しいユーザーを登録します。正常に終了した場合は、登録後のuuidが正しくセットされたUserインスタンスを返します。エラーがあった場合はnullを返します。
	具体的なエラーの内容としては、重複するidを指定していた場合、パスワードが8文字以上32文字以内でない場合、性別などのパラメータが異常な場合が上げられます。
	それぞれのエラーについて、insertする前に確かめる関数がありますので、if文を使用して確かめてください。
	 * @param new_user uuidが-1であるユーザー
	 * @see isUniqueID
	 * @see isValidPassword
	 * @see isValidParameter
	 */
	public User insertNewUser() throws SQLException, ClassNotFoundException{
		User ret = null;
		
		//エラーチェック
		if(this.isUniqueID() && this.isValidPassword() && this.isValidParameter()){
			//クエリ発行
			Connection db = DatabaseConnector.connect("chef","secret");
			String query = "insert into users (id, university_id, sex, password, salt, mail, twitter, facebook, icon_id) values (?,?,?,?,?,?,?,?,?);";
			PreparedStatement pst = db.prepareStatement(query);
			
			pst.setString(1, this.id_);
			pst.setInt(2, this.university_id_);
			pst.setInt(3, this.sex_);
			pst.setString(4, this.password_);
			pst.setString(5, this.salt_);
			pst.setString(6, this.mail_);
			pst.setString(7, this.twitter_);
			pst.setString(8, this.facebook_);
			pst.setInt(9, this.icon_id_);
			
			pst.executeUpdate();
			
			pst.close();
			
			query = "select last_insert_id() as last";
			Statement st = db.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			rs.next();
			int new_uuid = rs.getInt("LAST");
			ret = new User(new_uuid, this.id_, this.university_id_, this.sex_, this.password_, this.salt_, this.stretch_count_, this.mail_, this.twitter_, this.facebook_, this.icon_id_);
			
			rs.close();
			st.close();
			
			db.close();
		}
		return ret;
	}
	
	
	
	public User updateUser(final User old_user) throws SQLException, ClassNotFoundException{
		User ret= null;
		//エラーチェック
		if(this.isUniqueID() && this.isValidParameter() && this.id_.equals(old_user.id_) && this.uuid_ >= 0){
			//クエリ発行
			Connection db = DatabaseConnector.connect("chef","secret");
			String query;
			PreparedStatement pst;
			if(this.isValidPassword()){
				//Change Password
				query = "update users set university_id=?, sex=?, password=?, salt=?,stretch_count=?, mail=?, twitter=?, facebook=? where users.uuid=?";
				pst = db.prepareStatement(query);
			
				pst.setInt(1, this.university_id_);
				pst.setInt(2, this.sex_);
				pst.setString(3, this.password_);
				pst.setString(4, this.salt_);
				pst.setInt(5, this.stretch_count_);
				pst.setString(6, this.mail_);
				pst.setString(7, this.twitter_);
				pst.setString(8, this.facebook_);
				pst.setInt(9, old_user.uuid_);
			}else{
				//Not Change Password
				query = "update users set university_id=?, sex=?, mail=?, twitter=?, facebook=? where users.uuid=?";
				pst = db.prepareStatement(query);
			
				pst.setInt(1, this.university_id_);
				pst.setInt(2, this.sex_);
				pst.setString(3, this.mail_);
				pst.setString(4, this.twitter_);
				pst.setString(5, this.facebook_);
				pst.setInt(6, old_user.uuid_);
			}
			pst.executeUpdate();
			
			pst.close();
			
			db.close();
			
			if(this.isValidPassword()){
				ret = new User(old_user.uuid_, this.id_, this.university_id_, this.sex_, this.password_, this.salt_, this.stretch_count_, this.mail_, this.twitter_, this.facebook_, this.icon_id_);
			}else{
				ret = new User(old_user.uuid_, this.id_, this.university_id_, this.sex_, old_user.password_, old_user.salt_, old_user.stretch_count_, this.mail_, this.twitter_, this.facebook_, old_user.icon_id_);
			}
			
		}
		return ret;
	
	}
	
	
	//private function
	static private User getUserFromIDNonlimit(final String id) throws SQLException, ClassNotFoundException{
		User ret = null;
		
		Connection db = DatabaseConnector.connect("chef","secret");
		PreparedStatement ps = db.prepareStatement("select * from user where user.id=?");
		ps.setString(1,id);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		if(rs.next()){
			int uuid = rs.getInt("uuid");
			String id2 = rs.getString("id");
			int univ_id = rs.getInt("university_id");
			int sex = rs.getInt("sex");
			String password = rs.getString("password");
			String salt = rs.getString("salt");
			int stretch_count = rs.getInt("stretch_count");
			String mail = rs.getString("mail");
			String twitter = rs.getString("twitter");
			String facebook = rs.getString("facebook");
			int icon_id = rs.getInt("icon_id");
		
			ret = new User(uuid, id2, univ_id, sex, password, salt, stretch_count, mail, twitter, facebook, icon_id);
		}
		return ret;
	}
	
	static public User autholizeUser(final String id, final String password_str) throws SQLException, ClassNotFoundException{
		User ret = null;
		
		//get salt from id
		//final String id, final int university_id, final int sex, final String password_str, final String mail, final String twitter, final String facebook, final int icon_id
		Connection db = DatabaseConnector.connect("chef","secret");
		PreparedStatement ps = db.prepareStatement("select salt, stretch_count, password from users where users.id=?");
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		//hash with the salt
		String hash = User.getHashedPassword(password_str, rs.getString("salt"), rs.getInt("stretch_count"));
		
		//is equals pass
		if(hash.equals(rs.getString("password"))){
			//Success
			ret = User.getUserFromIDNonlimit(id);
		}
		
		return ret;
	}
	
		
	static public User getUserFromID(final String id)throws SQLException, ClassNotFoundException{
		User ret = null;
		
		Connection db = DatabaseConnector.connect("chef","secret");
		PreparedStatement ps = db.prepareStatement("select uuid, id, university_id, sex, mail, twitter, facebook, icon_id from user where user.id=?");
		ps.setString(1,id);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		if(rs.next()){
			int uuid = rs.getInt("uuid");
			String id2 = rs.getString("id");
			int univ_id = rs.getInt("university_id");
			int sex = rs.getInt("sex");
			String password = "";
			String salt = "";
			int stretch_count = -1;
			String mail = rs.getString("mail");
			String twitter = rs.getString("twitter");
			String facebook = rs.getString("facebook");
			int icon_id = rs.getInt("icon_id");
		
			ret = new User(uuid, id2, univ_id, sex, password, salt, stretch_count, mail, twitter, facebook, icon_id);
		}
		return ret;
	}
	
	static public User getUserFromUUID(final int uuid)throws SQLException, ClassNotFoundException{
		User ret = null;
		
		Connection db = DatabaseConnector.connect("chef","secret");
		PreparedStatement ps = db.prepareStatement("select uuid, id, university_id, sex, mail, twitter, facebook, icon_id from user where user.uuid=?");
		ps.setInt(1,uuid);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		if(rs.next()){
			int uuid2 = rs.getInt("uuid");
			String id = rs.getString("id");
			int univ_id = rs.getInt("university_id");
			int sex = rs.getInt("sex");
			String password = "";
			String salt = "";
			int stretch_count = -1;
			String mail = rs.getString("mail");
			String twitter = rs.getString("twitter");
			String facebook = rs.getString("facebook");
			int icon_id = rs.getInt("icon_id");
		
			ret = new User(uuid2, id, univ_id, sex, password, salt, stretch_count, mail, twitter, facebook, icon_id);
		}
		return ret;
	}
	
	

}

