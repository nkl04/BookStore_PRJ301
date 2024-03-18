package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import dal.BookDAO;
import dal.CartDAO;
import dal.GenreDAO;
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
import model.Cart;
import model.Genre;
import model.Wishlist;

/**
 *
 * @author Win
 */
public class WishlistController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        WishlistDAO wdao = new WishlistDAO();
        CartDAO cdao = new CartDAO();
        
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        request.setAttribute("genreList", listG);
                
        request.setAttribute("cart", cdao.getCart(a.getId()));
        request.setAttribute("wishlist", wdao.getByUser(a.getId()));
        if(action == null)
        {
            
            request.setAttribute("wishlist", wdao.getByUser(a.getId()));
            request.getRequestDispatcher("wishlist.jsp").forward(request, response);
        }
        else if(action.equalsIgnoreCase("add"))
        {
            doGet_Add(request, response);
        }
        else if(action.equalsIgnoreCase("remove"))
        {
            doGet_Remove(request, response);
        }
        else if(action.equalsIgnoreCase("move"))
        {
            doGet_Move(request, response);
        }
    } 
    protected void doGet_Move(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            BookDAO bdao = new BookDAO();
            Book book = bdao.get(id);
            Account a = (Account) session.getAttribute("user");
            WishlistDAO wdao = new WishlistDAO();
            List<Wishlist> wishlist = wdao.getByUser(a.getId());
            
            if(wishlist.isEmpty())
            {
                wdao.save(new Wishlist(a, book));
            }
            else 
            {
                int found = exists(id, wishlist);
                if(found == -1)
                {
                    wdao.save(new Wishlist(a, book));
                }
                else 
                {
                    request.getRequestDispatcher("wishlist.jsp").forward(request, response);
                    return;
                }
            }
            
            CartDAO cartDao = new CartDAO();
            Cart cart = new Cart();
            cart.setUser(a);
            cart.setBook(book);
            cartDao.deleteCartItem(cart);
            request.setAttribute("cart", cartDao.getCart(a.getId()));
            request.setAttribute("wishlist", wdao.getByUser(a.getId()));
            request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }
     protected void doGet_Remove(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("user");
            WishlistDAO wdao = new WishlistDAO();
            List<Wishlist> wishlist = wdao.getByUser(a.getId());
            for (Wishlist w : wishlist) {
                if(w.getBook().getId() == id)
                {
                    wdao.delete(w);
                }
            }
            
            request.setAttribute("wishlist", wdao.getByUser(a.getId()));
            request.getRequestDispatcher("wishlist.jsp").forward(request, response);
     }
    protected void doGet_Add(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // handle buy
            int id = Integer.parseInt(request.getParameter("id"));
            BookDAO bdao = new BookDAO();
            Book book = bdao.get(id);
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("user");
            WishlistDAO wdao = new WishlistDAO();
            List<Wishlist> wishlist = wdao.getByUser(a.getId());
            
            if(wishlist.isEmpty())
            {
                wdao.save(new Wishlist(a, book));
            }
            else 
            {
                int index = exists(id, wishlist);
                if(index == -1)
                {
                    wdao.save(new Wishlist(a, book));
                }
                else 
                {
                    request.getRequestDispatcher("wishlist.jsp").forward(request, response);
                    return;
                }
            }
            request.setAttribute("wishlist", wdao.getByUser(a.getId()));
            request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }
    private int exists(int productId, List<Wishlist> cart)
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
        
    }


}
