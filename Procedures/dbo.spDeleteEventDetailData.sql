SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spDeleteEventDetailData (
  @idEventDetail bigint = null
)
AS
BEGIN
  SET NOCOUNT ON;

  if @idEventDetail is null
    raiserror ('Incorrect parameters', 11, 1);

  declare @txt nvarchar(max);
  set @txt =  'spDeleteEventDetailData - '
            + 'idEventDetail:'       + isnull(cast(@idEventDetail as nvarchar(max)), '');

  exec spLogAction @txt, 'DEBUG';

  delete from EventDetail
    output deleted.*
  where idEventDetail = @idEventDetail

END
GO
