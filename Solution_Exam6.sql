SELECT 
ProductID
,Name
,ProductNumber
,MakeFlag
,FinishedGoodsFlag
,Color
,SafetyStockLevel
,ReorderPoint
,StandardCost
,ListPrice
,Size
,SizeUnitMeasureCode
,WeightUnitMeasureCode
,Weight
,DaysToManufacture
,ProductLine
,Class
,Style
,ProductSubcategoryID
,ProductModelID
,SellStartDate
,SellEndDate
,DiscontinuedDate
,rowguid
,ModifiedDate
, round(ROW_NUMBER() OVER(ORDER BY Name ASC)/2,0,1) AS PageIndex
FROM Production.Product
ORDER BY PageIndex










