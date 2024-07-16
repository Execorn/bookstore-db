DELIMITER $$

CREATE TRIGGER UpdateTotalQuantityAndAveragePriceWithTransaction AFTER INSERT ON _order
FOR EACH ROW
BEGIN
    DECLARE total_quantity INT;
    DECLARE total_sales DECIMAL(10,2);
    DECLARE average_price DECIMAL(10,2);
    
    -- Start transaction
    START TRANSACTION;
    
    -- Get total quantity sold
    SELECT SUM(quantity) INTO total_quantity FROM _order WHERE book_id = NEW.book_id;
    
    -- Get total sales for the book
    SELECT SUM(quantity * price) INTO total_sales FROM _order WHERE book_id = NEW.book_id;
    
    -- Calculate average price
    IF total_quantity > 0 THEN
        SET average_price = total_sales / total_quantity;
    ELSE
        SET average_price = 0;
    END IF;
    
    -- Update quantity_sold and average_price in the book table
    UPDATE book SET quantity_sold = total_quantity, average_price = average_price WHERE id = NEW.book_id;
    
    -- Commit transaction
    COMMIT;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER ArchiveOldOrdersWithLogging BEFORE DELETE ON _order
FOR EACH ROW
BEGIN
    DECLARE log_message VARCHAR(255);
    
    -- Check if the order is older than one year
    IF OLD._date < DATE_SUB(NOW(), INTERVAL 1 YEAR) THEN
        -- Insert the old order into archive table
        INSERT INTO archived_orders (id, book_id, customer_id, quantity, _date)
        VALUES (OLD.id, OLD.book_id, OLD.customer_id, OLD.quantity, OLD._date);
        
        -- Log the archiving action
        SET log_message = CONCAT('Order ID ', OLD.id, ' archived due to being older than one year.');
        INSERT INTO archive_log (message, _date) VALUES (log_message, NOW());
        
        -- Delete the old order from the _order table
        DELETE FROM _order WHERE id = OLD.id;
    END IF;
END$$

DELIMITER ;