// 
// ChangedMyInfo.java
// 

package user.svlt;

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import user.User;


public class ChangedMyInfo extends HttpServlet {
	public void doPost(HttpServletRequest hreq,	// リクエスト
			  HttpServletResponse hres)	// レスポンス
		throws ServletException, IOException {
		// リクエストパラメータの文字エンコーディング指定
		hreq.setCharacterEncoding("utf-8");
		// コンテント種類の指定
		hres.setContentType("text/html;charset=utf-8");
		// 出力用PrintWriterの参照を取得
		PrintWriter out = hres.getWriter();

		HttpSession session = hreq.getSession(false);
		User login_user = User.getLoginUser(session);

		if(login_user == null){
			hres.sendRedirect("/MyApp");
			return;
		}else{
			out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
			out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
			out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
			out.println("</head><body>");
			// ここまでは以降もそのまま使う
			String pass = hreq.getParameter("pass");
			// UserIdの確認
			try{
				if(login_user.authorizeUser(login_user.id_,pass,session)==null) {
					//パスワード間違い
					out.println("正しくないパスワードです。");
					out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
					out.println("</body></html>");
				} else {
					String newPass = hreq.getParameter("newPass");
					String newPass2 = hreq.getParameter("newPass2");
					String newTwitter = hreq.getParameter("newTwitter");
					String newFacebook = hreq.getParameter("newFacebook");
					String newMail = hreq.getParameter("newMail");
					if(newPass!=null && newTwitter==null && newFacebook==null && newMail==null){
						if(!newPass.equals(newPass2)){
							out.println("新しいパスワードと新しいパスワード（確認）が一致しません。");
							out.println("もう一度入力しなおしてください。");
							out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
							out.println("</body></html>");
						}else{
							//データのアップデート
							User tmpUser = new User(login_user.id_, login_user.university_id_,login_user.sex_,newPass,login_user.mail_,login_user.twitter_,login_user.facebook_,login_user.getImageId());
							if(tmpUser.isValidPassword()){
								//正常な新しいパス
								if(tmpUser.updateUser(login_user)==null){
								//登録失敗
									out.println("データの登録に失敗しました。もう一度入力しなおしてください。");
									out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
									out.println("</body></html>");
								}else{
									//登録成功
									out.println("データが登録されました。");
									out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
									out.println("</body></html>");
								}
							}else{
								//不正な新しいパス
								out.println("パスワードが不適切です。8-32文字の範囲で入力しなおしてください。");
								out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
								out.println("</body></html>");
							}
						}
					}else if(newPass==null && newTwitter!=null && newFacebook==null && newMail==null){
						if(newTwitter.equals("")){
							out.println("このツイッターアカウントは登録できません。もう一度入力しなおしてください。");
							out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
							out.println("</body></html>");
						}else{
							//データのアップデート
							User tmpUser = new User(login_user.id_, login_user.university_id_,login_user.sex_,"",login_user.mail_,newTwitter,login_user.facebook_,login_user.getImageId());
							if(tmpUser.updateUser(login_user)==null) {
								//登録失敗
								out.println("データの登録に失敗しました。もう一度入力しなおしてください。");
								out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
								out.println("</body></html>");
							}else {
								//登録成功
								out.println("データが登録されました。");
								out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
								out.println("</body></html>");
							}
						}
					}else if(newPass==null && newTwitter==null && newFacebook!=null && newMail==null){
						if(newFacebook.equals("")){
							out.println("このフェイスブックアカウントは登録できません。もう一度入力しなおしてください。");
							out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
							out.println("</body></html>");
						}else{
							//データのアップデータ
							User tmpUser = new User(login_user.id_, login_user.university_id_,login_user.sex_,"",login_user.mail_,login_user.twitter_,newFacebook,login_user.getImageId());
							if(tmpUser.updateUser(login_user)==null) {
								//登録失敗
								out.println("データの登録に失敗しました。もう一度入力しなおしてください。");
								out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
							}else{
								//登録成功
								out.println("データが登録されました。");
								out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
								out.println("</body></html>");
							}
						}
					}else if(newPass==null && newTwitter==null && newFacebook==null && newMail!=null){
						if(newMail.equals("")){
							out.println("このメールアドレスは登録できません。もう一度入力しなおしてください。");
							out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
							out.println("</body></html>");
						}else{
							//データのアップデート
							User tmpUser = new User(login_user.id_, login_user.university_id_,login_user.sex_,"",newMail,login_user.twitter_,login_user.facebook_,login_user.getImageId());
							if(tmpUser.updateUser(login_user)==null) {
								//登録失敗
								out.println("データの登録に失敗しました。もう一度入力しなおしてください。");
								out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
							}else{
								//登録成功
								out.println("データが登録されました．");
								out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
							}
							out.println("</body></html>");
						}
					}else{
						out.println("申し訳ありません。データを入力しなおしてください。");
						out.println("<p>メンバートップページは<a href = \"/MyApp/servlet/MemberTop\">こちら</a></p>");
						out.println("</body></html>");
					}
				}
			}catch(SQLException e){
				out.println("エラー:"+e.toString()+"</body></html>");
			}catch(ClassNotFoundException e){
				out.println("エラー:"+e.toString()+"</body></html>");
			}
		}
	}
}
