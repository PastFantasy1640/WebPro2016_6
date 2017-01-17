<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %> 
<%@ page import="static utility.StringUtil.NonNullString" %>
<%@ page import="circle.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utility.DatabaseConnector" %>


<%
  // リクエストパラメータの文字エンコーディング指定
  request.setCharacterEncoding("utf-8");
    
  if(request.getParameter("create_bt") != null) {
  	application.getRequestDispatcher("/sites/circle/circle_reg.jsp").forward(request,response);
  	return;
  }
  
  String circlename = NonNullString(request.getParameter("circlename"));
  String type = NonNullString(request.getParameter("type"));
  String prefecture = NonNullString(request.getParameter("prefecture"));
  int prefecture_id = -1;
  int type_id = -1;
  try{
  	prefecture_id = Integer.parseInt(prefecture);
  	type_id = Integer.parseInt(type);
  }catch(NumberFormatException e){
  	prefecture_id = -1;
  }
  
  
  ArrayList<Category> categs = Category.getCategories();
  ArrayList<University> univs = University.getUniversities();
  ArrayList<Prefecture> prefs = Prefecture.getPrefectures();

%>

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>サークル登録</title>
</head>
<body>

	<%@ include file="/WEB-INF/jsp/userinfo.jsp" %>


<form method="post" action=circle_regist.jsp>
<center>
<br><br><br><br><br>
<h1>サークル登録</h1>
<table>
<tbody>
<tr><th>サークル名</th><td>
<%
out.println("<input type=\"text\" value=\"" + circlename + "\"name=circlename size=30>");
%>
</td></tr>

<tr><th>カテゴリ</th><td>
<%
  out.println("<select name=type>");
  for(Category cg : categs){
    if(type_id == cg.id_){
      out.println("<option value=\"" + cg.id_ + "\"selected>" + cg.name_ + "</option>");
  }else{
    out.println("<option value=\"" + cg.id_ + "\">" + cg.name_ + "</option>");
    }
  }
  out.println("</select>");

%>
</select>
</td></tr>

<tr><th>所在大学</th><td>
<%
out.println("<select name=prefecture>");
  for(Prefecture pr : prefs){
    if(prefecture_id == pr.id_){
      out.println("<option value=\"" + pr.id_ + "\"selected>" + pr.name_ + "</option>");
    }else{
      out.println("<option value=\"" + pr.id_ + "\">" + pr.name_ + "</option>");
    }
  }
  out.println("</select>");
%>
<input type="submit" name="search_bt" value="検索">
<%
if(prefecture_id >= 0){
	Connection db = DatabaseConnector.connect("chef","secret");
  // Statement オブジェクトの生成
  Statement st3 = db.createStatement();
  // SQL 文を query に納入
  String query3 = "select universities.name,universities.id from universities,prefectures where prefectures.id='" + prefecture_id + "' and universities.prefecture_id=prefectures.id";
  // SQL 文を実行し挿入した数が返る
  ResultSet rs3 = st3.executeQuery(query3);

  out.println("<select name=\"university\">");
  while(rs3.next()){
      out.println("<option value=\"" + rs3.getString("id") + "\">" + rs3.getString("name") + "</option>");
  }
  out.println("</select>");
  rs3.close();
  st3.close();
  db.close();
}
%>
</select>
</td></tr>
</table>
<%
	if(prefecture_id >= 0){
		out.println("<input type=\"submit\" name=\"create_bt\" value=\"作成\">");
	}
%>
</form>
<p><a href="/MyApp/">トップページへ戻る</a></p>
</center>
</body>
</html>
