
package community;

import java.util.ArrayList;
import java.sql.*;
import user.User;
import utility.ImageManager;

public class ComComment {

  final private String comment;
  final private String name;
  final private String date_str;
  final private String img_src;

  public String getComment(){ return comment; }
  public String getName(){ return name; }
  public String getDateStr(){ return date_str; }
  public String getImageSrc(){ return img_src; }


  /**
   * @deprecated temporary function.
   */
  private ComComment(String comment, String name, String date_str, String img_src){
    this.comment = comment;
    this.name = name;
    this.date_str = date_str;
    this.img_src = img_src;
  }

  static public ArrayList<ComComment> getCommentsFromCommunity(final int community_id) throws SQLException, ClassNotFoundException{
    Connection db = null;
    ArrayList<ComComment> ret = null;

    // JDBC ドライバのロード
    try{
      Class.forName("org.gjt.mm.mysql.Driver");
    }catch(ClassNotFoundException e){}

    // データベースとの結合
      db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");

      // SQL 文を query に格納
      String query = "select * from community_comment where community_comment.community_id=?";
      PreparedStatement coms_ps = db.prepareStatement(query);
      coms_ps.setInt(1, community_id);

      // SQL 文を実行し結果を ResultSet に格納
      ResultSet rs = coms_ps.executeQuery();
      

      ret = new ArrayList<ComComment>();
      while(rs.next()){
        String comment = rs.getString("comment");
        User us = User.getUserFromUUID(rs.getInt("user_uuid"));
        String name = us.id_;
        String date_str = rs.getString("posted_at");
        String img_src = new ImageManager(us.getImageId()).url_;
        ret.add(new ComComment(comment,name,date_str,img_src));
      }

      rs.close();
      coms_ps.close();
      db.close();

    return ret;
    
  }

  static public boolean addComment(final int community_id, final int user_id, final String comment) throws SQLException{
    Connection db = null;
    ArrayList<ComComment> ret = null;

    // JDBC ドライバのロード
    try{
      Class.forName("org.gjt.mm.mysql.Driver");
    }catch(ClassNotFoundException e){}

    // データベースとの結合
    db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");


    // SQL 文を query に格納
    String query = "insert into community_comment set community_id=?, user_uuid=?, comment=?, posted_at=?";
    PreparedStatement coms_ps = db.prepareStatement(query);
    
    coms_ps.setInt(1, community_id);
    coms_ps.setInt(2, user_id);
    coms_ps.setString(3, comment);
  
    coms_ps.setDate(4, new Date(System.currentTimeMillis()));

    // SQL 文を実行し結果を ResultSet に格納
    int row = coms_ps.executeUpdate();


    
    coms_ps.close();
    db.close();

    return (row == 1);
  }
}
