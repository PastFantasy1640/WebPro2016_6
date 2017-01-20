<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="utility.ImageManager" %>
<%
session.setAttribute("ID",0);
session.setAttribute("url","result_test.jsp");
%>


<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache" />
<META HTTP-EQUIV="Expires" CONTENT="-1" />
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8" />
<title>testpage</title>
</head>
<body>

<form action=/MyApp/imguploader enctype=multipart/form-data method=post>
<h1>サークル画像<br></h1>
<input type=file name=image size=30>
<input type="submit" name=button value="送信">
</form>

</body>
</html>
