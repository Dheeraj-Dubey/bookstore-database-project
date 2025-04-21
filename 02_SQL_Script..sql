Tables Created:
---•	Customers: Stores customer details.
---•	Books: Contains book info such as title, author, genre, and stock.
---•	Orders: Tracks customer orders.
---•	Order_Items: Holds order line items, book quantities, sale price, and profit.
---    Highlights:
--•	Used Primary Keys and Foreign Keys to maintain data integrity and optimize joins.
---•	Proper normalization to reduce redundancy and improve performance.

--SQL Schema:
-- Create Customers Table
CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,
    name VARCHAR (100),
    email VARCHAR (100),
    phone VARCHAR (20),
    city VARCHAR (100),
    age INT
);

-- Create Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR (200),
    author VARCHAR (100),
    price DECIMAL (10, 2),
    stock_qty INT,
    genre VARCHAR (100),
    published_date DATE
);

-- Create Orders Table

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    payment_method VARCHAR (50),
    CONSTRAINT_FK_Orders_Customers FOREIGN KEY (customer_id) REFERENCES                                                                Customers(customer_id));




-- Create Order_Items Table

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    Sale_price DECIMAL (10, 2),
    profit_Amt DECIMAL (10, 2),
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_id) REFERENCES         Orders(order_id),
    CONSTRAINT FK_OrderItems_Books FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
