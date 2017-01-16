// 
// Regist.java
// 
package user.svlt;

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import java.sql.*;
import circle.University;
import java.util.ArrayList;
import user.User;

public class Regist extends HttpServlet {
	public void doGet(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();

		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		out.println("<title>Register</title>");
		out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"/MyApp/sites/user/regist.css\" media=\"all\" />");
		out.println("</head><body>");
		try{
			ArrayList<University> universities = University.getUniversities();
			out.println("<div id=\"regist\">"
			+"<h2 class=\"form-title\">ユーザー登録画面</h2>"
			+"<form method=\"POST\" action=\"/MyApp/servlet/RegistUser\">"
			+"<table border=\"0\">"
			+"<tr>"
			+"<td align=\"right\"><b>*ユーザーID:</b></td>"
			+"<td><input type=\"text\" name=UserId size=16 maxlength=16></td>"
			+"</tr><tr>"
			+"<td align=\"right\"><b>*大学ID</b></td>"
			+"<td><select name=UniversityId>");
			for(University uni : universities){
				out.println("<option value=\""+uni.id_+ "\">"
				+ uni.name_ +"</option>");
			}
			out.println("</select></td>"
			+"</tr><tr>"
			+"<td align=\"right\"><b>*性別:</b></td>"
			+"<td>"
			+"<input type=\"radio\" name=\"sex\" value=\"" + User.NOINFO + "\" checked>非公開"
			+"<input type=\"radio\" name=\"sex\" value=\"" + User.MALE + "\">男"
			+"<input type=\"radio\" name=\"sex\" value=\"" + User.FEMALE + "\">女"
			+"</td></tr><tr>"
			+"<td align=\"right\"><b>*パスワード:</b></td>"
			+"<td><input type=\"password\" name=password size=32 maxlength=32></td>"
			+"</tr><tr>"
			+"<td align=\"right\"><b>*パスワード(確認):</b></td>"
			+"<td><input type=\"password\" name=password2 size=32 maxlength=32></td>"
			+"</tr><tr>"
			+"<td align=\"right\"><b>メール:</b></td>"
			+"<td><input type=\"text\" name=mail size=32 maxlength=32></td>"
			+"</tr><tr>"
			+"<td align=\"right\"><b>twitter:</b></td>"
			+"<td><input type=\"text\" name=twitter size=16 maxlength=16></td>"
			+"</tr><tr>"
			+"<td align=\"right\"><b>facebook:</b></td>"
			+"<td><input type=\"text\" name=facebook size=64 maxlength=64></td>"
			+"</tr></table>"
			+"*:必須項目"
			+"<p class=\"submit\">"
			+"<input type=\"submit\" value=\"登録\"></form></div>"
			+"<div id=\"user\">"
			+"<p>アカウントをお持ちの方は<a href =/MyApp/sites/user/LoginPage.html>こちら</a>"
			+"</div>"
			+"</p></body></html>");
		}catch(SQLException e){
			out.println("接続失敗<br>"+e.toString());
		}catch(ClassNotFoundException e){
			out.println("エラー<br>"+e.toString());
		}
		out.println("</body></html>");
	}
}
