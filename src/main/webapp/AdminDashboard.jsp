<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        /* Global styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* System fonts */
            background: url('Images/Background Image.jpeg') no-repeat center center fixed; /* Gradient and background image */
            background-size: cover; /* Cover the entire viewport */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            min-height: 100vh; /* Full viewport height */
        }

        /* Container for dashboard content */
        .dashboard-container {
            background-color: rgba(255, 182, 255, 0.3); /* Pink background with transparency */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); /* Soft shadow */
            width: 90%; /* Responsive width */
            max-width: 600px; /* Maximum width */
            text-align: center; /* Center contents */
            position: relative; /* Relative positioning for absolute positioning */
            backdrop-filter: blur(10px); /* Blur effect */
        }

        /* Heading style */
        h2 {
            color: #ffff; /* White text */
            font-size: 36px;
            margin-bottom: 25px;
        }

        /* Button styles */
        .button {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 20px;
            transition: background-color 0.3s, color 0.3s;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Light shadow */
        }

        /* Add button */
        .button.add {
            background-color: #ff69b4; /* Pink */
            color: white;
        }

        .button.add:hover {
            background-color: #ff1493; /* Darker pink on hover */
        }

        /* Modify button */
        .button.modify {
            background-color: #ff69b4; /* Pink */
            color: white;
        }

        .button.modify:hover {
            background-color: #ff1493; /* Darker pink on hover */
        }

        /* Delete button */
        .button.delete {
            background-color: #ff69b4; /* Pink */
            color: white;
        }

        .button.delete:hover {
            background-color: #ff1493; /* Darker pink on hover */
        }

        /* View button */
        .button.view {
            background-color: #ff69b4; /* Pink */
            color: white;
        }

        .button.view:hover {
            background-color: #ff1493; /* Darker pink on hover */
        }

        /* Logout button */
        .logout-button {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .logout-button:hover {
            background-color: #ff1493; /* Darker pink on hover */
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <form action="UserTypeSelection.jsp">
            <button type="submit" class="logout-button">Logout</button>
        </form>
        <h2>Admin Dashboard</h2>
        <div class="button-container">
            <form action="RegisterForm.jsp" method="post">
                <button type="submit" class="button add">Add User</button>
            </form>

            <form action="searchUser.jsp" method="get">
                <button type="submit" class="button modify">Modify User</button>
            </form>

            <form action="DeleteUser.jsp" method="get">
                <button type="submit" class="button delete">Delete User</button>
            </form>

            <form action="ViewCustomerDetailsServlet" method="get">
                <button type="submit" class="button view">View Customer Details</button>
            </form>
        </div>
    </div>
</body>
</html>
