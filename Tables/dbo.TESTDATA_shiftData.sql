SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TESTDATA_shiftData] (
		[idShiftData]           [int] NOT NULL,
		[idShiftDefinition]     [int] NOT NULL,
		[shiftClosedAt]         [datetime] NOT NULL
) ON [PRIMARY]
GO
