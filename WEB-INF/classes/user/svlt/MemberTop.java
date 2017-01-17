// 
// MemberTop.java
// 

package user.svlt;

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import user.User;
import utility.ImageManager;
import circle.Circle;
import java.util.ArrayList;

// 
public class MemberTop extends HttpServlet {
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
		}
		ImageManager icon = new ImageManager(login_user.getImageId());
		
		ArrayList<Circle> hosting_circles = null;
		try{
			hosting_circles = Circle.getCirclesFromLeaderId(login_user.uuid_);
		}catch(SQLException | ClassNotFoundException e){
			throw new ServletException(e.toString());
		}
		
		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		// ここまでは以降もそのまま使う
		out.println("<title>MemberTop</title></head>");
		out.println("<body>"
			 + "<p> id " + login_user.id_ + " さんようこそ。</p>");
		out.println("<img src=\"/MyApp/uploads/images/" + icon.url_ + "\" alt=\"" + Integer.toString(icon.id_) + "\"/>");
		out.println("<p><a href = \"/MyApp/\">Topへ</a></p>"
			+ "<p><a href = \"ChangeMyInfo?Target=pass\">パスワード変更</a></p>"
			 + "<p><a href = \"ChangeMyInfo?Target=twitter\">ツイッターアカウント変更</a></p>"
			 + "<p><a href = \"ChangeMyInfo?Target=facebook\">フェイスブックアカウント変更</a></p>"
			 + "<p><a href = \"ChangeMyInfo?Target=mail\">メールアドレス変更</a></p>"
			 + "<p><a href = \"ChangeMyInfo?Target=image\">画像変更</a></p>"
			 + "<p><a href = \"/MyApp/sites/circle/circle_regist.jsp\">サークル作成</a></p>");
		out.println("<p><h2>現在あなたが部長であるサークル一覧</h2>");
		if(hosting_circles.size() > 0){
			out.println("<ul>");
			for(Circle cs : hosting_circles){
				out.println("<li><a href=\"/MyApp/sites/circle/ResultCircle1.jsp?id=" + cs.id_ + "\">" + cs.name_ + "</a></li>");
			}
			out.println("</ul>");
		}else{
			out.println("あなたが部長のサークルはありません");
		}
		
		out.println("</p>");
		
		out.println("<form action=\"Logout\">"
			 + "<input type=\"submit\" value=\"logout\">"
			 + "</form>"
			 + "<p>退会は<a href = \"../webpro/WebPro2016_6/DeleteUser.html\">こちら</a></p>"
			 + "</body>"
			 + "</html>");
	}
}
