SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Equipment] (
		[Equipment]          [float] NULL,
		[Sort field]         [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[Description]        [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[Location]           [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[ROOT FL]            [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[FL]                 [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[FL Description]     [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[Plant]              [float] NULL,
		[DELETED]            [int] NOT NULL,
		[SAP_STATUS]         [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Equipment]
	ADD
	CONSTRAINT [DF_Equipment_SAP_STATUS]
	DEFAULT ('') FOR [SAP_STATUS]
GO
ALTER TABLE [dbo].[Equipment]
	ADD
	CONSTRAINT [DF_Equipment_TO_DELETE]
	DEFAULT ((0)) FOR [DELETED]
GO
