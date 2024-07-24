<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify User</title>
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
            position: relative; /* For positioning the home button */
        }
        .form-container {
            background-color: rgba(255, 255, 255, 0.3); /* Semi-transparent white background */
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 90%;
            max-width: 600px;
            backdrop-filter: blur(8px); /* Optional: adds a blur effect */
        }
        h2 {
            color: #ff69b4; /* Pink color */
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600; /* Bold text for emphasis */
        }
        label {
            display: block;
            font-size: 18px;
            margin: 10px 0;
            color: #333;
        }
        input, select, button {
            width: calc(100% - 22px); /* Adjust width to account for padding */
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        button {
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            cursor: pointer;
            padding: 14px 20px;
            font-size: 16px;
            margin-top: 10px;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.2s;
        }
        button:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.05); /* Slight scale effect */
        }
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
    width: 50px; /* Set a specific width */
    height: 50px; /* Set a specific height */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transition: background-color 0.3s, transform 0.2s;
}
            
        }
        .home-button:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.1); /* Slight scale effect */
        }
        .home-button i {
            font-size: 20px;
        }
        .message {
            color: #ff1493; /* Darker pink for messages */
            margin-top: 20px;
        }
    </style>
    <!-- Include Font Awesome for the home icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <button class="home-button" onclick="window.location.href='AdminDashboard.jsp'">
        <i class="fas fa-home"></i>
    </button>
    <div class="form-container">
        <h2>Modify User Details</h2>
        <form action="ModifyUserServlet" method="get">
            <label for="accountNumber">Account Number:</label>
            <input type="text" id="accountNumber" name="accountNumber" required>
            <button type="submit">Search</button>
        </form>
        <c:if test="${not empty fullName}">
            <form action="ModifyUserServlet" method="post">
                <input type="hidden" name="action" value="modify">
                <input type="hidden" name="accountNumber" value="${accountNumber}">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" value="${fullName}" required>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${email}" required>
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="${phone}" required>
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="${address}" required>
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" value="${dob}" required>
                <label for="gender">Gender:</label>
                <input type="text" id="gender" name="gender" value="${gender}" required>
                <label for="accountType">Account Type:</label>
                <input type="text" id="accountType" name="accountType" value="${accountType}" required>
                <label for="branch">Branch:</label>
                <input type="text" id="branch" name="branch" value="${branch}" required>
                <label for="idType">ID Type:</label>
                <input type="text" id="idType" name="idType" value="${idType}" required>
                <label for="contactMethod">Contact Method:</label>
                <input type="text" id="contactMethod" name="contactMethod" value="${contactMethod}" required>
                <button type="submit">Update</button>
            </form>
        </c:if>
        <c:if test="${not empty Message}">
            <p class="message">${Message}</p>
        </c:if>
    </div>
</body>
</html>
