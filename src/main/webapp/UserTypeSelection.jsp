<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Type Selection</title>
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
            color: #fff; /* Change text color to white for better contrast */
        }
        .selection-container {
            background-color: rgba(255, 255, 255, 0.5); /* Semi-transparent white background */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 80%;
            max-width: 400px;
        }
        h2 {
            color: #333; /* Dark color for heading */
        }
        .buttons {
            margin-top: 20px;
        }
         button {
            background-color: transparent; /* Transparent background */
            color: #333; /* Dark text color */
            padding: 10px 20px;
            border: 2px solid #ff69b4; /* Pink border */
            border-radius: 4px;
            cursor: pointer;
            margin: 5px;
            width: 100%;
            transition: background-color 0.3s, color 0.3s; /* Smooth transition */
        }
        button:hover {
            background-color: #ff69b4; /* Pink background on hover */
            color: white;  /* White text on hover */
    </style>
</head>
<body>
    <div class="selection-container">
        <h2>Select User Type</h2>
        <div class="buttons">
            <button type="button" onclick="submitForm('admin')">Admin</button>
            <button type="button" onclick="submitForm('customer')">Customer</button>
        </div>
    </div>

    <form id="userTypeForm" action="UserTypeServlet" method="post" style="display:none;">
        <input type="hidden" id="userType" name="userType">
    </form>

    <script>
        function submitForm(userType) {
            document.getElementById('userType').value = userType;
            document.getElementById('userTypeForm').submit();
        }
    </script>
</body>
</html>
