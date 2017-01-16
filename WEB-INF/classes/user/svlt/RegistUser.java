// 
// RegistUser.java
// 

package user.svlt;

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import java.sql.*;
import java.util.ArrayList;
import static utility.StringUtil.NonNullString;
import circle.University;
import user.User;

 
public class RegistUser extends HttpServlet {
	public void doPost(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();
		// パラメータ情報の収集
		//(final String id, final int university_id, final int sex, final String password_str, final String mail, final String twitter, final String facebook, final int icon_id)
		User new_user = new User(NonNullString(hreq.getParameter("UserId")),
			Integer.parseInt(NonNullString(hreq.getParameter("UniversityId"))),
			Integer.parseInt(NonNullString(hreq.getParameter("sex"))),
			NonNullString(hreq.getParameter("password")),
			NonNullString(hreq.getParameter("mail")),
			NonNullString(hreq.getParameter("twitter")),
			NonNullString(hreq.getParameter("facebook")),
			0);		//TO DO : icon_idをデフォルトで新規作成
		
		String pass = NonNullString(hreq.getParameter("password"));
		String pass2 = NonNullString(hreq.getParameter("password2"));
		
		String sex2 = "";
		// 性別の文字列化
		if(new_user.sex_ == User.MALE){
			sex2 = "男";
		} else if(new_user.sex_ == User.FEMALE){
			sex2 = "女";
		} else if(new_user.sex_ == User.NOINFO){
			sex2 = "非公開";
		}
		
		University univ = null;
		try{
			univ = University.getUniversityFromID(new_user.university_id_);
		}catch(SQLException | ClassNotFoundException e){
			throw new ServletException("大学名の取得中にエラーが発生しました\r\n" + e.toString());
		}

		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"/MyApp/sites/user/registuser.css\" media=\"all\" />");

		// ここまでは以降もそのまま使う
		out.println("<title>ユーザー登録確認画面</title></head>");
		out.println("<body>");
		
		if(!new_user.isValidParameter()){
			out.println("未記入項目があります。入力しなおしてください。");
			out.println("<p>再入力は<a href=\"/MyApp/servlet/Regist\">こちら</a></p>");
		}else if(!pass.equals(pass2)){
			out.println("パスワードが一致しません。入力しなおしてください。");
			out.println("<p>再入力は<a href=\"/MyApp/servlet/Regist\">こちら</a></p>");
		}else if(!new_user.isValidPassword()){
			out.println("パスワードが不適切です。8-32文字の範囲で入力しなおしてください。");
			out.println("<p>再入力は<a href=\"/MyApp/servlet/Regist\">こちら</a></p>");
		}else if(!new_user.isUniqueID()){
			out.println("そのIDはすでに使用されています。入力しなおしてください。");
			out.println("<p>再入力は<a href=\"/MyApp/servlet/Regist\">こちら</a></p>");
		}else if(univ == null){
			out.println("大学名にエラーがあります。入力しなおしてください。");
			out.println("<p>再入力は<a href=\"/MyApp/servlet/Regist\">こちら</a></p>");
		}else {
			out.println("<body>"
				 + "<div id=\"registuser\">");
			
			out.println("<body>"
			 + "以下の情報で登録します。"
			 + "<table border=\"0\">"
			 + "<tr><td align=\"right\">ユーザーID:</td>"+"<td>"+new_user.id_+"</td></tr>"
			 + "<tr><td align=\"right\">大学名:</td>"+"<td>"+ univ.name_ +"</td></tr>"
			 + "<tr><td align=\"right\">性別:</td>"+"<td>"+sex2+"</td></tr>"
			 + "<tr><td align=\"right\">パスワード:</td><td>表示なし</td></tr>"
			 + "<tr><td align=\"right\">メール:</td>"+"<td>"+new_user.mail_+"</td></tr>"
			 + "<tr><td align=\"right\">twitter:</td>"+"<td>"+new_user.twitter_+"</td></tr>"
			 + "<tr><td align=\"right\">facebook:</td>"+"<td>"+new_user.facebook_+"</td></tr>"
			 + "</table>");
			
			//登録情報記憶
			HttpSession session = hreq.getSession(true);
			session.setAttribute("login_user", new_user);
			out.println("<form method=\"POST\" action=\"/MyApp/servlet/SignupPage\">"
			+ "<p class=\"submit\">"
			+ "<input type=\"hidden\" value=\"" + new_user.salt_ + "\" />"
			+ "<input type=\"submit\" value=\"登録\">"
			+ "</p></form></div>");
		}
			
		out.println("</body></html>");
	}
}
