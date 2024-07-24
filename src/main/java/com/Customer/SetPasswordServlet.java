package com.Customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SetPasswordServlet")
public class SetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Create an instance of CustomerDAO
    private CustomerDAO customerDAO = new CustomerDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("setPassword.jsp?accountNumber=" + accountNumber + "&error=passwordMismatch");
            return;
        }

        try {
            // Use CustomerDAO to update the password
            boolean success = customerDAO.updatePassword(accountNumber, password);
            if (success) {
            	boolean tempPasswordCleared = customerDAO.clearTempPassword(accountNumber);
                if (tempPasswordCleared)
                    response.sendRedirect("CustomerDashboardServlet");
            } else {
                response.sendRedirect("setPassword.jsp?accountNumber=" + accountNumber + "&error=updateFailed");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("setPassword.jsp?accountNumber=" + accountNumber + "&error=dbError");
        } finally {
            customerDAO.closeConnection(); // Ensure connection is closed
        }
    }
}
