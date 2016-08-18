SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventDef] (
		[idEventDef]                      [nchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
		[idEventType]                     [nchar](4) COLLATE Latin1_General_CI_AS NOT NULL,
		[idFactory]                       [int] NOT NULL,
		[name]                            [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[Ip21DefName]                     [nchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[Ip21Tag]                         [nchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[idDataServer]                    [nchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
		[description]                     [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[Enabled]                         [bit] NULL,
		[maxAllowedTimeNotReported]       [int] NULL,
		[maxAllowedAmountNotReported]     [real] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventDef]
	ADD
	CONSTRAINT [PK_EventDef]
	PRIMARY KEY
	CLUSTERED
	([idEventDef])
	ON [PRIMARY]
GO
