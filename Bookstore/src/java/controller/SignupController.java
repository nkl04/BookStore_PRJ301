/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AccountDAO;
import dal.GenreDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
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
public class SignupController extends HttpServlet {
   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        GenreDAO genreDao = new GenreDAO();
        List<Genre> listG = genreDao.getAll();
        request.setAttribute("genreList", listG);
      request.getRequestDispatcher("signup.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String firstName = request.getParameter("firstName");
       String lastName = request.getParameter("lastName");
       String email = request.getParameter("email");
       String pass = request.getParameter("pass");
       String address = request.getParameter("address");
       
       
       
        System.out.println(address);
       AccountDAO dao = new AccountDAO();
       Account a = dao.getUserByEmail(email);
       if(a == null) // duoc register
       {
           dao.save(new Account(firstName, lastName, email, pass, address, 0));
           HttpSession session = request.getSession();
            session.setAttribute("user", dao.login(email, pass));
           response.sendRedirect("home");
       }
       else // quay ve sign up
       {
           request.setAttribute("mess", "The email is in use");
           request.getRequestDispatcher("signup.jsp").forward(request, response);
       }
    }


}
