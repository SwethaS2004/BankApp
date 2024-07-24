package com.Customer;

import java.math.BigDecimal;
import java.util.Date;

public class Transaction {
    private int id;
    private String accountNumber;
    private BigDecimal amount;
    private Date date;
    private String type;

    public Transaction() {
    }

    public Transaction(int id, String accountNumber, BigDecimal amount, Date date, String type) {
        this.id = id;
        this.accountNumber = accountNumber;
        this.amount = amount;
        this.date = date;
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
