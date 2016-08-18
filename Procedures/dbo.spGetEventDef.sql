SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spGetEventDef (@idFactory int = null,
                                    @idEventType nchar(4) = null)
AS
BEGIN
  SET NOCOUNT ON;

  if (@idFactory is null or @idEventType is null)
    raiserror ('idFactory and idEventType parameters are mandatory', 11, 1);

  select idEventDef,
         name,
         Ip21DefName,
         Ip21Tag,
         idDataServer,
         description,
         maxAllowedTimeNotReported,
         maxAllowedAmountNotReported
  from EventDef
  where idFactory=@idFactory and idEventType=@idEventType and Enabled=1

END
GO
