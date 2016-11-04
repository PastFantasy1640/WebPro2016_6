// 
// RegistUser.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

// 
public class RegistUser extends HttpServlet {
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
		String userId = hreq.getParameter("UserId");
		String universityId = hreq.getParameter("UniversityId");
		String sex = hreq.getParameter("sex");	//1->男 2->女
		String pass = hreq.getParameter("password");
		String mail = hreq.getParameter("mail");
		String twitter = hreq.getParameter("twitter");
		String facebook = hreq.getParameter("facebook");
		String iconUrl = hreq.getParameter("icon_url");

		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		// ここまでは以降もそのまま使う
		out.println("<title>ユーザー登録確認画面</title></head>");
		out.println("<body>");
		if(userId.equals("") || universityId.equals("") || pass.equals("")){
			out.println("未記入項目があります。入力しなおしてください。");
		}else{
			out.println("<body>"
				 + "以下の情報で登録します。"
				 + "<table border=\"0\">"
				 + "<tr><td align=\"right\">ユーザーID:</td>"+"<td>"+userId+"</td></tr>"
				 + "<tr><td align=\"right\">大学ID:</td>"+"<td>"+universityId+"</td></tr>"
				 + "<tr><td align=\"right\">性別:</td>"+"<td>"+sex+"</td></tr>"
				 + "<tr><td align=\"right\">パスワード:</td><td>表示なし</td></tr>"
				 + "<tr><td align=\"right\">メール:</td>"+"<td>"+mail+"</td></tr>"
				 + "<tr><td align=\"right\">twitter:</td>"+"<td>"+twitter+"</td></tr>"
				 + "<tr><td align=\"right\">facebook:</td>"+"<td>"+facebook+"</td></tr>"
				 + "<tr><td align=\"right\">アイコン(URL):</td>"+"<td>"+iconUrl+"</td></tr>"
				 + "</table>");
			//登録情報記憶

			out.println("<form action=SignupPage>"+
				  "<input type=\"hidden\" name=\"UserId\" value=\""+userId+"\">"
				 + "<input type=\"hidden\" name=\"UniversityId\" value=\""+universityId+"\">"
				 + "<input type=\"hidden\" name=\"sex\" value=\""+sex+"\">"
				 + "<input type=\"hidden\" name=\"password\" value=\""+pass+"\">"
				 + "<input type=\"hidden\" name=\"mail\" value=\""+mail+"\">"
				 + "<input type=\"hidden\" name=\"twitter\" value=\""+twitter+"\">"
				 + "<input type=\"hidden\" name=\"facebook\" value=\""+facebook+"\">"
				 + "<input type=\"hidden\" name=\"icon_url\" value=\""+iconUrl+"\">"
				 + "<input type=\"submit\" value=\"登録\">"
				 + "</form>");
		}
		out.println("</body></html>");
	}
}