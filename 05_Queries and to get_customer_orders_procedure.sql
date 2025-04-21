-- Before accessing any table, you need to select the database first using the          USE statement.
USE Database_Design_Online_Bookstore;
-- 1. Get all customers
SELECT * FROM Customers;

-- 2. List all books that are in stock
SELECT * FROM Books WHERE stock_qty > 0;

-- 3. Get all orders placed after April 1, 2024
SELECT * FROM Orders WHERE order_date > '2024-04-01';

-- 4. Find total number of orders placed by each customer
SELECT customer_id, COUNT (*) AS total_orders
FROM Orders
GROUP BY customer_id;



-- 5. Show total sales value for each book
SELECT
book_id,
SUM (sale_price) AS total_sales
FROM Order_Items
GROUP BY book_id;

Stored Procedure:
-- Stored Procedure: Get all orders for a specific customer
CREATE PROCEDURE GetCustomerOrders
    @cust_id INT
AS
BEGIN
    SELECT
        Orders.customer_id,
        Orders.order_id,
        Orders.order_date,
        Books.title,
        Order_Items.quantity,
        Order_Items.sale_price
    FROM Orders
    JOIN Order_Items ON Orders.order_id = Order_Items.order_id
    JOIN Books ON Order_Items.book_id = Books.book_id
    WHERE Orders.customer_id = @cust_id;
END;

-- Execute example
EXEC GetCustomerOrders @cust_id = 1;
