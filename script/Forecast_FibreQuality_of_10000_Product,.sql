-- =============================================
-- CTE: ProductFiberQuantities
-- Purpose: Joins product sales with fiber requirements and converts quantity to FLOAT
-- =============================================
WITH ProductFiberQuantities AS (
    SELECT
        P.[Order ID],  -- Unique identifier for each sales transaction
        P.[Final Product Name],  -- Name of the final product sold
        R.[ReXI Fiber Required To Make Final Product],  -- Type of ReXI fiber required
        TRY_CAST(R.[Quantity of ReXI Fiber Bundles Required To Make Final Product] AS FLOAT) AS Individual_FibreQuantity
        -- Safely converts the fiber bundle quantity to a numeric format (FLOAT)
    FROM
        [Fibre].[dbo].[Product_Sold] AS P  -- Sales data
    JOIN
        [Fibre].[dbo].[ReXI_Bundles_Required] AS R  -- Fiber requirement data
    ON
        P.[Final Product Name] = R.[Final Product]  -- Match products between sales and fiber requirement tables
),

-- =============================================
-- CTE: FinalProductAnalysis
-- Purpose: Performs analytical calculations for each order and product
-- =============================================
FinalProductAnalysis AS (
    SELECT
        pfq.[Order ID],  -- Order identifier
        pfq.[Final Product Name],  -- Product name
        pfq.[ReXI Fiber Required To Make Final Product],  -- Fiber type
        pfq.Individual_FibreQuantity,  -- Fiber bundles used per unit

        SUM(pfq.Individual_FibreQuantity) OVER() AS Total_FibreQuantity,
        -- Total fiber quantity used across all orders (global sum)

        CAST(
            (pfq.Individual_FibreQuantity * 100.0) / 
            SUM(pfq.Individual_FibreQuantity) OVER ()
            AS DECIMAL(5, 2)
        ) AS PercentageOfTotal,
        -- Percentage contribution of the current record's fiber quantity to the total

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
        -- Forecasted number of units for this product, scaled to a target of 10,000 total units
    FROM
        ProductFiberQuantities AS pfq
)

-- =============================================
-- Final SELECT: Combines all computed metrics
-- =============================================
SELECT
    [Order ID],  -- Order identifier
    [Final Product Name],  -- Product name
    [ReXI Fiber Required To Make Final Product],  -- Type of ReXI fiber
    Individual_FibreQuantity,  -- Fiber used per unit of product
    Total_FibreQuantity,  -- Total fiber quantity across all orders
    PercentageOfTotal,  -- Current row's percentage of total fiber used
    Forecast_Units_Per_Product_of_10000,  -- Scaled forecasted units for the product
    (Forecast_Units_Per_Product_of_10000 * Individual_FibreQuantity) AS Individual_Forecast_FibreQuality_of_10000_Product,
    -- Projected fiber quantity for this order if 10,000 units are sold

    SUM(Forecast_Units_Per_Product_of_10000 * Individual_FibreQuantity) OVER() AS Total_Forecast_Fibre_For_All_Products
    -- Grand total of forecasted fiber quantity across all products (repeats for each row)
FROM
    FinalProductAnalysis;

