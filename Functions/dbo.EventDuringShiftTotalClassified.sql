SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[EventDuringShiftTotalClassified]
(
  -- parameters
  @idEvent bigint,
  @idShiftData bigint
)
RETURNS real
AS
BEGIN
  -- Declare the return variable here
  DECLARE @ResultVar real;

  SELECT TOP 1 @ResultVar = Sum(d.classified)
  FROM dbo.EventPerShift s,dbo.EventDetail d     --[SAPMII_ESLB-D]
  where s.idEvent= @idEvent and s.idEventPerShift = d.idEventPerShift
        and s.idShiftData = @idShiftData;

  -- Return the result of the function
  RETURN @ResultVar

END
GO
