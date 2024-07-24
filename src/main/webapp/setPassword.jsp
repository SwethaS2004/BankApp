<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Set Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('Images/Background Image.jpeg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: #333;
        }
        .password-container {
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 80%;
            max-width: 400px;
        }
        h1 {
            color: #ff69b4; /* Pink color */
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: 600; /* Bold text for emphasis */
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 16px;
            color: #333;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .action-button {
            background-color: #ff69b4; /* Pink */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.2s;
        }
        .action-button:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.05); /* Slight scale effect */
        }
        .error-message {
            color: #ff1493; /* Darker pink */
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="password-container">
        <h1>Set Your Password</h1>
        <form action="SetPasswordServlet" method="post">
            <div class="form-group">
                <label for="accountNumber">Account Number:</label>
                <input type="text" id="accountNumber" name="accountNumber" value="<%= request.getParameter("accountNumber") %>" readonly>
            </div>
            <div class="form-group">
                <label for="password">New Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" class="action-button">Set Password</button>
        </form>
        <%
            String error = request.getParameter("error");
            String message = request.getParameter("message");
            if (error != null) {
                if (error.equals("passwordMismatch")) {
                    out.println("<p class='error-message'>Passwords do not match!</p>");
                } else if (error.equals("dbError")) {
                    out.println("<p class='error-message'>Database error occurred. Please try again later.</p>");
                    if (message != null) {
                        out.println("<p class='error-message'>" + message + "</p>");
                    }
                } else if (error.equals("updateFailed")) {
                    out.println("<p class='error-message'>Password update failed. Please try again.</p>");
                }
            }
        %>
    </div>
</body>
</html>
