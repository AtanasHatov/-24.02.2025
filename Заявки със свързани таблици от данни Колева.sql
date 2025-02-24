CREATE DATABASE [Library]
CREATE TABLE [customers](
[customers_id] INT PRIMARY KEY IDENTITY (1,1),
[name] NVARCHAR(50) NOT NULL,
[year] INT NOT NULL
);

CREATE TABLE [books](
[books_id] INT PRIMARY KEY IDENTITY(1,1),
[title] NVARCHAR(150) NOT NULL,
[author] NVARCHAR(100) NOT NULL,
[year_published] INT NOT NULL,
[publishing_Hause] NVARCHAR(100) NOT NULL
);

CREATE TABLE [orders](
[orders_id] INT PRIMARY KEY IDENTITY(1,1),
[book_id] INT FOREIGN KEY REFERENCES books(books_id),
[costumer_id] INT FOREIGN KEY REFERENCES customers(customers_id),
[date_orders] DATE NOT NULL
);

INSERT INTO books([title],[author],[year_published],[publishing_Hause])
VALUES
('1984', 'Джордж Оруел', 1949, 'Сиела'), 
('Хари Потър и Философският камък', 'Дж. К. Роулинг', 1997, 'Егмонт'), 
('Престъпление и наказание', 'Фьодор Достоевски', 1866, 'Фама'), 
('Сто години самота', 'Габриел Гарсия Маркес', 1967, 'Колибри'), 
('Фермата на животните', 'Джордж Оруел', 1945, 'Сиела'); 

INSERT INTO customers([name],[year])
VALUES
('Иван Петров', 30), 
('Мария Георгиева', 25), 
('Стефан Димитров', 40), 
('Анна Иванова', 35); 

INSERT INTO orders([costumer_id],[book_id],[date_orders])
VALUES
(1, 1, '2024-02-01'), 
(1, 3, '2024-02-02'), 
(2, 2, '2024-02-03'), 
(3, 4, '2024-02-04'), 
(4, 5, '2024-02-05'); 

SELECT * 
FROM 
books
WHERE books_id IN(SELECT book_id FROM orders)

SELECT title, year_published
FROM 
books
WHERE author=N'Джордж Оруел'

SELECT TOP 1 title FROM books ORDER BY year_published ASC

SELECT books.title,customers.[name]
FROM
books
JOIN 
orders ON books.books_id=orders.book_id
JOIN
customers ON customers.customers_id=orders.costumer_id

SELECT customers.[name]
FROM
customers
JOIN 
orders ON customers.customers_id=orders.costumer_id
JOIN
books ON books.books_id=orders.book_id
WHERE books.author=N'Джордж Оруел'

SELECT TOP 1 customers.[name]
FROM
customers
JOIN 
orders ON customers.customers_id=orders.costumer_id
JOIN
books ON books.books_id=orders.book_id
ORDER BY books.year_published DESC

SELECT books.title, books.year_published, customers.[name]
FROM
books
JOIN
orders ON books.books_id=orders.book_id
JOIN
customers ON customers.customers_id=orders.costumer_id
ORDER BY books.year_published

SELECT books.title, customers.[name], orders.date_orders
FROM 
books
JOIN  
orders ON books.books_id=orders.book_id
JOIN
customers ON customers.customers_id=orders.costumer_id
ORDER BY orders.date_orders