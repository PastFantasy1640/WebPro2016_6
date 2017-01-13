<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.sql.*,utility.ImageManager"  %>


<%

    //int ret = 5000;

    //ret = (int)session.getAttribute("UserID");

    // リクエストパラメータの文字エンコーディング指定
    request.setCharacterEncoding("utf-8");
    
    String str  = request.getParameter("result");

    //str  = "2";

    // JDBC ドライバのロード
    Class.forName("org.gjt.mm.mysql.Driver");
    // データベースとの結合
    Connection db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle_db?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");

    Statement st1 = db.createStatement();

    String query1 = "select * from circles where id ="+Integer.valueOf(str);

    ResultSet rs1 = st1.executeQuery(query1);

    //circlesデータ取得のために一歩前に進む
    rs1.next();

    int ImageId = rs1.getInt("imageid");

    //images->idから画像取得
    ImageManager image = new ImageManager(ImageId);

    Statement st2 = db.createStatement();

    String query2 = "select name from universities where id ="+rs1.getInt("university_id");

    ResultSet rs2 = st2.executeQuery(query2);    

    rs2.next();

%>

<html>
    <head>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
	<title>全学生の表示</title>
	<script>
	 
	 function imgClick1() {
             document.body.style.cursor = "pointer";
         }

         function imgClick2() {
             document.body.style.cursor = "default";
         }

         function imgClick3() {
             top.location.href = 'http://localhost:8080/examples/jQueryGoogleImgSearchUI/';
         }

         function imgClick4() {
             top.location.href = 'https://login.yahoo.co.jp/config/login?.src=ym&.done=http%3A%2F%2Fmail.yahoo.co.jp%2F';
         }

         function imgClick5() {
             top.location.href = 'https://twitter.com/login?lang=ja';
         }

         function imgClick6() {
             top.location.href = 'https://ja-jp.facebook.com/login/';
         }
	 
	</script>
	<style>

	 body {
	     margin: 0 auto;
	     padding: 0 auto;
	 }
	 
	 .box1 {
	     position: absolute;
	     height: 1000px;
	     width: 100%;
	 }

	 .box2 {
	     position: absolute;
	     height: 200px;
	     width: 100%;
	     background-color: #ffffff;
	 }

	 .box3 {
	     position: absolute;
	     height: 80%;
	     width: 300px;
	     background-color: #ffffff;
	     top: 200px;
	 }

	 .box4 {
	     position: absolute;
	     height: 80%;
	     width: 100%;
	     background-color: #ffffff;
	     top: 200px;
	     left: 300px;
	     margin: 0 auto;
	 }

	 .box2-1{
	     width:80%;
	     height: 200px;
	     background-color: #fff;
	     margin: 0 auto;
	 }

	 .box2-1-1{
	     position: absolute;
	     width:80%;
	     background-color: #aff;
	     background-size: contain;
	     background-image: url(../../logo.png);
	     height: 150px;
	 }

	 
	 .box2-1-2{
	     position: absolute;
             width:80%;
             background-color: #FFFFF0;
	     top: 150px;
	     height: 50px;
	 }

	 .box2-1-2-1{
	     position: absolute;
             width:24.9%;
	     height: 75%;
             background-color: #3ae;
	     text-align: center;
	     padding-top: 10px;
	     margin: 1px;
	 }

	 .box2-1-2-2{
             position: absolute;
	     left: 25%;
             width:24.9%;
             height: 75%;
             background-color: #3ae;
	     text-align: center;
	     padding-top: 10px;
	     margin: 1px;
	 }

	 .box2-1-2-3{
             position: absolute;
	     left: 50%;
             width:24.9%;
             height: 75%;
             background-color: #3ae;
	     text-align: center;
	     padding-top: 10px;
	     margin: 1px;
	 }


         .box2-1-2-4{
             position: absolute;
	     left: 75%;
             width:24.8%;
             height: 75%;
	     background-color: #3ae;
	     text-align: center;
	     padding-top: 10px;
	     margin: 1px;
         }

	 .box3-1{
	     position: absolute;
	     margin: 10px;
	     width: 90%;
	     height: 30%;
	     background-color: #3ae;
	 }

	 .box3-2{
	     position: absolute;
	     margin: 10px;
	     width: 90%;
	     height: 30%;
	     top: 30%;
	     background-color: #3ae;
	 }

	 .box3-3{
	     position: absolute;
	     margin: 10px;
	     width: 90%;
	     height: 40%;
	     top: 60%;
	     background-color: #3ae;

	 }

	 .box3-3-1{
	     position: absolute;
	     margin: 10px;
	     top: 10%;
	     width: 90%;
	     height: 10%;
	     border:1px solid #ccc;
	     background-color: #fff;
	     /*
	     overflow: auto;  
    	     white-space: nowrap;  
    	     text-overflow: ellipsis; 
	     */
	 }

	 .box3-3-1-1{
	     position: absolute;
             width: 50%;
             height: 50%;
             background-color: #fff;
	 }

	 .box3-3-1-2{
             position: absolute;
             width: 50%;
             height: 50%;
             background-color: #fff;
	     left: 50%;
         }

	 .box3-3-1-3{
             position: absolute;
	     top: 50%;
             width: 50%;
             height: 50%;
             background-color: #fff;
         }

	 .box3-3-1-4{
             position: absolute;
             width: 50%;
             height: 50%;
	     top: 50%;
	     left: 50%;
             background-color: #fff;
         }

	 .box4-1{
	     position: absolute;
	     width: 80%;
	     height: 100%;
	     background-color: #3ae;
	     margin: 10px;

	 }
	 
	 .box4-1-1{
	     position: absolute;
	     top: 9%;
	     margin-left: 10px;
	     width: 99%;
	     height: 90%;
	     background-color: #fff;
	 }
	 

	 .image img{
	     border-radius: 50px;
	     -webkit-border-radius: 50px;
	     -moz-border-radius: 50px;
	 }

	 
	 

	</style>
    </head>


    <%	
    
    /*
    if(str.equals("-1")){
       out.println("<body>error</body>");
    }
    else{

    */

    
    
    %>
    <body>
	<div class="box1">
	    <div class="box2">
	    	 <div style="text-align:center;">
			<img border="0" src="../../images/logo.png" width="600px" height="150px">
		 </div>
	      <!--			
		<div class="box2-1">
		    <div style="text-align:center; top: 50px;">
			<img border="0" src="../../images/logo.png" width="600px" height="150px">
		    </div>
		     
		    <div class="box2-1-1">
		    </div>
		    <div class="box2-1-2">
			<div class="box2-1-2-1"><a href="#" style="text-decoration: none; color: #fff">項目1</a></div>
			<div class="box2-1-2-2"><a href="#" style="text-decoration: none; color: #fff">項目2</a></div>
			<div class="box2-1-2-3"><a href="#" style="text-decoration: none; color: #fff">項目3</a></div>
			<div class="box2-1-2-4"><a href="#" style="text-decoration: none; color: #fff">項目4</a></div>
		    </div>
		</div>
		-->
	    </div>
	    <div class="box3">
		<div class="box3-1">
		    <div class="image">
			<%
			if(ImageId != 0){
				   out.println("<img src=\"/MyApp/uploads/images/" + image.getFileName() + "\" width=\"100%\" height=\"100%\" />");
			}
			else{
				   out.println("<br><br><br><br><div style=\"text-align:center;color:#fff\">画像は編集されていません</div>");
			}
			%>
			
		    </div>
		</div>
		<div class="box3-2" style="text-align:center">
		    <div style="color: #fff;" >
		    	<p>
			Phone<br>
			<%
			String Phone = rs1.getString("phone");
			if(Phone == null){
			     out.println("登録されていません");
			}
			else{
			     out.println(Phone);
			}
			%>
			</p>
			<p>
			Mail<br>
			<%
			String Mail = rs1.getString("mail");
			if(Mail == null){
			     out.println("登録されていません");
			}
			else{
			     out.println(Mail);
			}
			%>
			</p>
			<p>
			    <a href="https://twitter.com/login?lang=ja" style="text-decoration: none;">Twwiter Acount</a><br>
			    <%
			    String Twitter = rs1.getString("twitter");
			    if(Twitter == null){
			       out.println("登録されていません");
			    }
			    else{
			       out.println(Twitter);
			    }
			    %>
			</p>
			<p>
			    <a href="https://ja-jp.facebook.com/login/" style="text-decoration: none;">Facebook Acount</a><br>
			    <%
			    String Facebook = rs1.getString("facebook");
			    if(Facebook == null){
			        out.println("登録されていません");
			    }		
			    else{
				out.println(Facebook);
			    }
			    %>
			</p>
		    </div>
		</div>
		<div class="box3-3">
		     <div style="color: #fff;" >
		     Comment
		     </div>
		     <div class="box3-3-1">
		     	  <marquee behavior="scroll">
		    	  <%
			  String Comment = rs1.getString("comment");
			  if(Comment == null){
			     out.println("編集されていません");
			  }
			  else{
			     out.println(Comment);
			  }
			  %>
			  </marquee>
		     </div>
		</div>
            </div>
	    <div class="box4">
		<div class="box4-1">
		     <h2 style="color:#fff"><%=rs2.getString("name")+rs1.getString("name")%></h2>
		     <div class="box4-1-1">
		     	  <%
			  if(rs1.getString("file") == null){
			     out.println("編集されていません。サークル編集ページで編集してください");
			  }
			  else{
			     out.println(rs1.getString("file"));
			  }
			  %>
		     </div>
		</div>
            </div>
	</div>
	
    </body>

    <%
    //}
    %>

</html>


