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
import java.util.List;
import model.Book;
import model.Genre;

/**
 *
 * @author Win
 */
public class SearchController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String txt = request.getParameter("text");
        
        // get book data from dao
        BookDAO bookDao = new BookDAO();
        List<Book> listB = new ArrayList<>();
        listB = bookDao.searchBookByName(txt);
        
        // get Genre of book from dao;
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        
        request.setAttribute("bookList", listB);
        request.setAttribute("genreList", listG);
        request.getRequestDispatcher("collections.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }


}
