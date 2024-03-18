/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dal.AccountDAO;
import dal.BookDAO;
import dal.GenreDAO;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import model.Account;
import model.Book;
import model.Genre;
import model.Order;

/**
 *
 * @author Win
 */
public class AdminController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {        
        BookDAO bdao = new BookDAO();
        GenreDAO gdao = new GenreDAO();
        OrderDAO odao = new OrderDAO();
        AccountDAO adao = new AccountDAO();
        
        List<Book> listB = bdao.getAll();
        List<Genre> listG = gdao.getAll();
        List<Order> listO = odao.getAll();
        List<Account> listU = adao.getAll();
        
        request.setAttribute("listB", listB);
        request.setAttribute("listG", listG);
        request.setAttribute("listO", listO);
        request.setAttribute("listU", listU);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
        // Handle the case where the response has already been committed
        // You may log an error, redirect to an error page, or take other appropriate action
        // For example:
        // response.sendRedirect("error.jsp");
    }
//System.out.println("servlet");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        
        
        
    }


}
