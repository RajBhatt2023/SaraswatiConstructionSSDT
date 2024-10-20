CREATE PROCEDURE [dbo].[Api_Vendor_CreateOrUpdateVendorDetails]
    @VendorID                 BIGINT = NULL,  
    @VendorName               NVARCHAR(100),
    @Email                    NVARCHAR(255),
    @PhoneNumberCountryCode   NVARCHAR(5) = '91',  
    @PhoneNumber              NVARCHAR(20) = '',    
    @Address                  NVARCHAR(200) = '',  
    @IsActive                 BIT = 1,
    @CreatedBy                BIGINT= NULL     
AS
BEGIN
    SET NOCOUNT ON;

    -- If VendorID is NULL, 0, or not provided, perform an insert (create)
    IF @VendorID IS NULL OR @VendorID = 0
    BEGIN
        INSERT INTO [dbo].[VendorDetails] (
            VendorName,
            Email,
            PhoneNumberCountryCode,
            PhoneNumber,
            Address,
            IsActive,
            CreatedBy,
            CreatedDate
        )
        VALUES (
            @VendorName,
            @Email,
            @PhoneNumberCountryCode,
            @PhoneNumber,
            @Address,
            @IsActive,
            @CreatedBy,
            GETUTCDATE()
        );
        
       SELECT  '0' ResultCode,
			   'Vendor is created successfully.'  ResultDescription;
    END
    ELSE
    BEGIN
        -- Update the existing record if VendorID is provided
        UPDATE [dbo].[VendorDetails]
        SET 
            VendorName = @VendorName,
            Email = @Email,
            PhoneNumberCountryCode = @PhoneNumberCountryCode,
            PhoneNumber = @PhoneNumber,
            Address = @Address,
            IsActive = @IsActive,
            UpdatedBy = @CreatedBy,
            UpdatedDate = GETUTCDATE()
        WHERE VendorID = @VendorID;

         SELECT  '0' ResultCode,
			   'Vendor is Updated successfully.'  ResultDescription;
    END
END;