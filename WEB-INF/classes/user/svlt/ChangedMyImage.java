// 
// ChangedMyImage.java
// 

package user.svlt;

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import java.sql.*;
import user.User;

public class ChangedMyImage extends HttpServlet {
	public void doGet(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();

		HttpSession session = hreq.getSession(false);
		User login_user = User.getLoginUser(session);

		if(login_user == null){
			hres.sendRedirect("/MyApp");
			return;
		}else{
			out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
			out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
			out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
			out.println("</head><body>");
			if((int)session.getAttribute("ID") > -1){
				out.println((int)session.getAttribute("ID"));
				out.println("<p>登録に成功しました。</p>"
				+"<p>メンバートップページは<a href= \"/MyApp/servlet/MemberTop\">こちら</a></p>"
				+"</body></html>");
			}else{
				out.println("<p>登録に失敗しました。</p>"
				+"<p>メンバートップページは<a href=\"/MyApp/servlet/MemberTop\">こちら</a></p>"
				+"</body></html>");
			}
		}
	}
}
