//package com.example.tictactoe.controller;
//
//import java.io.IOException;
//import com.example.tictactoe.model.UserDatabase;
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//@WebServlet("/login")
//public class LoginServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        if (UserDatabase.isValidUser(username, password)) {
//            HttpSession session = request.getSession();
//            session.setAttribute("username", username);
//            response.sendRedirect("playerNames.jsp");
//        } else {
//            response.getWriter().println("<h3 style='color:red;text-align:center;'>Invalid username or password!</h3>");
//            request.getRequestDispatcher("login.jsp").include(request, response);
//        }
//    }
//}

package com.example.tictactoe.controller;

import java.io.IOException;
import com.example.tictactoe.model.UserDatabase;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (UserDatabase.isValidUser(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("playerNames.jsp"); // ✅ Go to game setup
        } else {
            response.getWriter().println("<h3 style='color:red;text-align:center;'>Invalid username or password!</h3>");
            request.getRequestDispatcher("login.jsp").include(request, response);
        }
    }
}


//package com.example.tictactoe.controller;
//
//import java.io.IOException;
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//@WebServlet("/login")
//public class LoginServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        // Check saved users (demo purpose)
//        String savedUser = (String) getServletContext().getAttribute(username);
//
//        if (savedUser != null && savedUser.equals(password)) {
//            HttpSession session = request.getSession();
//            session.setAttribute("username", username);
//
//            // ✅ Set player names here (automatically from login)
//            session.setAttribute("player1", username);
//            session.setAttribute("player2", "Computer"); // or static second player
//
//            // ✅ Redirect to game (names already set)
//            response.sendRedirect("game");
//        } else {
//            request.setAttribute("error", "Invalid username or password!");
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//        }
//    }
//}
