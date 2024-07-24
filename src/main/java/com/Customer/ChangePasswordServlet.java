package com.Customer;



import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.authenticate(accountNumber, oldPassword);

        if (customer != null) {
            // Update password in the database
            boolean passwordChanged = customerDAO.updatePassword(accountNumber, newPassword);

            if (passwordChanged) {
                response.sendRedirect("passwordChanged.jsp"); // Redirect to success page
            } else {
                response.sendRedirect("passwordChangeFailed.jsp"); // Redirect to failure page
            }
        } else {
            response.sendRedirect("passwordChangeFailed.jsp"); // Redirect to failure page
        }
    }
}
