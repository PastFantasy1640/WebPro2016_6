<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="community.ImageUpload" %>

<%

String hogehoge = "not yet";
String param = request.getParameter("cname");
if(param != null){
	hogehoge = "param";
	//ImageUpload.post(request, response, config);
	hogehoge = "uploaded";
}

%>





<html lang="ja">
<head>
	<meta charset="UTF-8" />
	<link rel="stylesheet" type="text/css" href="style.css">
	<title>TEMP create a community.</title>
	
	<!-- JAVASCRIPT and JQUERY -->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="jquery.textchange.min.js"></script>
</head>
<body>
	<%= hogehoge %><br />
	<%= param %>
	<font color="red" size="+5">TEMPORARY!!!</font>
	<h1>Create a community.</h1>
	<form action="community_create.jsp"  enctype="multipart/form-data" method="post">
	<table border="1">
	<tr>
		<td>NAME:</td>
		<td><input type="text" name="cname" size="22" maxlength="20" /></td>
	</tr>
	<tr>
		<td>DESCRIPTION:</td>
		<td><textarea name="cdescription" rows="5" cols="102" maxlength="512"></textarea>
	</tr>
	<tr>
		<td>TOP IMAGE</td>
		<td><input type="file" name="topimage" /></td>
	</tr>
	<tr>
		<td>SEND</td>
		<td><input type="submit" value="create" /></td>
	</tr>
	</table>

	<h1>to do</h1>
	<p>check the user's power authority.</p>
</body>
</html>
