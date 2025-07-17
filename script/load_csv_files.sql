PRINT '>> Truncating Table: Product_Sold';
TRUNCATE TABLE Product_Sold;

PRINT '>> Inserting Data Into: Product_Sold';
BULK INSERT Product_Sold
FROM 'C:\Users\user\Downloads\Case Study_ Inventory Forecast - Products Sold.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    -- Consider adding ROWTERMINATOR if not using default Windows line endings
    -- , ROWTERMINATOR = '0x0a' -- for Unix/Linux style '\n'
    -- , ROWTERMINATOR = '0x0d0a' -- for Windows style '\r\n'
    -- Consider adding CODEPAGE for UTF-8 files
    -- , CODEPAGE = '65001' -- for UTF-8 encoded files
);

PRINT '>> Truncating Table: ReXI_Bundles_Required';
TRUNCATE TABLE ReXI_Bundles_Required;

PRINT '>> Inserting Data Into: ReXI_Bundles_Required';
BULK INSERT ReXI_Bundles_Required
FROM 'C:\Users\user\Downloads\Case Study_ Inventory Forecast - ReXI Bundles Required.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    -- Consider adding ROWTERMINATOR if not using default Windows line endings
    -- , ROWTERMINATOR = '0x0a'
    -- Consider adding CODEPAGE for UTF-8 files
    -- , CODEPAGE = '65001'
);
