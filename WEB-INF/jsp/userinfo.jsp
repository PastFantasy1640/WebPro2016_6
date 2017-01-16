<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="user.User" %>

<%
	User login_user = User.getLoginUser(session);
%>

<style type="text/css">

#userinfo{
	position: fixed;
	top: 20px;
	right: 20px;
	font-weight:bold;
	background-color: #CFC;
	padding: 0.5rem 1rem;
	
	font-family: 游ゴシック体, 'Yu Gothic', YuGothic, 'ヒラギノ角ゴシック Pro', 'Hiragino Kaku Gothic Pro', メイリオ, Meiryo, Osaka, 'ＭＳ Ｐゴシック', 'MS PGothic', sans-serif;
}

</style>

<div id="userinfo">
<%
	if(login_user == null) out.println("ログイン | <a href=\"/MyApp/servlet/Regist\">新規登録</a>");
	else out.println("ID:" + login_user.id_ + "さんでログイン中 | <a href=\"/MyApp/servlet/MemberTop\">メンバーページ</a>");
%>


</div>


