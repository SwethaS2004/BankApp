package com.Customer;

import java.math.BigDecimal;

public class Customer {
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String dob;
    private String gender;
    private String accountType;
    private String branch;
    private BigDecimal initialDeposit;
    private String idType;
    private String contactMethod;
    private String accountNumber;
    private BigDecimal balance;

    public Customer(String fullName, String email, String phone, String address, String dob, String gender, 
                    String accountType, String branch, BigDecimal initialDeposit, String idType, BigDecimal balance, 
                    String accountNumber) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.dob = dob;
        this.gender = gender;
        this.accountType = accountType;
        this.branch = branch;
        this.initialDeposit = initialDeposit;
        this.idType = idType;
        this.balance = balance;
        this.accountNumber = accountNumber;
    }

    // Getters and Setters for all fields

    public Customer() {
		// TODO Auto-generated constructor stub
	}

	public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public BigDecimal getInitialDeposit() {
        return initialDeposit;
    }

    public void setInitialDeposit(BigDecimal initialDeposit) {
        this.initialDeposit = initialDeposit;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getContactMethod() {
        return contactMethod;
    }

    public void setContactMethod(String contactMethod) {
        this.contactMethod = contactMethod;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

	public String getTemporaryPassword() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setPassword(String string) {
		// TODO Auto-generated method stub
		
	}

	public void setTemporaryPassword(String string) {
		// TODO Auto-generated method stub
		
	}

	public void deposit(BigDecimal amount) {
		// TODO Auto-generated method stub
		
	}

	public void withdraw(BigDecimal amount) {
		// TODO Auto-generated method stub
		
	}
}
