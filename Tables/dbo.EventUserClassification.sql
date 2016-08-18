SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventUserClassification] (
		[idEvent]                [int] NOT NULL,
		[Comment]                [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[idEventReason]          [nchar](4) COLLATE Latin1_General_CI_AS NULL,
		[idEventSubReason]       [nchar](7) COLLATE Latin1_General_CI_AS NULL,
		[idEventLocalReason]     [nchar](7) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventUserClassification]
	ADD
	CONSTRAINT [PK_Event]
	PRIMARY KEY
	CLUSTERED
	([idEvent])
	ON [PRIMARY]
GO
