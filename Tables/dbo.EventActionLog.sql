SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventActionLog] (
		[timestamp]     [datetime] NOT NULL,
		[text]          [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[logLevel]      [nvarchar](10) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
