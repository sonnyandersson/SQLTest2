SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spGetEvents2 (@idFactory int = null,
                                  @start Datetime = null,
                                  @end Datetime = null)
AS
BEGIN
  SET NOCOUNT ON;

  if (@start is null and @end is null and @idFactory is not null)
    select
      e.idEvent, es.idShiftData, e.idEventType, es.idEventPerShift,
      Convert(VARCHAR(255), e.timeStart, 127)+'Z' timeStartISO,
      e.timeStart,
      (case when e.timeEnd is null then '' else Convert(VARCHAR(255), e.timeEnd, 127)+'Z' end) timeEndISO,
      e.timeEnd,
      e.totMeasured eventTotMeasured,
      e.sumClassified eventTotClassified,
      e.diff eventDiff,
      e.idEventReason, eventReasonName,
      e.idEventLocalReason, eventLocalReasonName,
      es.shiftTotMeasured,
      es.sumClassified shiftTotClassified,
      es.diff shiftDiff
    from vwEventTotals e, vwEventShiftTotals es
    where e.idFactory = @idFactory
      and e.idEvent = es.idEvent

    else  if (@start is not null and @end is not null and @idFactory is not null)
      select
        e.idEvent, es.idShiftData, e.idEventType, es.idEventPerShift,
        Convert(VARCHAR(255), e.timeStart, 127)+'Z' timeStartISO,
        e.timeStart,
        (case when e.timeEnd is null then '' else Convert(VARCHAR(255), e.timeEnd, 127)+'Z' end) timeEndISO,
        e.timeEnd,
        e.totMeasured eventTotMeasured,
        e.sumClassified eventTotClassified,
        e.diff eventDiff,
        e.idEventReason, eventReasonName,
        e.idEventLocalReason, eventLocalReasonName,
        es.shiftTotMeasured,
        es.sumClassified shiftTotClassified,
        es.diff shiftDiff
      from vwEventTotals e, vwEventShiftTotals es
      where e.idFactory = @idFactory
        and e.idEvent = es.idEvent
        and (
                  (e.timeStart <= @start and  e.TimeEnd_NowUtcIfNull >= @start)  --1
                  or (e.timeStart <= @end and e.TimeEnd_NowUtcIfNull >= @end)  --2
                  or (e.timeStart >= @start and e.TimeEnd_NowUtcIfNull <=@end)  --3
                  or (e.timeStart <= @start and e.TimeEnd_NowUtcIfNull >=@end)  --4
        )
      else
        raiserror ('Incorrect parameters, factory is mandatory and start/end must both either be set or both null',
          11, 1);

END
GO
