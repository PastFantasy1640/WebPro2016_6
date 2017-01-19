<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="utility.DatabaseConnector" %>
<%@ page import="circle.Prefecture" %>
<%@ page import="circle.University" %>
<%@ page import="circle.Category" %>
<%@ page import="circle.Circle" %>
<%@ page import="java.util.ArrayList" %>

<%
request.setCharacterEncoding("utf-8");

	ArrayList<Prefecture> prefs = Prefecture.getPrefectures();
	ArrayList<University> univs = University.getUniversities();
	ArrayList<Category> categs = Category.getCategories();
	ArrayList<Circle> circles = Circle.getCircles();

%>

<html>
    <head>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
	<title>全学生の表示</title>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	
	<script>

         function IdSearch(val1, val2){
                  var i;
                  for(i = 0; i < val2.length; i++){
                        if(val2[i] == val1)
                               return i;
                  }
         }

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
	     for(University uv : univs){
	     	out.println("a.push(\'" + uv.name1_ + "\');");
	     	out.println("b.push(\'" + uv.name_ + "\');");
	     	out.println("c.push(\'" + uv.id_ + "\');");
	     }
	     %>

	     if(val == -1){

		 mozi = '<select><option value = -1>指定してください</option></select>';
		 
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
		 mozi += "<option value = -1>見つからない</option>";
	     }

	     mozi += "</select>";
	     
	     target.innerHTML = mozi;

	     
	 }

	 function Handler2()
         {
	     var a = [];
	     var b = [];
	     var c = [];
	     var d = [];
	     var e = [];
             var val    = document.searchCircle.CircleName.value;
             var target = document.getElementById("output2");
	     var rect = target.getBoundingClientRect();
	     var positionX = rect.left + window.pageXOffset ;	// 要素のX座標
	     var positionY = rect.top + window.pageYOffset ;	// 要素のY座標

		<%
		for(Circle cs : circles){
			out.println("a.push(\'" + cs.name_ + "\');");
			out.println("b.push(\'" + cs.university_id_ + "\');");
			out.println("d.push(\'" + cs.id_ + "\');");
		}

		for(University uv : univs){
			out.println("c.push(\'" + uv.name_ + "\');");
			out.println("e.push(\'" + uv.id_ + "\');");
		}
		
		%>
             var mozi = '';

             mozi = '<select name="result">';

	     if(val != ''){
		 for(i = 0; i < a.length; i++){
                     if(~a[i].indexOf(val)){
			 mozi += '<option value="'+d[i]+'">'+c[IdSearch(b[i],e)]+a[i]+'</option>';
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
	    var e = [];

        var val    = document.searchUniversity.UniversityName.value;	
        var target = document.getElementById("output2");
        var rect = target.getBoundingClientRect();
        var positionX = rect.left + window.pageXOffset ;   // 要素のX座標
        var positionY = rect.top + window.pageYOffset ;    // 要素のY座標
        <%
		for(University uv : univs){
			out.println("a.push(\'" + uv.name_ + "\');");
			out.println("b.push(\'" + uv.id_ + "\');");
		}

		for(Circle cs : circles){
			out.println("c.push(\'" + cs.name_ + "\');");
			out.println("d.push(\'" + cs.university_id_ + "\');");
			out.println("e.push(\'" + cs.id_ + "\');");
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
	     
	     for(i = 0; i < c.length; i++){
		 for(j = 0; j < id_result.length; j++){
		     if(d[i] == id_result[j]){
			 mozi += '<option value="'+e[i]+'">'+a[IdSearch(d[i],b)]+c[i]+"</option>";
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

	     if(collegeid == -1)
		 collegeid = null;
	    
	    <%
	    for(University uv : univs){
			out.println("UniversityName.push(\'" + uv.name_ + "\');");
			out.println("UniversitiesId.push(\'" + uv.id_ + "\');");
			out.println("UniversitiesPrefecture_id.push(\'" + uv.prefecture_id_ + "\');");
		}

		for(Circle cs : circles){
			out.println("CirclesId.push(\'" + cs.id_ + "\');");
			out.println("CirclesName.push(\'" + cs.name_ + "\');");
			out.println("CirclesCategory_id.push(\'" + cs.category_id_ + "\');");
			out.println("CirclesUniversity_id.push(\'" + cs.university_id_ + "\');");
		}
	    %>


	     var mozi = '';

	     mozi = '<select name="result">';

	     
	     if(collegeid != null){
		 for(i = 0; i < CirclesName.length; i++){
		     if(CirclesUniversity_id[i] == collegeid){
			 if(stack1 != ''){
			     if(~stack1.indexOf(CirclesCategory_id[i])){
				 mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[IdSearch(collegeid,UniversitiesId)]+CirclesName[i]+'</option>';
			     }
			 }
			 else{
                             mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[IdSearch(collegeid,UniversitiesId)]+CirclesName[i]+'</option>';
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


		     if(stack1 != ''){
			 for(i = 0; i < CirclesName.length; i++){
			     if(~id_result1.indexOf(CirclesUniversity_id[i])){
				 if(~stack1.indexOf(CirclesCategory_id[i])){
				     mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[IdSearch(CirclesUniversity_id[i],UniversitiesId)]+CirclesName[i]+'</option>';
				 }
			     }
			 }
		     }
		     else{

			 for(i = 0; i < CirclesName.length; i++){
                             if(~id_result1.indexOf(CirclesUniversity_id[i])){
                                 mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[IdSearch(CirclesUniversity_id[i],UniversitiesId)]+CirclesName[i]+'</option>';
                             }
                         }
			 
		     }

                 }else{


		     if(stack1 != ''){
			 for(i = 0; i < CirclesName.length; i++){
                             if(~stack1.indexOf(CirclesCategory_id[i])){
				 mozi += '<option value="'+CirclesId[i]+'">'+UniversityName[IdSearch(CirclesUniversity_id[i],UniversitiesId)]+CirclesName[i]+'</option>';
                             }
			 }
		     }
		     else{
			 mozi += '<option value="-1">検索条件を指定してください</option>';
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


	     mozi = '<select><option value=-1>指定しろ</option></select>';

	     target.innerHTML = mozi;

	 }
	 
	 
	 
	</script>

	<link rel="stylesheet" type="text/css" href="Kensaku8Style.css">

    </head>
    <body>

	<div id="top_frame">
	    <div class="table-ul2"><img border="0" src="../../images/logo.png" width="600px" /></div>
	    
	</div>
	<div id="under_frame">
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
			    for(Category cg : categs){
				if(i == 0){
				    k++;
			    %>
			    <form name="nform">
				<ul class="table-ul">
				    
<%
}
%>
<li><input type="checkbox"  name="category"   value=<%= cg.id_ %>><%= cg.name_ %></li>
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

	    <!--
	    <ul class="table-ul">
		<%
		for(Category cg : categs){
		%>
		<li><input type="checkbox" name="category"   value=<%= cg.id_ %>><%= cg.name_ %></li>
		
		    <%
		    }
		    %>
		    <li></li><li></li><li></li><li></li>
	    </ul>
	    -->
	    
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
						for(Prefecture pr : prefs) {
						%>
						<option value=<%= pr.id_ %>><%= pr.name_ %></option>
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
					    <option value="す">す</option>
					    <option value="せ">せ</option>
					    <option value="そ">そ</option>
					    <option value="た">た</option>
					    <option value="ち">ち</option>
					    <option value="つ">つ</option>
					    <option value="て">て</option>
					    <option value="と">と</option>
					    <option value="な">な</option>
					    <option value="に">に</option>
					    <option value="ぬ">ぬ</option>
					    <option value="ね">ね</option>
					    <option value="の">の</option>
					    <option value="は">は</option>
					    <option value="ひ">ひ</option>
					    <option value="ふ">ふ</option>
					    <option value="へ">へ</option>
					    <option value="ほ">ほ</option>
					    <option value="ま">ま</option>
					    <option value="み">み</option>
					    <option value="む">む</option>
					    <option value="め">め</option>
					    <option value="も">も</option>
					    <option value="や">や</option>
					    <option value="ゆ">ゆ</option>
					    <option value="よ">よ</option>
					    <option value="ら">ら</option>
					    <option value="り">り</option>
					    <option value="る">る</option>
					    <option value="れ">れ</option>
					    <option value="ろ">ろ</option>
					    <option value="わ">わ</option>
					    <option value="を">を</option>
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
			<h1 style="text-align: center; color: #0099cc;">検索結果はこちら</h1>
			<div style="text-align:center">
			    <form action="ResultCircle1.jsp" method="get">
				<select name="id" style="width:400px;height:40px; margin-top:40px" id="output2">
				    <option value="-1" >検索ボタンをおしてね!</option>
				</select>
				<input type="submit" value="このサークル紹介に行く" >
			    </form>
			</div>
		    </div>
		</div>
	    </div>
	</div>

    </body>
</html>


