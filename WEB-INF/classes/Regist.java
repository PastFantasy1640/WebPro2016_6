// 
// Regist.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import java.sql.*;

@MultipartConfig(location="", maxFileSize=1048576)
public class Regist extends HttpServlet {
	public void doGet(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();

		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		out.println("</head><body>");
		Connection db = null;
		String db_name = "circle_triangle";
		try {
			// JDBC ドライバのロード
			Class.forName("org.gjt.mm.mysql.Driver");
			// データベースとの結合
			db = DriverManager.getConnection("jdbc:mysql://localhost/"+db_name+"?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");
			// Statement オブジェクトの生成
			Statement st = db.createStatement();
			String query = "select id, name from universities";
			ResultSet rs = st.executeQuery(query);
			out.println("<h2>ユーザー登録画面</h2>"
				+"<form method=\"POST\" enctype=\"multipart/form-data\" action=\"../../servlet/RegistUser\">"
				+"<table border=\"0\">"
				+"<tr>"
				+"<td align=\"right\"><b>ユーザーID:</b></td>"
				+"<td><input type=\"text\" name=UserId size=16 maxlength=16></td>"
				+"</tr><tr>"
				+"<td align=\"right\"><b>大学ID</b></td>"
				+"<td><select name=UniversityId>");
			while(rs.next()){
				int value=rs.getInt("id");
				String uni=rs.getString("name");
				out.println("<option value=\""+value+"\">"
					+uni+"</option>");
			}
			out.println("</td>"
				+"</tr><tr>"
				+"<td align=\"right\"><b>性別:</b></td>"
				+"<td>"
				+"<input type=\"radio\" name=\"sex\" value=\"1\">男"
				+"<input type=\"radio\" name=\"sex\" value=\"2\">女"
				+"</td></tr><tr>"
				+"<td align=\"right\"><b>パスワード:</b></td>"
				+"<td><input type=\"password\" name=password size=32 maxlength=32></td>"
				+"</tr><tr>"
				+"<td align=\"right\"><b>パスワード(確認):</b></td>"
				+"<td><input type=\"password\" name=password2 size=32 maxlength=32></td>"
				+"</tr><tr>"
				+"<td align=\"right\"><b>メール:</b></td>"
				+"<td><input type=\"text\" name=mail size=32 maxlength=32></td>"
				+"</tr><tr>"
				+"<td align=\"right\"><b>twitter:</b></td>"
				+"<td><input type=\"text\" name=twitter size=16 maxlength=16></td>"
				+"</tr><tr>"
				+"<td align=\"right\"><b>facebook:</b></td>"
				+"<td><input type=\"text\" name=facebook size=64 maxlength=64></td>"
				+"</tr><tr>"
				+"<td align=\"right\"><b>アイコン:</b></td>"
				+"<td><input type=\"file\" name=icon_url size=64 maxlength=64></td>"
				+"</tr></table>"
				+"<input type=\"submit\" value=\"登録\"></form>"
				+"<p>アカウントをお持ちの方は<a href = \"LoginPage.html\">こちら</a>"
				+"</p></body></html>");
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
