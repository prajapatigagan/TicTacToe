//package com.example.tictactoe.controller;
//
//import java.io.IOException;
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//@WebServlet("/signup")
//public class SignupServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
////            throws ServletException, IOException {
////
////        String username = request.getParameter("username");
////        String password = request.getParameter("password");
////
////        // Save user temporarily in ServletContext (for demo)
////        getServletContext().setAttribute(username, password);
////
////        response.getWriter().println("<h3 style='color:green;text-align:center;'>Account created! Please login.</h3>");
////        request.getRequestDispatcher("login.jsp").include(request, response);
////    }
////}
//
//
//package com.example.tictactoe.controller;
//
//import java.io.IOException;
//import com.example.tictactoe.model.UserDatabase;
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//@WebServlet("/signup")
//public class SignupServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        UserDatabase.addUser(username, password);  // ✅ store user
//
//        // Redirect to login page
//        response.sendRedirect("login.jsp");
//    }
//}

package com.example.tictactoe.controller;

import java.io.IOException;
import com.example.tictactoe.model.UserDatabase;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Save user in memory
        UserDatabase.addUser(username, password);

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}

