<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %>

<%
request.setCharacterEncoding("utf-8");
// JDBC ドライバのロード
Class.forName("org.gjt.mm.mysql.Driver");
// データベースとの結合
Connection db = DriverManager.getConnection("jdbc:mysql://localhost/webpro_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");

Statement st3 = db.createStatement();
// SQL 文を query に格納
String query3 = "select name from prefectures";
// SQL 文を実行し結果を ResultSet に格納
ResultSet rs3 = st3.executeQuery(query3);

Statement st4 = db.createStatement();

String query4 = "select name,name1 from universities";

ResultSet rs4 = st4.executeQuery(query4);

Statement st5 = db.createStatement();

String query5 = "select name from categories";

ResultSet rs5 = st5.executeQuery(query5);

Statement st6 = db.createStatement();

String query6 = "select name from circles";

ResultSet rs6 = st5.executeQuery(query6);

%>


<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>全学生の表示</title>
<script type="text/javascript">

 var a = [];
 var b = [];
 

 function Handler1()
 {
     a = [];
     b = [];
     var val    = document.Form1.initial.value;
     var target = document.getElementById("output1");
     <%
     while(rs4.next()) {
     %>
     a.push('<%= rs4.getString("name1") %>');
     b.push('<%= rs4.getString("name") %>');
     <%
     }
     %>

     var mozi = '';
     
     mozi = "<select>";
 
     for(i = 0; i < a.length; i++){
	 if(~a[i].indexOf(val)){
	     mozi += "<option>"+b[i]+"</option>";
	 }
     }	 
     mozi += "</select>";
	 
     target.innerHTML = mozi;
 }

 function OnButtonClick1()
 {
	
	

	var val    = document.Circle.GoToCircleName.value;
	var target = document.getElementById("output2");

	
	target.innerHTML = val;
	
	
 }
 
 function OnButtonClick2()
 {
	var val    = document.University.GoToUniversity.value;
	var target = document.getElementById("output2");

	<%
     	while(rs6.next()) {
     	%>		       
     	b.push('<%= rs4.getString("name") %>');
     	<%
     	 }
     	 %>	


	target.innerHTML = val;
	
	
 }
 
 
</script>

<style type="text/css">

 .box1 {
     border: 1px solid #ffffff;  
     margin: 0 auto;
     background-color: #b2946c;
     padding: 2px;
     width: 1000px;
     height: 640px;
 }

 .box2 {
     background-color: #fff;
     position: absolute;
     top: 40px;
     width: 998px;
     height: 600px;
 }

 .box3 {
     background-color: #fff;  
     position: absolute;
     height: 100px;
     width: 998px;
 }

 .box4 {
     background-color: #fff;
     position: absolute;
     height: 100px;	
     width: 499px;    
 }

 .box5 {
     background-color: #fff;
     position: absolute;
     left: 499px;
     width: 499px;
     height: 100px;
     
 }

 .box6 {
     background-color: #fff;
     position: absolute;
     left: 600px;
     width: 390px;
     height: 100px;
 }

 .box7{
     background-color: #fff;
     position: absolute;
     top: 100px;
     height: 300px;
     width: 998px;
     border-top: 1px dotted red;
     
 }

 .box8 {
     background-color: #fff;
     position: absolute;
     top: 400px;
     height: 100px;
     width: 998px;
     border-top: 1px dotted red;
 }

 .box9 {
     background-color: #fff;
     position: absolute;
     height: 100px;
     width: 499px;
 }

 .box10{
     background-color: #fff;
     position: absolute;
     left: 499px;
     height: 100px;
     width: 499px;
 }

 .box11{
     background-color: #fff;
     position: absolute;
     top: 500px;
     height: 100px;
     width: 998px;
     border-top: 1px dotted red;
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

		    <form name="Circle">
			<div style="text-align: center; padding: 10px">
			<input type="text" name="GoToCircleName">
			<input type="button" value="検索する" name="CircleButton" onClick="OnButtonClick1()">
			</div>
		    </form>
		</div>
		<div class = "box5">
		    <div class = "font2">
			大学名から探す
		    </div>
		    <form name="University">
			<div style="text-align: center; padding: 10px">
			<input type="text" name="GoToUniversity">
			<input type="button" value="検索する" name="UniversityButton" onClick="OnButtonClick2()">
			</div>
		    </form>
		</div>
		<!--
		<div class = "box6">
		    <div class = "font2">
			団体名から探す
                    </div>
                    <form action=DbJspEn2.jsp>
                        <div style="text-align: center; padding: 10px">
			    
				<input type="checkbox" name="riyu" value="1">学内
				<input type="checkbox" name="riyu" value="2">インカレ
				<input type="checkbox" name="riyu" value="3">学生団体
				<input type="checkbox" name="riyu" value="4">体育会(部活動)
				<p>
				    <input type="submit" value="送信する">
				</p>
			</div>
                    </form>
		</div>
		-->
	    </div>
	    <div class="box7">
		<div class="font2">カテゴリから探す</div>
		<!--
		<ul class="table-ul">
		    <li><input type="checkbox" name="category" value="1">fdsfjkdah</li>
		    <li><input type="checkbox" name="category" value="1">fdsfaf</li>
		    <li><input type="checkbox" name="category" value="1">dfsasfad</li>
		    <li><input type="checkbox" name="category" value="1">dsfafds</li>
		    <li><input type="checkbox" name="category" value="1">dsfa</li>
		    <li><input type="checkbox" name="category" value="1">sfa</li>
		    <li><input type="checkbox" name="category" value="1">sdfa</li>
		</ul>
                <ul class="table-ul">
                    <li><input type="checkbox" name="category" value="1">fdsfjkdah</li>
                    <li><input type="checkbox" name="category" value="1">fdsfaf</li>
                    <li><input type="checkbox" name="category" value="1">dfsasfad</li>
                    <li><input type="checkbox" name="category" value="1">dsfafds</li>
                    <li><input type="checkbox" name="category" value="1">dsfa</li>
                    <li><input type="checkbox" name="category" value="1">sfa</li>
                    <li><input type="checkbox" name="category" value="1">sdfa</li>
                </ul>
		-->


		    <%
		    int i=0;
		    int k=0;
		    while(rs5.next()){
			if(i == 0){
			    k++;
		    %>

		<ul class="table-ul">
				
<%
}
%>
                    <li><input type="checkbox" name="category"   value=<%=rs5.getString("name")%>><%= rs5.getString("name") %></li>
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
		while(rs5.next()){
                %>
		    <li><input type="checkbox" name="category"   value=<%=rs5.getString("name")%>><%= rs5.getString("name") %></li>
		    
		    <%
		    }
		    %>

		<li></li><li></li><li></li><li></li>

		</ul>
		

	    </div>
	    <div class = "box8">
		<div class = "box9">
		    <div class="font2">活動地域から探す</div>
		    <div style="text-align: center; padding:10px">
			    <select name="prefec">
				<option value="-1">指定しない</option>
				<%
				rs3 = st3.executeQuery(query3);
				while(rs3.next()) {
				%>
				<option value=<%= rs3.getString("name") %>><%= rs3.getString("name") %></option>
     <%
     }
     %>
     
     
			    </select>
		    </div>
		</div>
		<div class = "box10">
		    <div class="font2">大学名から探す</div>
		    <div style="text-align: center; padding:10px">
			<form name="Form1">
				<select name="initial" onChange="Handler1()">
				    <option value="">頭文字</option>
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
				    <option value="む">む</option>
				    <option value="め">め</option>
				    <option value="も">も</option>
				    <option value="よ">よ</option>
				    <option value="り">り</option>
				    <option value="わ">わ</option>
				</select>
				<select style="width:200px;height:30px" id="output1">
				    <option value="指定">指定しろ</option>
				</select>
			</form>
		    </div>
		</div>
	    </div>
	    <div class="box11">
	    	    <div style="text-align:center; padding:35px">
			<input type="button" value="この条件で探す" >
			<input type="button" value="この条件をクリア" >
		    </div>
	    </div>
	</div>
    </div>
    <br>
    <div id="output2">
    </div>

      <%
      rs3.close();
      st3.close();
      db.close();
      %>

	    
    
</body>
</html>


