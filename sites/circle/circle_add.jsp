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

  String circleid = NonNullString(request.getParameter("circleid"));
  String comment = NonNullString(request.getParameter("comment"));
  String mail = NonNullString(request.getParameter("mail"));
  String phone = NonNullString(request.getParameter("phone"));
  String twitter = NonNullString(request.getParameter("twitter"));
  String facebook = NonNullString(request.getParameter("facebook"));
  String file = NonNullString(request.getParameter("file"));
  User login_user = User.getLoginUser(session);

  Circle now_circle = Circle.getCircleFromId(Integer.parseInt(circleid));
  Circle new_circle = new Circle(now_circle.name_, now_circle.circle_leader_id_, now_circle.category_id_, now_circle.university_id_, comment, mail, phone, twitter, facebook, file, now_circle.imageid_);
  
  new_circle = new_circle.updateCircle(now_circle);

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
    if(new_circle == null){
    %>
    <p>Failed to update your circle information.</p>
    <%
  }else{
  %>
	<p>更新しました。</p>
  <%
}
%>
	<a href="ResultCircle1.jsp?id=<%= new_circle.id_ %>">サークルのトップページへ行く</a>
    </body>
</html>
