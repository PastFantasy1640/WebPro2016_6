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

  String circlename = request.getParameter("circlename");
  if(circlename==null)
    circlename="";
  String type = request.getParameter("type");
  if(type==null)
    type="";
  String prefecture = request.getParameter("prefecture");
  if(prefecture==null)
    prefecture="fukuoka";
  String university = request.getParameter("university");
  if(university==null)
    university="";
  String button = request.getParameter("button");
  if(button==null)
    button="";

  // データベースとの結合
  Connection db = DriverManager.getConnection("jdbc:mysql://localhost/webpro_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");

  // Statement オブジェクトの生成;
  Statement st1 = db.createStatement();
  // SQL 文を query に納入
  String query1 = "select name from categories";
  // SQL 文を実行し挿入した数が返る
  ResultSet rs1 = st1.executeQuery(query1);

  if(button.equals("送信")){
  out.println("<form method=\"post\" enctype=\" multipart/form-data\" action=circle_reg.jsp>");
  }else{  
  out.println("<form method=\"post\" enctype=\" multipart/form-data\" action=circle_regist.jsp>");
  }
%>
<h1>サークル名<br>
<%
out.println("<input type=\"text\" value=\"" + circlename + "\"name=circlename size=30></h1>");
%>

<h1>カテゴリ<br>
<%
  out.println("<select name=type>");
  while(rs1.next()){
    out.println("<option value=\"" + rs1.getString("name") + "\">" + rs1.getString("name") + "</option>");
  }
  out.println("</select>");

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

<input type="submit" name=button value="送信">
<%
  // Statement, データベースを順にクローズ
  rs1.close();
  rs2.close();
  rs3.close();
  st1.close();
  st2.close();
  st3.close();
  db.close();
%>
</form>
</body>
</html>
