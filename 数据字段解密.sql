USE [YGDB_C]
GO

/****** Object:  UserDefinedFunction [dbo].[DecryptByPassPhrasePwd]    Script Date: 2018/10/29 11:15:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  FUNCTION [dbo].[DecryptByPassPhrasePwd](@password varbinary(max),@Decrypt_KEY nvarchar(50))
RETURNS nvarchar(max)
AS  
BEGIN 
    declare @pwd nvarchar(max)
 SELECT @pwd =CAST( DecryptByPassPhrase(@Decrypt_KEY,@password)  as nvarchar(max))
    return @pwd
END
GO


