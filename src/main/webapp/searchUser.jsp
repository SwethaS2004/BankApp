<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search User</title>
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
            height: 100vh;
            position: relative; /* For positioning the home button */
        }
        .container {
            background-color: rgba(255, 255, 255, 0.3); /* More transparent white background */
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3); /* Slightly more prominent shadow */
            text-align: center;
            width: 90%;
            max-width: 400px;
            backdrop-filter: blur(10px); /* Enhanced blur effect */
        }
        h2 {
            color: #ff69b4; /* Pink color */
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: 600; /* Bold text for emphasis */
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        label {
            font-size: 18px;
            margin-bottom: 10px;
            color: #333;
        }
        input[type="text"] {
            width: 80%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            padding: 14px 22px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.2s;
        }
        input[type="submit"]:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.05); /* Slight scale effect */
        }
        /* Home button styles */
        .home-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 16px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s, transform 0.2s;
        }
        .home-button:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.1); /* Slight scale effect */
        }
        .home-button i {
            font-size: 20px;
        }
    </style>
    <!-- Include Font Awesome for the home icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <button class="home-button" onclick="window.location.href='AdminDashboard.jsp'">
        <i class="fas fa-home"></i>
    </button>
    <div class="container">
        <h2>Search User by Account Number</h2>
        <form action="ModifyUserServlet" method="get">
            <label for="accountNumber">Account Number:</label>
            <input type="text" id="accountNumber" name="accountNumber" placeholder="Enter Account Number" required>
            <input type="submit" value="Search">
        </form>
    </div>
</body>
</html>
