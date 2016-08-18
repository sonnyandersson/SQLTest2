SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventLocalReason] (
		[idEventLocalReason]       [nchar](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[plant]                    [int] NOT NULL,
		[name]                     [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[description]              [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[disabledForSelection]     [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventLocalReason]
	ADD
	CONSTRAINT [PK_LocalEventReason]
	PRIMARY KEY
	CLUSTERED
	([idEventLocalReason])
	ON [PRIMARY]
GO
