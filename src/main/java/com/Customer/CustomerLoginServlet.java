package com.Customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        String password = request.getParameter("password");

        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = null;
        boolean isTempPassword = false;

        try {
            // Authenticate the customer
            customer = customerDAO.authenticate(accountNumber, password);

            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);

                // Check if the password used is temp_password
                if (password.equals(customerDAO.getTempPassword(accountNumber))) {
                    response.sendRedirect("setPassword.jsp?accountNumber=" + accountNumber);
                } else {
                    response.sendRedirect("CustomerDashboardServlet");
                }
            } else {
                // Invalid credentials, redirect back to login page with error
                response.sendRedirect("CustomerLogin.jsp?error=invalidCredentials");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("CustomerLogin.jsp?error=dbError");
        } finally {
            // Clean up resources if needed
            customerDAO.closeConnection();
        }
    }
}
