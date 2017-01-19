<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="utility.ImageManager" %>
<%@ page import="circle.Circle" %>
<%@ page import="circle.University" %>

<%

    // リクエストパラメータの文字エンコーディング指定
    request.setCharacterEncoding("utf-8");
    
//    String str  = request.getParameter("result");
	int id = -1;
	Circle circle = null;
	ImageManager image = null;
	University univ = null;
	try{
		id = Integer.parseInt(request.getParameter("id"));
		//サークルを取得
		circle = Circle.getCircleFromId(id);
		image = new ImageManager(circle.imageid_);
		univ = University.getUniversityFromID(circle.university_id_);
	}catch(NumberFormatException e){
		response.sendRedirect("/MyApp/");
		return;
	}

%>

<html>
    <head>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
	<title>全学生の表示</title>
	
	<link rel="stylesheet" type="text/css" href="ResultCircle1Style.css">

    </head>

    <body>
    
	<%@ include file="/WEB-INF/jsp/userinfo.jsp" %>
    
	    <header>
	    	<img border="0" src="../../images/logo.png" width="600px" />
	    </header>
	    
	    <div id="body_table">
			<div id="sidebar">
			    <div id="circle_image">
					<%
					if(image.isFailed()){
					   out.println("<br><br><br><br><div style=\"text-align:center;color:#fff\">画像にエラーが発生しています</div>");
					}
					else{
						out.println("<img src=\"/MyApp/uploads/images/" + image.getFileName() + "\" width=\"100%\" />");
					}
					%>
			    </div>
			    
			    <div style="color: #fff;" >
			    	<p>Phone<br>
						<%
							if(circle.phone_ == null){
								out.println("登録されていません");
							}else{
								out.println(circle.phone_);
							}
						%>
					</p>
					<p>Mail<br>
						<%
			if(circle.mail_ == null){
			     out.println("登録されていません");
			}
			else{
			     out.println(circle.mail_);
			}
						%>
					</p>
					<p><a href="https://twitter.com/login?lang=ja" style="text-decoration: none;">Twitter Acount</a><br>
			    		<%
			    if(circle.twitter_ == null){
			       out.println("登録されていません");
			    }
			    else{
			       out.println(circle.twitter_);
			    }
			    		%>
					</p>
					<p><a href="https://ja-jp.facebook.com/login/" style="text-decoration: none;">Facebook Acount</a><br>
			    		<%
			    			if(circle.facebook_ == null){
			    			    out.println("登録されていません");
			    			}else{
								out.println(circle.facebook_);
			    			}
			    		%>
					</p>
				</div>
				
		    	<div style="color: #fff;" >Comment</div>
		    	<div class="box3-3-1">
					<marquee behavior="scroll">
		    			<%
			  if(circle.comment_ == null){
			     out.println("編集されていません");
			  }
			  else{
			     out.println(circle.comment_);
			  }
						%>
					</marquee>
				</div>
			</div>
			<div id="margin"></div>
	   		<div id="contents">
	   			<div id="circle_name">
				<h1><%= univ.name_ + " " + circle.name_ %></h1>
<%
	if(login_user.uuid_ == circle.circle_leader_id_) out.println("<p><a href=\"#\">サークル情報を変更する</a>　｜　<a href=\"#\">サークルメンバーを招待する</a>　｜　<a href=\"#\">Twitterで広報する</a></p>");
%>
				</div>
				<div class="box4-1-1">
					<%
			  if(circle.file_ == null){
			     out.println("編集されていません。サークル編集ページで編集してください");
			  }
			  else{
			     out.println(circle.file_);
			  }
			  		%>
		     	</div>
			</div>
    	</div>
	
	
	<footer>
	
		<a href="Kensaku8.jsp">検索へ戻る</a> | <a href="/MyApp/">トップへ戻る</a>
	
	</footer>
	
</body>

</html>

