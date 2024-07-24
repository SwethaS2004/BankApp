<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.Customer.Customer" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
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
        .dashboard-container {
            background-color: rgba(255, 255, 255, 0.6); /* Increased transparency */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 800px;
            text-align: center;
            position: relative;
        }
        h1 {
            color: #ff69b4; /* Pink color */
            margin-bottom: 25px;
            font-size: 34px;
            font-weight: 700;
        }
        .welcome {
            margin-bottom: 20px;
        }
        .balance {
            font-size: 24px;
            margin-bottom: 30px;
            color: #ff1493; /* Darker pink */
        }
        .button-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
            margin-bottom: 30px;
        }
        .action-button {
            background-color: #ff69b4; /* Pink */
            color: white;
            padding: 12px 20px; /* Consistent padding */
            width: 250px; /* Fixed width */
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.2s;
            display: inline-block;
            font-size: 18px;
            font-weight: 600;
            text-align: center;
        }
        .action-button:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.05);
        }
        .top-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            gap: 10px;
        }
        .top-button {
            background-color: #ff69b4; /* Pink */
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.2s;
            font-size: 18px;
            font-weight: 600;
        }
        .top-button:hover {
            background-color: #ff1493; /* Darker pink */
            transform: scale(1.05);
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 450px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 30px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
        }
        .success-message {
            color: green;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .error-message {
            color: red;
            font-weight: bold;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="top-buttons">
            <a href="Profile.jsp" class="top-button">Profile</a>
            <a href="CustomerLogin.jsp" class="top-button">Log Out</a>
        </div>
        <h1>Customer Dashboard</h1>
        <div class="welcome">
            <% 
                
                Customer customer = (Customer) session.getAttribute("customer");
                if (customer != null) {
                    BigDecimal balance = customer.getBalance();
                    String message = (String) request.getAttribute("message");
                    if (message != null) {
                        if (message.startsWith("Deposit successful") || message.startsWith("Account closed successfully")) {
            %>
                        <p class="success-message"><%= message %></p>
            <%       } else { %>
                        <p class="error-message"><%= message %></p>
            <%       }
                    }
            %>
                <p>Welcome, <%= customer.getFullName() %>!</p>
                <p class="balance">Your current balance is: $<%= balance %></p>
                <div class="button-container">
                    <button class="action-button" id="depositBtn">Deposit</button>
                    <button class="action-button" id="withdrawBtn">Withdraw</button>
                    <a href="ViewTransactionsServlet" class="action-button">View Transactions</a>
                    <button class="action-button" id="closeAccountBtn">Close Account</button>
                </div>
            <% } else { %>
                <p>Session expired. Please <a href="CustomerLogin.jsp">login</a> again.</p>
            <% } %>
        </div>
    </div>

    <!-- The Modal for Deposit -->
    <div id="depositModal" class="modal">
        <div class="modal-content">
            <span class="close" id="depositClose">&times;</span>
            <h2>Deposit Amount</h2>
            <form action="DepositServlet" method="post">
    <input type="hidden" name="accountNumber" value="<%= customer != null ? customer.getAccountNumber() : "" %>">
    <div>
        <label for="amount">Amount:</label>
        <input type="text" id="amount" name="amount" required>
    </div>
    <button type="submit" class="action-button" style="margin-top: 15px;">Submit</button>
</form>

        </div>
    </div>

    <!-- The Modal for Withdrawal -->
    <div id="withdrawModal" class="modal">
        <div class="modal-content">
            <span class="close" id="withdrawClose">&times;</span>
            <h2>Withdraw Amount</h2>
            <form action="WithdrawServlet" method="post">
                <input type="hidden" name="accountNumber" value="<%= customer != null ? customer.getAccountNumber() : "" %>">
                <div>
                    <label for="amount">Amount:</label>
                    <input type="text" id="amount" name="amount" required>
                </div>
                <button type="submit" class="action-button" style="margin-top: 15px;">Submit</button>
            </form>
        </div>
    </div>

    <!-- The Modal for Close Account -->
    <div id="closeAccountModal" class="modal">
        <div class="modal-content">
            <span class="close" id="closeAccountClose">&times;</span>
            <h2>Close Account</h2>
            <p>Are you sure you want to close your account? This action cannot be undone.</p>
            <form action="CloseAccountServlet" method="post">
                <button type="submit" class="action-button" style="margin-top: 15px;">Confirm</button>
            </form>
        </div>
    </div>

    <script>
        function setupModal(modalId, btnId, closeId) {
            var modal = document.getElementById(modalId);
            var btn = document.getElementById(btnId);
            var span = document.getElementById(closeId);

            btn.onclick = function() {
                modal.style.display = "block";
            }

            span.onclick = function() {
                modal.style.display = "none";
            }

            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        }

        setupModal("depositModal", "depositBtn", "depositClose");
        setupModal("withdrawModal", "withdrawBtn", "withdrawClose");
        setupModal("closeAccountModal", "closeAccountBtn", "closeAccountClose");
    </script>
</body>
</html>
