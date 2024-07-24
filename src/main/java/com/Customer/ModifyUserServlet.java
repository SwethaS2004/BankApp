package com.Customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ModifyUserServlet")
public class ModifyUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CustomerDAO customerDAO = new CustomerDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        searchUser(request, response, accountNumber);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String accountNumber = request.getParameter("accountNumber");

        if ("modify".equals(action)) {
            updateUser(request, response);
        } else if ("delete".equals(action)) {
            deleteUser(request, response, accountNumber);
        }
    }

    private void searchUser(HttpServletRequest request, HttpServletResponse response, String accountNumber) 
            throws ServletException, IOException {
        
        Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber);

        if (customer != null) {
            request.setAttribute("fullName", customer.getFullName());
            request.setAttribute("email", customer.getEmail());
            request.setAttribute("phone", customer.getPhone());
            request.setAttribute("address", customer.getAddress());
            request.setAttribute("dob", customer.getDob());
            request.setAttribute("gender", customer.getGender());
            request.setAttribute("accountType", customer.getAccountType());
            request.setAttribute("branch", customer.getBranch());
            request.setAttribute("idType", customer.getIdType());
            request.setAttribute("contactMethod", customer.getContactMethod());
            request.setAttribute("accountNumber", accountNumber);
            
            request.getRequestDispatcher("/ModifyUser.jsp").forward(request, response);
        } else {
            request.setAttribute("Message", "User not found!");
            request.getRequestDispatcher("/message.jsp").forward(request, response);
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accountNumber = request.getParameter("accountNumber");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String accountType = request.getParameter("accountType");
        String branch = request.getParameter("branch");
        String idType = request.getParameter("idType");
        String contactMethod = request.getParameter("contact_method");

        Customer customer = new Customer();
        customer.setAccountNumber(accountNumber);
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customer.setDob(dob);
        customer.setGender(gender);
        customer.setAccountType(accountType);
        customer.setBranch(branch);
        customer.setIdType(idType);
        customer.setContactMethod(contactMethod);

        boolean isUpdated = customerDAO.updateCustomer(customer);

        if (isUpdated) {
            request.setAttribute("Message", "User details updated successfully.");
        } else {
            request.setAttribute("Message", "Failed to update user details.");
        }

        request.getRequestDispatcher("/message.jsp").forward(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response, String accountNumber) 
            throws ServletException, IOException {
        
        boolean isDeleted = customerDAO.deleteCustomer(accountNumber);

        if (isDeleted) {
            request.setAttribute("Message", "User successfully deleted.");
        } else {
            request.setAttribute("Message", "User not found or unable to delete.");
        }

        request.getRequestDispatcher("/message.jsp").forward(request, response);
    }
}
