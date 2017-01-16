// 
// LoginPage.java
// 

package user.svlt;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import user.User;

import static utility.StringUtil.NonNullString;

public class LoginPage extends HttpServlet {
	public void doPost(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();
		
		HttpSession session = hreq.getSession(true);
		
		User login_user = null;
		try{
			login_user = User.authorizeUser(NonNullString(hreq.getParameter("IdData")),
				NonNullString(hreq.getParameter("PasswordData")),
				session);
		}catch(SQLException | ClassNotFoundException e){
			throw new ServletException("exception : " + e.toString());
		}
		
		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		
		if(login_user != null){
			out.println("<title>ログイン成功</title></head>");
			out.println("<body><p>ログインに成功しました。</p>");
			out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
		}else{
			//ログイン失敗
			out.println("<title>ログイン失敗</title></head>");
			out.println("<body><p>IDかパスワードが正しくありません</p>");
			out.println("<p>再試行は<a href = \"/MyApp/sites/user/LoginPage.html\">こちら</a></p>");
		}
		
		
		out.println("</body></html>");
	}
/*
	public void doGet(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
			hres.sendRedirect("../webpro/WebPro2016_6/LoginPage.html");
	}*/
}
