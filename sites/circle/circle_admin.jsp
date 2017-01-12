<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="circle.University" %>
<%@ page import="circle.Category" %>
<%@ page import="circle.Prefecture" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utility.StringUtil" %>
<%@ page import="utility.DatabaseConnector" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.Logger" %>
<%
	// リクエストパラメータの文字エンコーディング指定
	request.setCharacterEncoding("utf-8");


	//Connection db = DatabaseConnector.connect("chef","secret");
	
	//if(db == null) out.println("db is null");
	
	ArrayList<University> univs = University.getUniversities();
	
	if(univs == null) out.println("univ is null");
	ArrayList<Category> categories =  Category.getCategories();
	if(categories == null) out.println("categ is null");
	ArrayList<Prefecture> prefectures = Prefecture.getPrefectures();
	if(prefectures == null) out.println("pref is null");
	if(/*univs == null || */categories == null || prefectures == null) {
		//response.sendRedirect("/MyApp/index.jsp");
		return;
	}

	String circlename = StringUtil.NonNullString(request.getParameter("circlename"));
	String type = StringUtil.NonNullString(request.getParameter("type"));
	String prefecture = StringUtil.NonNullString(request.getParameter("prefecture"));
	String university = StringUtil.NonNullString(request.getParameter("university"));
	String comment = StringUtil.NonNullString(request.getParameter("comment"));
	String mail = StringUtil.NonNullString(request.getParameter("mail"));
	String phone = StringUtil.NonNullString(request.getParameter("phone"));
	String twitter = StringUtil.NonNullString(request.getParameter("twitter"));
	String facebook = StringUtil.NonNullString(request.getParameter("facebook"));
	String button = StringUtil.NonNullString(request.getParameter("button"));
%>


<html>
    <head>
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
		<title>サークル管理</title>
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
		         for(University uv : univs){
		             out.println("a.push(\'" + uv.name1_ + "\');");
		             out.println("b.push(\'" + uv.name_ + "\');");
		             out.println("c.push(\'" + uv.id_ + "\');");
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
		 
		 
		</script>
	
    </head>
    <body>
    
	<center>
	    <h1>サークル管理</h1>
	 	<h2>・サークル画像変更</h2>
		<form action="/imguploader" enctype="multipart/form-data" method="post">
			<input type="file" name="image" size="30" />
			<input type="submit" name=button value="送信" />
 		</form>
 			
 		<br><br>

	    <h2>・サークル情報変更</h2>
	    <form action="circle_admin.jsp" method="post" name="Form1">
			<table><tbody>
				<tr>
					<th>サークル名</th>
					<td>
						<input type="text" value="<%= circlename %>" name="circlename" size="30" />
					</td>
				</tr>
				<tr>
					<th>カテゴリ</th>
					<td>
						<select name=type>
			    		<%
			    			for(Category ct : categories){
								out.println("<option value=\"" + ct.name_ + "\">" + ct.name_ + "</option>");
			    			}
			    		%>
			    		</select>
					</td>
				</tr>
				
				<tr>
					<th>所在大学</th>
					<td>
			    		<div style="text-align: center; padding:10px">
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
			    		</div>
			    		<!--
			    		prefecturesを使ってこねくり回して
			    		//out.println("<select name=prefecture onChange=\">");
			    		//  while(rs2.next()){
			    		//    if(prefecture.equals(rs2.getString("name"))){
			    		//      out.println("<option value=\"" + rs2.getString("name") + "\"selected>" + rs2.getString("name") + "</option>");
			    		//    }else{
			    		//      out.println("<option value=\"" + rs2.getString("name") + "\">" + rs2.getString("name") + "</option>");
			    		//    }
			    		//  }
			    		//  out.println("</select>");
			       		-->
			    	</td>
			    </tr>
				<input type="submit" name="button" value="検索" />
			<%
			// Statement オブジェクトの生成
		//	Statement st3 = db.createStatement();
			// SQL 文を query に納入
		//	String query3 = "select universities.name from universities,prefectures where prefectures.name='" + prefecture + "' and universities.prefecture_id=prefectures.id";
			// SQL 文を実行し挿入した数が返る
		//	ResultSet rs3 = st3.executeQuery(query3);
		//	out.println("<select name=university>");
		//	while(rs3.next()){
		//	    out.println("<option value=\"" + rs3.getString("name") + "\">" + rs3.getString("name") + "</option>");
		//	}
		//	out.println("</select>");
			%>
	    
	    </h1>
	    <h1>サークル紹介<br>
		<%
		out.println("<textarea name=comment rows=4 cols=30>" + comment + "</textarea>");
		%>
	    </h1>

	    <h1>メールアドレス<br></h1>
	    <%
	    out.println("<input type=\"text\" value=\"" + mail + "\"name=mail size=30></h1>");
	    %>

	    <h1>電話番号<br></h1>
	    <%
	    out.println("<input type=\"text\" value=\"" + phone + "\"name=phone size=30></h1>");
	    %>

	    <h1>Twitter<br></h1>
	    <%
	    out.println("<input type=\"text\" value=\"" + twitter + "\"name=twitter size=30></h1>");
	    %>

	    <h1>facebook<br></h1>
	    <%
	    out.println("<input type=\"text\" value=\"" + facebook + "\"name=facebook size=30></h1>");
	    %>

	    <br><br><input type="submit" name=button value="送信">

	</center>
    </body>
</html>
