<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
       

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: url('Images/Background Image.jpeg') no-repeat center center fixed; /* Background image */
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            min-height: 100vh; /* Full viewport height */
        }

        .container {
            background-color: rgba(255, 182, 193, 0.3); /* More transparent pink background */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            width: 350px;
            max-width: 90%;
            text-align: center; /* Center contents */
            backdrop-filter: blur(10px); /* Blur effect */
        }

        h2 {
            font-family: 'Lora', serif; 
            color: #f5f5f5; /* White text */
            font-size: 36px;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #ffffff; /* White text */
            font-weight: bold;
            text-align: left; /* Left align labels */
            font-size: 18px;
        }

        input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px);
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ffffff; /* White border */
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 18px;
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent input background */
            color: #333; /* Dark text */
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #ff69b4; /* Pink focus color */
        }

        .log, .cancelbtn, .backbtn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 20px;
            transition: opacity 0.3s, background-color 0.3s;
            margin-top: 10px;
        }

        .log {
            background-color: transparent; /* Transparent background */
            color: #ffffff; /* White text color */
            border: 2px solid #ff69b4; /* Pink border */
        }

        .log:hover {
            background-color: #ff69b4; /* Pink background on hover */
            color: white; /* White text on hover */
        }

        .cancelbtn {
            background-color: #ff69b4; /* Pink cancel button */
            color: white;
        }

        .cancelbtn:hover {
            opacity: 0.8;
        }

        .backbtn {
            background-color: #ff69b4; /* Pink background */
            color: white;
        }

        .backbtn:hover {
            opacity: 0.8;
        }

        .remember {
            margin-top: 15px;
            display: block;
            color: #ffffff; /* White text */
            font-size: 16px;
        }

        .forgot-password {
            display: block;
            text-align: right;
            margin-top: 10px;
            font-size: 16px;
        }

        .forgot-password a {
            color: #ffffff; /* White link */
            text-decoration: none;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form method="post" action="loginServlet">
        <div class="container">
            <h2>Admin Login</h2>
            <label for="name"><b>Username</b></label>
            <input type="text" placeholder="Enter Username" name="name" required>

            <label for="psw"><b>Password</b></label>
            <input type="password" placeholder="Enter Password" name="psw" required>

            <button type="submit" class="log">Login</button>
            <button type="button" class="cancelbtn">Cancel</button>

            <label class="remember">
                <input type="checkbox" checked="checked" name="remember"> Remember me
            </label>

            <div class="forgot-password">
                <a href="#">Forgot password?</a>
            </div>
            <div>
                <button type="button" class="backbtn" onclick="window.location.href='UserTypeSelection.jsp'">Back</button>
            </div>
        </div>
    </form>
</body>
</html>
