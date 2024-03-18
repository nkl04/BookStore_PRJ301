/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dal.BookDAO;
import dal.GenreDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Book;
import model.Genre;

/**
 *
 * @author Win
 */
public class UpdateGenreController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       request.getRequestDispatcher("admin.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        
        Genre genre = new Genre();
        genre.setTitle(title);
        genre.setId(Integer.parseInt(id));
        BookDAO bdao = new BookDAO();
        GenreDAO gdao = new GenreDAO();
        
            gdao.update(genre);
            List<Book> listB = bdao.getAll();
            List<Genre> listG = gdao.getAll();
            request.setAttribute("listB", listB);
            request.setAttribute("listG", listG);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
