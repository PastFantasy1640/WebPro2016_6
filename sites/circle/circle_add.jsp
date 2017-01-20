<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %>
<%@ page import="static utility.StringUtil.NonNullString" %>
<%@ page import="circle.*" %>
<%@ page import="user.User" %>
<%@ page import="utility.ImageManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utility.DatabaseConnector" %>
<%
// リクエストパラメータの文字エンコーディング指定
request.setCharacterEncoding("utf-8");

  String circleid = NonNullString(request.getParameter("circleid");
  String comment = NonNullString(request.getParameter("comment"));
  String mail = NonNullString(request.getParameter("mail"));
  String phone = NonNullString(request.getParameter("phone"));
  String twitter = NonNullString(request.getParameter("twitter"));
  String facebook = NonNullString(request.getParameter("facebook"));
  String file = NonNullString(request.getParameter("file"));
  User login_user = User.getLoginUser(session);

  Circle new_circle = getCircleFromId(circleid);
  new_circle.comment_ = comment;
  new_circle.mail_ = mail;
  new_circle.phone_ = phone;
  new_circle.twitter_ = twitter;
  new_circle.facebook_ = facebook;
  new_circle.file_ = file;
  new_circle.updateCircle(new_cirlce);

%>

<html>
    <head>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
	<title>サークル管理</title>
    </head>
    <body>
	<p>更新しました。</p>
	<a href="ResultCircle1.jsp?id=<%= new_circle.id_ %>">サークルのトップページへ行く</a>
    </body>
</html>
