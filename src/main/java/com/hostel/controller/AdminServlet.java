package com.hostel.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hostel.dao.RoomDAO;
import com.hostel.model.Room;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomNo = request.getParameter("roomNumber");
        String type = request.getParameter("type");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        double price = Double.parseDouble(request.getParameter("price"));

        Room r = new Room();
        r.setRoomNumber(roomNo);
        r.setType(type);
        r.setCapacity(capacity); 
        r.setPrice(price);
        
        RoomDAO dao = new RoomDAO();
        dao.addRoom(r);
        
        response.sendRedirect("admin_dashboard.jsp?msg=Room Added Successfully");
    }
}