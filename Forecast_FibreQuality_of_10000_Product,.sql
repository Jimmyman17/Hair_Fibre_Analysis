WITH ProductFiberQuantities AS (
    SELECT
        P.[Order ID],
        P.[Final Product Name],
        R.[ReXI Fiber Required To Make Final Product],
        TRY_CAST(R.[Quantity of ReXI Fiber Bundles Required To Make Final Product] AS FLOAT) AS Individual_FibreQuantity
    FROM
        [Fibre].[dbo].[Product_Sold] AS P
    JOIN
        [Fibre].[dbo].[ReXI_Bundles_Required] AS R
    ON
        P.[Final Product Name] = R.[Final Product]
),
FinalProductAnalysis AS (
    SELECT
        pfq.[Order ID],
        pfq.[Final Product Name],
        pfq.[ReXI Fiber Required To Make Final Product],
        pfq.Individual_FibreQuantity,

        SUM(pfq.Individual_FibreQuantity) OVER() AS Total_FibreQuantity,

        
        -- Fix percentage calculation
        CAST(
            (pfq.Individual_FibreQuantity * 100.0) / 
            SUM(pfq.Individual_FibreQuantity) OVER ()
            AS DECIMAL(5, 2)
        ) AS PercentageOfTotal,

        -- Forecast based on product’s share of total
        CAST (
            (
                (
                    CAST(
                        (pfq.Individual_FibreQuantity * 100.0) /
                        SUM(pfq.Individual_FibreQuantity) OVER ()
                        AS DECIMAL(5, 2)
                    )
                ) / 100.0
            ) * 10000 AS INT
        ) AS Forecast_Units_Per_Product_of_10000
    FROM
        ProductFiberQuantities AS pfq
)
SELECT
    [Order ID],
    [Final Product Name],
    [ReXI Fiber Required To Make Final Product],
    Individual_FibreQuantity,
    Total_FibreQuantity,
    PercentageOfTotal,
    Forecast_Units_Per_Product_of_10000,
    (Forecast_Units_Per_Product_of_10000 * Individual_FibreQuantity) AS Individual_Forecast_FibreQuality_of_10000_Product,
    SUM(Forecast_Units_Per_Product_of_10000 * Individual_FibreQuantity) OVER() AS Total_Forecast_Fibre_For_All_Products
FROM
    FinalProductAnalysis;
