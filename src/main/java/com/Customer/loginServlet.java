package com.Customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String VALIDATE_QUERY = "SELECT * FROM ADMIN WHERE username = ? AND password = ?";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("name");
        String password = req.getParameter("psw");
        resp.setContentType("text/html");
        PrintWriter pw = resp.getWriter();

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create connection
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "nooraniJamal")) {

                // Validate credentials
                try (PreparedStatement ps = con.prepareStatement(VALIDATE_QUERY)) {
                    ps.setString(1, username);
                    ps.setString(2, password);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            // Credentials are valid, redirect to admin dashboard
                            resp.sendRedirect("AdminDashboard.jsp");
                        } else {
                            // Invalid credentials, show error message
                            pw.println("<script type=\"text/javascript\">");
                            pw.println("alert('Invalid username or password');");
                            pw.println("location='AdminLogin.jsp';");
                            pw.println("</script>");
                        }
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            pw.println("MySQL JDBC Driver not found. Include it in your library path.");
            e.printStackTrace();
        } catch (SQLException se) {
            pw.println("SQLException: " + se.getMessage());
            se.printStackTrace();
        } catch (Exception e) {
            pw.println("Exception: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pw.close();
        }
    }
}
