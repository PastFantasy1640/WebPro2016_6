<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %> 

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>コミュニティ一覧</title>
<link rel="stylesheet" type="text/css" href="community_list.css">
</head>
<body>

<%
	// リクエストパラメータの文字エンコーディング指定
	request.setCharacterEncoding("utf-8");
	// JDBC ドライバのロード
	Class.forName("org.gjt.mm.mysql.Driver");
	// データベースとの結合
	Connection db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle_db?user=root&password=secret&useUnicode=true&characterEncoding=utf-8");

	// Statement オブジェクトの生成
	Statement st = db.createStatement();
	// SQL 文を query に格納
	String query = "select * from communities";
	// SQL 文を実行し結果を ResultSet に格納
	ResultSet rs = st.executeQuery(query);
%>
<h1>コミュニティ</h1>

<a href="http://www.google.co.jp/" class="makeCommunity">コミュニティを作る</a>

<h3>おすすめのコミュニティ</h3>



<%

	// nextメソッドでポインタを順次移動
	while(rs.next()) {
%>
  
<a href="http://www.google.co.jp/">
<div class="card_community">
  <img src="../../images/<%= rs.getString("image_url") %>" width=240px height=160px>
  <div class="name">
    <%= rs.getString("name") %>
  </div>
  <div class="description">
    <%= rs.getString("description") %>
  </div>
</div>

</a>
<%
	}
%>
<h3>新着のコミュニティ</h3>

<%
	// SQL 文を実行し結果を ResultSet に格納
	ResultSet rs_new = st.executeQuery(query);
	// nextメソッドでポインタを順次移動
	while(rs_new.next()) {
%>
  
<a href="http://www.google.co.jp/">
<div class="card_community">
  <img src="../../images/<%= rs_new.getString("image_url") %>" width=240px height=160px>
  <div class="name">
    <%= rs_new.getString("name") %>
  </div>
  <div class="description">
    <%= rs_new.getString("description") %>
  </div>
</div>

</a>
<%
	}
%>

<%
	// ResultSet, Statement, データベースを順にクローズ
	rs_new.close();
	rs.close();
	st.close();
	db.close();
%>
</body>
</html>
