package com.hostel.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hostel.dao.UserDAO;
import com.hostel.model.User;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();

        if ("register".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            
            String role = "GUEST";
            if(email != null && email.endsWith("@uni.edu")) {
                role = "STUDENT";
            }
            
            dao.register(name, email, pass, role);
            
            response.sendRedirect("login.jsp?msg=Registration Successful! Please Login.");
            
        } else if ("login".equals(action)) {
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            
            User user = dao.login(email, pass);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);

                if ("ADMIN".equals(user.getRole())) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    response.sendRedirect("dashboard.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?msg=Invalid Credentials");
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}