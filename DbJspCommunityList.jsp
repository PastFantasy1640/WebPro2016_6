<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %> 

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>コミュニティ一覧</title>
</head>
<body>

<%
	// リクエストパラメータの文字エンコーディング指定
	request.setCharacterEncoding("utf-8");
	// JDBC ドライバのロード
	Class.forName("org.gjt.mm.mysql.Driver");
	// データベースとの結合
	Connection db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle?user=root&password=secret&useUnicode=true&characterEncoding=utf-8");

	// Statement オブジェクトの生成
	Statement st = db.createStatement();
	// SQL 文を query に格納
	String query = "select * from communities";
	// SQL 文を実行し結果を ResultSet に格納
	ResultSet rs = st.executeQuery(query);
%>
<h1>全コミュニティ</h1>

<table border="1">
<tr><td>番号</td><td>サークル名</td><td>description</td></tr>
<%
	// nextメソッドでポインタを順次移動
	while(rs.next()) {
%>
<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("description") %></td>
</tr>
<%
	}
	// ResultSet, Statement, データベースを順にクローズ
	rs.close();
	st.close();
	db.close();
%>
</table>
</body>
</html>
