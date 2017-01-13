<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="utility.ImageManager" %>
<%
Integer ret = new Integer(5000);
ImageManager img = null;
if(session.getAttribute("ID") != null) {
	ret = (Integer)session.getAttribute("ID");
	if(ret != null){
		img = new ImageManager(ret);
		ret = img.getId();
	}
}
%>


<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache" />
<META HTTP-EQUIV="Expires" CONTENT="-1" />
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8" />
<title>testpage</title>
</head>
<body>

dekita?
<%= ret %>
<%
out.println("<img src=\"uploads/images/" + img.getFileName() + "\" />");
%>

</body>
</html>