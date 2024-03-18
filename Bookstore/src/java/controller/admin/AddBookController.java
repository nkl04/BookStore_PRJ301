/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dal.BookDAO;
import dal.GenreDAO;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import model.Book;
import model.Genre;
import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.jakarta.JakartaServletDiskFileUpload;

/**
 *
 * @author Win
 */
public class AddBookController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        System.out.println("post add");
//         String title = request.getParameter("title");
//        String author = request.getParameter("author");
//        String publisher = request.getParameter("publisher");
//        String description = request.getParameter("description");
//        String genre = request.getParameter("genre");
//        String language = request.getParameter("language");
//        String publicationDate = request.getParameter("publicationDate");
//        String bookImage = request.getParameter("bookImage");
//        String qtyInStock = request.getParameter("qtyInStock");
//        String price = request.getParameter("price").substring(1);
//        String pages = request.getParameter("pages");
        
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
        
        Book book = new Book();
        book.setAuthor(fields.get("author"));
        book.setBookImage(filename);
        book.setDescription(fields.get("description"));
        book.setGenre(fields.get("genre"));
        book.setLanguage(fields.get("language"));
        book.setPages(Integer.parseInt(fields.get("pages")));
        book.setPrice(Float.parseFloat(fields.get("price")));
        book.setPublicationDate(fields.get("publicationDate"));
        book.setPublisher(fields.get("publisher"));
        book.setQtyInStock(Integer.parseInt(fields.get("qtyInStock")));
        book.setTitle(fields.get("title"));

        BookDAO bdao = new BookDAO();
        GenreDAO gdao = new GenreDAO();
        
        List<Book> listB = bdao.getAll();
        List<Genre> listG = gdao.getAll();
        if(bdao.checkExist(fields.get("title")))
        {
            String mes = "Title is exist already";
            
        
        request.setAttribute("listB", listB);
        request.setAttribute("listG", listG);
        request.setAttribute("mes", mes);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
        else{
            bdao.save(book);
            listB = bdao.getAll();
            request.setAttribute("listB", listB);
            request.setAttribute("listG", listG);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
        
    }


}
