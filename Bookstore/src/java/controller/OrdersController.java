/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CartDAO;
import dal.OrderDAO;
import dal.OrderLineDAO;
import dal.WishlistDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.OrderLine;

/**
 *
 * @author Win
 */
public class OrdersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        WishlistDAO wdao = new WishlistDAO();
        CartDAO cdao = new CartDAO();
        request.setAttribute("cart", cdao.getCart(a.getId()));     
        request.setAttribute("wishlist", wdao.getByUser(a.getId()));
        if(action.equalsIgnoreCase("view"))
        {
            doGet_View(request, response);
        }
        else if(action.equalsIgnoreCase("orderDetail"))
        {
            doGet_OrderDetail(request, response);
        }
    } 
    protected void doGet_View(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        OrderDAO orderDao = new OrderDAO();
        Account user = (Account) session.getAttribute("user");
        request.setAttribute("orders", orderDao.getByUser(user.getId()));
        request.getRequestDispatcher("orders.jsp").forward(request, response);
    }
    
    protected void doGet_OrderDetail(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        OrderDAO orderDao = new OrderDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        OrderLineDAO orderLineDao = new OrderLineDAO();
        
        request.setAttribute("orders", orderDao.get(id));
        request.setAttribute("orderLine", orderLineDao.getByOrder(id));
        request.getRequestDispatcher("orderdetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
