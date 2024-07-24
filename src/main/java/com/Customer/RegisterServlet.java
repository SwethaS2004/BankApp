package com.Customer;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/RegisterServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file up to 16MB
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String dbURL = "jdbc:mysql://localhost:3306/bank";
    private String dbUser = "root";
    private String dbPass = "nooraniJamal";

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int TEMP_PASSWORD_LENGTH = 8; // Length of the temporary password
    private static final SecureRandom RANDOM = new SecureRandom();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String accountType = request.getParameter("accountType");
        String branch = request.getParameter("branch");
        String deposit = request.getParameter("deposit");
        String idType = request.getParameter("idType");
        Part idProofPart = request.getPart("idProof");
        String contactMethod = request.getParameter("contactMethod");

        InputStream idProofInputStream = null; // input stream of the upload file

        if (idProofPart != null) {
            idProofInputStream = idProofPart.getInputStream();
        }

        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to MySQL
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Generate unique account number and temporary password
            String accountNumber = generateAccountNumber();
            String tempPassword = generateTemporaryPassword();

            // Prepare SQL statement for inserting user data
            String sql = "INSERT INTO users (full_name, email, phone, address, dob, gender, account_type, branch, initial_deposit, id_type, id_proof, contact_method, account_number, temp_password,password, balance) "
                    + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setString(3, phone);
            statement.setString(4, address);
            statement.setString(5, dob);
            statement.setString(6, gender);
            statement.setString(7, accountType);
            statement.setString(8, branch);
            statement.setBigDecimal(9, new BigDecimal(deposit));
            statement.setString(10, idType);

            if (idProofInputStream != null) {
                statement.setBlob(11, idProofInputStream);
            }

            statement.setString(12, contactMethod);
            statement.setString(13, accountNumber);
            statement.setString(14, tempPassword);
            statement.setString(15, null);
            statement.setBigDecimal(16, new BigDecimal(deposit));
            

            // Execute the insert statement
            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                message = "User registered successfully!";
            } else {
                message = "Failed to register user.";
            }
        } catch (ClassNotFoundException | SQLException ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace(); // Print stack trace for debugging
        } finally {
            // Close resources
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            // Set attributes for message.jsp to display result to user
            request.setAttribute("Message", message);
            request.setAttribute("accountNumber", generateAccountNumber()); // Optionally generate another account number
            request.setAttribute("tempPassword", generateTemporaryPassword()); // Optionally generate another temporary password
            getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
        }
    }

    private String generateAccountNumber() {
        long timestamp = System.currentTimeMillis();
        int randomInt = RANDOM.nextInt(9000) + 1000; // 4-digit random number
        return String.valueOf(1000000000L + (timestamp % 1000000000L)) + randomInt;
    }

    private String generateTemporaryPassword() {
        StringBuilder password = new StringBuilder(TEMP_PASSWORD_LENGTH);
        for (int i = 0; i < TEMP_PASSWORD_LENGTH; i++) {
            password.append(CHARACTERS.charAt(RANDOM.nextInt(CHARACTERS.length())));
        }
        return password.toString();
    }
}
