
package community;

import java.util.ArrayList;
import java.sql.*;

public class Community {

  final public int id;
  final public String name;
  final public int image_id;
  final public String description;


  /**
   * @deprecated temporary function.
   */
  private Community(int id, String name, int image_id, String description){
    this.id = id;
    this.name = name;
    this.image_id = image_id;
    this.description = description;
  }

  static public ArrayList<Community> getAllCommunities() throws SQLException{
    Connection db = null;
    ArrayList<Community> ret = null;

    // JDBC ドライバのロード
    try{
      Class.forName("org.gjt.mm.mysql.Driver");
    }catch(ClassNotFoundException e){}

    // データベースとの結合
      db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");

      // SQL 文を query に格納
      String query = "select * from communities";
      Statement st = db.createStatement();
      ResultSet rs = st.executeQuery(query);

      

      ret = new ArrayList<Community>();
      while(rs.next()){
        int id = rs.getInt("id");
        String name = rs.getString("name");	//######
        int img_id  = rs.getInt("image_id");
        String description = rs.getString("description");	//######
        ret.add(new Community(id,name,img_id,description));
      }

      rs.close();
      st.close();
      db.close();

    return ret;
    
  }

  static public boolean addCommunity(final String name, final int image_id, final String description) throws SQLException{
    Connection db = null;
    ArrayList<Community> ret = null;

    // JDBC ドライバのロード
    try{
      Class.forName("org.gjt.mm.mysql.Driver");
    }catch(ClassNotFoundException e){}

    // データベースとの結合
    db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");


    // SQL 文を query に格納
    String query = "insert into communities set name=?, image_id=?, description=?";
    PreparedStatement coms_ps = db.prepareStatement(query);
    
    coms_ps.setString(1,name);
    coms_ps.setInt(2, image_id);
    coms_ps.setString(3, description);
  
    // SQL 文を実行し結果を ResultSet に格納
    int row = coms_ps.executeUpdate();


    
    coms_ps.close();
    db.close();

    return (row == 1);
  }
}
