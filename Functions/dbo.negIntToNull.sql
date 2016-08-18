SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 CREATE FUNCTION dbo.negIntToNull(@i int)
 RETURNS int
 AS
 BEGIN
     DECLARE @ret int = null;
   if @i >= 0
     set @ret = @i

     RETURN @ret;
 END;
GO
