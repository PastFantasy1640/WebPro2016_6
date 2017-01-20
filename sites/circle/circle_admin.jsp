<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="circle.University" %>
<%@ page import="circle.Category" %>
<%@ page import="circle.Prefecture" %>
<%@ page import="circle.Circle" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utility.StringUtil" %>
<%@ page import="utility.DatabaseConnector" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.Logger" %>


<html>
    <head>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
	<title>サークル管理</title>
    </head>
    <body>
	<%

    ArrayList<University> univs = University.getUniversities();
	
	ArrayList<Category> categories =  Category.getCategories();
	ArrayList<Prefecture> prefectures = Prefecture.getPrefectures();
	if(univs == null || categories == null || prefectures == null) {
		response.sendRedirect("/MyApp/index.jsp");
		return;
	}

	int circle_id = Integer.parseInt(request.getParameter("id"));
	Circle cs = Circle.getCircleFromId(circle_id);

	String circlename = StringUtil.NonNullString(request.getParameter("circlename"));
	//String type = StringUtil.NonNullString(request.getParameter("type"));
	//String prefecture = StringUtil.NonNullString(request.getParameter("prefecture"));
	//String university = StringUtil.NonNullString(request.getParameter("university"));
	String comment = StringUtil.NonNullString(request.getParameter("comment"));
	String mail = StringUtil.NonNullString(request.getParameter("mail"));
	String phone = StringUtil.NonNullString(request.getParameter("phone"));
	String twitter = StringUtil.NonNullString(request.getParameter("twitter"));
	String facebook = StringUtil.NonNullString(request.getParameter("facebook"));
	String button = "";//StringUtil.NonNullString(request.getParameter("button"));
	String file = StringUtil.NonNullString(request.getParameter("file"));
	String imageid = StringUtil.NonNullString(request.getParameter("imageid"));

	session.setAttribute("ID", cs.imageid_);
	session.setAttribute("url","/MyApp/sites/circle/ResultCircle1.jsp?id=" + Integer.toString(circle_id));

	%>

	<center>
	    <h1>サークル管理</h1><br>
	    <form action="/MyApp/imguploader" enctype="multipart/form-data" method="post">
		<h2>・サークル画像変更</h2>
		<input type=file name=image size=30>
		<input type="submit" name=button value="送信">
	    </form><br><br>

	    <h2>・サークル情報変更</h2>
	    <form action=circle_add.jsp method=post>
	    <input type="hidden" name="circleid" value="<%= circle_id %>">
		<table>
		    <tbody>
			<tr><th>サークル名</th><td>
      <% out.println(circlename); %>
			</td></tr>

	    <tr><th>一言コメント</th><td>
		<%
		out.println("<textarea name=comment rows=1 cols=30>" + comment + "</textarea>");
		%>
</textarea></td></tr>

	    <tr><th>サークル紹介</th><td>
		<%
		out.println("<textarea name=comment rows=8 cols=30>" + file + "</textarea>");
		%>
</textarea></td></tr>
	    <tr><th>メールアドレス</th><td>
	    <%
	    out.println("<input type=\"text\" value=\"" + mail + "\"name=mail size=30></h1>");
	    %>
      </td></tr>

	    <tr><th>電話番号</th><td>
	    <%
	    out.println("<input type=\"text\" value=\"" + phone + "\"name=phone size=30></h1>");
	    %>
      </td></tr>

	    <tr><th>Twitter</th><td>
	    <%
	    out.println("<input type=\"text\" value=\"" + twitter + "\"name=twitter size=30></h1>");
	    %>
      </td></tr>

	    <tr><th>facebook</th><td>
	    <%
	    out.println("<input type=\"text\" value=\"" + facebook + "\"name=facebook size=30></h1>");
	    %>
      </td></tr>
      </tbody>
      </table>
	    <br><input type="submit" name=button value="送信">
  </form>
	</center>
    </body>
</html>
