// 
// RegistUser.java
// 

// 必要なパッケージの指定
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import java.sql.*;

 
public class RegistUser extends HttpServlet {
	public void doPost(HttpServletRequest hreq,	// リクエスト
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
		String pass2 = hreq.getParameter("password2");
		String mail = hreq.getParameter("mail");
		String twitter = hreq.getParameter("twitter");
		String facebook = hreq.getParameter("facebook");

		// 性別の文字列化
		String sex2;
		if(sex == null) {
			sex2 = "";
		} else if(sex.equals("1")){
			sex2 = "男";
		} else
			sex2 = "女";

		// HTMLテキストの出力
		out.println("<html><head><meta http-equiv=\"Pragma\" content=\"no-cache\">");
		out.println("<meta http-equiv=\"Expires\" content=\"-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		// ここまでは以降もそのまま使う
		out.println("<title>ユーザー登録確認画面</title></head>");
		out.println("<body>");
		if(userId.equals("") || universityId.equals("") || pass.equals("") || sex2.equals("")){
			out.println("未記入項目があります。入力しなおしてください。");
			out.println("<p>再入力は<a href = \"Regist\">こちら</a></p>");
		}else if(!pass.equals(pass2)){
			out.println("パスワードが一致しません。入力しなおしてください。");
			out.println("<p>再入力は<a href = \"Regist\">こちら</a></p>");
		}else{
			Connection db=null;
			try{
				Class.forName("org.gjt.mm.mysql.Driver");
				String db_name="circle_triangle";
				db=DriverManager.getConnection("jdbc:mysql://localhost/"+db_name+"?user=chef&password=secret&useUnicode=true&characterEncoding=utf-8");
				Statement st=db.createStatement();
				String query="select name from universities where id="+universityId;
				ResultSet rs=st.executeQuery(query);
				String uniName="";
				if(rs.next()){
					uniName=rs.getString("name");
				}
				out.println("<body>"
				 + "以下の情報で登録します。"
				 + "<table border=\"0\">"
				 + "<tr><td align=\"right\">ユーザーID:</td>"+"<td>"+userId+"</td></tr>"
				 + "<tr><td align=\"right\">大学名:</td>"+"<td>"+uniName+"</td></tr>"
				 + "<tr><td align=\"right\">性別:</td>"+"<td>"+sex2+"</td></tr>"
				 + "<tr><td align=\"right\">パスワード:</td><td>表示なし</td></tr>"
				 + "<tr><td align=\"right\">メール:</td>"+"<td>"+mail+"</td></tr>"
				 + "<tr><td align=\"right\">twitter:</td>"+"<td>"+twitter+"</td></tr>"
				 + "<tr><td align=\"right\">facebook:</td>"+"<td>"+facebook+"</td></tr>"
				 + "</table>");

			

				//登録情報記憶
				HttpSession session = hreq.getSession(true);

				session.setAttribute("IdData",userId);
				session.setAttribute("UniversityId",universityId);
				session.setAttribute("sex",sex);
				session.setAttribute("password",pass);
				session.setAttribute("mail",mail);
				session.setAttribute("twitter",twitter);
				session.setAttribute("facebook",facebook);

				out.println("<form method=\"POST\" enctype=\"multipart/form-data\" action = SignupPage>"
				+ "<input type=\"submit\" value=\"登録\">"
				+ "</form>");
				rs.close();
				st.close();
				db.close();
			}catch(SQLException e){
				out.println("接続失敗<br>"+e.toString());
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				try{
					db.close();
				}catch(Exception e){}
			}
		}
		out.println("</body></html>");
	}
}
