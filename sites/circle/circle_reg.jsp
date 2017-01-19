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
	// パラメータの入力とチェック
  String circlename = NonNullString(request.getParameter("circlename"));
  String type = NonNullString(request.getParameter("type"));
  String prefecture = NonNullString(request.getParameter("prefecture"));
  String university = NonNullString(request.getParameter("university"));
  
  
  int prefecture_id = -1;
  int type_id = -1;
  int univ_id = -1;
  try{
  	prefecture_id = Integer.parseInt(prefecture);
  	type_id = Integer.parseInt(type);
  	univ_id = Integer.parseInt(university);
  }catch(NumberFormatException e){
  	prefecture_id = -1;
  }
  
  
  out.println("<!--\r\ncirclename:" + circlename + "\r\ntype_id:" + Integer.toString(type_id) 
  + "\r\npref_id:" + Integer.toString(prefecture_id) + "\r\nuniv_id:" + Integer.toString(univ_id) + "-->");
  
  Circle new_circle = null;
  
  if(circlename != ""){
  User login_user = User.getLoginUser(session);
  	
  	if(login_user != null && login_user.university_id_ != -1){
  		ImageManager img = ImageManager.getDefaultImage(getServletContext().getRealPath(""));
  		if(img == null) img = new ImageManager(0);
  		new_circle = new Circle(circlename, login_user.uuid_, type_id, univ_id, "新設サークルです。よろしくお願いします。（管理画面から変更することができます。）","","","","","新設サークルです。よろしくお願いします。ここは自分のサークルを思う存分紹介するためのスペースです。",img.id_);
  		new_circle = new_circle.insertNewCircle();
  	}
  }
%>

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>サークル登録</title>
</head>
<body>

<%
	if (new_circle == null){
%>
		<p>サークルの登録に失敗しました。ログインをしていないか、未入力の場所があるか、同じ大学、カテゴリで、同じサークル名がすでに存在しています。</p>

		<a href="circle_regist.jsp">戻る</a>

<%
	}
	else {
%>
		<p>サークルの登録に成功しました。</p>

		<a href="ResultCircle1.jsp?id=<%= new_circle.id_ %>">サークルのトップページへ行く</a>
<%
	}
%>
	
</body>
</html>
