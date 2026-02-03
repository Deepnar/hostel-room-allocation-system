<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.hostel.dao.RoomDAO, com.hostel.model.Room, com.hostel.model.User" %>
<%
    request.setCharacterEncoding("UTF-8"); // FORCE UTF-8
    User user = (User) session.getAttribute("currentUser");
    if(user == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <meta charset="UTF-8">
</head>
<body>

    <nav class="navbar">
        <h2 style="font-weight: 600; color: var(--text-coffee);">ZenHostel</h2>
        <div style="display: flex; align-items: center; gap: 20px;">
            <span style="color: var(--text-muted);">Hello, <b><%= user.getName() %></b></span>
            <span class="badge"><%= user.getRole() %></span>
            <a href="profile.jsp" class="btn-zen btn-secondary" style="padding: 8px 16px; font-size: 0.9rem;">My Profile</a>
            <a href="login.jsp" class="btn-zen btn-secondary" style="padding: 8px 16px; font-size: 0.9rem; background: #ffebee; color: #c62828;">Logout</a>
        </div>
    </nav>

    <div style="text-align: center; margin-top: 3rem;">
        <h1 style="font-size: 2.5rem; color: var(--text-coffee);">Find Your Space</h1>
        <p style="color: var(--text-muted);">Select a room that fits your vibe.</p>
        
        <% String msg = request.getParameter("msg"); 
           if(msg != null) { %>
            <div style="background: #ffebee; color: #c62828; padding: 15px; border-radius: 8px; display: inline-block; margin-top: 15px; border: 1px solid #ffcdd2;">
                ⚠️ <%= msg %>
            </div>
        <% } %>

        <% if(user.getRole().equals("STUDENT")) { %>
            <div style="margin-top: 1rem; color: var(--accent-ochre); font-weight: 600;">
                ✨ Student Discount Active (20% Off)
            </div>
        <% } %>
    </div>

    <div class="grid-container">
        <%
            RoomDAO dao = new RoomDAO();
            List<Room> rooms = dao.getAllRooms();
            for(Room r : rooms) {
        %>
        <div class="card room-card">
            <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                <div>
                    <h3 style="color: var(--text-coffee);">Room <%= r.getRoomNumber() %></h3>
                    <span style="color: var(--text-muted); font-size: 0.9rem;"><%= r.getType() %></span>
                    <br>
                    <span style="font-size: 0.8rem; background: #eee; padding: 2px 6px; border-radius: 4px;">
                        Capacity: <%= r.getCapacity() %> Person(s)
                    </span>
                </div>
                <h3 style="color: var(--accent-orange);">&#8377;<%= (int)r.getPrice() %></h3>
            </div>
            
            <hr style="border: 0; border-top: 1px solid var(--surface-latte); margin: 1.5rem 0;">

            <div style="display: flex; justify-content: space-between; align-items: center;">
                <% if(r.getStatus().equals("AVAILABLE")) { %>
                    <span style="color: green; font-size: 0.9rem;">● Available</span>
                    <a href="booking.jsp?id=<%= r.getId() %>&price=<%= r.getPrice() %>" 
                       class="btn-zen btn-primary" style="padding: 8px 20px;">Book</a>
                <% } else { %>
                    <span style="color: var(--text-muted); font-size: 0.9rem;">● Occupied</span>
                    <button class="btn-zen btn-secondary" disabled style="opacity: 0.5; cursor: not-allowed;">Booked</button>
                <% } %>
            </div>
        </div>
        <% } %>
    </div>

</body>
</html>