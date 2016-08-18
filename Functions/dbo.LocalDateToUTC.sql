SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].LocalDateToUTC(@date DateTime)
returns varchar(255)
as
begin
  return convert(varchar(255), dateadd(second, datediff(second, getdate(), getutcdate()), @date), 127) +'Z';
end
GO
