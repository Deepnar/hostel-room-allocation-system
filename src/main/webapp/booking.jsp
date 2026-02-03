<%@ page import="com.hostel.model.User" %>
<%
    String roomId = request.getParameter("id");
    String price = request.getParameter("price");
    User user = (User) session.getAttribute("currentUser");
    if(user == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirm Booking</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="auth-container">
        <div class="card" style="width: 500px;">
            <h2 style="color: var(--text-coffee);">Finalize Booking</h2>
            <p style="color: var(--text-muted);">Completing details for Room ID: <%= roomId %></p>
            
            <form action="book" method="post">
                <input type="hidden" name="roomId" value="<%= roomId %>">
                <input type="hidden" name="price" value="<%= price %>">

                <div style="margin-bottom: 15px;">
                    <label>College / University Name</label>
                    <input type="text" name="college" class="form-input" required placeholder="e.g. IIT Bombay">
                </div>

                <div style="margin-bottom: 15px;">
                    <label>Duration (Months)</label>
                    <select name="duration" class="form-input">
                        <option value="3">3 Months</option>
                        <option value="6">6 Months</option>
                        <option value="12">12 Months (1 Year)</option>
                    </select>
                </div>
                
                <% if(user.getRole().equals("STUDENT")) { %>
                    <div style="background: #e6fffa; padding: 10px; border-radius: 8px; color: #006644; margin-bottom: 15px;">
                        <b>Student Discount:</b> You will receive 20% off the total bill!
                    </div>
                <% } %>

                <button type="submit" class="btn-zen btn-primary" style="width: 100%;">Confirm & Pay</button>
            </form>
            <a href="dashboard.jsp" style="display:block; text-align:center; margin-top:15px; color: var(--text-muted);">Cancel</a>
        </div>
    </div>
</body>
</html>