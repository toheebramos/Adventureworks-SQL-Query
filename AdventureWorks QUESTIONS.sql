

-- Retrieve information about the products with colours that are not null and not silver nor black nor white and list price is between £75 and £750.
--Rename the column StandardCost as Price.Finally please sort the results by list price in descending order

select productid, name, color, standardcost as price, listprice from production.product
where Color not in ('white', 'black', 'silver', 'null') and ListPrice between 75 and 750
order by ListPrice desc


--  Find all the male employees born between 1962 to 1970 and with hire date greater than 2001 and female employees born between 1972 and 1975 and hire date between 2001 and 2002

select BusinessEntityID, year(BirthDate) as birthyear, Gender, year(HireDate) as hireyear from HumanResources.Employee
where year(birthdate) between 1962 and 1970 and year(hiredate) > 2001 and Gender = 'M'
OR Gender = 'F' and year(birthdate) Between 1972 and 1975 and year(hiredate) between 2001 and 2002


-- Create a list of 10 most expensive products that have a product number beginning with ‘BK’. Include only the product ID, Name and colour

select top 10 ProductID, Name, color from Production.product
where ProductNumber like 'BK%'
order by ListPrice desc


-- First create a list of all the contact people where the first 4 characters of their last name are equal to the first 4 characters of their email address. 
--Second find all the contact people whose first name and the last name begin with the same character,
--create a new column called full name combining their first name and their last name. Finally add a column with the length of the full name.

select PP.BusinessEntityID, FirstName, LastName, EmailAddress, CONCAT(firstname, LastName) as FullName, LEN(CONCAT(firstname, LastName)) as length 
from Person.Person as PP
INNER JOIN Person.EmailAddress as PE ON PP.BusinessEntityID = PE.BusinessEntityID
where SUBSTRING(lastname, 1,4) = SUBSTRING(emailaddress,1,4) and SUBSTRING(firstname,1,1) = SUBSTRING(lastname,1,1)


-- Return all product subcategories that take an average of 3 days or longer to manufacture.

select PSC.Name as subcategory_name, DaysToManufacture from Production.Product as PP inner join Production.ProductSubcategory as PSC
ON PP.ProductSubcategoryID = PSC.ProductSubcategoryID
where DaysToManufacture >= 3														


-- Create a price segmentation for products by defining a criteria that places each item in a segment as follows: 
-- If price is less than £200 then it’s low value. If price is between £201 and £750 then it is mid value. If price is between £751 and £1250
--then it is mid to high value. All else is higher value. Filter the results only for products that are black, silver and red (colour)

select name, color, ListPrice,
CASE
    WHEN listprice < 200 then 'low value'
	WHEN listprice between 201 and 750 then 'mid value'
	WHEN listprice between 751 and 1250 then 'high value'
    ELSE 'higher value'
END as price_segment
from Production.Product
where color in ('black', 'silver', 'red')


--How many distinct job titles are there in the Employee table

select count(distinct JobTitle) from HumanResources.Employee
--67


-- Use the Employee table and calculate the ages of each employee at the time of hiring

select BusinessEntityID, year(BirthDate) as birth_year, year(HireDate) as hire_year, age = (year(HireDate) - year(BirthDate)) from HumanResources.Employee

 
-- How many employees will be due a Long Service Award in the next 5 years, if long service is 20 years

select BusinessEntityID, year(HireDate) as Hire_year, year_in_service = (2023 - year(HireDate)) from HumanResources.Employee
WHERE year(HireDate) <= 2008
--OR
select count (year(HireDate)) as Hire_year from HumanResources.Employee
WHERE year(HireDate) <= 2008
--81


--How many more years does each employee have to work before reaching retirement, if the retirement age is 65

select BusinessEntityID, year(BirthDate) as birth_year, year(HireDate) as hire_year, age = (year(HireDate) - year(BirthDate)), 
Year_to_Retirement = (65 - (year(HireDate) - year(BirthDate))) from HumanResources.Employee
order by age desc

