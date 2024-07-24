<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Customer.Customer, com.Customer.CustomerDAO" %>

<%@ page import="com.Customer.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('Images/Background Image.jpeg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            position: relative;
        }
        .profile-container {
            background-color: rgba(255, 255, 255, 0.6);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 600px;
            text-align: center;
            position: relative;
        }
        h1 {
            color: #ff69b4;
            margin-bottom: 25px;
            font-size: 34px;
            font-weight: 700;
        }
        .profile-details {
            font-size: 18px;
            margin-bottom: 20px;
            color: #ff1493;
        }
        .back-button {
            background-color: #ff69b4;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.2s;
            display: inline-block;
            font-size: 18px;
            font-weight: 600;
            margin-top: 20px;
        }
        .back-button:hover {
            background-color: #ff1493;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h1>Profile Details</h1>
        <% 
            if (session != null && session.getAttribute("customer") != null) {
                Customer customer = (Customer) session.getAttribute("customer");

                // Debug output to ensure data is being retrieved
                System.out.println("Customer Details: " + customer.getFullName() + ", " + customer.getEmail() + ", " + customer.getPhone() + ", " + customer.getAddress() + ", " + customer.getDob() + ", " + customer.getGender() + ", " + customer.getAccountType() + ", " + customer.getBranch() + ", " + customer.getInitialDeposit() + ", " + customer.getIdType() + ", " + customer.getContactMethod() + ", " + customer.getAccountNumber() + ", " + customer.getBalance());
        %>
            <div class="profile-details">
                <p>Full Name: <%= customer.getFullName() %></p>
                <p>Email: <%= customer.getEmail() %></p>
                <p>Account Number: <%= customer.getAccountNumber() %></p>
                <p>Balance: $<%= customer.getBalance() %></p>
            </div>
            <a href="customerDashboard.jsp" class="back-button">Back to Dashboard</a>
        <% 
            } else { 
        %>
            <p>Session expired. Please <a href="CustomerLogin.jsp">login</a> again.</p>
        <% 
            } 
        %>
    </div>
</body>
</html>
