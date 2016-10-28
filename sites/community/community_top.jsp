<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="community.ComComment" %>

<%

    String community_name = "サイバー対策コンテストコミュニティー";
    String community_description = "このコミュニティーは、サイバー対策コンテストの対策として建てられたコミュニティーです。以下ダミーです。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。ほげほげふげふげひげひげはげはげふーばー。";
	String document_root = "/webpro";
	String community_img_url = document_root + "/assets/communities/001/top_image.jpg";

    ArrayList<ComComment> comments = new ArrayList<ComComment>();

    comments.add(new ComComment("これがコメントです","ほげゆーざ","2016/05/18 20:12","/assets/communities/001/top_image.jpg"));
    comments.add(new ComComment("コメント２です","はげちゅーざ","hizuke2","/assets/communities/001/top_image.jpg"));
    comments.add(new ComComment("コメント３です","hjdiska","hjfdshk","/assets/communities/001/top_image.jpg"));
%>

<html lang="ja">
<head>
	<meta charset="UTF-8" />
	<link rel="stylesheet" type="text/css" href="style.css">
	
	
	<!-- JAVASCRIPT and JQUERY -->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="jquery.textchange.min.js"></script>
	
	<style type="text/css">
	.header_image_url{
		background-image:url(<%= community_img_url %>);
	}
	</style>
	
<%
    out.print("<title>" + community_name + "のコミュニティーページ</title>");
%>

</head>
<body>

	<div id="base_ground">
		<header>
			<div id="header_image" class="header_image_url"></div>
			<h1><%= community_name %></h1>
			<p id="header_description"><%= community_description %></p>
		</header>
		
		<div id="contents_table">
			<div id="contents_base">

			<div id="talkarea">
				<div id="talkarea_margin">
					<form action="community_top.jsp" method="post" name="talk">
						<textarea rows="5" cols="20" name="talk_message" id="tkf1" placeholder="発言メッセージ" maxlength="512" ></textarea>
						<table id="talkarea_table"><tr><td width="100%">残り文字数は<span id="countdown">512</span>文字です</td>
						<td><input type="button" value="発言" name="talk_on" id="tkf2" disabled></td></tr></table>
					</form>
					
					<!-- Countdown jQuery-->
					<script type="text/javascript">
						$('#tkf1').bind('textchange', function (event, previousText) {
							var lgth = parseInt($(this).val().length);
							$('#countdown').html( 512 - lgth );
							if( lgth > 0 && lgth <= 512) $('#tkf2').prop("disabled", false);
							else $('#tkf2').prop("disabled", true);
						});
					</script>
	
				</div>
			</div>
			
			

<%
    for(ComComment p : comments){
        out.println("<div class=\"talk\">");
        out.println("<div class=\"image\">");
        out.println("<img src=\"" + document_root + p.getImageSrc() + "\" />");
        out.println("</div>");
        out.println("<div class=\"contents\">");
        out.println("<h2>" + p.getName() + "</h2>");
        out.println("<p>" + p.getComment() + "</p>");
        out.println("<small>" + p.getDateStr() + "</small>");
        out.println("</div>");
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

