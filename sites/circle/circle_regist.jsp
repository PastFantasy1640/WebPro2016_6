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
</table>
<%
	out.println("<input type=\"submit\" name=\"create_bt\" value=\"作成\">");
%>
</form>
<p><a href="/MyApp/">トップページへ戻る</a></p>
</center>
</body>
</html>
