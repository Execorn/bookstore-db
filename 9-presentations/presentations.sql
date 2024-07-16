-- Create a view to hide technical fields in the book table
CREATE VIEW
    book_info AS
SELECT
    _id,
    title,
    author,
    publisher,
    year_of_publishing AS publishing_year,
    price
FROM
    book;

-- Test the book_info view
SELECT
    *
FROM
    book_info;

-- Create a view to hide personal data in the client table
CREATE VIEW
    client_info AS
SELECT
    _id,
    _name,
    surname,
    '*****' AS email,
    '*****' AS phone,
    adress
FROM
    client;

-- Test the client_info view
SELECT
    *
FROM
    client_info;

-- Create a view to display sales statistics pivot table
CREATE VIEW
    sales_statistics AS
SELECT
    b.title AS book_title,
    b.author AS author,
    p.publisher AS publisher,
    SUM(q.quantity) AS total_sold,
    COUNT(f.score) AS feedback_count,
    AVG(f.score) AS avg_score
FROM
    book b
    JOIN quantity q ON b._id = q.book_id
    JOIN feedback f ON b._id = f.book_id
    JOIN publisher p ON b.publisher = p.publisher
GROUP BY
    b.title,
    b.author,
    p.publisher;

-- Test the sales_statistics view
SELECT
    *
FROM
    sales_statistics;

-- Create a view to display client feedback statistics
CREATE VIEW
    feedback_statistics AS
SELECT
    c._name || ' ' || c.surname AS client_name,
    COUNT(f.score) AS feedback_count,
    AVG(f.score) AS avg_score
FROM
    client c
    JOIN _order o ON c._id = o.customer_id
    JOIN feedback f ON o.book_id = f.book_id
GROUP BY
    c._name,
    c.surname;

-- Test the feedback_statistics view
SELECT
    *
FROM
    feedback_statistics;

-- Create a view to display popular publishers and their sales
CREATE VIEW
    popular_publishers_sales AS
SELECT
    p.publisher AS publisher,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    SUM(q.quantity) AS total_sold
FROM
    publisher p
    JOIN book b ON p.publisher = b.publisher
    JOIN quantity q ON b._id = q.book_id
    JOIN _order o ON b._id = o.book_id
GROUP BY
    p.publisher;

-- Test the popular_publishers_sales view
SELECT
    *
FROM
    popular_publishers_sales;

-- Create a view to display delivery methods and their usage
CREATE VIEW
    delivery_method_usage AS
SELECT
    dm.delivery_method AS delivery_method,
    COUNT(o._id) AS orders_count
FROM
    delivery_method dm
    JOIN _order o ON dm.adress = o.adress
GROUP BY
    dm.delivery_method;

-- Test the delivery_method_usage view
SELECT
    *
FROM
    delivery_method_usage;