INSERT INTO branch (branch_id, manager_id, branch_address, contact_no) VALUES
('B001', 'E101', '12 Main St, Lagos', '08031234567'),
('B002', 'E104', '22 Broad St, Abuja', '08039876543');

INSERT INTO employees (emp_id, emp_name, position, salary, branch_id) VALUES
('E101', 'Grace Johnson', 'Manager', 150000, 'B001'),
('E102', 'David Okoro', 'Librarian', 90000, 'B001'),
('E103', 'Aisha Bello', 'Assistant Librarian', 70000, 'B001'),
('E104', 'Michael Adams', 'Manager', 160000, 'B002'),
('E105', 'Tunde Akin', 'Librarian', 95000, 'B002');

INSERT INTO members (member_id, member_name, member_address, reg_date) VALUES
('M001', 'John Doe', '15 Allen Ave, Lagos', '2024-01-15'),
('M002', 'Sarah Williams', '45 Garki Rd, Abuja', '2024-03-22'),
('M003', 'Peter Obi', '88 Opebi Rd, Lagos', '2024-04-10'),
('M004', 'Mary Samuel', '72 Maitama, Abuja', '2024-05-05');

INSERT INTO books (isbn, book_title, category, rental_price, status, author, publisher) VALUES
('978-0-553-29698-2', 'The Great Gatsby', 'Fiction', 500.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0-7432-7356-5', 'To Kill a Mockingbird', 'Fiction', 450.00, 'yes', 'Harper Lee', 'Harper Perennial'),
('978-0-452-28423-4', '1984', 'Dystopian', 400.00, 'no', 'George Orwell', 'Plume'),
('978-0-375-41398-8', 'The Catcher in the Rye', 'Fiction', 480.00, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
('978-1-4028-9462-6', 'Clean Code', 'Programming', 600.00, 'no', 'Robert C. Martin', 'Prentice Hall');

INSERT INTO issued_status (issued_id, issued_member_id, issued_book_isbn, issued_book_name, issued_date, issued_emp_id) VALUES
('IS101', 'M001', '978-0-553-29698-2', 'The Great Gatsby', '2024-06-01', 'E102'),
('IS102', 'M002', '978-0-452-28423-4', '1984', '2024-06-10', 'E105'),
('IS103', 'M003', '978-1-4028-9462-6', 'Clean Code', '2024-06-15', 'E103'),
('IS104', 'M001', '978-0-375-41398-8', 'The Catcher in the Rye', '2024-06-20', 'E102');

INSERT INTO return_status (return_id, issued_id, return_book_name, return_date, return_book_isbn, book_quality) VALUES
('R201', 'IS101', 'The Great Gatsby', '2024-07-05', '978-0-553-29698-2', 'Good'),
('R202', 'IS102', '1984', '2024-07-20', '978-0-452-28423-4', 'Damaged'),
('R203', 'IS103', 'Clean Code', '2024-08-01', '978-1-4028-9462-6', 'Good');


