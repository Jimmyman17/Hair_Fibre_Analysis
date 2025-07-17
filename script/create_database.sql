USE master;
GO

-- Drop and recreate the 'Fibre' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Fibre')
BEGIN
    ALTER DATABASE Fibre SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Fibre;
END
GO

-- Create the 'Fibre' database
CREATE DATABASE Fibre;
GO

-- Switch to the newly created Fibre database for table creation
USE Fibre;
GO

-- Drop and recreate the 'Product_Sold' table
IF OBJECT_ID('Product_Sold', 'U') IS NOT NULL
    DROP TABLE Product_Sold;
GO

CREATE TABLE Product_Sold (
    [Order ID]                  NVARCHAR(50),  -- Changed from INT to NVARCHAR(50)
    [Final Product Name]        NVARCHAR(200)  -- Increased from NVARCHAR(50) to NVARCHAR(200)
);
GO

-- Drop and recreate the 'ReXI_Bundles_Required' table
IF OBJECT_ID('ReXI_Bundles_Required', 'U') IS NOT NULL
    DROP TABLE ReXI_Bundles_Required;
GO

CREATE TABLE ReXI_Bundles_Required(
    [Final Product]                                 NVARCHAR(200), -- Increased from NVARCHAR(50) to NVARCHAR(200)
    [ReXI Fiber Required To Make Final Product]     NVARCHAR(200), -- Increased from NVARCHAR(50) to NVARCHAR(200)
    [Quantity of ReXI Fiber Bundles Required To Make Final Product] NVARCHAR(200) -- Changed from INT to NVARCHAR(200)
);
GO
