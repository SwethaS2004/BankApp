<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
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
        .login-container {
            background-color: rgba(255, 255, 255, 0.9); /* Slightly more opaque white background */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 80%;
            max-width: 400px;
            position: relative; /* For positioning the back button */
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
        }
        .backbtn {
            background-color: #ff69b4; /* Pink background */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            position: absolute;
            top: 10px;
            left: 10px;
            cursor: pointer;
            transition: opacity 0.3s;
        }
        .backbtn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <button type="button" class="backbtn" onclick="window.location.href='UserTypeSelection.jsp'">Back</button>
        <h1>Customer Login</h1>
        <form action="CustomerLoginServlet" method="post">
            <div class="form-group">
                <label for="accountNumber">Account Number:</label>
                <input type="text" id="accountNumber" name="accountNumber" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <% 
                String error = request.getParameter("error");
                if (error != null && error.equals("invalidCredentials")) {
                    out.println("<p class='error-message'>Invalid account number or password!</p>");
                } else if (error != null && error.equals("dbError")) {
                    out.println("<p class='error-message'>Database error occurred. Please try again later.</p>");
                }
            %>
            <button type="submit" class="action-button">Login</button>
        </form>
    </div>
</body>
</html>
