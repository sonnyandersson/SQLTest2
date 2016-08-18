SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventReason] (
		[idEventReason]            [nchar](4) COLLATE Latin1_General_CI_AS NOT NULL,
		[idEventType]              [nchar](4) COLLATE Latin1_General_CI_AS NOT NULL,
		[name]                     [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[description]              [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[disabledForSelection]     [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventReason]
	ADD
	CONSTRAINT [PK_EventReason_1]
	PRIMARY KEY
	CLUSTERED
	([idEventReason])
	ON [PRIMARY]
GO
