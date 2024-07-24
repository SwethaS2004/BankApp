package com.Customer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewCustomerDetailsServlet")
public class ViewCustomerDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDAO customerDAO = new CustomerDAO();
        List<Customer> customers = customerDAO.getAllCustomers(); // Use DAO to get customer details

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("ViewCustomerDetails.jsp").forward(request, response);

        customerDAO.closeConnection(); // Close connection after use
    }
}
