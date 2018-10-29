USE [YGDB_C]
GO

/****** Object:  UserDefinedFunction [dbo].[EncryptByPassPhrasePwd]    Script Date: 2018/10/29 11:16:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[EncryptByPassPhrasePwd](@password nvarchar(50),@Encrypt_KEY nvarchar(50))
RETURNS varbinary(max)
AS  
BEGIN 
    declare @pwd varbinary(max)
 SELECT @pwd = EncryptByPassPhrase(
 @Encrypt_KEY,            
 @password)
    return @pwd
END
GO


