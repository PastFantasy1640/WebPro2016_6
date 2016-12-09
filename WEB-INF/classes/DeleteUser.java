//
// DeleteUser.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteUser extends HttpServlet {
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

		// パラメータ情報の収集
		String userId = hreq.getParameter("UserId");
                String pass = hreq.getParameter("password");

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
			String query = "select id, password from users where id='" + userId + "' and password='" + pass + "'";
			ResultSet rs = st.executeQuery(query);
			if(!rs.next()) {
				out.println("そのユーザーIDとパスワードのアカウントは存在しません.");
				out.println("<p>削除は<a href = \"../webpro/WebPro2016_6/DeleteUser.html\">こちら</a></p>");
				out.println("</body></html>");
			} else {
				// SQL 文を query に格納
				query = "delete from users where  id='" + userId + "'and password='" + pass + "'";
				// SQL 文を実行し挿入した数が返る
				int num = st.executeUpdate(query);
				if(num > 0) {
					session.setAttribute("Login",0);
					out.println("データが削除されました．");
					out.println("<p>再登録は<a href = \"../webpro/WebPro2016_6/RegistUser.html\">こちら</a></p>");
				}
				else {
					out.println("データが削除されませんでした．");
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
}
