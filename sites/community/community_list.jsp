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
<title>コミュニティ一覧</title>
<link rel="stylesheet" type="text/css" href="community_list.css">
</head>
<body>

<%
	// リクエストパラメータの文字エンコーディング指定
	request.setCharacterEncoding("utf-8");
%>
<h1>コミュニティ</h1>

<a href="http://www.google.co.jp/" class="makeCommunity">コミュニティを作る</a>

<h3>おすすめのコミュニティ</h3>

<% 
  for(Community c : communities){
    ImageManager image = new ImageManager(c.image_id);
    out.println(" <a href=\"sites/community/community_list \">");
    out.println("<div class=\"card_community\">");
    out.println(" <img src=\"/MyApp/uploads/images/" + image.getFileName() +"\" width=240px height=160px>");
    out.println("<div class=\"name\"> ");
    out.println(c.name);
    out.println("</div>");
    out.println("<div class=\"description\">");
    out.println(c.description);
    out.println("</div>");
    out.println("</div>");
  }
%>


<h3>新着のコミュニティ</h3>


</body>
</html>
