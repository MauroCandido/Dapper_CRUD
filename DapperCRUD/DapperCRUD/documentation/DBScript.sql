USE [DapperCrudDB]
GO
/****** Object:  StoredProcedure [dbo].[ContactViewAllOrSearch]    Script Date: 09-Apr-2017 7:48:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactViewAllOrSearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ContactViewAllOrSearch]
GO
/****** Object:  StoredProcedure [dbo].[ContactDeleteByID]    Script Date: 09-Apr-2017 7:48:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactDeleteByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ContactDeleteByID]
GO
/****** Object:  StoredProcedure [dbo].[ContactAddOrEdit]    Script Date: 09-Apr-2017 7:48:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactAddOrEdit]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ContactAddOrEdit]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 09-Apr-2017 7:48:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Contact]') AND type in (N'U'))
DROP TABLE [dbo].[Contact]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 09-Apr-2017 7:48:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Contact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Contact](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[Address] [varchar](250) NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ContactAddOrEdit]    Script Date: 09-Apr-2017 7:48:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactAddOrEdit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactAddOrEdit] AS' 
END
GO
ALTER PROC [dbo].[ContactAddOrEdit]
@ContactID int,
@Name varchar(50),
@Mobile varchar(50),
@Address varchar(250)
AS
BEGIN
IF(@ContactID = 0)
BEGIN
	INSERT INTO Contact
	(
	Name,
	Mobile,
	Address
	)
	VALUES
	(
	@Name,
	@Mobile,
	@Address
	)
END
ELSE
BEGIN
	UPDATE Contact
	SET
	Name = @Name,
	Mobile = @Mobile,
	Address = @Address
	WHERE ContactID = @ContactID
END


END
GO
/****** Object:  StoredProcedure [dbo].[ContactDeleteByID]    Script Date: 09-Apr-2017 7:48:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactDeleteByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactDeleteByID] AS' 
END
GO
ALTER PROC [dbo].[ContactDeleteByID]
@ContactID int
AS BEGIN
DELETE FROM Contact
WHERE ContactID = @ContactID
END
GO
/****** Object:  StoredProcedure [dbo].[ContactViewAllOrSearch]    Script Date: 09-Apr-2017 7:48:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactViewAllOrSearch]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactViewAllOrSearch] AS' 
END
GO
ALTER PROC [dbo].[ContactViewAllOrSearch]
@SearchText VARCHAR(50)
AS BEGIN
SELECT *
FROM Contact
WHERE @SearchText='' OR
	NAME LIKE '%'+@SearchText+'%'

END
GO
