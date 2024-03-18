/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookDAO;
import dal.CartDAO;
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
import java.util.List;
import model.Account;
import model.Book;
import model.Genre;

/**
 *
 * @author Win
 */
public class HomeController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        BookDAO bdao = new BookDAO();
        
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        request.setAttribute("genreList", listG);
        List<Book> listLB = bdao.getLatestBook();
        OrderDAO odao = new OrderDAO();
        List<Book> bestselling = odao.getBestsellingBook();
        request.setAttribute("bestselling", bestselling);
        request.setAttribute("latest", listLB);
        
        HttpSession session = request.getSession();
         Account a = (Account) session.getAttribute("user");
         WishlistDAO wdao = new WishlistDAO();
         CartDAO cdao = new CartDAO();
         if(a != null)
         {
            request.setAttribute("cart", cdao.getCart(a.getId()));     
            request.setAttribute("wishlist", wdao.getByUser(a.getId()));
         }
        
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
        
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }


}
