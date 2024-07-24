package com.Customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to AdminDashboard.jsp
        request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            // Redirect to RegisterForm.html
            response.sendRedirect("RegisterForm.jsp");
        } else if ("modify".equals(action)) {
            response.sendRedirect("ModifyUser.jsp");
        } else if ("delete".equals(action)) {
            response.sendRedirect("DeleteUser.jsp");
        } else if ("view".equals(action)) {
            response.sendRedirect("ViewCustomerDetailsServlet");
        } else {
        	
            // If no action matches, reload the dashboard
            response.sendRedirect("AdminDashboard.jsp");
        }
    }
}



