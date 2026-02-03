package com.hostel.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hostel.dao.BookingDAO;
import com.hostel.model.Booking;
import com.hostel.model.User;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        
        // 1. FIXED: Check if user is null FIRST to avoid crash
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Initialize DAO once
        BookingDAO dao = new BookingDAO();

        // 3. Check for double booking
        if(dao.hasActiveBooking(user.getId())) {
            response.sendRedirect("dashboard.jsp?msg=You already have an active booking! Check your profile.");
            return;
        }

        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String college = request.getParameter("college");
        int duration = Integer.parseInt(request.getParameter("duration"));
        double pricePerMonth = Double.parseDouble(request.getParameter("price"));

        // 4. Calculate Total
        double total = pricePerMonth * duration;
        
        // Apply Discount
        if ("STUDENT".equals(user.getRole())) {
            total = total * 0.80; 
        }

        Booking b = new Booking();
        b.setUserId(user.getId());
        b.setRoomId(roomId);
        b.setCollegeName(college);
        b.setDuration(duration);
        b.setTotalAmount(total);

        dao.createBooking(b);

        response.sendRedirect("profile.jsp?msg=Booking Successful!");
    }
}