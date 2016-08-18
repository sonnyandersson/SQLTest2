SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spPrevShiftEnd (@idFactory int,
                                     @idShiftData int)
AS
BEGIN

  if (@idFactory is null or @idShiftData is null)
    raiserror ('The idFactory and idShiftData parameters are mandatory', 11, 1);

  declare @hoursBack int = 48;
  declare @plannedShiftEnd DateTime;
  declare @firstShiftEnd DateTime;

  declare @tmpShiftData Table (idShiftData int,
                               plannedShiftEnd Datetime,
                               shiftClosedAt Datetime);

  declare @tmpShiftDataCombined Table (idShiftData int,
  							 prevShiftId int,
                               plannedShiftEnd Datetime,
  							 prevPlannedShiftEnd Datetime,
                               shiftClosedAt Datetime,
  							 prevShiftClosedAt Datetime);

  set @plannedShiftEnd = (select plannedShiftEnd from shiftData where idShiftData = @idShiftData);
  set @firstShiftEnd = dateadd(hh, -1 * @hoursBack, @plannedShiftEnd);

  insert into @tmpShiftData(idShiftData, plannedShiftEnd, shiftClosedAt)
  	select idShiftData, plannedShiftEnd, shiftClosedAt from shiftData
  		where idFactory = @idFactory
  		and plannedShiftEnd >= @firstShiftEnd
  		and plannedShiftEnd <= @plannedShiftEnd

  insert into @tmpShiftDataCombined(idShiftData, prevShiftId, shiftClosedAt, prevShiftClosedAt, plannedShiftEnd, prevPlannedShiftEnd)
  	select sd.idShiftData idShiftData,
  	       sdp.idShiftData prevShiftId,
  		   sd.shiftClosedAt shiftClosedAt,
  		   sdp.shiftClosedAt prevShiftClosedAt,
  		   sd.plannedShiftEnd plannedShiftEnd,
  		   sdp.plannedShiftEnd prevPlannedShiftEnd
  	from @tmpShiftData sd,  @tmpShiftData sdp
  	where sdp.plannedShiftEnd < sd.plannedShiftEnd

  select idShiftData,
         dbo.LocalDateToUTC(max(prevShiftClosedAt)) timePrevShiftClosedAt,
         dbo.LocalDateToUTC(plannedShiftEnd) timePlannedShiftEnd,
         dbo.LocalDateToUTC(shiftClosedAt) timeShiftClosedAt
  from @tmpShiftDataCombined
  where idShiftData = @idShiftData
  group by idShiftData, shiftClosedAt, plannedShiftEnd
  END;
GO
