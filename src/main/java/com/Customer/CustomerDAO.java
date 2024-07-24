package com.Customer;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private static final Statement DataSourceProvider = null;
	private Connection connection;

    // Constructor to initialize database connection
    public CustomerDAO() {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/bank";
            String username = "root";
            String password = "nooraniJamal";

            // Establish the database connection
            this.connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to register a new customer
    public boolean registerCustomer(Customer customer) {
        String query = "INSERT INTO users (account_number, full_name, email, temp_password) VALUES (?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, customer.getAccountNumber());
            preparedStatement.setString(2, customer.getFullName());
            preparedStatement.setString(3, customer.getEmail());
            preparedStatement.setString(4, customer.getTemporaryPassword());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to authenticate customer login
    public Customer authenticate(String accountNumber, String password) {
        String query = "SELECT * FROM users WHERE account_number = ? AND (password = ? OR temp_password = ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountNumber);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                Customer customer = new Customer();
                customer.setAccountNumber(resultSet.getString("account_number"));
                customer.setFullName(resultSet.getString("full_name"));
                customer.setEmail(resultSet.getString("email"));
                customer.setPassword(resultSet.getString("password"));
                customer.setTemporaryPassword(resultSet.getString("temp_password"));
                customer.setBalance(resultSet.getBigDecimal("balance"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // Return null if no matching customer found
    }

    // Method to update customer password
    public boolean updatePassword(String accountNumber, String newPassword) {
        String query = "UPDATE users SET password = ? WHERE account_number = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newPassword);
            preparedStatement.setString(2, accountNumber);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean clearTempPassword(String accountNumber) throws SQLException {
        String sql = "UPDATE users SET temp_password = '' WHERE account_number = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, accountNumber);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }


    // Method to fetch all customers (for admin view, etc.)
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT full_name, email, phone, address, dob, gender, account_type, branch, id_type, account_number FROM users";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Customer customer = new Customer();
                customer.setFullName(resultSet.getString("full_name"));
                customer.setEmail(resultSet.getString("email"));
                customer.setPhone(resultSet.getString("phone"));
                customer.setAddress(resultSet.getString("address"));
                customer.setDob(resultSet.getString("dob"));
                customer.setGender(resultSet.getString("gender"));
                customer.setAccountType(resultSet.getString("account_type"));
                customer.setBranch(resultSet.getString("branch"));
                customer.setIdType(resultSet.getString("id_type"));
                customer.setAccountNumber(resultSet.getString("account_number"));

                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;
    }

    // Method to close a customer account
    public boolean closeAccount(String accountNumber) {
        String query = "DELETE FROM users WHERE account_number = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountNumber);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to get the balance of a customer
    public BigDecimal getBalance(String accountNumber) {
        String query = "SELECT balance FROM users WHERE account_number = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountNumber);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getBigDecimal("balance");
            }
            return BigDecimal.ZERO;
        } catch (SQLException e) {
            e.printStackTrace();
            return BigDecimal.ZERO;
        }
    }

    // Method to update balance
    public boolean updateBalance(String accountNumber, BigDecimal amount) {
        String query = "UPDATE users SET balance = balance + ? WHERE account_number = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setBigDecimal(1, amount);
            preparedStatement.setString(2, accountNumber);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to insert a transaction
    public boolean insertTransaction(String accountNumber, BigDecimal amount, String type) {
        String query = "INSERT INTO transactions (account_number, amount, date, type) VALUES (?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountNumber);
            preparedStatement.setBigDecimal(2, amount);
            preparedStatement.setString(3, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            preparedStatement.setString(4, type);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to fetch the last 10 transactions of a customer
    public List<Transaction> getTransactions(String accountNumber, String order) {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transactions WHERE account_number = ? ORDER BY date " + order + " LIMIT 10";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountNumber);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Transaction transaction = new Transaction();
                transaction.setId(resultSet.getInt("id"));
                transaction.setAccountNumber(resultSet.getString("account_number"));
                transaction.setAmount(resultSet.getBigDecimal("amount"));
                transaction.setDate(resultSet.getDate("date"));
                transaction.setType(resultSet.getString("type"));
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }

    // Method to update customer details
    public boolean updateCustomer(Customer customer) {
        String query = "UPDATE users SET full_name = ?, email = ?, phone = ?, address = ?, dob = ?, gender = ?, account_type = ?, branch = ?, id_type = ? WHERE account_number = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, customer.getFullName());
            preparedStatement.setString(2, customer.getEmail());
            preparedStatement.setString(3, customer.getPhone());
            preparedStatement.setString(4, customer.getAddress());
            preparedStatement.setString(5, customer.getDob());
            preparedStatement.setString(6, customer.getGender());
            preparedStatement.setString(7, customer.getAccountType());
            preparedStatement.setString(8, customer.getBranch());
            preparedStatement.setString(9, customer.getIdType());
            preparedStatement.setString(10, customer.getAccountNumber());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

   

    // Method to delete a customer
    public boolean deleteCustomer(String accountNumber) {
        String query = "DELETE FROM users WHERE account_number = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountNumber);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Customer getCustomerByAccountNumber(String accountNumber) {
        String query = "SELECT * FROM users WHERE account_number = ?";
        Customer customer = null;

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountNumber);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                customer = new Customer();
                customer.setAccountNumber(resultSet.getString("account_number"));
                customer.setFullName(resultSet.getString("full_name"));
                customer.setEmail(resultSet.getString("email"));
                customer.setPhone(resultSet.getString("phone"));
                customer.setAddress(resultSet.getString("address"));
                customer.setDob(resultSet.getString("dob"));
                customer.setGender(resultSet.getString("gender"));
                customer.setAccountType(resultSet.getString("account_type"));
                customer.setBranch(resultSet.getString("branch"));
                customer.setIdType(resultSet.getString("id_type"));
                customer.setBalance(resultSet.getBigDecimal("balance"));
                customer.setPassword(resultSet.getString("password"));
                customer.setTemporaryPassword(resultSet.getString("temp_password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer;
    }

 // Method to get temporary password
    public String getTempPassword(String accountNumber) throws SQLException {
        String tempPassword = null;
        String sql = "SELECT temp_password FROM users WHERE account_number = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, accountNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    tempPassword = rs.getString("temp_password");
                }
            }
        }
        return tempPassword;
    }

    public Connection getConnection() {
        return this.connection;
    }

    // Method to close the database connection
    public void closeConnection() {
        if (this.connection != null) {
            try {
                this.connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public Customer getCustomerDetails(String accountNumber) throws SQLException {
        Customer customer = null;
        String sql = "SELECT full_name, email, phone, address, dob, gender, account_type, branch, initial_deposit, id_type, contact_method, balance FROM users WHERE account_number = ?";
        try (PreparedStatement pstmt = this.connection.prepareStatement(sql)) {
            pstmt.setString(1, accountNumber);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    customer = new Customer();
                    customer.setFullName(rs.getString("full_name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setAddress(rs.getString("address"));
                    customer.setDob(rs.getDate("dob").toString());
                    customer.setGender(rs.getString("gender"));
                    customer.setAccountType(rs.getString("account_type"));
                    customer.setBranch(rs.getString("branch"));
                    customer.setInitialDeposit(rs.getBigDecimal("initial_deposit"));
                    customer.setIdType(rs.getString("id_type"));
                    customer.setContactMethod(rs.getString("contact_method"));
                    customer.setBalance(rs.getBigDecimal("balance"));
                    customer.setAccountNumber(accountNumber);
                }
            }
        }
        return customer;
    }



}
