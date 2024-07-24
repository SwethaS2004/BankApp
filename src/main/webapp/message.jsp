<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Status</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('Images/Background Image.jpeg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .message-container {
             background-color: rgba(255, 255, 255, 0.3);  /* Pink background with opacity */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 80%;
            max-width: 600px;
      }
        h1 {
            color: #ff69b4; /* White text */
        }
        p {
            color: #ffffff; /* White text for better contrast on pink background */
            font-size: 18px;
        }
        .success {
           color: #00BFFF; /* deep sky blue for success messages */
        }
        .error {
            color: #FF4500; /* orangeRed for error messages */
        }
        .details {
            margin-top: 20px;
            color: #ffffff; /* White text */
        }
        button {
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #ff1493; /* Darker pink */
        }
        button:active {
            background-color: #c71585; /* Even darker pink */
        }
    </style>
</head>
<body>
    <div class="message-container">
        <h1>Registration Status</h1>
        <p class="<%= request.getAttribute("Message").toString().contains("ERROR") ? "error" : "success" %>">
            <%= request.getAttribute("Message") %>
        </p>
        <div class="details">
            <% if (request.getAttribute("accountNumber") != null) { %>
                <p><strong>Account Number:</strong> <%= request.getAttribute("accountNumber") %></p>
            <% } %>
            <% if (request.getAttribute("tempPassword") != null) { %>
                <p><strong>Temporary Password:</strong> <%= request.getAttribute("tempPassword") %></p>
            <% } %>
            <button onclick="window.location.href='AdminDashboard.jsp'">Home</button>
        </div>
    </div>
</body>
</html>
