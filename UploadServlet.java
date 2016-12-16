import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.PrintWriter;
import java.io.*;

@WebServlet("/UploadServlet")
@MultipartConfig(location="/tmp", maxFileSize=1048576)
public class UploadServlet extends HttpServlet {
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    Part part = request.getPart("image");
    String name = this.getFileName(part);
    String filename = getServletContext().getRealPath("/webpro/WebPro2016_6/image") + "/" + name;
    part.write(filename);
    File file = new File("/usr/local/MyApp/check.txt");
    if(checkBeforeWritefile(file)){
      PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter(file)));
      pw.println(getServletContext().getMimeType(filename));

      pw.close();
    }
    response.sendRedirect("/MyApp/circle_admin.jsp");
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
  private static boolean checkBeforeWritefile(File file){
    if (file.exists()){
      if (file.isFile() && file.canWrite()){
        return true;
      }
    }

    return false;
  }
}