<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %> 
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>サークル登録</title>
</head>
<body>
<%
  // リクエストパラメータの文字エンコーディング指定
  request.setCharacterEncoding("utf-8");
  // JDBC ドライバのロード
  Class.forName("org.gjt.mm.mysql.Driver");

  String button = request.getParameter("button");
  if(button==null)
    button="";
  String cat = request.getParameter("category");
  if(cat==null)
    cat="";
  // データベースとの結合
  Connection db = DriverManager.getConnection("jdbc:mysql://localhost/webpro_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");

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
<form method="post" action=circle_regist.jsp>
<h1>サークル名<br>
<input type="text" name=circlename size=30></h1>

<h1>画像(任意)<br>
<input type="file" name=image size=30></h1>

<h1>カテゴリ<br>
<select name=category>
<option value="0">体育系</option>
<option value="1">文化系</option>
</select>
<input type="submit" name=button value=検索>
<%
if(button.equals("検索") && cat.equals("0")){
  out.println("<select>");
  while(rs.next()){
    out.println("<option value=\"" + rs.getString("name") + "\">" + rs.getString("name") + "</option>");
  }
  out.println("</select>");
}
if(button.equals("検索") && cat.equals("1")){
  out.println("<select>");
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
  String query2 = "select name from universities order by prefecture_id desc";
  // SQL 文を実行し挿入した数が返る
  ResultSet rs2 = st2.executeQuery(query2);
%>
<h1>所在大学<br>
<select name=university>
<%
while(rs2.next()){
  out.println("<option value=\"" + rs2.getString("name") + "\">" + rs2.getString("name") + "</option>");
}
%>
</select>
</h1>

<h1>サークル紹介(任意)<br>
<textarea name=comment rows=4 cols=30>
</textarea><br></h1>

<h1>メールアドレス(任意)<br>
<input type="text" name=mail size=30></h1>

<h1>電話番号(任意)<br>
<input type="text" name=phone size=30></h1>

<h1>twitterID(任意)<br>
<input type="text" name=twitter size=30></h1>

<h1>facebookID(任意)<br>
<input type="text" name=facebook size=30></h1>

<input type="submit" name=button value="送信">
<%
  // Statement, データベースを順にクローズ
  rs.close();
  rs1.close();
  rs2.close();
  st.close();
  st1.close();
  st2.close();
  db.close();
%>
</form>
</body>
</html>
