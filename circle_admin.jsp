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
    Statement st3 = db.createStatement();
    String query3 = "select * from circles where circle_leader_id = " + id + "";
    ResultSet rs3 = st3.executeQuery(query3);

    if(!rs3.next()){
      %>サークル情報が登録されていません。<%
    }else{
      String circlename = rs3.getString("name");
      String comment = rs3.getString("comment");
      String mail = rs3.getString("mail");
      String phone = rs3.getString("phone");
      String twitter = rs3.getString("twitter");
      String facebook = rs3.getString("facebook");
      String file = rs3.getString("file");
      String button="";
      String imageid = rs3.getString("imageid");
	%>

	<center>
	    <h1>サークル管理</h1><br>
	    <form action=Servlet/ImageUploader enctype=multipart/form-data method=post>
		<h2>・サークル画像変更</h2>
		<input type=file name=image size=30>
		<input type="submit" name=button value="送信">
	    </form><br><br>

	    <h2>・サークル情報変更</h2>
	    <form action=circle_add.jsp method=post>
		<table>
		    <tbody>
			<tr><th>サークル名</th><td>
      <% out.println(circlename); %>
			</td></tr>

	    <tr><th>一言コメント</th><td>
		<%
		out.println("<textarea name=comment rows=1 cols=30>" + comment + "</textarea>");
		%>
</textarea></td></tr>

	    <tr><th>サークル紹介</th><td>
		<%
		out.println("<textarea name=comment rows=8 cols=30>" + file + "</textarea>");
		%>
</textarea></td></tr>
	    <tr><th>メールアドレス</th><td>
	    <%
	    out.println("<input type=\"text\" value=\"" + mail + "\"name=mail size=30></h1>");
	    %>
      </td></tr>

	    <tr><th>電話番号</th><td>
	    <%
	    out.println("<input type=\"text\" value=\"" + phone + "\"name=phone size=30></h1>");
	    %>
      </td></tr>

	    <tr><th>Twitter</th><td>
	    <%
	    out.println("<input type=\"text\" value=\"" + twitter + "\"name=twitter size=30></h1>");
	    %>
      </td></tr>

	    <tr><th>facebook</th><td>
	    <%
	    out.println("<input type=\"text\" value=\"" + facebook + "\"name=facebook size=30></h1>");
	    %>
      </td></tr>
      </tbody>
      </table>
	    <br><input type="submit" name=button value="送信">
	    <%
    }
	    // Statement, データベースを順にクローズ
      rs3.close();
      st3.close();
	    db.close();
	    %>
  </form>
	</center>
    </body>
</html>
