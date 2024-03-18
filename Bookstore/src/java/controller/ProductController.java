/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookDAO;
import dal.GenreDAO;
import dal.OrderDAO;
import dal.WishlistDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Book;
import model.Genre;

/**
 *
 * @author Win
 */
public class ProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String bookID = request.getParameter("id");
        
        // get book data from dao
        BookDAO bookDao = new BookDAO();
        Book book = bookDao.get(Integer.parseInt(bookID));
        OrderDAO odao = new OrderDAO();
        List<Book> bestselling = odao.getBestsellingBook();
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        request.setAttribute("genreList", listG);
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        WishlistDAO wdao = new WishlistDAO();
        
        // set data to jsp
        if (a != null) {
            request.setAttribute("wishlist", wdao.getByUser(a.getId()));
        }
        request.setAttribute("bestselling", bestselling);
        System.out.println(book);
        request.setAttribute("book", book);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }


}
