<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %> 
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>サークル管理</title>
</head>
<body>
<%
  // リクエストパラメータの文字エンコーディング指定
  request.setCharacterEncoding("utf-8");
  // JDBC ドライバのロード
  Class.forName("org.gjt.mm.mysql.Driver");


  String circlename = request.getParameter("circlename");
  if(circlename==null)
    circlename="";
  String category = request.getParameter("category");
  if(category==null)
    category="0";
  String type = request.getParameter("type");
  if(type==null)
    type="";
  String prefecture = request.getParameter("prefecture");
  if(prefecture==null)
    prefecture="fukuoka";
  String university = request.getParameter("university");
  if(university==null)
    university="";
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
  String button = request.getParameter("button");
  if(button==null)
    button="";

  // データベースとの結合
  Connection db = DriverManager.getConnection("jdbc:mysql://localhost/webpro_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");

  //ここにサークル情報を取得するSQL文を書く
  //
  //
  //
  //
  //
  //
  // Statement オブジェクトの生成
  Statement st = db.createStatement();
  Statement st1 = db.createStatement();
  // SQL 文を query に納入
  String query = "select name from categorys where type=0";
  // SQL 文を実行し挿入した数が返る
  ResultSet rs = st.executeQuery(query);
  // SQL 文を query に納入
  String query1 = "select name from categorys where type=32768";
  // SQL 文を実行し挿入した数が返る
  ResultSet rs1 = st1.executeQuery(query1);

%>
<form action=Servlet/UploadServlet enctype=multipart/form-data method=post>
<h1>サークル画像<br></h1>
<input type=file name=image size=30>
<input type="submit" name=button value="送信">
</form>

<form action=circle_admin.jsp method=post>
<h1>サークル名<br></h1>
<%
out.println("<input type=\"text\" value=\"" + circlename + "\"name=circlename size=30></h1>");
%>

<h1>カテゴリ<br></h1>
<%
if(category.equals("0")){
  out.println("<select name=category><option value=\"0\" selected>体育系</option><option value=\"1\">文化系</option></select>");
}
if(category.equals("1")){
  out.println("<select name=category><option value=\"0\">体育系</option><option value=\"1\" selected>文化系</option></select>");
}
%>
<input type="submit" name=button value=検索>
<%
if(category.equals("0")){
  out.println("<select name=type>");
  while(rs.next()){
    out.println("<option value=\"" + rs.getString("name") + "\">" + rs.getString("name") + "</option>");
  }
  out.println("</select>");
}
if(category.equals("1")){
  out.println("<select name=type>");
  while(rs1.next()){
    out.println("<option value=\"" + rs1.getString("name") + "\">" + rs1.getString("name") + "</option>");
  }
  out.println("</select>");
}
%>
</select>
</h1>
<%
  // Statement オブジェクトの生成
  Statement st2 = db.createStatement();
  // SQL 文を query に納入
  String query2 = "select name from prefectures order by id asc";
  // SQL 文を実行し挿入した数が返る
  ResultSet rs2 = st2.executeQuery(query2);
%>
<h1>所在大学<br>
<%
out.println("<select name=prefecture>");
  while(rs2.next()){
    if(prefecture.equals(rs2.getString("name"))){
      out.println("<option value=\"" + rs2.getString("name") + "\"selected>" + rs2.getString("name") + "</option>");
    }else{
      out.println("<option value=\"" + rs2.getString("name") + "\">" + rs2.getString("name") + "</option>");
    }
  }
  out.println("</select>");
%>
<input type="submit" name=button value=検索>
<%
  // Statement オブジェクトの生成
  Statement st3 = db.createStatement();
  // SQL 文を query に納入
  String query3 = "select universities.name from universities,prefectures where prefectures.name='" + prefecture + "' and universities.prefecture_id=prefectures.id";
  // SQL 文を実行し挿入した数が返る
  ResultSet rs3 = st3.executeQuery(query3);

  out.println("<select name=university>");
  while(rs3.next()){
      out.println("<option value=\"" + rs3.getString("name") + "\">" + rs3.getString("name") + "</option>");
  }
  out.println("</select>");
%>
</select>
</h1>
<h1>サークル紹介<br>
<%
out.println("<textarea name=comment rows=4 cols=30>" + comment + "</textarea>");
%>
</textarea><br>
</h1>

<h1>メールアドレス<br></h1>
<%
out.println("<input type=\"text\" value=\"" + mail + "\"name=circlename size=30></h1>");
%>

<h1>電話番号<br></h1>
<%
out.println("<input type=\"text\" value=\"" + phone + "\"name=circlename size=30></h1>");
%>

<h1>Twitter<br></h1>
<%
out.println("<input type=\"text\" value=\"" + twitter + "\"name=circlename size=30></h1>");
%>

<h1>facebook<br></h1>
<%
out.println("<input type=\"text\" value=\"" + facebook + "\"name=circlename size=30></h1>");
%>

<input type="submit" name=button value="送信">
<%
  // Statement, データベースを順にクローズ
  rs.close();
  rs1.close();
  rs2.close();
  rs3.close();
  st.close();
  st1.close();
  st2.close();
  st3.close();
  db.close();
%>
</form>
</body>
</html>
