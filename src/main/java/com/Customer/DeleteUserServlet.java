package com.Customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle GET request logic here, if needed
        // For example, forward to a JSP page to display a form or process GET-specific actions
        response.getWriter().println("GET method is not supported. Use POST method to delete a user.");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST request logic here to delete the user
        String accountNumber = request.getParameter("accountNumber");

        CustomerDAO customerDAO = new CustomerDAO();
        String message = null;

        try {
            boolean success = customerDAO.closeAccount(accountNumber);

            if (success) {
                message = "User deleted successfully!";
            } else {
                message = "User with account number " + accountNumber + " not found.";
            }
        } catch (Exception ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } finally {
            customerDAO.closeConnection();
            request.setAttribute("Message", message);
            request.getRequestDispatcher("/message.jsp").forward(request, response);
        }
    }
}
