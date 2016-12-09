// 
// SignupPage.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@MultipartConfig(location="", maxFileSize=1048576)
public class SignupPage extends HttpServlet {
	public void doGet(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();

		// パラメータの入力とチェック
		HttpSession session = hreq.getSession(true);
		String userId = (String)session.getAttribute("IdData");
		String universityId = (String)session.getAttribute("UniversityId");
		String sex = (String)session.getAttribute("sex");	//1->男 2->女
		String pass = (String)session.getAttribute("password");
		String mail = (String)session.getAttribute("mail");
		String twitter = (String)session.getAttribute("twitter");
		String facebook = (String)session.getAttribute("facebook");
		Part iconUrl = (Part)session.getAttribute("icon_url");

		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		// ここまでは以降もそのまま使う
		Connection db = null;
		String db_name = "circle_triangle";
		try {
			// JDBC ドライバのロード
			Class.forName("org.gjt.mm.mysql.Driver");
			// データベースとの結合
			db = DriverManager.getConnection("jdbc:mysql://localhost/"+db_name+"?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");
			// Statement オブジェクトの生成
			Statement st = db.createStatement();
			// UserIdの確認
			String query = "select id from users where id='" + userId + "'";
			ResultSet rs = st.executeQuery(query);
			if(rs.next()) {
				//ID被り
				out.println("そのユーザーIDは既に使用されています．");
				out.println("<p>再登録は<a href = \"../webpro/WebPro2016_6/RegistUser.html\">こちら</a></p>");
				out.println("</body></html>");
			} else {
				// SQL 文を query に格納
				query = "insert into users set id='" + userId + "', university_id=" + universityId + ", sex=" + sex + ",password='" + pass + "',mail='" + mail + "',twitter='" + twitter + "',facebook='" + facebook + "'";//, icon_url='" + iconUrl+"'";
				// SQL 文を実行し挿入した数が返る
				int num = st.executeUpdate(query);
				if(num > 0) {
					//登録成功
					//画像保存処理
					String name = this.getFileName(iconUrl);
					iconUrl.write(getServletContext().getRealPath("/uploads") + "/users/" + name);
					session.setAttribute("Login",1);
					session.setAttribute("IdData",userId);
					out.println("データが登録されました．");
					out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
				}
				else {
					out.println("データが登録されませんでした．");
				}
					// Statement, データベースを順にクローズ
				st.close();
				db.close();
			}
		} catch(SQLException e) {
			out.println("接続失敗<br>" + e.toString());
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			try {
				db.close();
			} catch(Exception e){}
		}
	out.println("</body></html>");
	}

	private String getFileName(Part part) {
		String name = null;
		for (String dispotion : part.getHeader("Content-Disposition").split(";")) {
			if (dispotion.trim().startsWith("filename")) {
				name = dispotion.substring(dispotion.indexOf("=") + 1).replace("\"", "").trim();
				name = name.substring(name.lastIndexOf("\\") + 1);
				break;
			}
		}
		return name;
	}
}
