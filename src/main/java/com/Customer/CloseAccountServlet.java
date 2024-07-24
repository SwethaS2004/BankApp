package com.Customer;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("CustomerLogin.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");
        BigDecimal balance = customer.getBalance();

        if (balance.compareTo(BigDecimal.ZERO) > 0) {
            request.setAttribute("message", "Cannot close account. Please withdraw all funds first.");
            request.getRequestDispatcher("/customerDashboard.jsp").forward(request, response);
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        boolean isClosed = customerDAO.closeAccount(customer.getAccountNumber());
        customerDAO.closeConnection();

        if (isClosed) {
            session.invalidate();
            request.setAttribute("message", "Account closed successfully.");
            request.getRequestDispatcher("/CustomerLogin.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Failed to close account. Please try again.");
            request.getRequestDispatcher("/customerDashboard.jsp").forward(request, response);
        }
    }
}
