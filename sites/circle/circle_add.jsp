<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %>
<%
// リクエストパラメータの文字エンコーディング指定
request.setCharacterEncoding("utf-8");
// JDBC ドライバのロード
Class.forName("org.gjt.mm.mysql.Driver");
Connection db = DriverManager.getConnection("jdbc:mysql://localhost/webpro_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");
%>

<html>
    <head>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
	<title>サークル管理</title>
    </head>
    <body>
	<%

    //本来こっちを使う
    //int id = (int)session.getAttribute("UserId");
    //テスト用
    int id = 1;
    String comment = request.getParameter("comment");
    if(comment==null)
      comment="";
    String mail = request.getParameter("mail");
    if(mail==null)
      mail="";
    String phone = request.getParameter("phone");
    if(phone==null)
      phone="";
    String twitter = request.getParameter("twitter");
    if(twitter==null)
      twitter="";
    String facebook = request.getParameter("facebook");
    if(facebook==null)
      facebook="";
    String file = request.getParameter("file");
    if(file==null)
      file="";

    Statement st3 = db.createStatement();
    String query3 = "update circles set comment='" + comment +"', mail='" + mail +"', phone='" + phone +"', twitter='" + twitter +"', facebook='" + facebook +"', file='" + file + "' where circle_leader_id="+id+"";
    int num = st3.executeUpdate(query3);
    if(num <= 0){
      %>更新に失敗しました。<%
    }else{
      %>更新しました。<%
    }
      st3.close();
	    db.close();
      %>
    </body>
</html>
