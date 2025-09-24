/* ===============================
 REPORTING QUERIES
=============================== */

-- members with overdue books
SELECT 
	ist.issued_member_id,
    m.member_name,
    b.book_title,
    ist.issued_date,
    -- rs.return_date,
    DATEDIFF(CURRENT_DATE, ist.issued_date) AS overdue_days
FROM issued_status as ist
JOIN
members as m
ON m.member_id = ist.issued_member_id
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE 
	rs.return_date IS NULL
    AND
    DATEDIFF(CURRENT_DATE, ist.issued_date) > 30
ORDER BY 1;

-- Overdue Books fine
CREATE TABLE overdue_fines AS
SELECT 
    ist.issued_member_id AS member_id,
    COUNT(CASE 
        WHEN rs.issued_id IS NULL AND DATEDIFF(CURDATE(), ist.issued_date) > 30 
        THEN 1 END) AS overdue_books,
    SUM(CASE 
        WHEN rs.issued_id IS NULL AND DATEDIFF(CURDATE(), ist.issued_date) > 30 
        THEN (DATEDIFF(CURDATE(), ist.issued_date) - 30) * 0.50 ELSE 0 END) AS total_fines,
    COUNT(*) AS total_books_issued
FROM issued_status ist
LEFT JOIN return_status rs ON ist.issued_id = rs.issued_id
GROUP BY ist.issued_member_id;

SELECT * FROM overdue_fines;

-- Branch Performance
CREATE TABLE branch_report AS
SELECT 
    b.branch_id,
    b.manager_id,
    COUNT(ist.issued_id) AS no_books_issued,
    COUNT(rs.return_id) AS no_books_returned,
    SUM(bk.rental_price) AS total_revenue
FROM issued_status ist
JOIN employees e ON e.emp_id = ist.issued_emp_id
JOIN branch b ON e.branch_id = b.branch_id
LEFT JOIN return_status rs ON rs.issued_id = ist.issued_id
JOIN books bk ON ist.issued_book_isbn = bk.isbn
GROUP BY b.branch_id, b.manager_id;

SELECT * FROM branch_report;

-- Active Members in last 6 months
CREATE TABLE active_members AS
SELECT * FROM members
WHERE member_id IN (
    SELECT DISTINCT issued_member_id
    FROM issued_status
    WHERE issued_date >= CURRENT_DATE - INTERVAL 6 MONTH
);

SELECT * FROM active_members;

-- Revenue generated from each book category
CREATE TABLE rev_gen_book_cat AS
SELECT 
	b.category,
    SUM(b.rental_price) as tot_income,
    COUNT(*) as no_issued
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1;

SELECT * FROM rev_gen_book_cat;

-- Members who returned damaged books (High Risk)
SELECT
    m.member_name,
    ist.issued_book_name AS book_title,
    COUNT(*) AS damaged_count
FROM members m
JOIN issued_status ist 
    ON m.member_id = ist.issued_member_id
JOIN return_status rs 
    ON rs.issued_id = ist.issued_id
WHERE rs.book_quality = 'Damaged'
GROUP BY m.member_name, ist.issued_book_name