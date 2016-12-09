// 
// ChangeMyInf.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

// 
public class ChangeMyInf extends HttpServlet {
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
		HttpSession session = hreq.getSession(false);
		if(session == null){
			session = hreq.getSession(true);
			hres.sendRedirect("../webpro/WebPro2016_6/LoginPage.html");
			session.setAttribute("Login",0);
		}else{
			if((int)session.getAttribute("Login")==1){
				String target = hreq.getParameter("Target");
				// HTMLテキストの出力
				out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
				out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
				out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
				// ここまでは以降もそのまま使う
				out.println("<title>ChangeMyInf</title></head>");
				if(target.equals("pass")){
					out.println("<body>"
					 + "<h2>パスワード変更</h2>"
					 + "<form action=\"ChangedMyInf\">"
					 + "<table border=\"0\">"
					 + "<tr><td align=\"right\">新しいパスワード:</td>
					 + "<td><input type=\"password\" name=\"pass\" size=32 maxlength=32></td></tr>"
					 + "<tr><td align=\"right\">新しいパスワード（確認）:</td>
					 + "<td><input type=\"password\" name=\"pass2\" size=32 maxlength=32></td></tr>"
					 + "<tr><td align=\"right\">変更前のパスワード:</td>
					 + "<td><input type=\"password\" name=\"oldpass\" size=32 maxlength=32></td></tr>"
					 + "</table>"
					 + "<input type=\"submit\" value=\"変更\">"
					 + "</form>"
					 + "</body>"
					 + "</html>");
				}else if(target.equals("twitter")){
					out.println("<body>"
					+"</body>"
					+"</html>");
				}else if(taget.equals("facebook")){
					out.println("<body>"
					+"</body>"
					+"</html>");
				}else if(target.equals("mail")){
					out.println("<body>"
					+"</body>"
					+"</html>");
				}
			}else{
				hres.sendRedirect("../webpro/WebPro2016_6/LoginPage.html");
			}	
		}
	}
}
