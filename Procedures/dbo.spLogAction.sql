SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE dbo.spLogAction (
   @text nvarchar(max) = null,
   @logLevel nvarchar(10) = null
 )
 AS
 BEGIN
   SET NOCOUNT ON;

   declare @now DateTime = getutcdate();

   declare @txt nvarchar(max);
   set @txt = 'Logging:' + (convert(nvarchar(max), @now, 126)) + ',' +  @text + ',' + @logLevel;
   print @txt;

   if (@text is null or @logLevel is null)
     raiserror ('Both text and log level parameters are mandatory', 11, 1);
   else
     begin
       insert into EventActionLog(timestamp, text, logLevel)
          values (@now, @text, @logLevel);
     end
 END
GO
