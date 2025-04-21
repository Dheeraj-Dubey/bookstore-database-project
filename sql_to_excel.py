--Script 2: SQL Server to Excel
---•	Reads data from SQL tables
---•	Writes data into an Excel file with 4 sheets
import pandas as pd
from sqlalchemy import create_engine
import urllib

params = urllib.parse.quote_plus(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=DESKTOP-509Q3SC;"
    "DATABASE=Database_Design_Online_Bookstore;"
    "Trusted_Connection=yes;"
)
engine = create_engine("mssql+pyodbc:///?odbc_connect=%s" % params)

customers_df = pd.read_sql("SELECT * FROM Customers", engine)
books_df = pd.read_sql("SELECT * FROM Books", engine)
orders_df = pd.read_sql("SELECT * FROM Orders", engine)
order_items_df = pd.read_sql("SELECT * FROM Order_Items", engine)

with pd.ExcelWriter("bookstore_data.xlsx", engine='openpyxl', mode='w') as writer:
    customers_df.to_excel(writer, sheet_name="Customers", index=False)
    books_df.to_excel(writer, sheet_name="Books", index=False)
    orders_df.to_excel(writer, sheet_name="Orders", index=False)
    order_items_df.to_excel(writer, sheet_name="Order_Items", index=False)

print("✅ Data exported from SQL Server to Excel!")
