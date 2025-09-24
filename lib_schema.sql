/* ===============================
 SCHEMA: Library Management System
 Tables: books, members, employees, branch, issued_status, return_status
=============================== */

-- Books Table
CREATE TABLE books (
    isbn VARCHAR(30) PRIMARY KEY,
    book_title VARCHAR(255),
    category VARCHAR(100),
    rental_price FLOAT,
    status VARCHAR(10), 
    author VARCHAR(255),
    publisher VARCHAR(255)
);

-- Members Table
CREATE TABLE members (
    member_id VARCHAR(30) PRIMARY KEY,
    member_name VARCHAR(255),
    member_address VARCHAR(255),
    reg_date DATE
);


-- Branch Table
CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(100),
    contact_no VARCHAR(40)
);

-- Employees Table
CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(255),
    position VARCHAR(50),
    salary INT,
    branch_id VARCHAR(10),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Issued Status Table
CREATE TABLE issued_status (
    issued_id VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(30),
    issued_book_isbn VARCHAR(30),
    issued_book_name VARCHAR(255),
    issued_date DATE,
    issued_emp_id VARCHAR(10),
    FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
    FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn),
    FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id)
);

-- Return Status Table
CREATE TABLE return_status (
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(10),
    return_book_name VARCHAR(255),
    return_date DATE,
    return_book_isbn VARCHAR(30),
    book_quality VARCHAR(15) DEFAULT 'Good',
    FOREIGN KEY (issued_id) REFERENCES issued_status(issued_id)
);
