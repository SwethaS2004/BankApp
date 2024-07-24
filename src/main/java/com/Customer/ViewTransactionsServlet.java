package com.Customer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ViewTransactionsServlet")
public class ViewTransactionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        // Initialize CustomerDAO
        customerDAO = new CustomerDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("CustomerLogin.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");

        try {
            // Fetch transactions using CustomerDAO
            List<Transaction> transactions = customerDAO.getTransactions(customer.getAccountNumber(), "DESC");
            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("viewTransactions.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CustomerDashboardServlet"); // Redirect to dashboard on error
        } finally {
            customerDAO.closeConnection(); // Ensure connection is closed
        }
    }

    @Override
    public void destroy() {
        if (customerDAO != null) {
            customerDAO.closeConnection(); // Clean up resources
        }
    }
}
