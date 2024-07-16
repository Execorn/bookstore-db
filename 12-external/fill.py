import sqlite3
import random
from faker import Faker

# Connect to the SQLite database
conn = sqlite3.connect('bookshop.db')
cursor = conn.cursor()

# Create fake data generator
fake = Faker()

# Generate and insert data into the book table
for i in range(1, 101):
    title = fake.sentence(nb_words=3)
    author = fake.name()
    publisher = fake.company()
    year_of_publishing = fake.year()
    price = round(random.uniform(10, 100), 2)
    cursor.execute("INSERT INTO book (_id, title, author, publisher, year_of_publishing, price) VALUES (?, ?, ?, ?, ?, ?)",
                   (i, title, author, publisher, year_of_publishing, price))

# Generate and insert data into the client table
for i in range(1, 51):
    name = fake.first_name()
    surname = fake.last_name()
    email = fake.email()
    phone = fake.phone_number()
    address = fake.address()
    cursor.execute("INSERT INTO client (_id, _name, surname, email, phone, adress) VALUES (?, ?, ?, ?, ?, ?)",
                   (i, name, surname, email, phone, address))

# Generate and insert data into the feedback table
for i in range(1, 1001):
    score = random.randint(1, 5)
    book_id = random.randint(1, 100)
    date = fake.date_between(start_date='-1y', end_date='today')
    author_id = random.randint(1, 50)
    cursor.execute("INSERT INTO feedback (score, book_id, _date, author_id) VALUES (?, ?, ?, ?)",
                   (score, book_id, date, author_id))

# Commit changes and close connection
conn.commit()
conn.close()
