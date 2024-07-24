<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Customer Details</title>
    <style>
        /* Global styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('Images/Background Image.jpeg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            min-height: 100vh; /* Full viewport height */
            position: relative; /* For positioning the home button */
        }

        /* Container for dashboard content */
        .dashboard-container {
            background-color: rgba(255, 255, 255, 0.5); /* Semi-transparent white background */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3); /* Softer shadow */
            width: 90%; /* Responsive width */
            max-width: 1000px; /* Maximum width */
            text-align: center; /* Center contents */
        }

        h2 {
            color: #ff69b4; /* Pink color */
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600; /* Bold text for emphasis */
        }

        .table-container {
            overflow-x: auto; /* Enable horizontal scrolling if needed */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff; /* Solid background for the table */
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 15px;
            text-align: left;
        }

        th {
            background-color: #ff69b4; /* Pink header */
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9; /* Light grey for alternate rows */
        }

        tr:hover {
            background-color: #ffebee; /* Light pink on hover */
        }

        /* Home button style */
        .home-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            padding: 10px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 20px;
            width: 50px; /* Set a specific width */
            height: 50px; /* Set a specific height */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s, transform 0.2s;
            display: flex;
            justify-content: center;
            align-items: center;
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
    <div class="dashboard-container">
        <h2>Customer Details</h2>
        <div class="table-container">
            <table>
                <tr>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Date of Birth</th>
                    <th>Gender</th>
                    <th>Account Type</th>
                    <th>Branch</th>
                    <th>ID Type</th>
                    <th>Account Number</th>
                </tr>
                <c:forEach var="customer" items="${customers}">
                    <tr>
                        <td><c:out value="${customer.fullName}"/></td>
                        <td><c:out value="${customer.email}"/></td>
                        <td><c:out value="${customer.phone}"/></td>
                        <td><c:out value="${customer.address}"/></td>
                        <td><c:out value="${customer.dob}"/></td>
                        <td><c:out value="${customer.gender}"/></td>
                        <td><c:out value="${customer.accountType}"/></td>
                        <td><c:out value="${customer.branch}"/></td>
                        <td><c:out value="${customer.idType}"/></td>
                        <td><c:out value="${customer.accountNumber}"/></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</body>
</html>
