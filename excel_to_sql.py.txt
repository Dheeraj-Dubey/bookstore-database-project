--Script 1: Excel to SQL Server
--•	Reads Excel data with 4 sheets
--•	Cleans data (removes duplicates)
--•	Loads data into SQL Server using to_sql()
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

excel_path = 'bookstore_data.xlsx'
customers_df = pd.read_excel(excel_path, sheet_name='Customers')
books_df = pd.read_excel(excel_path, sheet_name='Books')
orders_df = pd.read_excel(excel_path, sheet_name='Orders')
order_items_df = pd.read_excel(excel_path, sheet_name='Order_Items')

customers_df = customers_df.drop_duplicates(subset=['customer_id'])
books_df = books_df.drop_duplicates(subset=['book_id'])
orders_df = orders_df.drop_duplicates(subset=['order_id'])
order_items_df = order_items_df.drop_duplicates(subset=['order_item_id'])

customers_df.to_sql('Customers', con=engine, if_exists='replace', index=False)
books_df.to_sql('Books', con=engine, if_exists='replace', index=False)
orders_df.to_sql('Orders', con=engine, if_exists='replace', index=False)
order_items_df.to_sql('Order_Items', con=engine, if_exists='replace', index=False)

print("✅ Data successfully inserted into SQL Server!")
