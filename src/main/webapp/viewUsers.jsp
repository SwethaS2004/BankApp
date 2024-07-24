<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>User List</h2>
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
            <th>Contact Method</th>
            <th>Account Number</th>
            <th>Action</th>
        </tr>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.address}</td>
                <td>${user.dob}</td>
                <td>${user.gender}</td>
                <td>${user.accountType}</td>
                <td>${user.branch}</td>
                <td>${user.idType}</td>
                <td>${user.contactMethod}</td>
                <td>${user.accountNumber}</td>
                <td><a href="ModifyUserServlet?accountNumber=${user.accountNumber}">Edit</a></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
