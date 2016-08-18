SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventSubReason] (
		[idEventSubReason]         [nchar](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[idEventReason]            [nchar](4) COLLATE Latin1_General_CI_AS NOT NULL,
		[name]                     [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[description]              [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[disabledForSelection]     [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventSubReason]
	ADD
	CONSTRAINT [PK_EventReason]
	PRIMARY KEY
	CLUSTERED
	([idEventSubReason])
	ON [PRIMARY]
GO
