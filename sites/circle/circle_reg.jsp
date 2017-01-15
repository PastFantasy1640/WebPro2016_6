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
	// パラメータの入力とチェック
  String circlename = request.getParameter("circlename");
  String type = request.getParameter("type");
  String prefecture = request.getParameter("prefecture");
  String university = request.getParameter("university");
  String button = request.getParameter("button");

%>
<form method=post action=top_test.html>
<%
	if(circlename.equals("")) {
%>
未入力の項目がありますので，登録できません．
<input type="submit" name=but value="トップページに戻る">
<%
	}
	else {
		// JDBC ドライバのロード
		Class.forName("org.gjt.mm.mysql.Driver");
		// データベースとの結合
		Connection db = DriverManager.getConnection("jdbc:mysql://localhost/webpro_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");

		// Statement オブジェクトの生成
		Statement st = db.createStatement();
    Statement st1 = db.createStatement();
    Statement st2 = db.createStatement();
    Statement st3 = db.createStatement();

    String query1 = "select id from categories where name='" + type + "'";
    String query2 = "select id from universities where name='" + university + "'";
    String query3 = "select id from circles where name='" + circlename + "' and university_id = (select id from universities where name='" + university + "')";
    
    ResultSet rs1 = st1.executeQuery(query1);
    ResultSet rs2 = st2.executeQuery(query2);
    ResultSet rs3 = st3.executeQuery(query3);
    if(rs3.next() == false){
%>
既に同大学に同名のサークルが登録されています.
<input type="submit" name=but value="トップページに戻る">
<%
    }
    else{
    rs1.next();
    rs2.next();
		// SQL 文を query に格納
		String query = "insert into circles set name='" + circlename + "', category_id=" + rs1.getInt("id") + ", university_id=" + rs2.getInt("id");
		// SQL 文を実行し挿入した数が返る
		int num = st.executeUpdate(query);
		if(num > 0) { 
%>
データが登録されました.
<input type="submit" name=but value="トップページに戻る">
<%
		}
		else {
%>
データが登録されませんでした．
<input type="submit" name=but value="トップページに戻る">
</form>
<%
		}
		// Statement, データベースを順にクローズ
    rs1.close();
    rs2.close();
		st.close();
    st1.close();
    st2.close();
    st3.close();
		db.close();
    }
	}
%>
</table>
</body>
</html>
