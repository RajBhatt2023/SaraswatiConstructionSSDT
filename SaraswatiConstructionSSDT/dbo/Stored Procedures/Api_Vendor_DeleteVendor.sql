CREATE PROCEDURE [dbo].[Api_Vendor_DeleteVendor]
    @VendorID BIGINT,        
    @UpdatedBy BIGINT=NULL        
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the VendorID exists and is already active
    IF EXISTS (SELECT 1 FROM [dbo].[VendorDetails] WHERE VendorID = @VendorID AND IsActive = 1)
    BEGIN
        -- Perform the soft delete by setting IsActive to 0
        DELETE [dbo].[VendorDetails]
        WHERE VendorID = @VendorID;

        -- Return a success message
        SELECT  
            '0' AS ResultCode,
            'Vendor deleted successfully.' AS ResultDescription;
    END
    ELSE
    BEGIN
        -- VendorID does not exist or is already inactive, return an error message
        SELECT  
            '1' AS ResultCode,
            'Vendor not found or already inactive.' AS ResultDescription;
    END
END;