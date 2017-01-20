<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="community.Community" %>
<%@ page import="utility.ImageManager" %>
<%@ page import="user.User" %>
<%
	User login_user = User.getLoginUser(session);
	if(login_user == null){
		response.sendRedirect("/MyApp/");
		return;
	}
    
    	ArrayList<Community> communities = Community.getAllCommunities();

	// リクエストパラメータの文字エンコーディング指定
	request.setCharacterEncoding("utf-8");
 	// パラメータの入力とチェック
 	String name = request.getParameter("name");
 	ImageManager img = ImageManager.getDefaultImage(getServletContext().getRealPath(""));
 	String description = request.getParameter("description");
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


<%

 if(name.equals("") || description.equals("")) {
 %>
   未入力の項目がありますので，登録できません．
 <%
 }
 else {
   boolean res = Community.addCommunity(name,img.id_,description);
   if(res) out.println("新規コミュニティが作成されました");
   else out.println("Failed to add the community.");
%>
<div>
  <a href="community_list.jsp"> コミュニティリストに戻る</a>
</div>
<%
 }
%>

</body>
</html>
