-- Q1. How many orders were placed by each customer? Show customer_id and order count.
SELECT customer_id, COUNT (order_id) as order_count FROM orders GROUP BY customer_id

-- Q2. What is the total quantity sold for each product? Show product_id and total quantity.
SELECT product_id, SUM (quantity) as total_quantity FROM orders GROUP BY product_id

-- Q3. Find the average price of products in each category.
SELECT category, AVG (price) as avg_price FROM products GROUP BY category

-- Q4. Find the most expensive and cheapest product price in each category.
SELECT category, MAX (price) as expensive_product, MIN (price) as cheapest_product FROM products  GROUP BY category

-- Q5. How many employees are there in each department? Show dept_id and count.
SELECT dept_id, COUNT(emp_id) as employee_count FROM employees GROUP BY dept_id

-- Q6. Find departments where the total salary bill exceeds 1,50,000. Show dept_id and total salary
SELECT dept_id, SUM (salary) as total_salary FROM employees 
GROUP BY dept_id HAVING SUM (salary) > 150000

-- Q7. List all customers who have placed at least one order.
 SELECT * FROM customers WHERE customer_id IN (SELECT customer_id   FROM orders);

--  Q8. List all customers who have NEVER placed any order.
SELECT * FROM customers WHERE customer_id NOT IN (SELECT customer_id  FROM orders);

-- Q9. Find employees who earn more than the average salary of ALL employees.
SELECT * FROM employees WHERE salary > (SELECT AVG (salary) FROM employees);

-- Q10. Find the student(s) who scored the highest marks in Mathematics (subject_id = 1).
SELECT * FROM exam_scores WHERE subject_id = 1 AND marks = (SELECT MAX (marks) FROM exam_scores WHERE subject_id = 1);

-- Q11. List products that have been ordered at least once — use a subquery (not a JOIN).
SELECT * FROM products WHERE product_id IN (SELECT DISTINCT product_id  FROM orders);

-- Q12. Display each order showing the customer name and city alongside order details.
SELECT  ord.order_id, ord.customer_id, cust.name, cust.city, ord.product_id, ord.quantity, ord.order_date
FROM orders ord
INNER JOIN customers cust
ON ord.customer_id = cust.customer_id;

-- Q13. Show each order with the product name, category, and the total amount (quantity x price).
SELECT  ord.order_id, prod.product_name, prod.category, ord.quantity, prod.price, (ord.quantity * prod.price) AS total_amount
FROM orders ord
INNER JOIN products prod
ON ord.product_id = prod.product_id;

-- Q14. List ALL customers and their orders. Customers with no orders should also appear (show NULL for order columns).
SELECT     cust.customer_id, cust.name, cust.city, ord.order_id, ord.product_id, ord.quantity,    ord.order_date
FROM customers cust
LEFT JOIN orders ord
ON cust.customer_id = ord.customer_id;

-- Q15. Display each student's name, the subject they were tested in, and their marks.
SELECT st.student_name, sub.subject_name, es.marks
FROM exam_scores es
INNER JOIN students st
ON es.student_id = st.student_id
INNER JOIN subjects sub
ON es.subject_id = sub.subject_id
order by st.student_name asc;

-- Q16. List all employees with their department name and office location.
 SELECT  emp.emp_id, emp.emp_name, dep.dept_name, dep.location
FROM employees emp
INNER JOIN departments dep
ON emp.dept_id = dep.dept_id;

-- Q17. Find total salary expense per department — show the department name (not the ID).
SELECT dep.dept_name, SUM (emp.salary) AS total_salary
FROM employees emp
INNER JOIN departments dep
ON emp.dept_id = dep.dept_id
GROUP BY dep.dept_name;

-- Q18. Which customer spent the most money in total? Show their name and total spend.
SELECT   cust.name AS customer_name, SUM (ord.quantity * prod.price) AS total_spent FROM orders ord
INNER JOIN customers cust
ON ord.customer_id = cust.customer_id
INNER JOIN products prod
ON ord.product_id = prod.product_id
GROUP BY cust.customer_id, cust.name ORDER BY total_spent DESC 
LIMIT 1;

-- Q19. Find the average Mathematics marks (subject_id = 1) for each class.
SELECT stu.class, AVG (es.marks) AS avg_maths_marks FROM exam_scores es
INNER JOIN students stu 
ON es.student_id = stu.student_id 
WHERE es.subject_id = 1 GROUP BY stu.class;

-- Q20. List employees who earn more than the average salary of their OWN department.
SELECT * FROM employees emp WHERE emp.salary > (SELECT AVG (salary) FROM employees WHERE dept_id = e.dept_id);


