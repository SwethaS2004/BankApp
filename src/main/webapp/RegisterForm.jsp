<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bank Registration Form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background:url('Images/Background Image.jpeg') no-repeat center center fixed; /* Gradient and background image */
            background-size: cover; /* Cover the entire viewport */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background-color: rgba(255, 192, 203, 0.3); /* Pink background with opacity */
            padding: 30px 50px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 600px;
            margin: auto;
            overflow: hidden;
            position: relative;
            backdrop-filter: blur(10px); /* Blur effect for better transparency */
        }

        .home-button {
            position: absolute;
            top: 10px;
            left: 10px;
            padding: 5px 10px;
            width: auto;
            background-color: #ff69b4; /* Pink */
            color: white;
            border: 2px solid #ff1493; /* Darker pink */
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .home-button:hover {
            background-color: #ff1493;
            border-color: #c71585; /* Even darker pink */
        }

        .home-button:active {
            background-color: #c71585;
            border-color: #a5006c;
        }

        h2 {
            text-align: center;
            color: #ffffff; /* White text */
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            color: #ffffff; /* White text */
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input:focus, select:focus {
            border-color: #ff69b4; /* Pink border */
            outline: none;
        }

        button {
            width: 100%;
            padding: 15px;
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #ff1493; /* Darker pink */
        }

        button:active {
            background-color: #c71585; /* Even darker pink */
        }

        .form-group.inline-group {
            display: flex;
            justify-content: space-between;
        }

        .form-group.inline-group .form-group {
            flex: 1;
            margin-right: 10px;
        }

        .form-group.inline-group .form-group:last-child {
            margin-right: 0;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .home-button {
                top: 5px;
                left: 5px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <button class="home-button" onclick="window.location.href='AdminDashboard.jsp'">Home</button>
        <h2>Bank Registration Form</h2>
        <form id="registrationForm" action="RegisterServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="">Select</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="accountType">Account Type:</label>
                <select id="accountType" name="accountType" required>
                    <option value="">Select</option>
                    <option value="savings">Savings</option>
                    <option value="current">Current</option>
                    <option value="fixed">Fixed Deposit</option>
                </select>
            </div>
            <div class="form-group">
                <label for="branch">Branch:</label>
                <input type="text" id="branch" name="branch" required>
            </div>
            <div class="form-group">
                <label for="deposit">Initial Deposit Amount:</label>
                <input type="number" id="deposit" name="deposit" min="1000" required>
            </div>
            <div class="form-group inline-group">
                <div class="form-group">
                    <label for="idType">Identification Type:</label>
                    <select id="idType" name="idType" required>
                        <option value="">Select</option>
                        <option value="Pan Card">Pan Card</option>
                        <option value="Aadhar Card">Aadhar Card</option>
                        <option value="driver_license">Driver's License</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="idProof">Upload Identification Proof (PDF):</label>
                    <input type="file" id="idProof" name="idProof" accept=".pdf" required>
                </div>
            </div>
            <div class="form-group">
                <label for="contactMethod">Preferred Branch Contact Method:</label>
                <select id="contactMethod" name="contactMethod" required>
                    <option value="">Select</option>
                    <option value="email">Email</option>
                    <option value="phone">Phone</option>
                    <option value="mail">Mail</option>
                </select>
            </div>
            <button type="submit">Register</button>
        </form>
    </div>
    <script>
        document.getElementById("registrationForm").addEventListener("submit", function(event) {
            var dob = new Date(document.getElementById("dob").value);
            var today = new Date();
            var age = today.getFullYear() - dob.getFullYear();
            var month = today.getMonth() - dob.getMonth();
            if (month < 0 || (month === 0 && today.getDate() < dob.getDate())) {
                age--;
            }

            if (age < 18) {
                alert("You must be at least 18 years old.");
                event.preventDefault();
            }

            var deposit = document.getElementById("deposit").value;
            if (deposit < 1000) {
                alert("Initial deposit must be at least 1000.");
                event.preventDefault();
            }
        });
    </script>
</body>
</html>