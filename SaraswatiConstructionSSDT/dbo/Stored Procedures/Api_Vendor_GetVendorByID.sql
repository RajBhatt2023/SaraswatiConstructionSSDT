CREATE PROCEDURE [dbo].[Api_Vendor_GetVendorByID]  
-- Api_Vendor_GetVendorByID 1 
(
@VendorID BIGINT  
)
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Retrieve all vendor details  
    SELECT '0' AS ResultCode,  
        'Vendor detail retrieved successfully.' AS ResultDescription,  
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
  AND VendorID = @VendorID  
    ORDER BY   
        VendorName ASC;  
END;