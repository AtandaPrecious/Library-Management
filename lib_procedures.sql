/* ===============================
 STORED PROCEDURES
=============================== */

-- ADD return Status
DROP PROCEDURE IF EXISTS add_return_records;
DELIMITER $$

CREATE PROCEDURE add_return_records(
    IN p_return_id VARCHAR(10),
    IN p_issued_id VARCHAR(10),
    IN p_book_quality VARCHAR(10)
)
BEGIN
    DECLARE v_isbn VARCHAR(50);
    DECLARE v_book_name VARCHAR(255);

    -- Get ISBN and title from issued_status first
    SELECT issued_book_isbn, issued_book_name
    INTO v_isbn, v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id
    LIMIT 1;

    -- Insert return record (now includes isbn and book name)
    INSERT INTO return_status (
        return_id,
        issued_id,
        return_date,
        book_quality,
        return_book_isbn,
        return_book_name
    )
    VALUES (
        p_return_id,
        p_issued_id,
        CURRENT_DATE,
        p_book_quality,
        v_isbn,
        v_book_name
    );

    -- Update book availability
    UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;

    -- Confirmation message
    SELECT CONCAT('Thank you for returning: ', v_book_name) AS message;
END $$

DELIMITER ;

-- TEST Procedure
CALL add_return_records('R205', 'IS105', 'Damaged');
SELECT * FROM return_status;
SELECT * FROM books;

-- Issue a book if available
DELIMITER $$
CREATE PROCEDURE issue_books(
    IN p_issued_id VARCHAR(10), 
    IN p_issued_member_id VARCHAR(30), 
    IN p_issued_book_isbn VARCHAR(30), 
    IN p_issued_emp_id VARCHAR(10)
)
BEGIN
    DECLARE v_status VARCHAR(10);
    DECLARE v_book_title VARCHAR(255);

    -- Check availability
    SELECT status, book_title
    INTO v_status, v_book_title
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN
        -- Insert into issued_status
        INSERT INTO issued_status (issued_id, issued_member_id, issued_date, issued_book_isbn, issued_book_name, issued_emp_id)
        VALUES (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, v_book_title, p_issued_emp_id);

        -- Update status to 'no'
        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

        SELECT CONCAT('Book issued successfully: ', v_book_title) AS message;
    ELSE
        SELECT CONCAT('Book unavailable. ISBN: ', p_issued_book_isbn) AS message;
    END IF;
END $$
DELIMITER ;

-- TEST Procedure
CALL issue_books('IS105', 'M004', '978-0-7432-7356-5', 'E105');
SELECT * FROM issued_status;
SELECT* FROM books;