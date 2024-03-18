/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AccountDAO;
import dal.CartDAO;
import dal.GenreDAO;
import dal.WishlistDAO;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import model.Account;
import model.Genre;
import org.apache.commons.fileupload2.core.DiskFileItem;
import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.jakarta.JakartaServletDiskFileUpload;

/**
 *
 * @author Win
 */
@MultipartConfig
public class ProfileController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        WishlistDAO wdao = new WishlistDAO();
        CartDAO cdao = new CartDAO();
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        request.setAttribute("genreList", listG);
        request.setAttribute("cart", cdao.getCart(a.getId()));     
        request.setAttribute("wishlist", wdao.getByUser(a.getId()));

        request.getRequestDispatcher("profile.jsp").forward(request, response);

    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        Part part = request.getPart("photo");
//        String firstName = request.getParameter("fname");
//        String lastName = request.getParameter("lname");
//        String email = request.getParameter("email");
//        String address = request.getParameter("address");
    String filename = null;
// Create a factory for disk-based file items
        DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
        ServletContext servletContext = this.getServletConfig().getServletContext();
// Create a new file upload handler
JakartaServletDiskFileUpload upload = new JakartaServletDiskFileUpload(factory);

// Set overall request size constraint

// Parse the request
 List fileItems = upload.parseRequest(request);

// Process the uploaded items
// Process the uploaded items
Iterator<FileItem> iter = fileItems.iterator();
HashMap<String, String> fields = new HashMap<>();
while (iter.hasNext()) {
    FileItem item = iter.next();
    if (item.isFormField()) {
        fields.put(item.getFieldName(), item.getString());
        String name = item.getFieldName();
        String value = item.getString();
    } else {
        filename = item.getName();
        if(filename == null || filename.equals(""))
        {
            break;
        }
        else 
        {
            Path path = Paths.get(filename);
            String storePath = servletContext.getRealPath("/images");
            File uploadFile = new File(storePath + "/" + path.getFileName());
            item.write(uploadFile.toPath());
            System.out.println(storePath + "/" + path.getFileName());
        }
        
    }
}
HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        AccountDAO dao = new AccountDAO();
        Account a = dao.get(user.getId());
        
        a.setFirstName(fields.get("fname"));
        
        a.setLastName(fields.get("lname"));
        a.setEmail(fields.get("email"));
        a.setAddress(fields.get("address"));
        a.setImage(filename);
        System.out.println(a);
        dao.update(a);
        session.setAttribute("user", a);
response.sendRedirect("profile");
    }

}
