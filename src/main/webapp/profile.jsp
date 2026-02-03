<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.hostel.util.DBConnection, com.hostel.model.User" %>
<%
    request.setCharacterEncoding("UTF-8");
    User user = (User) session.getAttribute("currentUser");
    if(user == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <meta charset="UTF-8">
</head>
<body>
    <nav class="navbar">
        <h2>My Profile</h2>
        <a href="dashboard.jsp" class="btn-zen btn-secondary">Back to Dashboard</a>
    </nav>

    <div class="auth-container" style="align-items: flex-start; margin-top: 50px;">
        <div class="card" style="width: 600px;">
            
            <% String msg = request.getParameter("msg"); 
               if(msg != null) { %>
               <div style="background: #e6fffa; color: #006644; padding: 10px; border-radius: 8px; margin-bottom: 20px;">
                   <%= msg %>
               </div>
            <% } %>

            <div style="display: flex; align-items: center; gap: 20px; margin-bottom: 20px;">
                <div style="width: 80px; height: 80px; background: var(--accent-ochre); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2rem; color: white;">
                    <%= user.getName().charAt(0) %>
                </div>
                <div>
                    <h3><%= user.getName() %></h3>
                    <p style="color: var(--text-muted);"><%= user.getEmail() %></p>
                    <span class="badge"><%= user.getRole() %></span>
                </div>
            </div>

            <hr style="border: 0; border-top: 1px solid var(--surface-latte);">

            <h4 style="margin-top: 20px; margin-bottom: 15px;">Current Accommodation</h4>

            <%
                boolean hasBooking = false;
                try {
                    Connection con = DBConnection.getConnection();
                    // Select logic: Get the LATEST booking for this user
                    String sql = "SELECT b.*, r.room_number, r.type FROM bookings b " +
                                 "JOIN rooms r ON b.room_id = r.id " +
                                 "WHERE b.user_id = ? ORDER BY b.booking_date DESC LIMIT 1";
                                 
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1, user.getId());
                    ResultSet rs = ps.executeQuery();
                    
                    if(rs.next()) {
                        hasBooking = true;
            %>
                        <div style="background: var(--surface-latte); padding: 20px; border-radius: 12px;">
                            <div style="display: flex; justify-content: space-between;">
                                <div>
                                    <h2 style="color: var(--accent-orange); margin-bottom: 5px;">Room <%= rs.getString("room_number") %></h2>
                                    <span style="font-size: 0.9rem; color: var(--text-coffee);"><%= rs.getString("type") %></span>
                                </div>
                                <div style="text-align: right;">
                                    <h3 style="margin-bottom: 0;">&#8377;<%= (int)rs.getDouble("total_amount") %></h3>
                                    <span style="font-size: 0.8rem; color: var(--text-muted);">Total Paid</span>
                                </div>
                            </div>
                            <hr style="border: 0; border-top: 1px solid #ddd; margin: 15px 0;">
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-size: 0.9rem;">
                                <div><b>College:</b> <%= rs.getString("college_name") %></div>
                                <div><b>Duration:</b> <%= rs.getInt("duration_months") %> Months</div>
                                <div><b>Date:</b> <%= rs.getTimestamp("booking_date") %></div>
                            </div>
                        </div>

            <%      } 
                    con.close();
                } catch(Exception e) { e.printStackTrace(); }

                if(!hasBooking) { 
            %>
                    <div style="text-align: center; padding: 30px; border: 2px dashed #ddd; border-radius: 12px;">
                        <p style="color: var(--text-muted);">No active bookings found.</p>
                        <a href="dashboard.jsp" class="btn-zen btn-primary" style="margin-top: 10px;">Find a Room</a>
                    </div>
            <%  } %>

        </div>
    </div>
</body>
</html>