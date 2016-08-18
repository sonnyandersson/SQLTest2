SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION dbo.EventGetSelection  (@idShiftData int = null, @idFactory int = null,
                                  @start Datetime = null,  @end Datetime = null, @plantView int = 0)
RETURNS @EventsSelected TABLE
   (
  [idEvent] [bigint] NOT NULL
   )
AS
BEGIN
  if (@start  = '') set @start = NULL;
  if (@end  = '') set @end = NULL;
  if (@start  = '1900-01-01 00:00:00.000') set @start = NULL;
  if (@end  = '1900-01-01 00:00:00.000') set @end = NULL;
  if (@start  is not null) set @idShiftData = NULL; -- Do not select on idShiftData if dates are given
  if (@plantView  is null) set @plantView = 0;


  -- no dates - just idShiftData
    if (@idShiftData is not null) and (@idShiftData > 0)
    INSERT @EventsSelected
        SELECT idEvent  FROM vwEvent_SelectByIdShiftData e
        WHERE e.idShiftData = @idShiftData
    -- Just selection on factory
    else if (@start  is null or @end is null)
    INSERT @EventsSelected
         SELECT DISTINCT idEvent
         FROM vwEvent e WHERE e.idFactory = @idFactory
    -- Time selection
    else -- should test that idFactory isn't null
       INSERT @EventsSelected
      SELECT idEvent
      FROM vwEvent e
      WHERE
          --------------------------------------------------------------------
  -- Param.10 = 0  -> Logbook view
  --          = 1  -> Plant view
  --------------------------------------------------------------------
  (
    (
      (@plantView = 0)
      AND (e.idFactory = @idFactory )
      )
    OR (
      (@plantView = 1)
      AND -- Plant view
      --.((1=1) AND
      /****** Takes any logBook id (idFactory) and returns all loogboos at that plant  ******/
      /*  By Sonny Andersson */
      e.idFactory IN (
        SELECT Y.LogbookAtPlant
        FROM (
          SELECT [idFactory] AS MainLogbook
            ,[idSubFactory] AS LogbookAtPlant
          FROM [AssignedSubFactory]

          UNION

          SELECT DISTINCT [idFactory]
            ,[idFactory]
          FROM [AssignedSubFactory]
          ) AS Y
        WHERE Y.MainLogbook = (
            SELECT X.MainLogbook
            FROM (
              SELECT [idFactory] AS MainLogbook
                ,[idSubFactory] AS LogbookAtPlant
              FROM [AssignedSubFactory]

              UNION

              SELECT DISTINCT [idFactory]
                ,[idFactory]
              FROM [AssignedSubFactory]
              ) AS X
            WHERE X.LogbookAtPlant = @idFactory
            )
        )
      )
    )



        AND (
                  /*
                               SelStart                      SelEnd
                                  |                             |
                  1         -----event------
                  2                                     -----event------
                  3                       -----event------
                  4         -------event--------------------------------
                  */
                  (e.timeStart <= @start AND  TimeEnd_NowUtcIfNull >= @start)  --1
                  OR
                  (e.timeStart <= @end AND TimeEnd_NowUtcIfNull >= @end)  --2
                  OR
                  (e.timeStart >= @start AND TimeEnd_NowUtcIfNull <=@end)  --3
                  OR
                  (e.timeStart <= @start AND TimeEnd_NowUtcIfNull >=@end)  --4

        )
  RETURN
END
GO
