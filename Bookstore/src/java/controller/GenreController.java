/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookDAO;
import dal.GenreDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Book;
import model.Genre;

/**
 *
 * @author Win
 */
public class GenreController extends HttpServlet {

    private HashMap<String, String> sortTitle = new HashMap<>(){
        {
            put("title-ascending", "Alphabetically, A-Z");
            put("title-descending", "Alphabetically, Z-A");
            put("price-ascending", "Price, low to high");
            put("price-descending", "Price, high to low");
            put("date-ascending", "Date, old to new");
            put("date-descending", "Date, new to old");
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
        String genreTitle = request.getParameter("title");
        genreTitle = genreTitle.replaceAll("-", " ").replace("and", "&");

        // get book data from dao
        BookDAO bookDao = new BookDAO();
        List<Book> listB = new ArrayList<>();
        if(sort != null)
        {
        switch(sort)
        {
            case "title-ascending":
                listB = bookDao.sortTitleAscBookByGenre(genreTitle,index);
                valSelect = sortTitle.get("title-ascending");
                break;
            case "title-descending":
                listB = bookDao.sortTitleDescBookByGenre(genreTitle,index);
                valSelect = sortTitle.get("title-descending");
                break;
            case "price-ascending":
                listB = bookDao.sortPriceAscBookByGenre(genreTitle,index);
                valSelect = sortTitle.get("price-ascending");
                break;
            case "price-descending":
                listB = bookDao.sortPriceDescBookByGenre(genreTitle,index);
                valSelect = sortTitle.get("price-descending");
                break;
            case "date-ascending":
                listB = bookDao.sortDateAscBookByGenre(genreTitle,index);
                valSelect = sortTitle.get("date-ascending");
                break;
            case "date-descending":
                listB = bookDao.sortDateDescBookByGenre(genreTitle,index);
                valSelect = sortTitle.get("date-descending");
                break;
            default:
                
                break;
        }
        } else 
        {
            listB = bookDao.pagingBookByGenre(genreTitle,index);
                valSelect = "Select your value";
        }
        
        int count = bookDao.getAmountBookByGenre(genreTitle);
        int endPage = count / 10;
        
        if(count % 10 != 0)
        {
            endPage++;
        }
        
        // get Genre of book from dao;
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        
        // set data to jsp
        request.setAttribute("bookList", listB);
        request.setAttribute("genreList", listG);
        request.setAttribute("tag", genreTitle);
        request.setAttribute("endP", endPage);
        request.setAttribute("sort", valSelect);
        request.getRequestDispatcher("collections.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }

}
