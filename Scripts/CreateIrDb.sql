/****** Object:  UserDefinedTableType [dbo].[NewExhibitType]    Script Date: 9/24/2026 10:43:54 AM ******/
CREATE TYPE [dbo].[NewExhibitType] AS TABLE(
	[FilingID] [int] NULL,
	[ExhibitDesc] [varchar](150) NULL,
	[ExhibitName] [varchar](50) NULL,
	[ExhibitType] [varchar](50) NULL,
	[Size] [int] NULL,
	[ExhibitUrl] [varchar](150) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[NewFilingType]    Script Date: 9/24/2026 10:43:54 AM ******/
CREATE TYPE [dbo].[NewFilingType] AS TABLE(
	[AccessionNum] [varchar](20) NULL,
	[FilingDate] [date] NULL,
	[FilingType] [varchar](50) NULL,
	[Size] [int] NULL,
	[IsXBRL] [int] NULL,
	[IsInlineXBRL] [int] NULL,
	[PrimaryDocument] [varchar](50) NULL,
	[PrimaryDocDesc] [varchar](50) NULL,
	[PrimaryDocURL] [varchar](120) NULL,
	[CIK] [varchar](10) NULL
)
GO
/****** Object:  Table [dbo].[ContactTypes]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ContactTypes]    Script Date: 9/24/2026 10:44:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ContactTypes] ON 
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (1, N'Individual Investor')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (2, N'Analyst')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (3, N'Broker/Investment Advisor')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (4, N'Portfolio Manager')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (5, N'Banker/Financing Source')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (6, N'Press/Media')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (7, N'Consultant')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (8, N'Employee')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (9, N'Customer/Client')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (10, N'Student')
GO
INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (11, N'Other')
GO
SET IDENTITY_INSERT [dbo].[ContactTypes] OFF
GO
CREATE TABLE [dbo].[EmailAlertUsers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [varchar](100) NULL,
	[ContactTypeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailAlertUsersNotificationPreferences]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAlertUsersNotificationPreferences](
	[UserId] [int] NOT NULL,
	[AllPressReleases] [bit] NULL,
	[EndOfDayAlerts] [bit] NULL,
	[AnnualQuarterly] [bit] NULL,
	[CurrentReports] [bit] NULL,
	[InsiderTransactions] [bit] NULL,
	[ProxyInformation] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exhibits]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exhibits](
	[ExhibitID] [int] IDENTITY(1,1) NOT NULL,
	[FilingID] [int] NOT NULL,
	[ExhibitDesc] [varchar](200) NULL,
	[ExhibitName] [varchar](50) NULL,
	[ExhibitType] [varchar](30) NULL,
	[Size] [int] NULL,
	[ExhibitUrl] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ExhibitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Filings]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Filings](
	[FilingID] [int] IDENTITY(1,1) NOT NULL,
	[AccessionNum] [varchar](20) NOT NULL,
	[FilingDate] [date] NOT NULL,
	[FilingType] [varchar](50) NOT NULL,
	[Size] [int] NULL,
	[IsXBRL] [int] NOT NULL,
	[IsInlineXBRL] [int] NOT NULL,
	[PrimaryDocument] [varchar](50) NULL,
	[PrimaryDocDesc] [varchar](50) NULL,
	[PrimaryDocURL] [varchar](120) NULL,
	[CIK] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FilingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Presentations]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Presentations](
	[PresentationID] [int] IDENTITY(1000,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[PresentationDate] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PresentationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PressReleases]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PressReleases](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[PublishedDate] [datetime2](7) NOT NULL,
	[PdfRelativePath] [nvarchar](500) NULL,
	[FullText] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_PressReleases_PublishedDate]    Script Date: 9/24/2026 10:43:54 AM ******/
CREATE NONCLUSTERED INDEX [IX_PressReleases_PublishedDate] ON [dbo].[PressReleases]
(
	[PublishedDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD  DEFAULT ((0)) FOR [AllPressReleases]
GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD  DEFAULT ((0)) FOR [EndOfDayAlerts]
GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD  DEFAULT ((0)) FOR [AnnualQuarterly]
GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD  DEFAULT ((0)) FOR [CurrentReports]
GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD  DEFAULT ((0)) FOR [InsiderTransactions]
GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD  DEFAULT ((0)) FOR [ProxyInformation]
GO
ALTER TABLE [dbo].[PressReleases] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[EmailAlertUsers]  WITH CHECK ADD FOREIGN KEY([ContactTypeId])
REFERENCES [dbo].[ContactTypes] ([id])
GO
ALTER TABLE [dbo].[Exhibits]  WITH NOCHECK ADD FOREIGN KEY([FilingID])
REFERENCES [dbo].[Filings] ([FilingID])
GO
/****** Object:  StoredProcedure [dbo].[GetAllFilingData]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllFilingData]
AS
BEGIN
    SELECT 
        F.AccessionNum, 
        F.FilingDate, 
        F.FilingType, 
        F.IsXBRL, 
        F.PrimaryDocURL, 
        E.ExhibitType, 
        E.ExhibitURL
    FROM 
        Filings F
    LEFT JOIN 
        Exhibits E ON F.FilingID = E.FilingID
END;
GO
/****** Object:  StoredProcedure [dbo].[GetAllPresentations]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Babak Shajari
-- Create date: 05/11/2026
-- Description:	Fetches are presentations for current tenant
-- =============================================
CREATE PROCEDURE [dbo].[GetAllPresentations]
AS
BEGIN
    SELECT 
        PresentationID,
        Title,
        FileName,
        PresentationDate,
        UpdatedAt,
        IsActive
    FROM Presentations
    WHERE IsActive = 1
    ORDER BY PresentationDate DESC
END
GO
/****** Object:  StoredProcedure [dbo].[GetQuarterlyFilingData]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetQuarterlyFilingData]
AS
BEGIN
    SELECT 
        F.AccessionNum, 
        F.FilingDate, 
        F.FilingType, 
        F.IsXBRL, 
        F.PrimaryDocURL, 
        E.ExhibitType, 
        E.ExhibitURL
    FROM 
        Filings F
    INNER JOIN 
        Exhibits E ON F.FilingID = E.FilingID
    WHERE 
        F.FilingType IN ('10-Q', 'NT 10-Q', '10-Q/A');
END;
GO
/****** Object:  StoredProcedure [dbo].[GetSectionSixteenFilingData]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSectionSixteenFilingData]
AS
BEGIN
    SELECT 
        F.AccessionNum, 
        F.FilingDate, 
        F.FilingType, 
        F.IsXBRL, 
        F.PrimaryDocURL, 
        E.ExhibitType, 
        E.ExhibitURL
    FROM 
        Filings F
    LEFT JOIN 
        Exhibits E ON F.FilingID = E.FilingID
    WHERE 
        F.FilingType IN ('4/A', '4', '5', '5/A', '3');
END;
GO
/****** Object:  StoredProcedure [dbo].[GetYearlyFilingData]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetYearlyFilingData]
AS
BEGIN
    SELECT 
        F.AccessionNum, 
        F.FilingDate, 
        F.FilingType, 
        F.IsXBRL, 
        F.PrimaryDocURL, 
        E.ExhibitType, 
        E.ExhibitURL
    FROM 
        Filings F
    LEFT JOIN 
        Exhibits E ON F.FilingID = E.FilingID
    WHERE 
        F.FilingType IN ('10-K/A', '10-K', '10-KT/A', '10-KT', 'NT 10-K');
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertFilingExhibits]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Babak Shajari	
-- Create date: 01/22/2025
-- Description:	Inserts new exhibit rows 
-- =============================================
CREATE PROCEDURE [dbo].[InsertFilingExhibits]
	@Exhibits dbo.NewExhibitType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Exhibits(FilingID, ExhibitDesc, ExhibitName, ExhibitType, Size, ExhibitUrl)
	SELECT FilingID, ExhibitDesc, ExhibitName, ExhibitType, Size, ExhibitUrl
	FROM @Exhibits
END
GO
/****** Object:  StoredProcedure [dbo].[InsertFilingsAndReturnIDs]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFilingsAndReturnIDs]
	@Filings dbo.NewFilingType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Filings (AccessionNum, FilingDate, FilingType, Size, IsXBRL, IsInlineXBRL, PrimaryDocument, PrimaryDocDesc, PrimaryDocURL, CIK)
	OUTPUT inserted.FilingID
    -- Insert statements for procedure here
	SELECT AccessionNum, FilingDate, FilingType, Size, IsXBRL, IsInlineXBRL, PrimaryDocument, PrimaryDocDesc, PrimaryDocURL, CIK
	FROM @Filings
END
GO
/****** Object:  StoredProcedure [dbo].[RegisterEmailAlertUser]    Script Date: 9/24/2026 10:43:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Babak Shajari	
-- Create date: May 07, 2026
-- Description:	For Email Alerts feature of Focus Universal Investor Relations website. 
--				User can signup to receive email alerts. The SP adds user information as well as his notification prefrences.
-- =============================================
CREATE PROCEDURE [dbo].[RegisterEmailAlertUser]
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Email VARCHAR(100),
	@ContactTypeId INT,
	@AllPressReleases INT,
	@EndOfDayAlerts BIT,
    @AnnualQuarterly BIT,
    @CurrentReports BIT,
    @InsiderTransactions BIT,
    @ProxyInformation BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
BEGIN TRANSACTION;

    BEGIN TRY
        -- 1. Insert the User and get the generated ID
        DECLARE @NewUserId INT;

        INSERT INTO EmailAlertUsers (FirstName, LastName, Email, ContactTypeId)
        VALUES (@FirstName, @LastName, @Email, @ContactTypeId);

        SET @NewUserId = SCOPE_IDENTITY();

        -- 2. Insert the Preferences using the new User ID
        INSERT INTO EmailAlertUsersNotificationPreferences (
            UserId, 
            AllPressReleases, 
            EndOfDayAlerts, 
            AnnualQuarterly, 
            CurrentReports, 
            InsiderTransactions, 
            ProxyInformation
        )
        VALUES (
            @NewUserId, 
            @AllPressReleases, 
            @EndOfDayAlerts, 
            @AnnualQuarterly, 
            @CurrentReports, 
            @InsiderTransactions, 
            @ProxyInformation
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW; -- Re-throw the error so Dapper/C# can catch it
    END CATCH
END
GO

-- =============================================
-- Author:		Babak Shajari	
-- Create date: May 07, 2026
-- Description:	Inserts new presentation into Presentations table. 
-- =============================================
CREATE PROCEDURE [dbo].[InsertPresentation]
    @Title NVARCHAR(255),
    @FileName NVARCHAR(255),
    @PresentationDate DATETIME,
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;

INSERT INTO Presentations (Title, FileName, PresentationDate, UpdatedAt, IsActive)
VALUES (@Title, @FileName, @PresentationDate, GETUTCDATE(), @IsActive);
END
GO