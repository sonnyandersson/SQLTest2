SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[EventDetailsTextConcat]
(
  -- parameters
  @idEvent bigint
)
RETURNS nvarchar(150)

AS
BEGIN
  -- Declare the return variable here
  DECLARE @ResultVar1 nvarchar(250);
  DECLARE @ResultVar2 nvarchar(250);
  DECLARE @ReasonCount int;
  DECLARE @Result nvarchar(250);


  SELECT TOP 1 @ResultVar1 = r.name
  FROM dbo.EventPerShift s,dbo.EventDetail d, dbo.EventReason r
  where s.idEvent= @idEvent
    and s.idEventPerShift = d.idEventPerShift
        and d.idEventReason = r.idEventReason
  order by d.idEventDetail;


  SELECT TOP 1 @ResultVar2 = r.name
  FROM dbo.EventPerShift s,dbo.EventDetail d, dbo.EventReason r
  where s.idEvent= @idEvent
    and s.idEventPerShift = d.idEventPerShift
        and d.idEventReason = r.idEventReason
        and @ResultVar2 <> r.name
  order by d.idEventDetail;


  SELECT  @ReasonCount = count(*)
  From (Select Distinct d.originIdEventDetail
      FROM dbo.EventPerShift s,dbo.EventDetail d, dbo.EventReason r
      where s.idEvent= @idEvent
        and s.idEventPerShift = d.idEventPerShift
        and d.idEventReason = r.idEventReason
    ) Dummy;


  --originIdEventDetail

  -- Return the result of the function
  IF (@ResultVar1 is null)
  Set @Result = '';
  Else
    Set @Result =  LEFT(@ResultVar1,250) ;
    if (@ResultVar2 is not null)
    Set @Result =  LEFT(@Result + ', ' + @ResultVar2,250) ;
    if (@ReasonCount>1)
      Set @Result = @Result + '(' + LTRIM(STR(@ReasonCount)) + ')';

  Return @Result

END
GO
