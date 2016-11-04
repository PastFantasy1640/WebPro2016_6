// 
// Logout.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

// 
public class Logout extends HttpServlet {
// SvlSmpl1::doGet()
	public void doGet(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();
		// パラメータ情報の収集
		HttpSession session = hreq.getSession(false);
		if(session == null){
			session = hreq.getSession(true);
			hres.sendRedirect("../webpro/WebPro2016_6/LoginPage.html");
			session.setAttribute("Login",0);
		}else{
			session.setAttribute("Login",0);
			hres.sendRedirect("../webpro/WebPro2016_6/LoginPage.html");
		}
	}
}
