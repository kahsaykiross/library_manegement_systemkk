-- =========================================================
-- Project: Library Management System
-- Author: Kahsay Kiross Meresa
-- Description: MySQL database design for managing books,
--              members, authors, and borrowing transactions
-- =========================================================

-- =========================
-- 1. CREATE DATABASE
-- =========================
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- =========================
-- 2. CREATE TABLES
-- =========================

-- Authors Table
CREATE TABLE IF NOT EXISTS authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    UNIQUE(first_name, last_name) -- No duplicate author names
);

-- Books Table
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    published_year YEAR,
    author_id INT NOT NULL, -- Foreign Key
    CONSTRAINT fk_books_author FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Members Table
CREATE TABLE IF NOT EXISTS members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    join_date DATE DEFAULT CURRENT_DATE
);

-- Borrowing Table (Many-to-Many between Members and Books)
CREATE TABLE IF NOT EXISTS borrowings (
    borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL DEFAULT CURRENT_DATE,
    return_date DATE,
    CONSTRAINT fk_borrow_member FOREIGN KEY (member_id)
        REFERENCES members(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_borrow_book FOREIGN KEY (book_id)
        REFERENCES books(book_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT unique_member_book UNIQUE(member_id, book_id, borrow_date)
);

-- =========================
-- 3. OPTIONAL SAMPLE DATA
-- =========================

INSERT INTO authors(first_name, last_name, birth_date)
VALUES
('J.K.', 'Rowling', '1965-07-31'),
('George', 'Orwell', '1903-06-25'),
('Jane', 'Austen', '1775-12-16');

INSERT INTO books(title, isbn, published_year, author_id)
VALUES
('Harry Potter and the Sorcerer''s Stone', '9780747532699', 1997, 1),
('1984', '9780451524935', 1949, 2),
('Pride and Prejudice', '9780141439518', 1813, 3);

INSERT INTO members(first_name, last_name, email, phone)
VALUES
('Alice', 'Smith', 'alice@example.com', '1234567890'),
('Bob', 'Johnson', 'bob@example.com', '0987654321');

INSERT INTO borrowings(member_id, book_id, borrow_date)
VALUES
(1, 1, '2025-08-16'),
(2, 2, '2025-08-16');

-- =========================
-- End of Library Management System
-- =========================
