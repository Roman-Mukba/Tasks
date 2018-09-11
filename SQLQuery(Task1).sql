1./*Update the Employees table, so it contains the HireDate values from 2014 till the current (2019) year.*/
update dbo.Employees
set HireDate = Case EmployeeID
				when '1' then '2014-05-01 00:00:00.000'
				when '2' then '2015-05-01 00:00:00.000'
				when '3' then '2016-05-01 00:00:00.000'
				when '4' then '2017-05-01 00:00:00.000'
				when '5' then '2018-05-01 00:00:00.000'
				when '6' then '2019-05-01 00:00:00.000'
				when '7' then '2016-05-01 00:00:00.000'
				when '8' then '2017-05-01 00:00:00.000'
				when '9' then '2018-05-01 00:00:00.000'
				else HireDate
				end
where EmployeeID IN('1','2','3','4','5','6','7','8','9');

2./*Delete records from the Products table where ReorderLevel values is equal to 30.*/
ALTER TABLE [dbo].[Order Details]
drop constraint FK_Order_Details_Products

delete from dbo.Products
where ReorderLevel = '30'

3./*Get the list of data about employees: First Name, Last Name, Title, HireDate who was hired this year.*/
select FirstName, LastName, Title, HireDate
from dbo.Employees
where HireDate between '2018-01-01 00:00:00.000' and '2018-12-31 00:00:00.000'

4./*Get the list of titles and corresponding employees, who are working in each department (the list of columns in the result set from the Employee table is optional).*/
select Title, LastName, FirstName
from dbo.Employees
order by Title desc
5./*Get the list of suppliers, which are located in USA and have a specified region.*/
select *
from dbo.Suppliers
where Country = 'USA' and Region <> 'NULL'

6./*Get the amount of products that were delivered by each supplier (company), which have a discount from the Unit Price more than 10%. 
  Where record are represented from the biggest to lowest discount.*/
select count (dbo.Products.ProductName) as Quantity, dbo.Suppliers.CompanyName
from dbo.[Order Details] 
join dbo.Products on dbo.[Order Details].ProductID = dbo.Products.ProductID
join dbo.Suppliers on dbo.Suppliers.SupplierID = dbo.Products.SupplierID
where dbo.[Order Details].Discount > 0.1
group by dbo.Suppliers.CompanyName
order by Quantity

7./*Get the top five product categories with the list of the most buyable products in European countries.*/
select  top 5 Quantity,  Products.ProductName, Suppliers.Country
From Products 
join Suppliers on Products.SupplierID = Suppliers.SupplierID
join [Order Details] on Products.ProductID = [Order Details].ProductID
where Suppliers.Country IN ('France', 'Italy','Sweden', 'Spain', 'Germany', 'UK')
order by Quantity desc

8./*Get the First Name, Last Name and Title of Managers and their subordinates.*/
select LastName, FirstName, Title, ReportsTo
from dbo.Employees
where Title like '%Manager%' or ReportsTo = (select EmployeeID 
											from Employees 
											where Title like '%Manager%')
											
select LastName, FirstName, Title, ReportsTo
from dbo.Employees
where Title like '%Manager%' or ReportsTo = '5' 

















