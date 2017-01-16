// 
// Logout.java
// 
package user.svlt;
// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import user.User;

// 
public class Logout extends HttpServlet {
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
		User.logoutCurrentUser(session);
		
		
		hres.sendRedirect("/MyApp");
		return;
	}
}
