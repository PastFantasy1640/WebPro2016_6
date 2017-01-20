// 
// ChangeMyInfo.java
// 

package user.svlt;

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import user.User;
import utility.ImageManager;

public class ChangeMyInfo extends HttpServlet {
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
		User login_user = User.getLoginUser(session);

		if(login_user == null){
			hres.sendRedirect("/MyApp");
			return;
		}else{
			String target = hreq.getParameter("Target");
			// HTMLテキストの出力
			out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
			out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
			out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
			// ここまでは以降もそのまま使う
			out.println("<title>ChangeMyInfo</title></head>");
			if(target.equals("pass")){
				out.println("<body>"
				 + "<h2>パスワード変更</h2>"
				 + "<form method=\"POST\" action=\"ChangedMyInfo\">"
				 + "<table border=\"0\">"
				 + "<tr><td align=\"right\">新しいパスワード:</td>"
				 + "<td><input type=\"password\" name=\"newPass\" size=32 maxlength=32></td></tr>"
				 + "<tr><td align=\"right\">新しいパスワード（確認）:</td>"
				 + "<td><input type=\"password\" name=\"newPass2\" size=32 maxlength=32></td></tr>"
				 + "<tr><td align=\"right\">変更前のパスワード:</td>"
				 + "<td><input type=\"password\" name=\"pass\" size=32 maxlength=32></td></tr>"
				 + "</table>"
				 + "<input type=\"submit\" value=\"変更\">"
				 + "</form>"
				 + "</body>"
				 + "</html>");
			}else if(target.equals("twitter")){
				out.println("<body>"
				+"<h2>ツイッターアカウント変更</h2>"
				 + "<form method=\"POST\" action=\"ChangedMyInfo\">"
				 + "<table border=\"0\">"
				 + "<tr><td align=\"right\">新しいツイッターアカウント:</td>"
				 + "<td><input type=\"text\" name=\"newTwitter\" size=16 maxlength=16></td></tr>"
				 + "<tr><td align=\"right\">パスワード:</td>"
				 + "<td><input type=\"password\" name=\"pass\" size=32 maxlength=32></td></tr>"
				 + "</table>"
				 + "<input type=\"submit\" value=\"変更\">"
				 + "</form>"
				+"</body>"
				+"</html>");
			}else if(target.equals("facebook")){
				out.println("<body>"
				+"<h2>フェイスブックアカウント変更</h2>"
				 + "<form method=\"POST\" action=\"ChangedMyInfo\">"
				 + "<table border=\"0\">"
				 + "<tr><td align=\"right\">新しいフェイスブックアカウント:</td>"
				 + "<td><input type=\"text\" name=\"newFacebook\" size=64 maxlength=64></td></tr>"
				 + "<tr><td align=\"right\">パスワード:</td>"
				 + "<td><input type=\"password\" name=\"pass\" size=32 maxlength=32></td></tr>"
				 + "</table>"
				 + "<input type=\"submit\" value=\"変更\">"
				 + "</form>"
				+"</body>"
				+"</html>");
			}else if(target.equals("mail")){
				out.println("<body>"
				+"<h2>メール変更</h2>"
				 + "<form method=\"POST\" action=\"ChangedMyInfo\">"
				 + "<table border=\"0\">"
				 + "<tr><td align=\"right\">新しいメールアドレス:</td>"
				 + "<td><input type=\"text\" name=\"newMail\" size=385 maxlength=385></td></tr>"
				 + "<tr><td align=\"right\">パスワード:</td>"
				 + "<td><input type=\"password\" name=\"pass\" size=32 maxlength=32></td></tr>"
				 + "</table>"
				 + "<input type=\"submit\" value=\"変更\">"
				 + "</form>"
				+"</body>"
				+"</html>");
			}else if(target.equals("image")){
				//ユーザの画像IDをセッション変数に格納する
				//（ユーザクラスから？
				session.setAttribute("ID",login_user.getImageId());
				session.setAttribute("url","/MyApp/servlet/ChangedMyImage");
				out.println("<body>"
				+"<h2>画像変更</h2>"
				+"<form action=/MyApp/imguploader enctype=multipart/form-data method=post>"
				+"<input type=file name=image size=30>"
				+"<input type=\"submit\" name=button value=\"変更\">"
				+"</form>"
				+"</body>"
				+"</html>");
			}
		}
	}
}
