// 
// ChangedMyInfo.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import java.sql.*;

@MultipartConfig(location="", maxFileSize=1048576)
public class ChangedMyInfo extends HttpServlet {
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
		if(session == null){
			session = hreq.getSession(true);
			hres.sendRedirect("../webpro/WebPro2016_6/LoginPage.html");
			session.setAttribute("Login",0);
		}else{
			if((int)session.getAttribute("Login")==1){
				out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
				out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
				out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
				out.println("</head><body>");
				// ここまでは以降もそのまま使う
				String id = (String)session.getAttribute("IdData");
				Connection db = null;
				String db_name = "circle_triangle";
				try {
					// JDBC ドライバのロード
					Class.forName("org.gjt.mm.mysql.Driver");
					// データベースとの結合
					db = DriverManager.getConnection("jdbc:mysql://localhost/"+db_name+"?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");
					// Statement オブジェクトの生成
					Statement st = db.createStatement();
					String pass = hreq.getParameter("pass");
					// UserIdの確認
					String query = "select password from users where password='" + pass + "'"+" and id = '" +id+"'";
					ResultSet rs = st.executeQuery(query);
					if(!rs.next()) {
						//パスワード間違い
						out.println("正しくないパスワードです。");
						out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
						out.println("</body></html>");
					} else {
						String newPass = hreq.getParameter("newPass");
						String newPass2 = hreq.getParameter("newPass2");
						String newTwitter = hreq.getParameter("newTwitter");
						String newFacebook = hreq.getParameter("newFacebook");
						String newMail = hreq.getParameter("newMail");
						if(!newPass.equals("") && newTwitter.equals("") && newFacebook.equals("") && newMail.equals("")){
							if(!newPass.equals(newPass2)){
								out.println("新しいパスワードと新しいパスワード（確認）が一致しません。");
								out.println("もう一度入力しなおしてください。");
								out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
								out.println("</body></html>");
							}else{
								query = "update users set password = '"+newPass+"' where id = '"+id+"'";
								int num = st.executeUpdate(query);
								if(num > 0) {
									//登録成功
									out.println("データが登録されました．");
									out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
								}else {
									out.println("データの登録に失敗しました。もう一度入力しなおしてください。");
									out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
								}
								out.println("</body></html>");
							}
						}else if(newPass.equals("") && !newTwitter.equals("") && newFacebook.equals("") && newMail.equals("")){
							query = "update users set twitter = '"+newTwitter+"' where id = '"+id+"'";
							int num = st.executeUpdate(query);
							if(num > 0) {
								//登録成功
								out.println("データが登録されました．");
								out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
							}else {
								out.println("データの登録に失敗しました。もう一度入力しなおしてください。");
								out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
							}
							out.println("</body></html>");
						}else if(newPass.equals("") && newTwitter.equals("") && !newFacebook.equals("") && newMail.equals("")){
							query = "update users set facebook = '"+newFacebook+"' where id = '"+id+"'";
							int num = st.executeUpdate(query);
							if(num > 0) {
								//登録成功
								out.println("データが登録されました．");
								out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
							}else {
								out.println("データの登録に失敗しました。もう一度入力しなおしてください。");
								out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
							}
							out.println("</body></html>");
						}else if(newPass.equals("") && newTwitter.equals("") && newFacebook.equals("") && !newMail.equals("")){
							query = "update users set mail = '"+newMail+"' where id = '"+id+"'";
							int num = st.executeUpdate(query);
							if(num > 0) {
								//登録成功
								out.println("データが登録されました．");
								out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
							}else {
								out.println("データの登録に失敗しました。もう一度入力しなおしてください。");
								out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
							}
							out.println("</body></html>");
						}else{
							out.println("申し訳ありません。データを入力しなおしてください。");
							out.println("<p>メンバートップページは<a href = \"MemberTop\">こちら</a></p>");
							out.println("</body></html>");
						}
					}
					st.close();
					db.close();
				} catch(SQLException e) {
					out.println("接続失敗<br>" + e.toString());
					out.println("</body></html>");
				} catch(Exception e){
					e.printStackTrace();
				} finally{
					try {
						db.close();
					} catch(Exception e){}
				}
			}else{
				hres.sendRedirect("../webpro/WebPro2016_6/LoginPage.html");
			}
		}
	}
}
