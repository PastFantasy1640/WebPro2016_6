// 
// LoginPage.java
// 

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginPage extends HttpServlet {
	public void doGet(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();
		//データベースとの結合
		Connection db = null;
		try {
			Class.forName("org.gjt.mm.myssql.Driver");
			db = DriverManager.getConnection("jdbc:mysql://localhost/circle_triangle?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");
			// id,passの取得
			String idData = hreq.getParameter("IdData");
			String pass = hreq.getParameter("PasswordData");
			//DBから参照
			Statement st=db.createStatement();
			String query = "select id, password from users where id="+idData+"and pass="+pass;
			ResultSet rs=st.executeQuery(query);

			// HTMLテキストの出力
			out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
			out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
			out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
			//id,passの判定
			if(idData.equals(rs.getString("id"))&&pass.equals(rs.getString("password"))){
				//ログイン成功
				out.println("<title>ログイン成功</title></head>");
				out.println("<body>"
				 + "IdData は " + idData + " で "
				 + "Password は " + pass + " です");
			}else{
				//ログイン失敗
				out.println("<title>ログイン失敗</title></head>");
				out.println("<body>"
				 + "IDかパスワードが正しくありません");
			}
			rs.close();
			st.close();
			db.close();
		} catch(SQLException e) {
			out.println("接続失敗<br>" + e.toString());
		} catch(Exception e) {
	 		e.printStackTrace();
		} finally {
			try {
				db.close();
			} catch(Exception e) {}
		}
		out.println("</body></html>");
	}
}
