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
public class AddGenreController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String title = request.getParameter("title");
        
        Genre genre = new Genre();
        genre.setTitle(title);
        
        BookDAO bdao = new BookDAO();
        GenreDAO gdao = new GenreDAO();
        
        List<Book> listB = bdao.getAll();
        List<Genre> listG = gdao.getAll();
        if(gdao.checkExist(title))
        {
            String mes = "Title is exist already";  
            request.setAttribute("listB", listB);
            request.setAttribute("listG", listG);
            request.setAttribute("mes", mes);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
        else{
            gdao.save(genre);
            listG = gdao.getAll();
            request.setAttribute("listB", listB);
            request.setAttribute("listG", listG);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }


}
