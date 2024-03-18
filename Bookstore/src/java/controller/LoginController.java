/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AccountDAO;
import dal.DAO;
import dal.GenreDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Genre;

/**
 *
 * @author Win
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        request.setAttribute("genreList", listG);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String rem = request.getParameter("remember");
        
        // create cookies
        Cookie cemail = new Cookie("email", email);
        Cookie cpass = new Cookie("pass", pass);
        Cookie crem = new Cookie("rem", rem);

        
        
        if(rem != null)
        {
            cemail.setMaxAge(60*5);
            cpass.setMaxAge(60*5);
            crem.setMaxAge(60*5);
        }
        else
        {
            cemail.setMaxAge(0);
            cpass.setMaxAge(0);
            crem.setMaxAge(0);
        }
        
        response.addCookie(cemail);
        response.addCookie(cpass);
        response.addCookie(crem);
        AccountDAO dao = new AccountDAO();
        Account a = dao.login(email, pass);
        if(a == null)
        {
            request.setAttribute("mess", "Wrong email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        else 
        {
            HttpSession session = request.getSession();
            session.setAttribute("user", a);
            response.sendRedirect(request.getContextPath() + "/home");
            
        }
    }

}
