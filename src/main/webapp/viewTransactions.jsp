<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.Customer.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Transactions</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('Images/Background Image.jpeg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: #fff; /* White text color for better readability on dark background */
        }
        .transactions-container {
            background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent white */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 900px;
            color: #333;
        }
        h1 {
            color: #ff69b4; /* Pink color */
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
            font-weight: 700;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #dee2e6;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
            color: #ff69b4; /* Pink color */
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .action-button {
            background-color: #ff69b4; /* Pink color */
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s, transform 0.2s;
        }
        .action-button:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.05);
        }
        .center {
            text-align: center;
        }
        .error-message {
            color: #dc3545;
            font-weight: bold;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="transactions-container">
        <h1>Recent Transactions</h1>
        <%
            if (session == null || session.getAttribute("customer") == null) {
                response.sendRedirect("CustomerLogin.jsp");
                return;
            }

            Customer customer = (Customer) session.getAttribute("customer");

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "nooraniJamal");

                String sql = "SELECT * FROM transactions WHERE account_number = ? ORDER BY id DESC LIMIT 10";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, customer.getAccountNumber());

                rs = stmt.executeQuery();
        %>
        <table>
            <tr>
                <th>Transaction ID</th>
                <th>Account Number</th>
                <th>Date</th>
                <th>Amount</th>
                <th>Type</th>
            </tr>
            <% 
              if (!rs.isBeforeFirst()) {
                %>
                <tr>
                    <td colspan="5" class="center">No transactions found.</td>
                </tr>
                <%
            } else {
                while (rs.next()) {
                    BigDecimal amount = rs.getBigDecimal("amount");
                    Timestamp timestamp = rs.getTimestamp("date");
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("account_number") %></td>
                <td><%= formatDate(timestamp) %></td>
                <td>$<%= amount %></td>
                <td><%= rs.getString("type") %></td>
            </tr>
            <%
                }
            }
            %>
        </table>
        <div class="center">
            <a href="CustomerDashboardServlet" class="action-button">Back to Dashboard</a>
            <a href="DownloadPDFServlet" class="action-button">Download PDF</a>
        </div>
        <%
            } catch (SQLException ex) {
                ex.printStackTrace();  // Print stack trace for debugging
                %>
                <p class="error-message">An error occurred while retrieving transactions. Please try again later.</p>
                <%
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        %>
    </div>

    <%-- Function to format date and time --%>
    <%!
        private String formatDate(Timestamp timestamp) {
            if (timestamp == null) return "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return sdf.format(new Date(timestamp.getTime()));
        }
    %>
</body>
</html>
