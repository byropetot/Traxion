with q1 as(
SELECT 
     pvt.[FullName]
    ,pvt.[Territory]
    ,pvt.[Jan]
    ,pvt.[Feb]
    ,pvt.[Mar] 
	,pvt.[Apr]
    ,pvt.[May]
    ,pvt.[Jun]
    ,pvt.[Jul]
    ,pvt.[Aug]
    ,pvt.[Sep]
    ,pvt.[Oct]
    ,pvt.[Nov]
    ,pvt.[Dec]
	
FROM (select 
concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) [FullName]
,st.Name [Territory]
,sod.UnitPrice * sod.OrderQty [TotalSales]
,CONVERT(varchar(3), soh.OrderDate, 100) [Month]
from Sales.SalesPerson sp
join Person.Person p on p.BusinessEntityID = sp.BusinessEntityID
join Sales.SalesTerritory st on st.TerritoryID = sp.TerritoryID
join Sales.SalesOrderHeader soh on soh.SalesPersonID = sp.BusinessEntityID
join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID

	 ) a
PIVOT 
(
    SUM([TotalSales])  
    FOR [Month] 
    IN (
	 [Jan]
     ,[Feb]
     ,[Mar]
     ,[Apr]
     ,[May]
     ,[Jun]
     ,[Jul]
     ,[Aug]
     ,[Sep]
     ,[Oct]
     ,[Nov]
     ,[Dec]
	
	) 
) AS pvt
), q2 as
(
Select 
FullName
,Territory
,sum(TotalSales) [TotalSales]

from
(
select 
concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) [FullName]
,st.Name [Territory]
,sod.UnitPrice * sod.OrderQty [TotalSales]
,CONVERT(varchar(3), soh.OrderDate, 100) [Month]
from Sales.SalesPerson sp
join Person.Person p on p.BusinessEntityID = sp.BusinessEntityID
join Sales.SalesTerritory st on st.TerritoryID = sp.TerritoryID
join Sales.SalesOrderHeader soh on soh.SalesPersonID = sp.BusinessEntityID
join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
)a
group by FullName,Territory
)


select 

q1.*
,q2.TotalSales
from q1
join q2 on q1.FullName = q2.FullName
order by 15 desc