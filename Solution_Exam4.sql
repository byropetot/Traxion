select distinct
CustomerName
,Territory

from
(
select
concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) [CustomerName]
,st.Name [Territory]
,row_number() over ( order by c.CustomerID)  [NoD]
,soh.OrderDate
from Sales.SalesPerson sp
join Person.Person p on p.BusinessEntityID = sp.BusinessEntityID
join Sales.SalesTerritory st on st.TerritoryID = sp.TerritoryID
join Sales.SalesOrderHeader soh on soh.SalesPersonID = sp.BusinessEntityID
join Sales.Customer c on c.CustomerID = soh.CustomerID
)a
where   NoD - 30 <= DATEDIFF(DAY, DATEADD(DAY, NoD - 30, OrderDate), OrderDate) 