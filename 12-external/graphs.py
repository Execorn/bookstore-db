import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

# Connect to the SQLite database
conn = sqlite3.connect('bookshop.db')

# Read data from the book table into a pandas DataFrame
df = pd.read_sql_query("SELECT * FROM book", conn)

# Close connection
conn.close()

# Analyze the data (e.g., plot a histogram of book prices)
plt.hist(df['price'], bins=20, color='skyblue', edgecolor='black')
plt.xlabel('Price')
plt.ylabel('Frequency')
plt.title('Distribution of Book Prices')
plt.show()
