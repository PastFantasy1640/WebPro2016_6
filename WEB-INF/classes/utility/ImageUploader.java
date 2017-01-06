package utility;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/ImageUploader")
@MultipartConfig(location="/tmp", maxFileSize=1048576)
public class ImageUploader extends HttpServlet {
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    Part part = request.getPart("image");
    String name = this.getFileName(part);
    String filename = getServletContext().getRealPath("/uploads/images") + "/" + name;
    HttpSession session = request.getSession();
    if(getServletContext().getMimeType(filename).equals("image/png")
    || getServletContext().getMimeType(filename).equals("image/jpeg")
    || getServletContext().getMimeType(filename).equals("image/gif"))
    {
      ImageManager imagemanager = new ImageManager((int)session.getAttribute("ID"));
      if(imagemanager.isFailed() == false){
        name = imagemanager.getFileName();
        filename = getServletContext().getRealPath("/uploads/images") + "/" + name;
        part.write(filename);
      }
      session.setAttribute("ID",imagemanager.getId());
    }else session.setAttribute("ID",-1);

    //URL先はセッションから取得
    response.sendRedirect((String)session.getAttribute("url"));
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
}
