with q1 as(
SELECT 
     
    pvt.[Territory]
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

st.Name [Territory]
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

Territory
,sum(TotalSales) [TotalSales]

from
(
select 

st.Name [Territory]
,sod.UnitPrice * sod.OrderQty [TotalSales]

from Sales.SalesPerson sp
join Person.Person p on p.BusinessEntityID = sp.BusinessEntityID
join Sales.SalesTerritory st on st.TerritoryID = sp.TerritoryID
join Sales.SalesOrderHeader soh on soh.SalesPersonID = sp.BusinessEntityID
join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
)a
group by Territory
)
select 
RANK() OVER (ORDER BY TotalSales DESC) [Rank]
,q2.Territory
,q1.*
,q2.TotalSales
from q1
join q2 on q1.Territory = q2.Territory

