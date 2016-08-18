SET ANSI_NULLS ON --
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE dbo.logAction (
   @text nvarchar(max) = null,
   @logLevel nvarchar(10) = null
 )
 AS
 BEGIN
   SET NOCOUNT ON;

   if (@text is null or @logLevel is null)
     raiserror ('Both text and log level parameters are mandatory', 11, 1);
   else
     begin
       declare @now DateTime = getutcdate();
       insert into EventActionLog
         output inserted.timestamp, inserted.text, inserted.logLevel
         values (@now, @text, @logLevel);
     end
 END
GO
