// 
// MemberTop.java
// 

package user.svlt;

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import user.User;

// 
public class MemberTop extends HttpServlet {
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
		User login_user = User.getLoginUser(session);
		
		if(login_user == null){
			hres.sendRedirect("/MyApp");
			return;
		}
		
		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		// ここまでは以降もそのまま使う
		out.println("<title>MemberTop</title></head>");
		out.println("<body>"
			 + " id " + login_user.id_ + " さんようこそ。"
			 + "<p><a href = \"ChangeMyInfo?Target=pass\">パスワード変更</a></p>"
			 + "<p><a href = \"ChangeMyInfo?Target=twitter\">ツイッターアカウント変更</a></p>"
			 + "<p><a href = \"ChangeMyInfo?Target=facebook\">フェイスブックアカウント変更</a></p>"
			 + "<p><a href = \"ChangeMyInfo?Target=mail\">メールアドレス変更</a></p>"
			 + "<p><a href = \"ChangeMyInfo?Target=image\">画像変更</a></p>"
			 + "<form action=Logout>"
			 + "<input type=\"submit\" value=\"logout\">"
			 + "</form>"
			 + "<p>退会は<a href = \"../webpro/WebPro2016_6/DeleteUser.html\">こちら</a></p>"
			 + "</body>"
			 + "</html>");
	}
}
