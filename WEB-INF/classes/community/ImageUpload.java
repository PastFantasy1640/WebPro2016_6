package community;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.ServletConfig;

@WebServlet("/ImageUpload")
@MultipartConfig(location="/tmp", maxFileSize=1048576)
public class ImageUpload{

    static public void post
    (HttpServletRequest request,
     HttpServletResponse response,
     ServletConfig config)
      throws ServletException, IOException {
        Part part = request.getPart("file");
        String name = ImageUpload.getFileName(part);
        part.write(config.getServletContext().getRealPath("/WEB-INF/uploaded") + "/" + name);
        //response.sendRedirect("jsp/upload.jsp");
    }

    static private String getFileName(Part part) {
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