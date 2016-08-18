SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UOM] (
		[idUOM]           [nchar](3) COLLATE Latin1_General_CI_AS NOT NULL,
		[name]            [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[description]     [nvarchar](255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UOM]
	ADD
	CONSTRAINT [PK_UOM]
	PRIMARY KEY
	CLUSTERED
	([idUOM])
	ON [PRIMARY]
GO
