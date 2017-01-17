<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<%@ page import="circle.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>

<%
	ArrayList<Circle> circles = Circle.getCircles();
	
	Collections.reverse(circles);

%>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf-8">
	<meta name="description" content="全国の大学サークルによるコミュニティーサイト。">
	<meta name="copyright" content="&copy; WebPro2016 Group6">
	<title>Circle Triangle</title>
	<link rel="stylesheet" href="/MyApp/css/indexstyle.css" />
	<link rel="stylesheet" href="/MyApp/css/contentsstyle.css" />
	<!--<link href="https://fonts.googleapis.com/css?family=Lato:300,700" rel="stylesheet">-->
	
	
</head>
<body>

<%@ include file="/WEB-INF/jsp/userinfo.jsp" %>

<!-- header : using style sheet = indexstyle.css -->
<header>

	<div id="title_center">
		<img src="images/logo.png" />
		<p id="description">全国の大学サークルによるコミュニティーサイト</p>
		<div id="circle_ex">
<%
			
			for(int i = 0;i < 3 && i < circles.size(); i++){
				Circle cs = circles.get(i);
				University uv = University.getUniversityFromID(cs.university_id_);
				Prefecture pr = Prefecture.getPrefectureFromID(uv.prefecture_id_);
%>
		
			<div class="circle_tbcell">
				<div class="circle_area">
					<div class="image_area">
						<img src="images/background01.jpg" />
					</div>
					<p class="title"><a href="/MyApp/sites/circle/ResultCircle1.jsp?id=<%= cs.id_ %>"><%= cs.name_ %></a></p>
					<p class="univ"><small><%= pr.name_ %>　<%= uv.name_ %></small></p>
					<p class="comment"><%= cs.comment_ %></p>
				</div>
			</div>

<%
			}
%>

		</div>
		<div id="search_circle">
			<p>あなたにぴったりなサークルを</p>
			<div id="search_button">探す(unavailable)</div>
			
		</div>
	</div>

</header>
	
	<!-- body : using stylesheet =  contentsstyle.css -->
	
	<main>
	
		<article>
			<section>
				<h1>Circle Triangleって？</h1>
				<img src="images/triangle.png" align="right" width="500px" />
				<p>Circle Triangleの説明文をここに書きます。正直つらつらと書いてもいいけど、あくまでもサイト設計の課題であるためここは重要ではない。今は時間がないのでそのうち書くかもしれない。というわけで以下ダミー。ほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげ</p>
			</section>
			
			<br clear="all" />
			
			<section>
				<h1>使ってみる！</h1>
				<p>Circle Triangleの使い方をここに書きます。とりあえず要約すると、<span style="font-weight:bold;color:red;">「ログインするか新規登録しろ」</span>ということを丁寧にやさしく誰もがユーザーになりたくさせるように説明を書く。ほれほれ、新規登録じゃ。というわけで以下ダミー。ほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげfffほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげ</p>
			</section>
		</article>
	</main>
	
	
	<footer>
		&copy; 2016  WebProgramming
	</footer>
	
</body>
</html>