DROP TABLE IF EXISTS book;
CREATE TABLE book (
	_id INTEGER,
	title TEXT,
	author TEXT,
	publisher TEXT,
	year_of_publishing INTERVAL YEAR,
	price FLOAT
);

DROP TABLE IF EXISTS client;
CREATE TABLE client (
        _id INTEGER,
		_name TEXT,
		surname TEXT,
		email TEXT,
		phone TEXT,
		adress TEXT
);

DROP TABLE IF EXISTS delivery_method;
CREATE TABLE delivery_method (
	adress TEXT,
	delivery_method TEXT
);

DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback (
        score FLOAT,
        book_id INTEGER,
        _date DATE,
        author_id INTEGER
);

DROP TABLE IF EXISTS nearest_delivery_point;
CREATE TABLE nearest_delivery_point (
		nearest_point_adress TEXT,
		adress TEXT
);

DROP TABLE IF EXISTS _order;
CREATE TABLE _order (
        _id INTEGER,
        _date date,
        adress TEXT,
        book_id INTEGER,
        customer_id INTEGER
);

DROP TABLE IF EXISTS publisher;
CREATE TABLE publisher (
        publisher TEXT,
        discount FLOAT
);

DROP TABLE IF EXISTS quantity;
CREATE TABLE quantity (
	book_id INTEGER,
	quantity INTEGER
);
