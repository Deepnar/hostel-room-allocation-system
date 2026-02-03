<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="auth-container">
        <div class="card" style="width: 400px; text-align: center;">
            <h2 style="color: var(--accent-ochre);">Join Us</h2>
            <p style="color: var(--text-muted); margin-bottom: 2rem;">
                Use <b>@uni.edu</b> for exclusive student rates.
            </p>

            <form action="auth" method="post">
                <input type="hidden" name="action" value="register">
                <input type="text" name="name" class="form-input" placeholder="Full Name" required>
                <input type="email" name="email" class="form-input" placeholder="Email Address" required>
                <input type="password" name="password" class="form-input" placeholder="Password" required>
                <button type="submit" class="btn-zen btn-primary" style="width: 100%;">Create Account</button>
            </form>
            
            <p style="margin-top: 1rem;">
                <a href="login.jsp" style="color: var(--text-muted); font-size: 0.9rem;">Back to Login</a>
            </p>
        </div>
    </div>
</body>
</html>