<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.ArrayList" %>
<%-- @ page import="community.ComComment" --%>

<%

    String community_name = "サイバー対策コンテストコミュニティー";
    String community_description = "このコミュニティーは、サイバー対策コンテストの対策として建てられたコミュニティーです。以下ダミーです。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。";

	ArrayList comments = new ArrayList();
	//java.util.ArrayList<community.ComComment> comments = new java.util.ArrayList<>();
	community.ComCommunity("","","","");
	//comments.add(new community.ComComment("これがコメントです","ほげゆーざ","2016/05/18 20:12",""));
	comments.add("hoge");
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
				<!-- 参加者のコメント -->
				<div class="talk">
					<h2>東大　サイバー研</h2>
					<p>これが発言の表示サンプルです。</p>
					<small>2016/10/24  11:28:03</small>
				</div>
			</div>
			
			<div id="sidebar_base">
				<!-- 参加するボタン、広告、ほかのコミュニティー -->
			</div>
		</div>
	</div>


</body>
</html>

