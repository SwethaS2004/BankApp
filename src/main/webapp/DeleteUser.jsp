<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete User</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('Images/Background Image.jpeg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.3); /* Semi-transparent white background */
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 90%;
            max-width: 400px;
            backdrop-filter: blur(8px); /* Optional: adds a blur effect */
        }
        h2 {
            color: #ff69b4; /* Pink color */
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600; /* Bold text for emphasis */
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        input[type="text"] {
            width: calc(100% - 22px); /* Adjust width to account for padding */
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus {
            outline: none;
            border-color: #ff69b4; /* Pink border on focus */
        }
        button[type="submit"], .home-button {
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            padding: 12px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.2s;
        }
        button[type="submit"]:hover, .home-button:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.05); /* Slight scale effect */
        }
        .home-button {
            background: linear-gradient(to right, #ff69b4, #ff1493);
            border: none;
            padding: 12px 24px;
            font-size: 16px;
            margin-top: 20px;
            border-radius: 25px;
            transition: background 0.3s ease-in-out, transform 0.2s;
        }
        .home-button:hover {
            background: linear-gradient(to right, #ff1493, #ff69b4);
            transform: scale(1.05); /* Slight scale effect */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Delete User</h2>
        <form action="DeleteUserServlet" method="post">
            <input type="text" name="accountNumber" placeholder="Enter Account Number" required>
            <button type="submit">Delete User</button>
            <button class="home-button" onclick="window.location.href='AdminDashboard.jsp'">Home</button>
        </form>
    </div>
</body>
</html>
