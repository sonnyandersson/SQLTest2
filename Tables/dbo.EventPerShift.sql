SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[EventPerShift] (
		[idEventPerShift]             [bigint] IDENTITY(1, 1) NOT NULL,
		[idEvent]                     [bigint] NOT NULL,
		[idShiftData]                 [bigint] NOT NULL,
		[responsibilityTimeStart]     [datetime] NOT NULL,
		[responsibilityTimeEnd]       [datetime] NULL,
		[totMeasured]                 [real] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventPerShift]
	ADD
	CONSTRAINT [PK_EventPerShift_1]
	PRIMARY KEY
	CLUSTERED
	([idEventPerShift])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'idEvent and idShiftData are unique together.

 idEventPerShift is a auto generated sequence that is used when referring to this table from EventDetails.', 'SCHEMA', N'dbo', 'TABLE', N'EventPerShift', 'COLUMN', N'idEventPerShift'
GO
