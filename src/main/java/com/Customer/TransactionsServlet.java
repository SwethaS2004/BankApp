package com.Customer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TransactionsServlet")
public class TransactionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Use the DAO for database operations
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        customerDAO = new CustomerDAO(); // Initialize DAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("CustomerLogin.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");
        String order = request.getParameter("order");
        if (order == null || (!order.equals("asc") && !order.equals("desc"))) {
            order = "asc";
        }

        List<Transaction> transactions = new ArrayList<>();
        try {
            // Retrieve transactions using DAO
            transactions = customerDAO.getTransactions(customer.getAccountNumber(), order);

            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("/viewTransactions.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while retrieving transactions. Please try again later.");
            request.getRequestDispatcher("/viewTransactions.jsp").forward(request, response);

        } finally {
            customerDAO.closeConnection(); // Ensure the connection is closed
        }
    }
}
