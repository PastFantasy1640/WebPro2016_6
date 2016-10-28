// 
// MemberTop.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

// 
public class MemberTop extends HttpServlet {
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
		String iddata = hreq.getParameter("IdData");
		String passdata = hreq.getParameter("Password");

		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		// ここまでは以降もそのまま使う
		out.println("<title>MemberTop</title></head>");
		out.println("<body>"
		 + " id " + iddata + " さんようこそ。"
		 + "</body>"
		 + "</html>");
	}
}
