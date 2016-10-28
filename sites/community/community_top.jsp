<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="community.ComComment" %>

<%

    String community_name = "サイバー対策コンテストコミュニティー";
    String community_description = "このコミュニティーは、サイバー対策コンテストの対策として建てられたコミュニティーです。以下ダミーです。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。";

    ArrayList<ComComment> comments = new ArrayList<ComComment>();

    comments.add(new ComComment("これがコメントです","ほげゆーざ","2016/05/18 20:12",""));
    comments.add(new ComComment("コメント２です","はげちゅーざ","hizuke2",""));
    comments.add(new ComComment("コメント３です","hjdiska","hjfdshk",""));
%>

<html lang="ja">
<head>
	<meta charset="UTF-8" />
	<link rel="stylesheet" type="text/css" href="style.css">
<%
    out.print("<title>" + community_name + "のコミュニティーページ</title>");
%>

</head>
<body>

	<div id="base_ground">
		<header>
			<div id="header_image"></div>
			<h1><%= community_name %></h1>
			<p id="header_description"><%= community_description %></p>
		</header>
		
		<div id="contents_table">
			<div id="contents_base">

<%
    for(ComComment p : comments){
	out.println("<div class=\"talk\">");
	out.println("<h2>" + p.getName() + "</h2>");
	out.println("<p>" + p.getComment() + "</p>");
	out.println("<small>" + p.getDateStr() + "</small>");
	out.println("</div>");
    }
%>

				<!-- 参加者のコメント -->
				<div class="talk">
					<div class="image">
						<img src="../../assets/communities/001/top_image.jpg" />
					</div>
					<div class="contents">
						<h2>東大　サイバー研</h2>
						<small>2016/10/24  11:28:03</small>
						<p>これが発言の表示サンプルです</p>
					</div>
				</div>
			</div>
			
			<div id="sidebar_base">
				<!-- 参加するボタン、広告、ほかのコミュニティー -->
			</div>
		</div>
	</div>


</body>
</html>

