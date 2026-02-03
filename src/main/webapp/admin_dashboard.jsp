<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, com.hostel.util.DBConnection, com.hostel.dao.*, com.hostel.model.*" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if(user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel | ZenHostel</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    <nav class="navbar">
        <h2>Admin Panel</h2>
        <div>
            <span style="margin-right: 15px;">Welcome, <b>Warden</b></span>
            <a href="login.jsp" class="btn-zen btn-secondary">Logout</a>
        </div>
    </nav>

    <%
        int totalRooms = 0, bookedRooms = 0, totalStudents = 0;
        double totalEarnings = 0.0;

        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            
            // Stats Queries
            ResultSet rs1 = stmt.executeQuery("SELECT count(*) as total, sum(case when status='BOOKED' then 1 else 0 end) as booked FROM rooms");
            if(rs1.next()) { totalRooms = rs1.getInt("total"); bookedRooms = rs1.getInt("booked"); }
            
            ResultSet rs2 = stmt.executeQuery("SELECT sum(total_amount) as earnings, count(*) as students FROM bookings");
            if(rs2.next()) { totalEarnings = rs2.getDouble("earnings"); totalStudents = rs2.getInt("students"); }
            
            con.close();
        } catch(Exception e) { e.printStackTrace(); }
    %>

    <div class="container" style="padding: 2rem; max-width: 1200px; margin: 0 auto;">
        
        <div class="analytics-grid">
            <div class="stat-card earnings">
                <h3>Total Revenue</h3>
                <div class="stat-num">₹<%= (int)totalEarnings %></div>
                <p>Lifetime earnings</p>
            </div>

            <div class="stat-card occupancy">
                <h3>Occupancy Rate</h3>
                <div class="stat-num"><%= bookedRooms %> <span style="font-size: 1rem; color: #999;">/ <%= totalRooms %></span></div>
                
                <div class="progress-bg">
                    <div class="progress-fill" style="width: <%= (totalRooms > 0) ? (bookedRooms * 100 / totalRooms) : 0 %>%;"></div>
                </div>
            </div>

            <div class="stat-card bookings">
                <h3>Total Bookings</h3>
                <div class="stat-num"><%= totalStudents %></div>
                <p>Active reservations</p>
            </div>
        </div>

        <div class="dashboard-main">
            
            <div class="card">
                <h3>Add New Room</h3>
                
                <% String msg = request.getParameter("msg"); if(msg != null) { %>
                   <div style="color: green; margin-bottom: 10px;"><%= msg %></div>
                <% } %>

                <form action="admin" method="post">
                    <label>Room Number</label>
                    <input type="text" name="roomNumber" class="form-input" placeholder="e.g. 305" required>
                    
                    <label>Type</label>
                    <select name="type" class="form-input">
                        <option value="AC">Standard AC</option>
                        <option value="Non-AC">Standard Non-AC</option>
                        <option value="Luxury AC">Luxury AC</option>
                    </select>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                        <div>
                            <label>Capacity</label>
                            <input type="number" name="capacity" class="form-input" placeholder="1-4" required>
                        </div>
                        <div>
                            <label>Price (₹)</label>
                            <input type="number" name="price" class="form-input" placeholder="₹" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-zen btn-primary" style="width: 100%;">+ Add Room</button>
                </form>
            </div>

            <div class="card">
                <h3>Recent Bookings</h3>
                <div class="table-container">
                    <table class="zen-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User</th>
                                <th>Room</th>
                                <th>College</th>
                                <th>Paid</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                BookingDAO dao = new BookingDAO();
                                List<Booking> list = dao.getAllBookings();
                                for(Booking b : list) {
                            %>
                            <tr>
                                <td>#<%= b.getId() %></td>
                                <td><%= b.getUserId() %></td>
                                <td style="color: var(--accent-orange); font-weight: bold;"><%= b.getRoomId() %></td>
                                <td><%= b.getCollegeName() %></td>
                                <td style="color: green;">₹<%= (int)b.getTotalAmount() %></td>
                                <td><%= b.getBookingDate() %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

</body>
</html>