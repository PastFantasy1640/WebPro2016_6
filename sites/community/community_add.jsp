<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="community.Community" %>
<%@ page import="utility.ImageManager" %>
<%
     ArrayList<Community> communities = Community.getAllCommunities();
%>

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>コミュニティ新規作成</title>
<link rel="stylesheet" type="text/css" href="community_list.css">
</head>
<body>

<%@ include file="/WEB-INF/jsp/userinfo.jsp" %>

<%
	// リクエストパラメータの文字エンコーディング指定
	request.setCharacterEncoding("utf-8");
 // リクエストパラメータの文字エンコーディング指定
 request.setCharacterEncoding("utf-8");
 // パラメータの入力とチェック
 String name = request.getParameter("name");
 int image_id = Integer.parseInt(request.getParameter("image_id"));
 String description = request.getParameter("description");

 if(name.equals("") || description.equals("")) {
 %>
   未入力の項目がありますので，登録できません．
 <%
 }
 else {
   Community.addCommunity(name,image_id,description);
   out.println("新規コミュニティが作成されました");
%>
<div>
  <a href="community_list.jsp"> コミュニティリストに戻る</a>
</div>
<%
 }
%>

</body>
</html>
