
package community;

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
  @Deprecated
  public ComComment(String comment, String name, String date_str, String img_src){
    this.comment = comment;
    this.name = name;
    this.date_str = date_str;
    this.img_src = img_src;
  }

}