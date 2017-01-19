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

  Circle new_circle = Circle()
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

    Statement st3 = db.createStatement();
    String query3 = "update circles set comment='" + comment +"', mail='" + mail +"', phone='" + phone +"', twitter='" + twitter +"', facebook='" + facebook +"', file='" + file + "' where circle_leader_id="+id+"";
    int num = st3.executeUpdate(query3);
    if(num <= 0){
      %>更新に失敗しました。<%
    }else{
      %>更新しました。<%
    }
      st3.close();
	    db.close();
      %>
    </body>
</html>
