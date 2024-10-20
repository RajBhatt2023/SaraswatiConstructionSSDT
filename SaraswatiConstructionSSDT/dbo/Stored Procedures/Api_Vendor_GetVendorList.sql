CREATE PROCEDURE [dbo].[Api_Vendor_GetVendorList]
-- Api_Vendor_GetVendorList
@UserID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Retrieve all vendor details
    SELECT '0' AS ResultCode,
        'Vendor list retrieved successfully.' AS ResultDescription,
        VendorID,
        VendorName,
        Email,
        PhoneNumberCountryCode,
        PhoneNumber,
        Address,
        CreatedBy,
        CreatedDate,
        UpdatedBy,
        UpdatedDate
    FROM 
        [dbo].[VendorDetails]
		Where IsActive = 1
    ORDER BY 
        VendorName ASC;
END;