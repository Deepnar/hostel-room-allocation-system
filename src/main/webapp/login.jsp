<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login`</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="auth-container">
        <div class="card" style="width: 400px; text-align: center;">
            <h2 style="margin-bottom: 0.5rem; color: var(--accent-orange);">Welcome Back</h2>
            <p style="color: var(--text-muted); margin-bottom: 2rem;">Please login to your account</p>

            <% String msg = request.getParameter("msg"); 
               if(msg != null) { %>
               <p style="color: red; font-size: 0.9rem;"><%= msg %></p>
            <% } %>

            <form action="auth" method="post">
                <input type="hidden" name="action" value="login">
                <input type="email" name="email" class="form-input" placeholder="Email Address" required>
                <input type="password" name="password" class="form-input" placeholder="Password" required>
                <button type="submit" class="btn-zen btn-primary" style="width: 100%;">Sign In</button>
            </form>

            <div style="margin-top: 1.5rem;">
                <a href="register.jsp" style="color: var(--accent-ochre); text-decoration: none;">Create an Account</a>
            </div>
        </div>
    </div>
</body>
</html>