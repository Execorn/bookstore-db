DELIMITER $$

CREATE PROCEDURE CalculateTotalSalesWithDiscount (IN book_id INT, OUT total_sales DECIMAL(10,2))
BEGIN
    DECLARE total_quantity INT;
    DECLARE book_price DECIMAL(10,2);
    DECLARE discount DECIMAL(5,2);
    
    -- Get total quantity sold
    SELECT SUM(quantity) INTO total_quantity FROM _order WHERE book_id = book_id;
    
    -- Get price of the book
    SELECT price INTO book_price FROM book WHERE id = book_id;
    
    -- Get discount for the book
    SELECT IFNULL(discount, 0) INTO discount FROM book WHERE id = book_id;
    
    -- Apply discount to the book price
    SET book_price = book_price - (book_price * (discount / 100));
    
    -- Calculate total sales
    SET total_sales = total_quantity * book_price;
END$$

DELIMITER ;

-- Call the stored procedure to calculate total sales with discount for book with ID 1
CALL CalculateTotalSalesWithDiscount(1, @total_sales);
SELECT @total_sales AS total_sales;

DELIMITER $$

CREATE PROCEDURE GetBooksByAuthorAndGenre (IN author_name VARCHAR(100), IN genre_name VARCHAR(50))
BEGIN
    SELECT title
    FROM book b
    JOIN author a ON b.author_id = a.id
    WHERE a.name = author_name AND b.genre = genre_name;
END$$

DELIMITER ;

-- Call the stored procedure to get books by author "John Doe" and genre "Mystery"
CALL GetBooksByAuthorAndGenre('John Doe', 'Mystery');