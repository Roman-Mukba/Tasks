1.
select ShipperID, CompanyName, Phone
into dbo.NewShippers
from dbo.Shippers

2.
select ProductName, UnitsInStock
from dbo.Products
where UnitsInStock between '25' and '50'
order by UnitsInStock

3.
SELECT Suppliers.Country, Sum([Order Details].Quantity) AS QuantityOrdered
    FROM Suppliers INNER JOIN [Order Details] ON Suppliers.SupplierID = [Order Details].ProductID
	where Country like '%Germany%'
	group by Country
Union
SELECT Suppliers.Country, Sum([Order Details].Quantity)*0.7 AS QuantityOrdered
    FROM Suppliers INNER JOIN [Order Details] ON Suppliers.SupplierID = [Order Details].ProductID
	where Country like '%Sweden%'
	group by Country

4.
select Country
from Customers
except
select Country
from Employees

5.
select PostalCode
from Employees
intersect
select PostalCode
from Suppliers

6.
select max (Region) as TopRegion
from dbo.Employees
where Title like '%Sales%'

7.
select ProductName, UnitPrice, Discontinued
from dbo.Products
where UnitPrice <50 and (Discontinued ='1' or Discontinued ='0')
order by Discontinued

8.
create table NewProducts (	ProductID int not null Primary Key,
							ProductName nvarchar(40) not null, 
							SupplierID int null, 
							CategoryID int null,
							QuantityPerUnit nvarchar(20) null, 
							UnitPrice money null, 
							UnitsInStock smallint null, 
							UnitsOnOrder smallint null, 
							ReorderLevel smallint null, 
							Discontinued bit not null,
							Foreign Key (SupplierID) references Suppliers(SupplierID),
							Foreign Key (CategoryID) references Categories(CategoryID) );
														
insert into NewProducts (ProductID, 
						ProductName, 
						SupplierID, 
						CategoryID, 
						QuantityPerUnit, 
						UnitPrice, 
						UnitsInStock, 
						UnitsOnOrder, 
						ReorderLevel, 
						Discontinued)
select					ProductID, 
						ProductName, 
						SupplierID, 
						CategoryID, 
						QuantityPerUnit, 
						UnitPrice, 
						UnitsInStock, 
						UnitsOnOrder, 
						ReorderLevel, 
						Discontinued
from Products
where Discontinued = '1'

select ProductName, Discontinued
from Products
union
select ProductName, Discontinued
from NewProducts
order by Discontinued desc