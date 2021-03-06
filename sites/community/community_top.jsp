<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="community.ComComment" %>
<%@ page import="community.Community" %>
<%@ page import="utility.ImageManager" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="user.User" %>

<%

	//文字セット
	response.setContentType("text/html;charset=UTF-8");
 	request.setCharacterEncoding("UTF-8");

	//コミュニティー取得
	int community_id = -1;
	Community community = null;
	try{
    	community_id = Integer.parseInt(request.getParameter("id"));
    	community = Community.getCommunityFromID(community_id);
    }catch(NumberFormatException e){}
    if(community == null) community_id = -1;
    
    if(community_id < 0){
    	response.sendRedirect("/MyApp/sites/community/community_list.jsp");
    	return;
    //	application.getRequestDispatcher("/MyApp/sites/community/community_list.jsp").forward(request,response);
    }
    
    User login_user = User.getLoginUser(session);
    if(login_user == null){
    		response.sendRedirect("/MyApp/");
    		return;
	}
    int user_id = login_user.uuid_;

	//セッションをチェック
	//F5対策
	String ncomment = request.getParameter("talk_message");
	String last_comment = (String)session.getAttribute("last_comment");
	String error_msg = new String("");
	if(last_comment == null) last_comment = new String("");
	Integer add_community_id = null;
	try{
		add_community_id = (Integer)session.getAttribute("community_id");
	}catch(ClassCastException e){}
	session.setAttribute("community_id", community_id);
	
	
	if(ncomment != null && add_community_id != null && add_community_id >= 0){
		if(!last_comment.equals(ncomment)){
			if(ncomment.length() > 0 && ncomment.length() < 512){
				//submit comment
				ComComment.addComment(add_community_id, user_id, ncomment);
			}else error_msg = "文字数が512文字を超過しています。";
			session.setAttribute("last_comment", ncomment);
		}else{
			error_msg = "同じコメントでの発言はできません。";
		}
	}





	//コミュニティー情報代入
    String community_name = community.name;
    String community_description = community.description;
    ImageManager img = new ImageManager(community.image_id);
    String community_img_url = "/MyApp/uploads/images/" + img.url_;
    
    ImageManager community_image = new ImageManager(community.image_id);
    community_img_url = "/MyApp/uploads/images/" + community_image.getFileName();

	//ユーザー制御
    boolean user_allow_talk = true;


    ArrayList<ComComment> comments = ComComment.getCommentsFromCommunity(community_id);
    java.util.Collections.reverse(comments);

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

	//エラーメッセージ
	if(!error_msg.equals("")){
		out.print("<script>alert(\"" + error_msg + "\");</script>");
	}

%>

</head>
<body>
	<%@ include file="/WEB-INF/jsp/userinfo.jsp" %>
	<div id="base_ground">
		<header>
			<div id="header_image" class="header_image_url"></div>
			<h1><%= community_name %></h1>
			<p id="header_description"><%= community_description %></p>
			<p><a href="community_list.jsp">Return to community list page.</a></p>
		</header>
		
		<div id="header_contents_margin"></div>
		<div id="contents_table">
			<div id="contents_base">

			
			<%-- ########################## Talk Area Jsp ############################ --%>

			<%
			
			if(user_allow_talk){
			
			%>
			
			<div id="talkarea">
				<div id="talkarea_margin">
					<form action="community_top.jsp?id=<%= community_id %>" method="post" accept-charset="utf-8">
						<textarea rows="5" cols="20" name="talk_message" id="tkf1" placeholder="発言メッセージ" maxlength="512" ></textarea>
						<table id="talkarea_table"><tr><td width="100%">残り文字数は<span id="countdown">512</span>文字です。<br /></td>
						<td><input type="submit" value="発言" name="talk_on" id="tkf2" disabled></td></tr></table>
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
			
			}
			
			%>

			<%-- ####################### end of Talk Area############################ --%>

<%
    for(ComComment p : comments){
        out.println("<div class=\"talk\">");
        out.println("<div class=\"image\">");
        out.println("<img src=\"/MyApp/uploads/images/" + p.getImageSrc() + "\" />");
        out.println("</div>");
        out.println("<div class=\"contents\">");
        out.println("<h2>" + p.getName() + "</h2>");
        out.println("<p>" + p.getComment() + "</p>");
        out.println("<small>" + p.getDateStr() + "</small>");
        out.println("</div>");
        out.println("</div>");
    }
%>

			</div>
			
			<div id="sidebar_base">
				<!-- 参加するボタン、広告、ほかのコミュニティー -->
				
				<div class="joincom">
					<p>このコミュニティーに参加して意見を交換しましょう！</p>
					<form action="community_join.jsp" method="post" name="talk">
						<button id="join_button" type="join">参加</button>
					</form>
					<small>※コミュニティーには、サークルの代表者のみが参加できます。コミュニティーについて、詳しくは<a href="#">こちら</a>をご覧ください。</small>
				</div>
				
				<p class="sidemenu">参加団体一覧</p>
				
				<p>このコミュニティーに参加している団体は以下のとおりです。</p>
				
				
			</div>
		</div>
	</div>


</body>
</html>

