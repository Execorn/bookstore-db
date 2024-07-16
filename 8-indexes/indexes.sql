

-- Index for book table
CREATE INDEX idx_book_title ON book (title);

CREATE INDEX idx_book_author ON book (author);

CREATE INDEX idx_book_year_of_publishing ON book (year_of_publishing);

-- Index for client table
CREATE INDEX idx_client_email ON client (email);

CREATE INDEX idx_client_phone ON client (phone);

CREATE INDEX idx_client_surname ON client (surname);

-- Index for feedback table
CREATE INDEX idx_feedback_book_id ON feedback (book_id);

CREATE INDEX idx_feedback_author_id ON feedback (author_id);

CREATE INDEX idx_feedback_date ON feedback (_date);

-- Index for _order table
CREATE INDEX idx_order_book_id ON _order (book_id);

CREATE INDEX idx_order_customer_id ON _order (customer_id);

CREATE INDEX idx_order_date ON _order (_date);

-- Index for quantity table
CREATE INDEX idx_quantity_book_id ON quantity (book_id);

CREATE INDEX idx_quantity_quantity ON quantity (quantity);