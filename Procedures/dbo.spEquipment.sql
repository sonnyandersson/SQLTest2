SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spEquipment (@sortField varchar(10) = null)
AS
BEGIN
  SET NOCOUNT ON;

  -- get all equipments
  if (@sortField is null)
    select Equipment, [Sort field], Description, Location, [ROOT FL], FL, [FL Description], Plant ,DELETED ,SAP_STATUS
    from Equipment
    where deleted=0

  -- get equipments starting with sortField
  else
    select Equipment, [Sort field], Description, Location, [ROOT FL], FL, [FL Description], Plant ,DELETED ,SAP_STATUS
    from Equipment
    where deleted=0 and [Sort field] like @sortField + '%'
END
GO
