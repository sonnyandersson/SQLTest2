SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE sp_max_shift_closed_at
AS
BEGIN
	SET NOCOUNT ON;

	declare @tmpTable Table (idShiftData int, idShiftDefinition int, shiftClosedAt Datetime, shiftstartedAt Datetime);

	 insert into @tmpTable (idShiftData, idShiftDefinition, shiftClosedAt, shiftstartedAt)
		select shiftData.idShiftData, shiftData.idShiftDefinition, shiftData.shiftClosedAt, shiftDataPrev.shiftClosedAt as shiftstartedAt
		from TESTDATA_shiftData shiftData, TESTDATA_shiftData shiftDataPrev
		where shiftData.shiftClosedAt > shiftDataPrev.shiftClosedAt
		order by idShiftData

	select idShiftData, shiftClosedAt, max(shiftStartedAt) as shiftStartedAt from @tmpTable group by idShiftData, shiftClosedAt;
	END;
GO
