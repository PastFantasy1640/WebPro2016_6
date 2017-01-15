<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %>

<%
request.setCharacterEncoding("utf-8");
// JDBC ドライバのロード
Class.forName("org.gjt.mm.mysql.Driver");
// データベースとの結合
Connection db = DriverManager.getConnection("jdbc:mysql://localhost/webpro_db?user=root&password=Imakiti838&useUnicode=true&characterEncoding=utf-8");

Statement st11 = db.createStatement();

String query11 = "select * from prefectures";

ResultSet rs11 = st11.executeQuery(query11);

Statement st12 = db.createStatement();

String query12 = "select * from universities";

ResultSet rs12 = st12.executeQuery(query12);

Statement st13 = db.createStatement();

String query13 = "select * from categories";

ResultSet rs13 = st13.executeQuery(query13);

Statement st14 = db.createStatement();

String query14 = "select *  from circles";

ResultSet rs14 = st14.executeQuery(query14);


%>

<html>
    <head>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
	<title>全学生の表示</title>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	
	<script>
	 



	 function Handler1()
	 {
	     var a = [];
	     var b = [];
	     var c = [];
	     var val    = document.Form1.initial.value;
	     var target = document.getElementById("output1");
	     var mozi= '';
	     var bool = false;
	     
	     <%
	     rs12.beforeFirst();
	     while(rs12.next()) {
	     %>
	     a.push('<%= rs12.getString("name1") %>');
	     b.push('<%= rs12.getString("name") %>');
	     c.push('<%= rs12.getString("id") %>');
     <%
     }
     %>

	     
	     if(val == -1){
     		 
		 mozi = '<select><option value = -2>指定してください</option></select>';
		 
		 target.innerHTML = mozi;
		 
		 return true;
	     }
	     
	     
	     mozi = "<select>";
	     
	     for(i = 0; i < a.length; i++){
		 if(~a[i].indexOf(val)){
		     bool = true;
		     mozi += "<option value="+c[i]+">"+b[i]+"</option>";
		 }
	     }

	     if(bool == false){
		 mozi += "<option value = -3>見つからない</option>";
	     }

	     mozi += "</select>";
	     
	     target.innerHTML = mozi;

	     
	 }

	 function Handler2()
         {
             var a = [];
             var val    = document.searchCircle.CircleName.value;
             var target = document.getElementById("output2");
	     var rect = target.getBoundingClientRect();
	     var positionX = rect.left + window.pageXOffset ;	// 要素のX座標
	     var positionY = rect.top + window.pageYOffset ;	// 要素のY座標
             <%
	     rs14.beforeFirst();
             while(rs14.next()) {
             %>
             a.push('<%= rs14.getString("name") %>');
	     <%
	     }
	     %>


             var mozi = '';

             mozi = '<select name="result">';
	     
	     if(val != ''){
		 for(i = 0; i < a.length; i++){
                     if(~a[i].indexOf(val)){
			 mozi += '<option>'+a[i]+"</option>";
                     }
		 }
	     }

             mozi += "</select>";
	     

             target.innerHTML = mozi;
	     
	     document.searchCircle.CircleName.value = '';

	     window.scrollTo(0,positionY) ;

         }

	 function Handler3(){
	     var a = [];
	     var b = [];
	     var c = [];
	     var d = [];
	     
             var val    = document.searchUniversity.UniversityName.value;
             var target = document.getElementById("output2");
             var rect = target.getBoundingClientRect();
             var positionX = rect.left + window.pageXOffset ;   // 要素のX座標
             var positionY = rect.top + window.pageYOffset ;    // 要素のY座標
             <%
	     rs12.beforeFirst();
             while(rs12.next()) {
             %>
             a.push('<%= rs12.getString("name") %>');
	     b.push('<%= rs12.getString("id") %>');
             <%
             }
             %>

	     <%
	     rs14.beforeFirst();
             while(rs14.next()) {
             %>
             c.push('<%= rs14.getString("name") %>');
             d.push('<%= rs14.getString("university_id") %>');
             <%
             }
             %>
	     

	     var id_result = [];
	     
	     //id_resultには大学名が部分一致したidが入っている
	     
             if(val != ''){
		 for(i = 0; i < a.length; i++){
                     if(~a[i].indexOf(val)){
			 id_result.push(b[i]);
                     }
		 }
             }


	     var mozi = '';


	     mozi = '<select name="result">';

	     //dにはカテゴリーサークルの中のuniversity_idが入っている
	     
	     alert(d[0]);
	     alert(id_result);
	     
	     for(i = 0; i < c.length; i++){
		 for(j = 0; j < id_result.length; j++){
		     if(d[i] == id_result[j]){
			 mozi += "<option>"+a[d[i]-1]+c[i]+"</option>";
			 break;
		     }
		 }
	     }

	     
	     mozi += "</select>";



             target.innerHTML = mozi;

             document.searchUniversity.UniversityName.value = '';

             window.scrollTo(0,positionY) ;


	 }

	 function Handler4(){

	     
	     var stack1 = [];
	     var activearea = null;
	     var collegeid = null;

	     var CirclesId = [];
	     var CirclesName = [];
	     var CirclesCategory_id = [];
	     var CirclesUniversity_id = [];
	     var UniversityName = [];
	     var UniversitiesId = [];
	     var UniversitiesPrefecture_id = [];

	     var id_result = [];
	     var id_result1 = [];

	     var target = document.getElementById("output2");
	     
	     
	     for(i=0; i < document.nform.category.length; i++){

                 if(document.nform.category[i].checked){
		     stack1.push(document.nform.category[i].value);
                 }
             }

	     activearea = document.sform.prefec.value;
	     
	     collegeid = document.Form1.result.value;


	     if(activearea == -1)
		 activearea = null;

	     if(collegeid == -2 || collegeid == -3)
		 collegeid = null;
	     
	     <%
	     rs14.beforeFirst();
             while(rs14.next()) {
             %>
	     CirclesId.push('<%= rs14.getString("id")%>');
             CirclesName.push('<%= rs14.getString("name") %>');
             CirclesCategory_id.push('<%= rs14.getString("category_id") %>');
	     CirclesUniversity_id.push('<%= rs14.getString("university_id") %>');
             <%
             }
             %>

             <%
	     rs12.beforeFirst();
             while(rs12.next()) {
             %>
	     UniversityName.push('<%= rs12.getString("name") %>');
             UniversitiesId.push('<%= rs12.getString("id") %>');
             UniversitiesPrefecture_id.push('<%= rs12.getString("prefecture_id") %>');
             <%
             }
             %>


	     var mozi = '';

	     mozi = '<select name="result">';

	     
	     if(collegeid != null){
		 for(i = 0; i < CirclesName.length; i++){
		     if(CirclesUniversity_id == collegeid){
			 if(stack1 != ''){
			     if(~stack1.indexOf(CirclesCategory_id[i])){
				 mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[collegeid-1]+CirclesName[i]+'</option>';
			     }
			 }
			 else{
                             mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[collegeid-1]+CirclesName[i]+'</option>';
			 }
			 
		     }
		 }
	     }
	     else{

		 if(activearea != null){

		     for(i = 0; i < UniversitiesPrefecture_id.length; i++){
			 if(UniversitiesPrefecture_id[i] == activearea){
			     id_result1.push(UniversitiesId[i]);
			 }
                     }

		     alert(stack1);

		     if(stack1 != ''){
			 for(i = 0; i < CirclesName.length; i++){
			     if(~id_result1.indexOf(CirclesUniversity_id[i])){
				 if(~stack1.indexOf(CirclesCategory_id[i])){
				     alert("hoge");
				     mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[CirclesUniversity_id[i]-1]+CirclesName[i]+'</option>';
				 }
			     }
			 }
		     }
		     else{

			 for(i = 0; i < CirclesName.length; i++){
                             if(~id_result1.indexOf(CirclesUniversity_id[i])){
                                 alert("hoge");
                                 mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[CirclesUniversity_id[i]-1]+CirclesName[i]+'</option>';
                             }
                         }
			 
		     }

                 }else{


		     if(stack1 != ''){
			 for(i = 0; i < CirclesName.length; i++){
                             if(~stack1.indexOf(CirclesCategory_id[i])){
				 mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[CirclesUniversity_id[i]-1]+CirclesName[i]+'</option>';
                             }
			 }
		     }
		     else{
			 mozi += "<option>検索条件を指定してください</optrion>";
		     }

		     
                 }

	     }

	     mozi += '</select>';

	     target.innerHTML = mozi;

	 }

	 



	 function submitStop(e){
	     if(!e) var e = window.event;

	     if(e.keyCode == 13)
		 return false;
	 }

	 function chBxOff(){

	     var target = document.getElementById("output1");
	     
	     for(var i=0; i<document.nform.category.length;i++){
		 if(document.nform.category[i].checked){
		     document.nform.category[i].checked = false;
		 }
	     }

	     document.sform.prefec.value=-1;

	     document.Form1.initial.value=-1;

	     var mozi = '';


	     mozi = '<select><option value=-2>指定しろ</option></select>';

	     target.innerHTML = mozi;

	 }
	 
	 
	 
	</script>

	<style type="text/css">

	 .box1 {
	     border: 1px solid #fff;  
	     margin: 0 auto;
	     padding: 4px;
	     background-color: #b2946c;
	     width: 1000px;
	     height: 1000px;
	 }

	 .box2 {
	     background-color: #fff;
	     margin: 0 auto;
	     position: absolute;
	     width: 1000px;
	     height: 970px;
	 }

	 .box3 {
	     position: absolute;
	     height: 100px;
	     width: 1000px;
	 }
	 
	 .box4 {
	     position: absolute;
	     width: 500px;
	     height: 100px;
	 }

	 .box5 {
	     position: absolute;
	     left: 500px;
	     width: 500px;
	     height: 100px;
	     
	 }

	 .box6{
	     border: solid 1px #fff;
	     position: absolute;
	     top: 100px;
	     height: 600px;
	     width: 996px;
	 }

	 .box12{
	     border: solid 1px #fff;
             position: absolute;
             top: 700px;
             height: 270px;
             width: 996px;
	 }

	 .box7{
	     background-color: #fff;
	     position: absolute;
	     height: 300px;
	     width: 992px;
	 }

	 .box8 {
	     background-color: #fff;
	     position: absolute;
	     top: 300px;
	     height: 200px;
	     width: 992px;
	 }

	 .box9 {
	     background-color: #fff;
	     position: absolute;
	     height: 200px;
	     width: 496px;
	 }

	 .box10{
	     background-color: #fff;
	     position: absolute;
	     left: 496px;
	     height: 200px;
	     width: 496px;
	 }

	 .box11 {
	     background-color: #fff;
	     position: absolute;
	     top: 500px;
	     height: 100px;
	     width: 992px;
	 }

	 .font1 {
	     color: #fff;
	 }

	 .font2 {
	     color: #0099cc;
	 }

	 .table-ul {
	     display: table;
	     table-layout: fixed;
	     width: 100%
	 }

	 .table-ul li{
	     font-size: 60%;
	     display: table-cell;
	     vertical-align: middle;
	 }
	 

	</style>
	
    </head>
    <body>
	<div class = "box1">
	    <div class = "font1">
		サークル/団体検索
	    </div>
	    <div class = "box2">
		<div class = "box3">
		    <div class = "box4">
			<div class = "font2">
			    サークル名から探す
			</div>

			<form name="searchCircle">
			    <div style="text-align: center; padding: 10px">
				<input type="text" name="CircleName" onKeyPress="return submitStop(event);">
				<input type="button" value="検索する" onclick="Handler2()">
			    </div>
			</form>
		    </div>
		    <div class = "box5">
			<div class = "font2">
			    大学名から探す
			</div>
			<form name="searchUniversity">
			    <div style="text-align: center; padding: 10px">
				<input type="text" name="UniversityName" onKeyPress="return submitStop(event);">
				<input type="button" value="検索する" onclick="Handler3()">
			    </div>
			</form>
		    </div>
		</div>
		<div class="box6">
		    <div class="box7">
			<div class="font2">カテゴリから探す</div>
			<%
			int i=0;
			int k=0;
			rs13.beforeFirst();
			while(rs13.next()){
			    if(i == 0){
				k++;
			%>
			<form name="nform">
			    <ul class="table-ul">
				
<%
}
%>
<li><input type="checkbox"  name="category"   value=<%=rs13.getString("id")%>><%= rs13.getString("name") %></li>
<%
if(i == 5){
    if(k == 5){
	break;
    }
%>
			    </ul>
			    <%
			    i = 0;
			    
			    continue;

			    }
			    
			    i++;
			    }
			    
			    
			    %>
			    </ul>

			    <ul class="table-ul">
				<%
				while(rs13.next()){
				%>
				<li><input type="checkbox" name="category"   value=<%=rs13.getString("id")%>><%= rs13.getString("name") %></li>
				
		    <%
		    }
		    %>
		    <li></li><li></li><li></li><li></li>
			    </ul>
			    
			</form>
		    </div>
		    <div class = "box8">
			<div class = "box9">
			    <div class="font2">活動地域から探す</div>
			    <div style="text-align: center; margin-top:60px">
				<p>
				    <form name="sform">
					<select name="prefec">
					    <option value="-1">指定しない</option>
					    <%
					    rs11.beforeFirst();
					    while(rs11.next()) {
					    %>
					    <option value=<%= rs11.getString("id")%>><%= rs11.getString("name") %></option>
     <%
     }
     %>
     
     
					</select>
				    </form>
				</p>
			    </div>
			</div>
			<div class = "box10">
			    <div class="font2">大学名から探す</div>
			    <div style="text-align: center; margin-top:50px">
				<form name="Form1">
				    <select name="initial" onChange="Handler1()">
					<option value="-1">頭文字</option>
					<option value="あ">あ</option>
					<option value="い">い</option>
					<option value="う">う</option>
					<option value="え">え</option>
					<option value="お">お</option>
					<option value="か">か</option>
					<option value="き">き</option>
					<option value="く">く</option>
					<option value="け">け</option>
					<option value="こ">こ</option>
					<option value="さ">さ</option>
					<option value="し">し</option>
					<option value="せ">せ</option>
					<option value="そ">そ</option>
					<option value="た">た</option>
					<option value="ち">ち</option>
					<option value="つ">つ</option>
					<option value="て">て</option>
					<option value="と">と</option>
					<option value="な">な</option>
					<option value="に">に</option>
					<option value="ひ">ひ</option>
					<option value="ふ">ふ</option>
					<option value="ほ">ほ</option>
					<option value="み">み</option>
					<option value="む">む</option>
					<option value="め">め</option>
					<option value="も">も</option>
					<option value="よ">よ</option>
					<option value="り">り</option>
					<option value="わ">わ</option>
				    </select>
				    <select style="width:200px;height:40px;" id="output1" name="result">
					<option value="-1">指定してください</option>
				    </select>
				</form>
			    </div>
			</div>
		    </div>
		    <div class="box11">
			<div style="text-align: center; margin-top: 40px">
			    <input type="button" value="この条件で検索" onclick="Handler4()">
			    <input type="button" value="条件をクリア" onclick="chBxOff()">
			</div>
		    </div>
		</div>
		<div class="box12">
		    <h1 style="text-align: center;">検索結果はこちら</h1>
		    <div style="text-align:center">
			<form action = ResultCircle.jsp>
			    <select name="result" style="width:400px;height:40px; margin-top:40px" id="output2">
				<option value="指定" >検索ボタンをおしてね!</option>
			    </select>
			    <input type="submit" value="このサークル紹介に行く" >
			</form>
		    </div>
		</div>
	    </div>
	</div>
	<%
	rs11.close();
        st11.close();
	rs12.close();
        st12.close();
	rs13.close();
        st14.close();
	rs14.close();
	%>

    </body>
</html>


B
