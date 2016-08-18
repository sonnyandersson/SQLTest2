SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE dbo.spPrintLastLog
 AS
 BEGIN
   SET NOCOUNT ON;

   declare @txt nvarchar(max) = (select convert(nvarchar(max), r.timestamp, 126) + ', ' + r.text
    from
    (select row_number() over(order by timestamp desc) rn, timestamp, text, logLevel from EVentActionLog) r
     where rn = 1);
   print @txt;
 END
GO
