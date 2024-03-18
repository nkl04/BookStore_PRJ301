/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookDAO;
import dal.CartDAO;
import dal.OrderDAO;
import dal.OrderLineDAO;
import dal.WishlistDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Account;
import model.Book;
import model.Cart;
import model.Order;
import model.OrderLine;

/**
 *
 * @author Win
 */
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        CartDAO cdao = new CartDAO();
        WishlistDAO wdao = new WishlistDAO();
        
        request.setAttribute("wishlist", wdao.getByUser(a.getId()));
        
        if(action == null)
        {
            request.setAttribute("cart", cdao.getCart(a.getId()));
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
        else if(action.equalsIgnoreCase("buy"))
        {
            doGet_Buy(request, response);
        }
        else if(action.equalsIgnoreCase("remove"))
        {
            doGet_Remove(request, response);
        }
        else if(action.equalsIgnoreCase("checkout"))
        {
            doGet_Checkout(request, response);
        }
        else if(action.equalsIgnoreCase("thanks"))
        {
            doGet_Thanks(request, response);
        }
        
    } 
    protected void doGet_Checkout(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        OrderDAO orderDao = new OrderDAO();
        OrderLineDAO orderLineDao = new OrderLineDAO();
        CartDAO cdao = new CartDAO();
        HttpSession session = request.getSession();
        Account user = (Account)session.getAttribute("user");
        BookDAO bdao = new BookDAO();
        // add new order
        Order order = new Order();
        order.setUser(user);
        SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
        order.setOrderDate(ft.format(new Date()));
        order.setOrderStatus("Done");
        int orderID = orderDao.saveAndReturnID(order);
        
        // add invoice details
        List<Cart> cart = cdao.getCart(user.getId());
        for(Cart b : cart)
        {
            OrderLine orderLine = new OrderLine();
            orderLine.setOrderID(orderID);
            orderLine.setBook(b.getBook());
            orderLine.setPrice(b.getBook().getPrice());
            orderLine.setQuantity(b.getQuantity());
            orderLineDao.save(orderLine);
            
            // update quantity of book
            int remain = b.getBook().getQtyInStock() -  b.getQuantity();
            
            b.getBook().setQtyInStock(remain);
            bdao.update(b.getBook());
        }
        
        // Clear cart
        Cart userCart = new Cart();
        userCart.setUser(user);
        cdao.delete(userCart);
        
        response.sendRedirect("cart?action=thanks");
    }
    protected void doGet_Thanks(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("thanks.jsp").forward(request, response);
    }
    protected void doGet_Remove(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int index = Integer.parseInt(request.getParameter("index"));
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("user");
            CartDAO cdao = new CartDAO();
            List<Cart> cart = cdao.getCart(a.getId());
            cdao.deleteCartItem(cart.get(index));
            request.setAttribute("cart", cdao.getCart(a.getId()));
            request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
    protected void doGet_Buy(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // handle buy
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("user");
            CartDAO cdao = new CartDAO();
            BookDAO bdao = new BookDAO();
            Book book = bdao.get(id);
            if(book.getQtyInStock() == 0){
                request.setAttribute("cart", cdao.getCart(a.getId()));
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }
            
            List<Cart> cart = cdao.getCart(a.getId());
            
            if(cart.isEmpty())
            {
                cdao.save(new Cart(a, book, 1));
            }
            else 
            {
                int index = exists(id, cart);
                if(index == -1)
                {
                    cdao.save(new Cart(a, book, 1));
                }
                else 
                {
                    int newQuantity = cart.get(index).getQuantity() + 1;
                    cart.get(index).setQuantity(newQuantity);
                    cdao.update(cart.get(index));
                }
            }
            request.setAttribute("cart", cdao.getCart(a.getId()));
            request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
    private int exists(int productId, List<Cart> cart)
    {
        for (int i = 0; i < cart.size(); i++) {
            if(cart.get(i).getBook().getId() == productId)
            {
                return i;
            }
        }
        return -1;
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int index = Integer.parseInt(request.getParameter("index"));
        CartDAO cdao = new CartDAO();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        List<Cart> cart = cdao.getCart(a.getId());
        if(quantity > cart.get(index).getBook().getQtyInStock())
        {
            // alert
        }
        else {
            cart.get(index).setQuantity(quantity);
            cdao.update(cart.get(index));
        }
        request.setAttribute("cart", cdao.getCart(a.getId()));
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
