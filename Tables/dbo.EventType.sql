SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventType] (
		[idEventType]     [nchar](4) COLLATE Latin1_General_CI_AS NOT NULL,
		[UOM]             [nchar](3) COLLATE Latin1_General_CI_AS NOT NULL,
		[name]            [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[description]     [nvarchar](255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventType]
	ADD
	CONSTRAINT [PK_EventType]
	PRIMARY KEY
	CLUSTERED
	([idEventType])
	ON [PRIMARY]
GO
