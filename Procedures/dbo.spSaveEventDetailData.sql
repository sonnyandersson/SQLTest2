SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spSaveEventDetailData (
  @idEvent bigint = null,               -- Param.1
  @idEventDetail bigint = null,         -- Param.2
  @idEventPerShift bigint = null,       -- Param.3
  @idShiftData bigint = null,           -- Param.4
  @timeStart Datetime = null,           -- Param.5
  @timeEnd Datetime = null,             -- Param.6
  @classified real = null,              -- Param.7
  @idEventReason nchar(10) = null,      -- Param.8
  @idEventSubReason nchar(10) = null,   -- Param.9
  @idEventLocalReason nchar(10) = null, -- Param.10
  @idEquipment float = null,            -- Param.11
  @synergyNumber nchar(50) = null,      -- Param.12
  @comment nchar(1000) = null,          -- Param.13
  @originIdEventDetail bigint = null    -- Param.14
)
AS
BEGIN
  SET NOCOUNT ON;

  set @idEventDetail = dbo.negIntToNull(@idEventDetail);
  set @idEventPerShift = dbo.negIntToNull(@idEventPerShift);
  set @idEquipment = dbo.negFloatToNull(@idEquipment);
  set @originIdEventDetail = dbo.negIntToNull(@originIdEventDetail);

  -- idEventPerShift is not known when doing an insert
  if @idEventPerShift is null
     and @idShiftData is not null
     and @idEvent is not null
    set @idEventPerShift = (select idEventPerShift from EventPerShift
                            where idShiftData =  @idShiftData and idEvent = @idEvent)

  declare @txt nvarchar(max);
  set @txt =  'spSaveEventDetailData - '
            + 'idEvent:'             + isnull(cast(@idEvent as nvarchar(max)), '') + ', '
            + 'idEventDetail:'       + isnull(cast(@idEventDetail as nvarchar(max)), '') + ', '
            + 'idEventPerShift:'     + isnull(cast(@idEventPerShift as nvarchar(max)), '') + ', '
            + 'idShiftData:'         + isnull(cast(@idShiftData as nvarchar(max)), '') + ', '
            + 'timeStart:'           + isnull(convert(nvarchar(max), @timeStart, 126), '') + ', '
            + 'timeEnd:'             + isnull(convert(nvarchar(max), @timeEnd, 126), '') + ', '
            + 'classified:'          + isnull(cast(@classified as nvarchar(max)), '') + ', '
            + 'idEventReason:'       + isnull(@idEventReason, '') + ', '
            + 'idEventSubReason:'    + isnull(@idEventSubReason, '') + ', '
            + 'idEventLocalReason:'  + isnull(@idEventLocalReason, '') + ', '
            + 'idEquipment:'         + isnull(cast(@idEquipment as nvarchar(max)), '') + ', '
            + 'synergyNumber:'       + isnull(@synergyNumber, '') + ', '
            + 'comment:'             + isnull(@comment, '') + ', '
            + 'originIdEventDetail:' + isnull(cast(@originIdEventDetail as nvarchar(max)), '');

  exec spLogAction @txt, 'DEBUG';

  -- Perform insert
  if (@idEventDetail is null
      and @idEventPerShift is not null
      and @timeStart is not null
      and @idEventSubReason is not null
    /*  and @idEventLocalReason is not null */ )
  begin
    insert into EventDetail
      output inserted.idEventDetail
      values (@idEventPerShift,
                                    @timeStart,
                                    @timeEnd,
                                    @classified,
                                    @idEventReason,
                                    @idEventSubReason,
                                    @idEventLocalReason,
                                    @idEquipment,
                                    @synergyNumber,
                                    @comment,
                                    @originIdEventDetail);
  end
  -- Perform update
  else if (@idEventDetail is not null
      and @idEventPerShift is not null
      and @timeStart is not null
      and @idEventSubReason is not null
    /*  and @idEventLocalReason is not null */ )
    begin
      update EventDetail set idEventPerShift = @idEventPerShift,
                             timeStart = @timeStart,
                             timeEnd = @timeEnd,
                             classified = @classified,
                             idEventReason = @idEventReason,
                             idEventSubReason = @idEventSubReason,
                             idEventLocalReason= @idEventLocalReason,
                             idEquipment = @idEquipment,
                             synergyNumber = @synergyNumber,
                             comment = @comment,
                             originIdEventDetail= @originIdEventDetail
      where idEventDetail = @idEventDetail;
      select * from EventDetail where idEventDetail = @idEventDetail;
    end

  -- incorrect input parameters
  else
    raiserror ('Incorrect parameters', 11, 1);

END
GO
