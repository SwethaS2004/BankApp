package com.Customer;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("CustomerLogin.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");
        String accountNumber = customer.getAccountNumber();
        BigDecimal amount = new BigDecimal(request.getParameter("amount"));

        CustomerDAO customerDAO = new CustomerDAO();
        Connection conn = customerDAO.getConnection();
        try {
            conn.setAutoCommit(false);

            if (customerDAO.updateBalance(accountNumber, amount.negate())) {
                if (customerDAO.insertTransaction(accountNumber, amount, "Withdraw")) {
                    conn.commit();
                    customer.setBalance(customer.getBalance().subtract(amount));
                    session.setAttribute("customer", customer);
                    request.getSession().setAttribute("message", "Withdrawal successful!");
                } else {
                    conn.rollback();
                    request.getSession().setAttribute("message", "Withdrawal failed. Please try again.");
                }
            } else {
                conn.rollback();
                request.getSession().setAttribute("message", "Withdrawal failed. Please try again.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            request.getSession().setAttribute("message", "An error occurred. Please try again.");
        } finally {
            customerDAO.closeConnection();
        }

        response.sendRedirect("CustomerDashboardServlet");
    }
}
