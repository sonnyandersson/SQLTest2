SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spGetEventDetails (@idEvent int = null)
AS
BEGIN
  SET NOCOUNT ON;

  if (@idEvent is null)
    raiserror ('Incorrect parameters, event is mandatory', 11, 1);
  else

    select idEventDetail, idEventPerShift, idEvent, sd.idShiftData, ShiftName,
               Convert(VARCHAR(255), timeStart, 127)+'Z' timeStartISO,
               timeStart,
               Convert(VARCHAR(255), timeEnd, 127)+'Z' timeEndISO,
               timeEnd,
               classified,
               idEventReason, eventReasonName,
               idEventSubReason, eventSubReasonName,
               idEventLocalReason, eventLocalReasonName,
               isNull(idEquipment, -1) idEquipment,
               isNull([Sort field], -1) SortField,
               synergyNumber,
               comment,
               originIdEventDetail
        from vwEventDetails ed, ShiftData sd, ShiftConfig sc
        where idEvent = @idEvent
          and ed.idShiftData = sd.idShiftData
          and sd.idShiftDefinition = sc.idShiftConfig
END
GO
