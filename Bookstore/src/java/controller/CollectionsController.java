/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookDAO;
import dal.CartDAO;
import dal.GenreDAO;
import dal.WishlistDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import model.Account;
import model.Book;
import model.Genre;

/**
 *
 * @author Win
 */
@WebServlet(urlPatterns={"/collections"})
public class CollectionsController extends HttpServlet {
   
    private HashMap<String, String> sortTitle = new HashMap<>(){
        {
            put("title-ascending", "A-Z");
            put("title-descending", "Z-A");
            put("price-ascending", "Low to high");
            put("price-descending", "High to low");
            put("date-ascending", "Old to New");
            put("date-descending", "New to Old");
        }
    };
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String indexPage = request.getParameter("index");
        String sort = request.getParameter("sort");
        if(indexPage == null)
        {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        String valSelect = null;
        
        // get book data from dao
        BookDAO bookDao = new BookDAO();
        List<Book> listB = new ArrayList<>();
        if(sort != null)
        {
        switch(sort)
        {
            case "title-ascending":
                listB = bookDao.sortTitleAscBook(index);
                valSelect = sortTitle.get("title-ascending");
                break;
            case "title-descending":
                listB = bookDao.sortTitleDescBook(index);
                valSelect = sortTitle.get("title-descending");
                break;
            case "price-ascending":
                listB = bookDao.sortPriceAscBook(index);
                valSelect = sortTitle.get("price-ascending");
                break;
            case "price-descending":
                listB = bookDao.sortPriceDescBook(index);
                valSelect = sortTitle.get("price-descending");
                break;
            case "date-ascending":
                listB = bookDao.sortDateAscBook(index);
                valSelect = sortTitle.get("date-ascending");
                break;
            case "date-descending":
                listB = bookDao.sortDateDescBook(index);
                valSelect = sortTitle.get("date-descending");
                break;
            default:
                break;
        }
        } else 
        {
            listB = bookDao.pagingBook(index);
                valSelect = "Select your value";
        }
        
        
        //
        int count = bookDao.getTotalAmountBook();
        int endPage = count / 10;
        
        if(count % 10 != 0)
        {
            endPage++;
        }
        
        
        // get Genre of book from dao;
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        WishlistDAO wdao = new WishlistDAO();
        CartDAO cdao = new CartDAO();
        // set data to jsp
        if(a != null)
        {
            request.setAttribute("cart", cdao.getCart(a.getId()));
        request.setAttribute("wishlist", wdao.getByUser(a.getId()));
        }
        
        request.setAttribute("bookList", listB);
        request.setAttribute("genreList", listG);
        request.setAttribute("endP", endPage);
        request.setAttribute("sort", valSelect);
        
        request.getRequestDispatcher("collections.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }
}


