SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spShiftActualStartAndEnd (@idFactory int,
                                               @startDate Datetime,
                                               @endDate Datetime,
                                               @idShiftData int = null)
AS
BEGIN
  SET NOCOUNT ON;

  set @idShiftData = dbo.negIntToNull(@idShiftData);

  if (@idFactory is null or @startDate is null or @endDate is null)
    raiserror ('The idFactory, startDate and endDate parameters are mandatory', 11, 1);

  declare @tmpShiftData Table (idFactory int,
                               idShiftData int,
                               idShiftDefinition int,
                               shiftClosedAt Datetime);

  declare @tmpShiftDataCombined Table (idFactory int,
                                       idShiftData int,
                                       idShiftDefinition int,
                                       shiftClosedAt Datetime,
                                       shiftStartedAt Datetime);

  declare @tmpShiftDataResult Table (idFactory int,
                                     idShiftData int,
                                     idShiftDefinition int,
                                     shiftClosedAt Datetime,
                                     shiftStartedAt Datetime);

  insert into @tmpShiftData (idFactory, idShiftData, idShiftDefinition, shiftClosedAt)
    select idFactory, idShiftData, idShiftDefinition, shiftClosedAt
    from shiftData
    where idFactory = @idFactory
    and shiftClosedAt >= @startDate
    and shiftClosedAt <= @endDate
    and shiftClosed = 1
    order by idShiftData

  insert into @tmpShiftDataCombined (idFactory, idShiftData, idShiftDefinition, shiftClosedAt, shiftStartedAt)
    select sd.idFactory, sd.idShiftData, sd.idShiftDefinition, sd.shiftClosedAt, sdp.shiftClosedAt as shiftStartedAt
    from @tmpShiftData sd, @tmpShiftData sdp
    where sd.shiftClosedAt > sdp.shiftClosedAt
    order by sd.idShiftData

  insert into @tmpShiftDataResult (idFactory, idShiftData, idShiftDefinition, shiftClosedAt, shiftStartedAt)
    select idFactory, idShiftData, idShiftDefinition,
    max(shiftStartedAt) as shiftStartedAt, shiftClosedAt
    from @tmpShiftDataCombined
    group by idFactory, idShiftData, idShiftDefinition, shiftClosedAt
    order by idFactory, idShiftData

  if (@idShiftData is null)
    select * from @tmpShiftDataResult res, shiftData sd
    where res.idShiftData = sd.idShiftData
  else
    select * from @tmpShiftDataResult res, shiftData sd
      where res.idShiftData = sd.idShiftData
      and res.idShiftData = @idShiftData
  END;
GO
