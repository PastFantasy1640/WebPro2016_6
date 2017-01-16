// 
// SignupPage.java
// 

package user.svlt;

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import user.User;
import java.sql.*;

public class SignupPage extends HttpServlet {
	public void doPost(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();

		// パラメータの入力とチェック
		HttpSession session = hreq.getSession(false);
		User new_user = User.getLoginUser(session);
		String post_salt = hreq.getParameter("key");
		
		boolean salt_equal = false;
		if(new_user != null){
			salt_equal = new_user.salt_.equals(post_salt);
		
			if(salt_equal){
				//前のページから飛んできた
				//リロードなどに対しては、新たに取得できるUserがnullになることによって検知可能のはず
				try{
					new_user = new_user.insertNewUser(session);
				}catch(SQLException | ClassNotFoundException e){
					new_user = null;
					throw new ServletException("新たなユーザーの登録に失敗しました。" + e.toString());
				}
			}
		}
		

		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		out.println("</head><body>");
		
		if(!salt_equal){
			out.println("<p>適切なページ遷移が行われませんでした。</p>");
			out.println("<p>トップページは<a href=\"/MyApp\">こちら</a></p>");
		}else if(new_user == null){
			out.println("<p>すでに登録されているか、適切なページ遷移が行われませんでした。</p>");
			out.println("<p>トップページは<a href=\"/MyApp\">こちら</a></p>");
		}else{
			out.println("<p>正常に会員登録ができました</p>");
			out.println("<p>メンバートップページは<a href=\"/MyApp/servlet/MemberTop\">こちら</a></p>");
		}
		
		out.println("</body></html>");
	}
}
