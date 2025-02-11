SELECT
    c.address
    ,c.city
FROM
    Customer c;

SELECT
    e.EmployeeId
    ,e.Firstname
    ,e.LastName
FROM
    Employee e

SELECT
    i.InvoiceId
    ,i.Total
FROM
    Invoice i

SELECT
    *
FROM
    Customer c;

-- List all customers. Show only the CustomerId, FirstName and LastName columns
SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
FROM
    Customer c

-- List customers in the United Kingdom   
SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
    ,c.Country
FROM
    Customer c
WHERE Country='United Kingdom'


-- List customers whose first names begins with an A.
-- Hint: use LIKE and the % wildcard
SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName

FROM
    Customer c
WHERE c.FirstName LIKE 'A%'

-- List Customers with an apple email address
SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
    ,c.Email
FROM
    Customer c
WHERE c.Email LIKE '%@apple%'

-- Which customers have the initials LK?
SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
-- ,left(FirstName,1) as FirstnameItal
--,left(LastName,1) as LastnameItal
    ,LEFT(FirstName,1) + LEFT(LastName,1) AS Initials
FROM
    Customer c
--WHERE Firstname like 'L%'
WHERE LEFT(FirstName,1)='L' AND LEFT(LastName,1)='K'

-- Which are the corporate customers i.e. those with a value, not NULL, in the Company column?

SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
    ,c.Company

FROM
    Customer c
--WHERE Firstname like 'L%'
WHERE c.company IS NULL

-- How many customers are in each country.  Order by the most popular country first.
SELECT
    c.country
    ,count(*) AS NoCustomers


FROM
    Customer c
--WHERE Firstname like 'L%'
GROUP BY c. Country


-- When was the oldest employee born?  Who is that?
SELECT
    TOP 1
    e.FirstName
    ,e.LastName
    ,e.BirthDate
FROM
    Employee e
ORDER BY 
    e.BirthDate ASC

-- List the 10 latest invoices. Include the InvoiceId, InvoiceDate and Total

-- Then  also include the customer full name (first and last name together)


-- List the customers who have spent more than £45



SELECT
    c.FirstName
        ,c.LastName
        ,Sum(i.Total) AS InvTotal
FROM
    Invoice i
    JOIN Customer c ON i.CustomerId=c.CustomerId
GROUP BY c.FirstName
        ,c.LastName
HAVING Sum(i.Total)>45

--OR
SELECT *
FROM Customer
WHERE CustomerID in 
(SELECT
        i.CustomerID
FROM 
Invoice i
GROUP BY i.CustomerId
HAVING Sum(i.Total)>45)

-- implement as a table subquery
 
SELECT
    c.FirstName
    ,c.LastName
    ,topCust.InvoiceTotal
FROM
    Customer c JOIN  
(SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45) topCust
ON c.CustomerId = topCust.CustomerId
 
-- implement as a CTE
;
with cte AS
(SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45 )
select
    c.FirstName
    ,c.LastName
    ,cte.InvoiceTotal
from  Customer c JOIN cte on c.CustomerId = cte.CustomerId
 
--implement as temporary tables
 
SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
INTO #topCust -- Temporary Table
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45
 
SELECT * FROM #topCust JOIN Customer c ON #topCust.CustomerId=c.CustomerID
 
-- List the City, CustomerId and LastName of all customers in Paris and London,
-- and the Total of their invoices
 


