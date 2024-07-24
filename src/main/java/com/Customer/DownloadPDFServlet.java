package com.Customer;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@WebServlet("/DownloadPDFServlet")
public class DownloadPDFServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String dbURL = "jdbc:mysql://localhost:3306/bank";
    private String dbUser = "root";
    private String dbPass = "nooraniJamal";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("CustomerLogin.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");

        List<Transaction> transactions = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            String sql = "SELECT * FROM transactions WHERE account_number = ? ORDER BY id DESC LIMIT 10";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, customer.getAccountNumber());
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String accountNumber = rs.getString("account_number");
                        BigDecimal amount = rs.getBigDecimal("amount");
                        java.sql.Timestamp date = rs.getTimestamp("date");
                        String type = rs.getString("type");

                        Transaction transaction = new Transaction(id, accountNumber, amount, date, type);
                        transactions.add(transaction);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=transactions.pdf");

        try {
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Title and Bank Details
            Paragraph bankName = new Paragraph("Smart Bank", new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 20, com.itextpdf.text.Font.BOLD, new com.itextpdf.text.BaseColor(255, 105, 180))); // Pink color
            bankName.setAlignment(Element.ALIGN_CENTER);
            document.add(bankName);

            Paragraph title = new Paragraph("Recent Transactions", new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 18, com.itextpdf.text.Font.BOLD, new com.itextpdf.text.BaseColor(255, 105, 180))); // Pink color
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            
            document.add(new Paragraph(" ")); // Add an empty line

            Paragraph customerDetails = new Paragraph("Customer Name: " + customer.getFullName() + "\n" +
                                                      "Account Number: " + customer.getAccountNumber() + "\n" +
                                                      "Date: " + java.time.LocalDate.now(), 
                                                      new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 12, com.itextpdf.text.Font.NORMAL, new com.itextpdf.text.BaseColor(0, 0, 0))); // Black color for contrast
            customerDetails.setAlignment(Element.ALIGN_LEFT);
            document.add(customerDetails);
            
            document.add(new Paragraph(" ")); // Add an empty line

            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(10f);

            // Table Headers
            addTableHeader(table, "ID");
            addTableHeader(table, "Account Number");
            addTableHeader(table, "Date");
            addTableHeader(table, "Amount");
            addTableHeader(table, "Type");

            // Table Data
            for (Transaction transaction : transactions) {
                table.addCell(String.valueOf(transaction.getId()));
                table.addCell(transaction.getAccountNumber());
                table.addCell(transaction.getDate().toString());
                table.addCell(transaction.getAmount().toString());
                table.addCell(transaction.getType());
            }

            document.add(table);
            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }

    private void addTableHeader(PdfPTable table, String headerText) {
        PdfPCell header = new PdfPCell(new Phrase(headerText, new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 12, com.itextpdf.text.Font.BOLD, new com.itextpdf.text.BaseColor(255, 105, 180)))); // Pink color
        header.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(header);
    }
}
