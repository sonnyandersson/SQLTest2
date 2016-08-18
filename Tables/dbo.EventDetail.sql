SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventDetail] (
		[idEventDetail]           [bigint] IDENTITY(1, 1) NOT NULL,
		[idEventPerShift]         [bigint] NOT NULL,
		[timeStart]               [datetime] NOT NULL,
		[timeEnd]                 [datetime] NULL,
		[classified]              [real] NULL,
		[idEventReason]           [nchar](4) COLLATE Latin1_General_CI_AS NULL,
		[idEventSubReason]        [nchar](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[idEventLocalReason]      [nchar](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[idEquipment]             [float] NULL,
		[synergyNumber]           [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[comment]                 [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[originIdEventDetail]     [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventDetail]
	ADD
	CONSTRAINT [PK_EventDetail]
	PRIMARY KEY
	CLUSTERED
	([idEventDetail])
	ON [PRIMARY]
GO
