with q1 as(
SELECT 
     pvt.[ProductName]
    ,pvt.[ProductCategory]
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
p.Name [ProductName]
,pc.Name [ProductCategory]
,sod.OrderQty [TotalQty]
,CONVERT(varchar(3), soh.OrderDate, 100) [Month]
from Production.Product p
join Production.ProductInventory pi on pi.ProductID = p.ProductID
join Production.ProductSubcategory psc on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc on pc.ProductCategoryID = psc.ProductCategoryID
join Sales.SalesOrderDetail sod on sod.ProductID = p.ProductID
join Sales.SalesOrderHeader soh on soh.SalesOrderID = sod.SalesOrderID


	 ) a
PIVOT 
(
    SUM([TotalQty])  
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
),q2 as (

select 
p.Name [ProductName]
,pc.Name [ProductCategory]
,SUM(sod.OrderQty) [TotalQty]

from Production.Product p
join Production.ProductInventory pi on pi.ProductID = p.ProductID
join Production.ProductSubcategory psc on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc on pc.ProductCategoryID = psc.ProductCategoryID
join Sales.SalesOrderDetail sod on sod.ProductID = p.ProductID
join Sales.SalesOrderHeader soh on soh.SalesOrderID = sod.SalesOrderID
group by p.Name,pc.Name

)


select 

q1.*
,q2.TotalQty
from q1
join q2 on q1.ProductName = q2.ProductName
order by 15 desc