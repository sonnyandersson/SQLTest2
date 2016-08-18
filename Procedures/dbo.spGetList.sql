SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spGetList (@listName varchar(20) = null)
AS
BEGIN
  SET NOCOUNT ON;

  if (@listName is null)
  raiserror ('listName parameters is mandatory', 11, 1);

  -- EventReason
  else if (@listName = 'EventReason')
  select idEventReason, idEventType, name, description
  from EventReason where (disabledForSelection = 0 or disabledForSelection is null);

  -- EventSubReason
  else if (@listName = 'EventSubReason')
  select idEventSubReason , idEventReason, name, description
  from EventSubReason where (disabledForSelection = 0 or disabledForSelection is null);

  -- EventLocalReason
  else if (@listName = 'EventLocalReason')
  select idEventLocalReason, plant, name, description
  from EventLocalReason where (disabledForSelection = 0 or disabledForSelection is null);

  -- Equipment
  else if (@listName = 'Equipment')
  select Equipment, [Sort field], Description, Location, [ROOT FL], FL, [FL Description], Plant, DELETED, SAP_STATUS
  from Equipment;

  -- incorrect input parameters
  else
  raiserror ('Unknown list', 11, 1);

END
GO
