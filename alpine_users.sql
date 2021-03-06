-- ----------------------------
--  Table structure for alpine_users
-- ----------------------------
CREATE TABLE [dbo].[alpine_users] (
	[userGUID] uniqueidentifier NOT NULL DEFAULT (newid()) ROWGUIDCOL,
	[nameFirst] varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[nameLast] varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[isAdmin] bit NOT NULL DEFAULT ((0)),
	[isDeleted] bit NOT NULL DEFAULT ((0)),
	[password] char(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[salt] char(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[emailAddress] varchar(64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [email-idx]
ON [dbo].[alpine_users] ([emailAddress] ASC, [isDeleted] ASC)
WITH (PAD_INDEX = OFF,
	IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	SORT_IN_TEMPDB = OFF,
	ONLINE = OFF,
	ALLOW_ROW_LOCKS = ON,
	ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [email-pw-idx]
ON [dbo].[alpine_users] ([emailAddress] ASC, [password] ASC, [isDeleted] ASC)
WITH (PAD_INDEX = OFF,
	IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	SORT_IN_TEMPDB = OFF,
	ONLINE = OFF,
	ALLOW_ROW_LOCKS = ON,
	ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [name-by-last-first-idx]
ON [dbo].[alpine_users] ([nameLast] ASC, [nameFirst] ASC)
WITH (PAD_INDEX = OFF,
	IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	SORT_IN_TEMPDB = OFF,
	ONLINE = OFF,
	ALLOW_ROW_LOCKS = ON,
	ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
ALTER TABLE [dbo].[alpine_users] SET (LOCK_ESCALATION = TABLE)




CREATE PROCEDURE [dbo].[alpine_getDupe]
	@emailAddress varchar(64)
AS
	SELECT userGUID
	FROM alpine_users
	WHERE
		isDeleted = 0
		AND emailAddress = @emailAddress

GO


CREATE PROCEDURE [dbo].[alpine_getProfile]
	@userGUID uniqueidentifier
AS
	SELECT
		emailAddress,
		nameFirst,
		nameLast,
		isAdmin,
		userGUID
	FROM alpine_users
	WHERE userGUID = @userGUID

GO


CREATE PROCEDURE [dbo].[alpine_getUserByEmailPW]
	@emailAddress varchar(64),
	@password varchar(128)
AS
	SELECT
		userGUID,
		nameFirst,
		isAdmin
	FROM alpine_users
	WHERE
		isDeleted = 0
		AND emailAddress = @emailAddress
		AND password = @password

GO


CREATE PROCEDURE [dbo].[alpine_getUsers]

AS
	SELECT
		userGUID,
		nameFirst,
		nameLast,
		emailAddress,
		isAdmin
	FROM alpine_users
	ORDER BY nameLast, nameFirst
GO


CREATE PROCEDURE [dbo].[alpine_getUserSalt]
	@emailAddress varchar(64)
AS
	SELECT salt
	FROM alpine_users
	WHERE
		isDeleted = 0
		AND emailAddress = @emailAddress
GO


CREATE PROCEDURE [dbo].[alpine_saveUser]
	@nameFirst varchar(128),
	@nameLast varchar(128),
	@emailAddress varchar(64),
	@password varchar(128),
	@salt varchar(128)
AS
	INSERT INTO alpine_users ( nameFirst, nameLast, emailAddress, password, salt )
	VALUES (
		@nameFirst,
		@nameLast,
		@emailAddress,
		@password,
		@salt
	)
GO


-- ----------------------------
--  Records of alpine_users
-- ----------------------------
BEGIN TRANSACTION
GO
INSERT INTO [dbo].[alpine_users] VALUES ('64DAE5AD-8B49-4E80-ACA6-6180DD50AE34', 'Charles', 'Fahey', '1', '0', '804635E74B998FC2525FE9058DE101CBA42B84AB6F978BCA16C385E7C1D4E59AC745FB8E05B367FA5BE1F226682DFA50C33749DC650BBCAEB3A03A3DA04D5B9A', '28CF55832FFE064D10D17F7FA42D3D6BE0E4537E81745E9F47B32C18F82E72121BABD5703B1DC9DEA4108F48810D00C9A0A302957AB7EF773EE2F0BE0CBC6FA3', 'cfahey@cfahey.com');
INSERT INTO [dbo].[alpine_users] VALUES ('D1F51D8D-DF4C-481D-96DF-04AE566E3E62', 'Michael', 'Scott', '1', '0', 'D3388CDA2D5CBD8353E12ADA62010274963F75239EC6329DAD80F28D725E66F14CCDE68B288A7F4E3D8376F2B65CBAB68BB654C91A9EB11AD78664048E9BBFD0', 'FB6676FE20C853E9C2FFE1773EB21D15D0C1358E2A843737F585FD71DB14D3417ABB5B1A09D2E37742E9721689B4F2EADCE347643E491BAC4846CC005FAB8C22', 'scottstotts@dundermiflin.com');
INSERT INTO [dbo].[alpine_users] VALUES ('6B7D298F-ACFE-4193-8E1A-3B53B8BBCE94', 'Gob', 'Bluth', '0', '0', '77154C44D4BCB077B7B91C3AC1FB97DC2FB13BE1FAF38289B115572063CDD5F4A23F717D1E45894D9EE5C38A7BD2160D18A6858BF5BC584ED1B4B95E0BBE6046', 'D04FCE8A9F600CD5086286F804D63F30E48C5368E7D00DF8E8D47AAB42ED947B0430DC983097274E75E1F0C3EB7D896F9991A50DA32A8E16BC37D3C726FDCA46', 'gob@bluth.com');
INSERT INTO [dbo].[alpine_users] VALUES ('DDC032D1-D745-41DA-876D-354785474329', 'Uncle', 'Jim', '0', '0', '3D4CA38EC26B46271DEBA4F818B67FFDC973F518241FFDA6022B6AEA99CB1A5B4DCDB5332ECF40A745CCDF08853F1AC6E83EDA73BA76A166C53DF2B5B06B905B', '603F4558EFC63C922B36A5C358AD2CAABECC4C372A534D20FA5B9ACDB32087E279E93E45C684F4EFAFDEFF033030DF7B949AF8FD566C76ED331F64007DAAF08C', 'ribbondancer@aol.com');
GO
COMMIT
GO
