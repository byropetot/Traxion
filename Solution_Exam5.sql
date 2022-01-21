


select
SalesTerritory
,sum(TotalSales) [TotalSales]
from(
select 
st.[Name] AS [SalesTerritory]
,sum(sod.UnitPrice * sod.OrderQty) [TotalSales]
,row_number() over ( order by st.TerritoryID) [NoD]
,soh.OrderDate
from Sales.SalesPerson sp
        join Sales.SalesOrderHeader soh on sp.BusinessEntityID = soh.SalesPersonID
        join [Sales].[SalesTerritory] st on sp.TerritoryID = st.TerritoryID 
        join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
		
group by st.Name,soh.OrderDate,st.TerritoryID
)a

where   NoD - 7 <= DATEDIFF(DAY, DATEADD(DAY, NoD - 7, OrderDate), OrderDate) 

group by SalesTerritory