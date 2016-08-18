SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventIp21Copy] (
		[idEventDef]          [nchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
		[idIP21Event]         [nchar](27) COLLATE Latin1_General_CI_AS NOT NULL,
		[idEvent]             [bigint] IDENTITY(1, 1) NOT NULL,
		[timeStart]           [datetime] NOT NULL,
		[timeEnd]             [datetime] NULL,
		[totMeasured]         [real] NULL,
		[limitUsedToTrig]     [real] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventIp21Copy]
	ADD
	CONSTRAINT [PK_EventIp21Copy]
	PRIMARY KEY
	CLUSTERED
	([idEvent])
	ON [PRIMARY]
GO
