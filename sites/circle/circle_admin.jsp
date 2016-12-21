<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*" %>
<%

// リクエストパラメータの文字エンコーディング指定
request.setCharacterEncoding("utf-8");
// JDBC ドライバのロード
Class.forName("org.gjt.mm.mysql.Driver");

Connection db = DriverManager.getConnection("jdbc:mysql://localhost/webpro_db?user=root&password=Imakiti838&useUnicode=true&characterEncoding=utf-8");
Statement st4 = db.createStatement();
String query4 = "select id, name,name1 from universities";
ResultSet rs4 = st4.executeQuery(query4);


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
	     rs4.beforeFirst();
	     while(rs4.next()) {
	     %>
	     a.push('<%= rs4.getString("name1") %>');
	     b.push('<%= rs4.getString("name") %>');
	     c.push('<%= rs4.getString("id") %>');
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
	 
	 
	</script>
	
    </head>
    <body>
	<%
	String circlename = request.getParameter("circlename");
	if(circlename==null)
	circlename="";
	String type = request.getParameter("type");
	if(type==null)
	type="";
	String prefecture = request.getParameter("prefecture");
	if(prefecture==null)
	prefecture="fukuoka";
	String university = request.getParameter("university");
	if(university==null)
	university="";
	String comment = request.getParameter("comment");
	if(comment==null)
	comment="";
	String mail = request.getParameter("mail");
	if(mail==null)
	mail="";
	String phone = request.getParameter("phone");
	if(phone==null)
	phone="";
	String twitter = request.getParameter("twitter");
	if(twitter==null)
	twitter="";
	String facebook = request.getParameter("facebook");
	if(facebook==null)
	facebook="";
	String button = request.getParameter("button");
	if(button==null)
	button="";

	%>

	<%
	// Statement オブジェクトの生成
	Statement st1 = db.createStatement();
	// SQL 文を query に納入
	String query1 = "select name from categories";
	// SQL 文を実行し挿入した数が返る
	ResultSet rs1 = st1.executeQuery(query1);
	%>

	<center>
	    <h1>サークル管理</h1><br>
	    <form action=Servlet/ImageUploader enctype=multipart/form-data method=post>
		<h2>・サークル画像変更</h2>
		<input type=file name=image size=30>
		<input type="submit" name=button value="送信">
	    </form><br><br>

	    <h2>・サークル情報変更</h2>
	    <form action=circle_admin.jsp method=post name="Form1">
		<table>
		    <tbody>
			<tr><th>サークル名</th><td>
			    <%
			    out.println("<input type=\"text\" value=\"" + circlename + "\"name=circlename size=30></h1>");
			    %>
			</td></tr>
			<tr><th>カテゴリ</th><td>
			    <%
			    out.println("<select name=type>");
			    while(rs1.next()){
				out.println("<option value=\"" + rs1.getString("name") + "\">" + rs1.getString("name") + "</option>");
			    }
			    out.println("</select>");
			    %>
</select>
			</td></tr>
			<%
			// Statement オブジェクトの生成
			Statement st2 = db.createStatement();
			// SQL 文を query に納入
			String query2 = "select name from prefectures order by id asc";
			// SQL 文を実行し挿入した数が返る
			ResultSet rs2 = st2.executeQuery(query2);
			%>
			<tr><th>所在大学</th><td>

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
			    
			</td></tr>
			<input type="submit" name=button value=検索>
			<%
			// Statement オブジェクトの生成
			Statement st3 = db.createStatement();
			// SQL 文を query に納入
			String query3 = "select universities.name from universities,prefectures where prefectures.name='" + prefecture + "' and universities.prefecture_id=prefectures.id";
			// SQL 文を実行し挿入した数が返る
			ResultSet rs3 = st3.executeQuery(query3);
			out.println("<select name=university>");
			while(rs3.next()){
			    out.println("<option value=\"" + rs3.getString("name") + "\">" + rs3.getString("name") + "</option>");
			}
			out.println("</select>");
			%>
	     </select>
	    </h1>
	    <h1>サークル紹介<br>
		<%
		out.println("<textarea name=comment rows=4 cols=30>" + comment + "</textarea>");
		%>
</textarea><br>
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
	    <%
	    // Statement, データベースを順にクローズ
	    rs1.close();
	    rs2.close();
	    rs3.close();
	    rs4.close();
	    st1.close();
	    st2.close();
	    st3.close();
	    st4.close();
	    db.close();
	    %>
	</center>
    </body>
</html>
