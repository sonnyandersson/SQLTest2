SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 CREATE FUNCTION dbo.negFloatToNull(@i float)
 RETURNS float
 AS
 BEGIN
     DECLARE @ret float = null;
   if @i >= 0
     set @ret = @i

     RETURN @ret;
 END;
GO
