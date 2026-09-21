/****** Object:  UserDefinedTableType [dbo].[NewExhibitType] ******/
CREATE TYPE [dbo].[NewExhibitType] AS TABLE(
    [FilingID] [int] NULL,
    [ExhibitDesc] [varchar](150) NULL,
    [ExhibitName] [varchar](50) NULL,
    [ExhibitType] [varchar](50) NULL,
    [Size] [int] NULL,
    [ExhibitUrl] [varchar](150) NULL
    )
    GO  

/****** Object:  UserDefinedTableType [dbo].[NewFilingType] ******/
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

/****** Object:  Table [dbo].[ContactTypes] ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    GO

/****** Object:  Table [dbo].[EmailAlertUsers] ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    GO

/****** Object:  Table [dbo].[EmailAlertUsersNotificationPreferences] ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    GO

/****** Object:  Table [dbo].[Exhibits] ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    GO

/****** Object:  Table [dbo].[Filings] ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    GO

/****** Object:  Table [dbo].[Presentations] ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    GO

/****** Object:  Table [dbo].[PressReleases] ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO

/* =========================================================
   SEED DATA INSERTIONS
   ========================================================= */
    SET IDENTITY_INSERT [dbo].[ContactTypes] ON
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (1, N'Individual Investor')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (2, N'Analyst')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (3, N'Broker/Investment Advisor')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (4, N'Portfolio Manager')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (5, N'Banker/Financing Source')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (6, N'Press/Media')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (7, N'Consultant')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (8, N'Employee')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (9, N'Customer/Client')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (10, N'Student')
    INSERT [dbo].[ContactTypes] ([id], [title]) VALUES (11, N'Other')
    SET IDENTITY_INSERT [dbo].[ContactTypes] OFF

    SET IDENTITY_INSERT [dbo].[EmailAlertUsers] ON
    INSERT [dbo].[EmailAlertUsers] ([id], [FirstName], [LastName], [Email], [ContactTypeId]) VALUES (1, N'Babak', N'Shajari', N'babak@focusuniversal.com', 2)
    SET IDENTITY_INSERT [dbo].[EmailAlertUsers] OFF

    INSERT [dbo].[EmailAlertUsersNotificationPreferences] ([UserId], [AllPressReleases], [EndOfDayAlerts], [AnnualQuarterly], [CurrentReports], [InsiderTransactions], [ProxyInformation]) VALUES (1, 1, 1, 1, 1, 1, 1)

    SET IDENTITY_INSERT [dbo].[Exhibits] ON
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (404, 525, N'EXHIBIT 10.1', N'ef20060722_ex10-1.htm', N'EX-10.1', 74614, N'https://www.sec.gov/Archives/edgar/data/320193/000114036126006577/ef20060722_ex10-1.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (405, 525, N'EXHIBIT 10.2', N'ef20065677_ex10-2.htm', N'EX-10.2', 35680, N'https://www.sec.gov/Archives/edgar/data/320193/000114036126006577/ef20065677_ex10-2.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (406, 570, N'CERTIFICATION', N'focus_ex3101.htm', N'EX-31.1', 9155, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825003212/focus_ex3101.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (407, 570, N'CERTIFICATION', N'focus_ex3102.htm', N'EX-31.2', 9121, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825003212/focus_ex3102.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (408, 570, N'CERTIFICATION', N'focus_ex3201.htm', N'EX-32.1', 3546, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825003212/focus_ex3201.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (409, 570, N'CERTIFICATION', N'focus_ex3202.htm', N'EX-32.2', 3602, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825003212/focus_ex3202.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (410, 573, N'CERTIFICATION', N'focus_ex3101.htm', N'EX-31.1', 9159, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825005122/focus_ex3101.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (411, 573, N'CERTIFICATION', N'focus_ex3102.htm', N'EX-31.2', 9125, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825005122/focus_ex3102.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (412, 574, N'CERTIFICATION', N'focus_ex3101.htm', N'EX-31.1', 8079, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825005910/focus_ex3101.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (413, 574, N'CERTIFICATION', N'focus_ex3102.htm', N'EX-31.2', 8125, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825005910/focus_ex3102.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (414, 574, N'CERTIFICATION', N'focus_ex3201.htm', N'EX-32.1', 3231, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825005910/focus_ex3201.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (415, 574, N'CERTIFICATION', N'focus_ex3202.htm', N'EX-32.2', 3192, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825005910/focus_ex3202.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (416, 578, N'OPINION OF CORPORATE SECURITIES LEGAL LLP', N'focus_ex0501.htm', N'EX-5.1', 10974, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007235/focus_ex0501.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (417, 578, N'AT THE MARKET SALES AGREEMENT', N'focus_ex1001.htm', N'EX-10.1', 270047, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007235/focus_ex1001.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (418, 582, N'CERTIFICATE OF DESIGNATION OF SERIES A', N'focus_ex0301.htm', N'EX-3.1', 16301, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_ex0301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (419, 582, N'CERTIFICATE OF DESIGNATION OF SERIES B', N'focus_ex0302.htm', N'EX-3.2', 129308, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_ex0302.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (420, 582, N'SERIES A PREFERRED STOCK PURCHASE AGREEMENT', N'focus_ex1001.htm', N'EX-10.1', 67907, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_ex1001.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (421, 582, N'FORM OF SERIES B PREFERRED STOCK SUBSCRIPTION AGREEMENT', N'focus_ex1002.htm', N'EX-10.2', 325463, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_ex1002.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (422, 582, N'REGISTRATION RIGHTS AGREEMENT', N'focus_ex1003.htm', N'EX-10.3', 152790, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_ex1003.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (423, 582, N'FORM OF PLACEMENT AGENT AGREEMENT', N'focus_ex1004.htm', N'EX-10.4', 61348, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_ex1004.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (424, 582, N'FORM OF LOCK-UP AGREEMENT DATED 10-21-25', N'focus_ex1005.htm', N'EX-10.5', 16216, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_ex1005.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (425, 582, N'PRESS RELEASE DATED OCTOBER 27, 2025', N'focus_ex9901.htm', N'EX-99.1', 18501, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_ex9901.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (426, 585, N'CERTIFICATION', N'focus_ex3101.htm', N'EX-31.1', 8784, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008135/focus_ex3101.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (427, 585, N'CERTIFICATION', N'focus_ex3102.htm', N'EX-31.2', 8850, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008135/focus_ex3102.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (428, 585, N'CERTIFICATION', N'focus_ex3201.htm', N'EX-32.1', 3323, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008135/focus_ex3201.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (429, 585, N'CERTIFICATION', N'focus_ex3202.htm', N'EX-32.2', 3259, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008135/focus_ex3202.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (430, 588, N'AMENDMENT TO CERTIFICATE OF DESIGNATION OF SERIES B', N'focus_ex0301.htm', N'EX-3.1', 203230, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008956/focus_ex0301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (431, 589, N'2ND AMENDED AND RESTATED ARTICLES OF INCORPORATION', N'focus_ex0301d.htm', N'EX-3.1', 19302, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008989/focus_ex0301d.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (432, 589, N'3RD AMENDED AND RESTATED ARTICLES OF INCORPORATION', N'focus_ex0301e.htm', N'EX-3.1', 19173, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008989/focus_ex0301e.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (433, 589, N'LEGAL OPINION', N'focus_ex0501.htm', N'EX-5.1', 5251, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008989/focus_ex0501.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (434, 589, N'CONSENT', N'focus_ex2301.htm', N'EX-23.1', 2087, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008989/focus_ex2301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (435, 589, N'FILING FEES', N'focus_ex107.htm', N'EX-FILING FEES', 13241, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008989/focus_ex107.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (436, 590, N'LEGAL OPINION', N'focus_ex0501.htm', N'EX-5.1', 5252, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009197/focus_ex0501.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (437, 590, N'CONSENT', N'focus_ex2301.htm', N'EX-23.1', 2125, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009197/focus_ex2301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (438, 592, N'LEGAL OPINION', N'focus_ex0501.htm', N'EX-5.1', 5298, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009222/focus_ex0501.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (439, 592, N'CONSENT', N'focus_ex2301.htm', N'EX-23.1', 2222, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009222/focus_ex2301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (440, 596, N'AMENDMENT TO ARTICLES OF INCORPORATION', N'focus_ex0301.htm', N'EX-3.1', 7842, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826000776/focus_ex0301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (441, 596, N'PRESS RELEASE', N'focus_ex9901.htm', N'EX-99.1', 7955, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826000776/focus_ex9901.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (442, 597, N'CONSENT OF INDEPENDENT REGISTERED PUBLIC ACCOUNTING FIRM', N'focus_ex2301.htm', N'EX-23.1', 1951, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002503/focus_ex2301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (443, 597, N'CERTIFICATION OF PRINCIPAL EXECUTIVE OFFICER', N'focus_ex3101.htm', N'EX-31.1', 10421, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002503/focus_ex3101.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (444, 597, N'CERTIFICATION OF PRINCIPAL ACCOUNTING OFFICER', N'focus_ex3102.htm', N'EX-31.2', 10142, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002503/focus_ex3102.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (445, 597, N'CERTIFICATION', N'focus_ex3201.htm', N'EX-32.1', 4062, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002503/focus_ex3201.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (446, 597, N'CERTIFICATION', N'focus_ex3202.htm', N'EX-32.2', 4179, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002503/focus_ex3202.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (447, 598, N'FORM OF PIPE PRE-FUNDED WARRANT', N'focus_ex0401.htm', N'EX-4.1', 138266, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_ex0401.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (448, 598, N'FORM OF SERIES A PIPE COMMON WARRANT', N'focus_ex0402.htm', N'EX-4.2', 147056, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_ex0402.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (449, 598, N'FORM OF SERIES B PIPE COMMON WARRANT', N'focus_ex0403.htm', N'EX-4.3', 147056, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_ex0403.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (450, 598, N'FORM OF SECURITIES PURCHASE AGREEMENT', N'focus_ex1001.htm', N'EX-10.1', 315086, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_ex1001.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (451, 598, N'FORM OF REGISTRATION RIGHTS AGREEMENT', N'focus_ex1002.htm', N'EX-10.2', 180169, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_ex1002.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (452, 598, N'FORM OF PLACEMENT AGENT AGREEMENT', N'focus_ex1003.htm', N'EX-10.3', 86472, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_ex1003.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (453, 598, N'PRESS RELEASE BY FOCUS UNIVERSAL INC. DATED APRIL 6, 2026', N'focus_ex9901.htm', N'EX-99.1', 11730, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_ex9901.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (454, 598, N'PRESS RELEASE BY FOCUS UNIVERSAL INC. DATED APRIL 8, 2026', N'focus_ex9902.htm', N'EX-99.2', 11001, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_ex9902.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (455, 601, N'OPINION OF CORPORATE SECURITIES LEGAL LLP', N'focus_ex0501.htm', N'EX-5.1', 14843, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex0501.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (456, 601, N'LEASE AGREEMENT WITH CAMERON COURT L.P', N'focus_ex1026.htm', N'EX-10.26', 343552, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex1026.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (457, 601, N'BUSINESS LOAN AGREEMENT', N'focus_ex1027.htm', N'EX-10.27', 128116, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex1027.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (458, 601, N'PROMISSORY NOTE BETWEEN LUSHER HOLDINGS LLC AND EAST WEST BANK', N'focus_ex1028.htm', N'EX-10.28', 50369, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex1028.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (459, 601, N'REDEMPTION AGREEMENT BETWEEN FOCUS UNIVERSAL INC AND GREAT POINT CAPITAL LLC', N'focus_ex1029.htm', N'EX-10.29', 16714, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex1029.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (460, 601, N'LOCK-UP AGREEMENT', N'focus_ex1030.htm', N'EX-10.30', 29291, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex1030.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (461, 601, N'SUBSIDIARIES OF THE REGISTRANT', N'focus_ex2101.htm', N'EX-21.1', 3951, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex2101.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (462, 601, N'CONSENT', N'focus_ex2301.htm', N'EX-23.1', 2363, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex2301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (463, 601, N'ARTICLES OF ORGANIZATION OF LUSHER HOLDINGS LLC', N'focus_ex9908.htm', N'EX-99.8', 2124, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex9908.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (464, 601, N'ARTICLES OF ORGANIZATION OF LUSHER LLC', N'focus_ex9909.htm', N'EX-99.9', 2266, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex9909.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (465, 601, N'ARTICLES OF ORGANIZATION OF LUSHER SERVICES LLC', N'focus_ex9910.htm', N'EX-99.10', 2199, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex9910.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (466, 601, N'FILING FEE IXBRL', N'focus_ex107.htm', N'EX-FILING FEES', 13149, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_ex107.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (467, 603, N'AGREEMENT FOR PURCHASE AND SALE AND ESCROW INSTRUCTIONS', N'focus_ex1001.htm', N'EX-10.1', 303595, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003231/focus_ex1001.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (468, 603, N'FIRST AMENDMENT TO AGREEMENT FOR PURCHASE AND SALE', N'focus_ex1002.htm', N'EX-10.2', 11659, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003231/focus_ex1002.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (469, 603, N'SECOND AMENDMENT TO AGREEMENT FOR PURCHASE AND SALE', N'focus_ex1003.htm', N'EX-10.3', 14474, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003231/focus_ex1003.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (470, 603, N'THIRD AMENDMENT TO AGREEMENT FOR PURCHASE AND SALE', N'focus_ex1004.htm', N'EX-10.4', 13725, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003231/focus_ex1004.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (471, 603, N'LOS ANGELES COUNTY ASSESSORS 2026 ASSESSMENT VALUES OF THE PARCELS', N'focus_ex9901.htm', N'EX-99.1', 7271, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003231/focus_ex9901.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (472, 604, N'CONSENT OF WEINBURG & COMPANY P.A.', N'focus_ex2301.htm', N'EX-23.1', 2870, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003265/focus_ex2301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (473, 608, N'CONSENT OF WEINBURG & COMPANY P.A.', N'focus_ex2301.htm', N'EX-23.1', 2872, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003417/focus_ex2301.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (474, 610, N'CERTIFICATION PURSUANT TO SECTION 302', N'focus_ex3101.htm', N'EX-31.1', 8180, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003903/focus_ex3101.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (475, 610, N'CERTIFICATION PURSUANT TO SECTION 302', N'focus_ex3102.htm', N'EX-31.2', 8225, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003903/focus_ex3102.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (476, 610, N'CERTIFICATION', N'focus_ex3201.htm', N'EX-32.1', 3288, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003903/focus_ex3201.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (477, 610, N'CERTIFICATION', N'focus_ex3202.htm', N'EX-32.2', 3262, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003903/focus_ex3202.htm')
    INSERT [dbo].[Exhibits] ([ExhibitID], [FilingID], [ExhibitDesc], [ExhibitName], [ExhibitType], [Size], [ExhibitUrl]) VALUES (478, 613, N'CERTIFICATE OF AMENDMENT TO ARTICLES OF INCORPORATION', N'focus_ex0301.htm', N'EX-3.1', 21637, N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826004961/focus_ex0301.htm')
    SET IDENTITY_INSERT [dbo].[Exhibits] OFF

    SET IDENTITY_INSERT [dbo].[Filings] ON
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (525, N'0001780525-26-000005', CAST(N'2026-03-17' AS Date), N'4', 9251, 0, 0, N'xslF345X05/wk-form4_1773786674.xml', N'FORM 4', N'https://www.sec.gov/Archives/edgar/data/320193/000114036126006577/ef20060722_8k.htm', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (526, N'0001780525-26-000003', CAST(N'2026-03-06' AS Date), N'3', 490535, 0, 0, N'xslF345X02/wk-form3_1772839848.xml', N'FORM 3', N'https://www.sec.gov/Archives/edgar/data/320193/000169088226000004/xslF345X05/wk-form4_1772148630.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (527, N'0001059235-26-000004', CAST(N'2026-02-26' AS Date), N'4', 5753, 0, 0, N'xslF345X05/wk-form4_1772148856.xml', N'FORM 4', N'https://www.sec.gov/Archives/edgar/data/320193/000145314926000005/xslF345X05/wk-form4_1772148681.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (528, N'0001216519-26-000004', CAST(N'2026-02-26' AS Date), N'4', 5760, 0, 0, N'xslF345X05/wk-form4_1772148826.xml', N'FORM 4', N'https://www.sec.gov/Archives/edgar/data/320193/000105140126000004/xslF345X05/wk-form4_1772148721.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (529, N'0001179864-26-000004', CAST(N'2026-02-26' AS Date), N'4', 5734, 0, 0, N'xslF345X05/wk-form4_1772148791.xml', N'FORM 4', N'https://www.sec.gov/Archives/edgar/data/320193/000121412826000004/xslF345X05/wk-form4_1772148758.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (530, N'0001214128-26-000004', CAST(N'2026-02-26' AS Date), N'4', 7816, 0, 0, N'xslF345X05/wk-form4_1772148758.xml', N'FORM 4', N'https://www.sec.gov/Archives/edgar/data/320193/000117986426000004/xslF345X05/wk-form4_1772148791.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (531, N'0001051401-26-000004', CAST(N'2026-02-26' AS Date), N'4', 5748, 0, 0, N'xslF345X05/wk-form4_1772148721.xml', N'FORM 4', N'https://www.sec.gov/Archives/edgar/data/320193/000121651926000004/xslF345X05/wk-form4_1772148826.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (532, N'0001453149-26-000005', CAST(N'2026-02-26' AS Date), N'4', 5765, 0, 0, N'xslF345X05/wk-form4_1772148681.xml', N'FORM 4', N'https://www.sec.gov/Archives/edgar/data/320193/000105923526000004/xslF345X05/wk-form4_1772148856.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (533, N'0001690882-26-000004', CAST(N'2026-02-26' AS Date), N'4', 5728, 0, 0, N'xslF345X05/wk-form4_1772148630.xml', N'FORM 4', N'https://www.sec.gov/Archives/edgar/data/320193/000178052526000003/xslF345X02/wk-form3_1772839848.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (534, N'0001140361-26-006577', CAST(N'2026-02-24' AS Date), N'8-K', 415164, 1, 1, N'ef20060722_8k.htm', N'8-K', N'https://www.sec.gov/Archives/edgar/data/320193/000178052526000005/xslF345X05/wk-form4_1773786674.xml', N'0000320193')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (569, N'0001683168-26-004961', CAST(N'2026-06-18' AS Date), N'8-K', 677534, 1, 1, N'focus_8k.htm', N'CURRENT REPORT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825003140/focus_424b5.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (570, N'0001683168-26-004516', CAST(N'2026-06-04' AS Date), N'424B4', 1361377, 0, 0, N'focus_424b4.htm', N'PROSPECTUS', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825003212/focus_i10q-033125.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (571, N'0001683168-26-004299', CAST(N'2026-05-26' AS Date), N'8-K', 193701, 1, 1, N'focus_8k.htm', N'CURRENT REPORT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825004772/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (572, N'0001683168-26-003903', CAST(N'2026-05-14' AS Date), N'10-Q', 5094956, 1, 1, N'focus_i10q-033126.htm', N'FORM 10-Q FOR MAR 2026', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825004919/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (573, N'9999999995-26-001446', CAST(N'2026-05-01' AS Date), N'EFFECT', 1821, 0, 0, N'xslEFFECTX01/primary_doc.xml', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825005122/focus_i10qa1-033125.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (574, N'0001683168-26-003417', CAST(N'2026-05-01' AS Date), N'S-1/A', 464046, 1, 1, N'focus_s1a2.htm', N'FORM S-1 AMENDMENT 2', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825005910/focus_i10q-063025.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (575, N'0001683168-26-003297', CAST(N'2026-04-29' AS Date), N'DEFA14A', 57523, 0, 0, N'focus_defa14a.htm', N'DEFINITIVE ADDITIONAL MATERIALS', N'https://www.sec.gov/Archives/edgar/data/1163791/000168316825006262/xslF345X05/ownership.xml', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (576, N'0001683168-26-003293', CAST(N'2026-04-29' AS Date), N'CORRESP', 9082, 0, 0, N'filename1.htm', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007118/focus_pre14c.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (577, N'0000000000-26-004359', CAST(N'2026-04-29' AS Date), N'UPLOAD', 147074, 0, 0, N'filename1.pdf', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007180/focus_424b5.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (578, N'0001683168-26-003265', CAST(N'2026-04-28' AS Date), N'S-1/A', 469854, 1, 1, N'focus_s1a1.htm', N'AMENDMENT #1 TO FORM S-1', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007235/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (579, N'0001683168-26-003231', CAST(N'2026-04-27' AS Date), N'8-K', 2649820, 1, 1, N'focus_8k.htm', N'FORM 8-K', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007575/focus_prer14c.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (580, N'0001683168-26-003202', CAST(N'2026-04-24' AS Date), N'DEF 14A', 921776, 1, 1, N'focus_def14a.htm', N'DEFINITIVE PROXY STATEMENT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007723/xslF345X05/ownership.xml', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (581, N'0001683168-26-003166', CAST(N'2026-04-23' AS Date), N'S-1', 9515095, 1, 1, N'focus_s1.htm', N'REGISTRATION STATEMENT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007779/focus_def14c.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (582, N'0001683168-26-003119', CAST(N'2026-04-22' AS Date), N'D', 9957, 0, 0, N'xslFormDX08/primary_doc.xml', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825007784/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (583, N'0001683168-26-002936', CAST(N'2026-04-14' AS Date), N'PRE 14A', 825272, 1, 1, N'focus_ipre14a.htm', N'PRELIMINARY PROXY STATEMENT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008080/xslFormDX08/primary_doc.xml', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (584, N'0001683168-26-002816', CAST(N'2026-04-10' AS Date), N'8-K', 1490066, 1, 1, N'focus_8k.htm', N'CURRENT REPORT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008082/xslFormDX08/primary_doc.xml', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (585, N'0001683168-26-002503', CAST(N'2026-03-31' AS Date), N'10-K', 7322108, 1, 1, N'focus_i10k-123125.htm', N'FORM 10-K', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008135/focus_i10q-093025.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (586, N'0001683168-26-000776', CAST(N'2026-02-05' AS Date), N'8-K', 241146, 1, 1, N'focus_8k.htm', N'FORM 8-K', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008658/xslF345X05/ownership.xml', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (587, N'0001683168-25-009339', CAST(N'2025-12-23' AS Date), N'8-K', 190271, 1, 1, N'focus_8k.htm', N'FORM 8-K', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008669/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (588, N'9999999995-25-003846', CAST(N'2025-12-18' AS Date), N'EFFECT', 1764, 0, 0, N'xslEFFECTX01/primary_doc.xml', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008956/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (589, N'0001683168-25-009234', CAST(N'2025-12-17' AS Date), N'8-K', 195224, 1, 1, N'focus_8k.htm', N'CURRENT REPORT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825008989/focus_s1.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (590, N'0001683168-25-009222', CAST(N'2025-12-17' AS Date), N'S-1/A', 6800083, 1, 1, N'focus_s1a2.htm', N'AMENDMENT NO. 2', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009197/focus_s1a1.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (591, N'0001683168-25-009198', CAST(N'2025-12-16' AS Date), N'CORRESP', 9208, 0, 0, N'filename1.htm', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009198/filename1.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (592, N'0001683168-25-009197', CAST(N'2025-12-16' AS Date), N'S-1/A', 6799931, 1, 1, N'focus_s1a1.htm', N'AMENDMENT NO 1', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009222/focus_s1a2.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (593, N'0001683168-25-008989', CAST(N'2025-12-08' AS Date), N'S-1', 14426049, 1, 1, N'focus_s1.htm', N'REGISTRATION STATEMENT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009234/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (594, N'0001683168-25-008956', CAST(N'2025-12-08' AS Date), N'8-K', 492211, 1, 1, N'focus_8k.htm', N'CURRENT REPORT', N'https://www.sec.gov/Archives/edgar/data/1590418/999999999525003846/xslEFFECTX01/primary_doc.xml', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (595, N'0001683168-25-008669', CAST(N'2025-11-25' AS Date), N'8-K', 192048, 1, 1, N'focus_8k.htm', N'FORM 8-K', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316825009339/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (596, N'0001683168-25-008658', CAST(N'2025-11-24' AS Date), N'4', 10561, 0, 0, N'xslF345X05/ownership.xml', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826000776/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (597, N'0001683168-25-008135', CAST(N'2025-11-10' AS Date), N'10-Q', 5192282, 1, 1, N'focus_i10q-093025.htm', N'FORM 10-Q FOR SEP 2025', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002503/focus_i10k-123125.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (598, N'0001683168-25-008082', CAST(N'2025-11-07' AS Date), N'D', 10372, 0, 0, N'xslFormDX08/primary_doc.xml', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002816/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (599, N'0001683168-25-008080', CAST(N'2025-11-07' AS Date), N'D', 9232, 0, 0, N'xslFormDX08/primary_doc.xml', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826002936/focus_ipre14a.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (600, N'0001683168-25-007784', CAST(N'2025-10-27' AS Date), N'8-K', 13042794, 1, 1, N'focus_8k.htm', N'CURRENT REPORT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003119/xslFormDX08/primary_doc.xml', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (601, N'0001683168-25-007779', CAST(N'2025-10-27' AS Date), N'DEF 14C', 254239, 0, 0, N'focus_def14c.htm', N'FORM DEF 14C', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003166/focus_s1.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (602, N'0001683168-25-007723', CAST(N'2025-10-22' AS Date), N'5/A', 18965, 0, 0, N'xslF345X05/ownership.xml', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003202/focus_def14a.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (603, N'0001683168-25-007575', CAST(N'2025-10-15' AS Date), N'PRER14C', 226934, 0, 0, N'focus_prer14c.htm', N'AMENDMENT TO PRELIMINARY INFORMATION STATEMENT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003231/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (604, N'0001683168-25-007235', CAST(N'2025-09-25' AS Date), N'8-K', 648859, 1, 1, N'focus_8k.htm', N'CURRENT REPORT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003265/focus_s1a1.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (605, N'0001683168-25-007180', CAST(N'2025-09-22' AS Date), N'424B5', 396334, 0, 0, N'focus_424b5.htm', N'PROSPECTUS', N'https://www.sec.gov/Archives/edgar/data/1590418/000000000026004359/filename1.pdf', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (606, N'0001683168-25-007118', CAST(N'2025-09-18' AS Date), N'PRE 14C', 128973, 0, 0, N'focus_pre14c.htm', N'FORM PRE 14C', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003293/filename1.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (607, N'0001683168-25-006262', CAST(N'2025-08-15' AS Date), N'4', 19345, 0, 0, N'xslF345X05/ownership.xml', N'', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003297/focus_defa14a.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (608, N'0001683168-25-005910', CAST(N'2025-08-12' AS Date), N'10-Q', 5141271, 1, 1, N'focus_i10q-063025.htm', N'FORM 10-Q JUN 2025', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003417/focus_s1a2.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (609, N'0001683168-25-005122', CAST(N'2025-07-15' AS Date), N'10-Q/A', 207984, 1, 1, N'focus_i10qa1-033125.htm', N'AMENDMENT NO. 1', N'https://www.sec.gov/Archives/edgar/data/1590418/999999999526001446/xslEFFECTX01/primary_doc.xml', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (610, N'0001683168-25-004919', CAST(N'2025-07-03' AS Date), N'8-K', 189946, 1, 1, N'focus_8k.htm', N'CURRENT REPORT', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826003903/focus_i10q-033126.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (611, N'0001683168-25-004772', CAST(N'2025-06-26' AS Date), N'8-K', 203901, 1, 1, N'focus_8k.htm', N'FORM 8-K', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826004299/focus_8k.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (612, N'0001683168-25-003212', CAST(N'2025-05-07' AS Date), N'10-Q', 4614722, 1, 1, N'focus_i10q-033125.htm', N'FORM 10-Q FOR MAR 2025', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826004516/focus_424b4.htm', N'0001590418')
    INSERT [dbo].[Filings] ([FilingID], [AccessionNum], [FilingDate], [FilingType], [Size], [IsXBRL], [IsInlineXBRL], [PrimaryDocument], [PrimaryDocDesc], [PrimaryDocURL], [CIK]) VALUES (613, N'0001683168-25-003140', CAST(N'2025-05-06' AS Date), N'424B5', 369922, 0, 0, N'focus_424b5.htm', N'FORM 424B5', N'https://www.sec.gov/Archives/edgar/data/1590418/000168316826004961/focus_8k.htm', N'0001590418')
    SET IDENTITY_INSERT [dbo].[Filings] OFF

    SET IDENTITY_INSERT [dbo].[Presentations] ON
    INSERT [dbo].[Presentations] ([PresentationID], [Title], [FileName], [PresentationDate], [UpdatedAt], [IsActive]) VALUES (1000, N'Focus Universal (FCUV) Presentation', N'Perfecular Deck.pdf', CAST(N'2022-11-18T20:56:17.633' AS DateTime), CAST(N'2026-04-17T20:56:17.633' AS DateTime), 1)
    INSERT [dbo].[Presentations] ([PresentationID], [Title], [FileName], [PresentationDate], [UpdatedAt], [IsActive]) VALUES (1001, N'Next Generation AI Financial Software', N'Perfecular Deck.pdf', CAST(N'2026-04-17T22:17:17.287' AS DateTime), CAST(N'2026-04-17T22:17:17.287' AS DateTime), 1)
    SET IDENTITY_INSERT [dbo].[Presentations] OFF

    SET IDENTITY_INSERT [dbo].[PressReleases] ON
    INSERT [dbo].[PressReleases] ([Id], [Title], [PublishedDate], [PdfRelativePath], [FullText], [CreatedAt]) VALUES (1, N'Focus Universal Announces Certification of Universal Smart IoT Devices', CAST(N'2026-08-20T03:37:00.0000000' AS DateTime2), N'press-releases/2026-08-20_Focus_Universal_Announces_Certification_of_95.pdf', N'MONTEREY PARK, CA - August 20, 2026 (NEWMEDIAWIRE) - Focus Universal Inc. (Nasdaq: FCUV) ("Focus" or the "Company") is pleased to announce that the certification process of Universal Smart Device and associated sensors was completed by accredited laboratories GRG Metrology & Test Group Co., Ltd. and Centre Testing International Group Co., Ltd. ... Released August 20, 2026', CAST(N'2026-08-28T23:32:52.4000756' AS DateTime2))
    INSERT [dbo].[PressReleases] ([Id], [Title], [PublishedDate], [PdfRelativePath], [FullText], [CreatedAt]) VALUES (2, N'Focus Universal Inc. to Showcase Deterministic AI Technology at H.C. Wainwright 28th Annual Global Investment Conference', CAST(N'2026-08-06T03:37:00.0000000' AS DateTime2), N'press-releases/2026-08-06_Focus_Universal_Inc_to_Showcase_Deterministic_AI_94.pdf', N'MONTEREY PARK, CA - August 6, 2026 (NEWMEDIAWIRE) - Focus Universal Inc. (NASDAQ: FCUV) ... Released August 6, 2026', CAST(N'2026-08-28T23:32:52.4000756' AS DateTime2))
    INSERT [dbo].[PressReleases] ([Id], [Title], [PublishedDate], [PdfRelativePath], [FullText], [CreatedAt]) VALUES (3, N'Focus Universal Announces Deterministic AI Forms Auto-Populate Engine, Introducing a New Era of Autonomous Business Document Processing', CAST(N'2026-07-31T03:37:00.0000000' AS DateTime2), N'press-releases/2026-07-31_Focus_Universal_Announces_Deterministic_AI_Forms_93.pdf', N'MONTEREY PARK, CA - July 31, 2026 (NEWMEDIAWIRE) - Focus Universal Inc. (NASDAQ: FCUV) ... Released July 31, 2026', CAST(N'2026-08-28T23:32:52.4000756' AS DateTime2))
    SET IDENTITY_INSERT [dbo].[PressReleases] OFF

/* =========================================================
   INDEXES & CONSTRAINTS
   ========================================================= */
    SET ANSI_PADDING ON
    GO

/****** Object:  Index [UQ__EmailAle__A9D105347A7F341F] ******/
ALTER TABLE [dbo].[EmailAlertUsers] ADD UNIQUE NONCLUSTERED
    (
    [Email] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    GO

/****** Object:  Index [IX_PressReleases_PublishedDate] ******/
CREATE NONCLUSTERED INDEX [IX_PressReleases_PublishedDate] ON [dbo].[PressReleases]
(
    [PublishedDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD DEFAULT ((0)) FOR [AllPressReleases]
    GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD DEFAULT ((0)) FOR [EndOfDayAlerts]
    GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD DEFAULT ((0)) FOR [AnnualQuarterly]
    GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD DEFAULT ((0)) FOR [CurrentReports]
    GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD DEFAULT ((0)) FOR [InsiderTransactions]
    GO
ALTER TABLE [dbo].[EmailAlertUsersNotificationPreferences] ADD DEFAULT ((0)) FOR [ProxyInformation]
    GO
ALTER TABLE [dbo].[PressReleases] ADD DEFAULT (sysutcdatetime()) FOR [CreatedAt]
    GO

ALTER TABLE [dbo].[EmailAlertUsers] WITH CHECK ADD FOREIGN KEY([ContactTypeId])
    REFERENCES [dbo].[ContactTypes] ([id])
    GO
ALTER TABLE [dbo].[Exhibits] WITH NOCHECK ADD FOREIGN KEY([FilingID])
    REFERENCES [dbo].[Filings] ([FilingID])
    GO

    /* =========================================================
       STORED PROCEDURES
       ========================================================= */
/****** Object:  StoredProcedure [dbo].[GetAllFilingData] ******/
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

/****** Object:  StoredProcedure [dbo].[GetAllPresentations] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

/****** Object:  StoredProcedure [dbo].[GetQuarterlyFilingData] ******/
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

/****** Object:  StoredProcedure [dbo].[GetSectionSixteenFilingData] ******/
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

/****** Object:  StoredProcedure [dbo].[GetYearlyFilingData] ******/
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

/****** Object:  StoredProcedure [dbo].[InsertFilingExhibits] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFilingExhibits]
    @Exhibits dbo.NewExhibitType READONLY
AS
BEGIN
    SET NOCOUNT ON;

INSERT INTO Exhibits(FilingID, ExhibitDesc, ExhibitName, ExhibitType, Size, ExhibitUrl)
SELECT FilingID, ExhibitDesc, ExhibitName, ExhibitType, Size, ExhibitUrl
FROM @Exhibits
END
GO

/****** Object:  StoredProcedure [dbo].[InsertFilingsAndReturnIDs] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFilingsAndReturnIDs]
    @Filings dbo.NewFilingType READONLY
AS
BEGIN
    SET NOCOUNT ON;

INSERT INTO Filings (AccessionNum, FilingDate, FilingType, Size, IsXBRL, IsInlineXBRL, PrimaryDocument, PrimaryDocDesc, PrimaryDocURL, CIK)
    OUTPUT inserted.FilingID
SELECT AccessionNum, FilingDate, FilingType, Size, IsXBRL, IsInlineXBRL, PrimaryDocument, PrimaryDocDesc, PrimaryDocURL, CIK
FROM @Filings
END
GO

/****** Object:  StoredProcedure [dbo].[RegisterEmailAlertUser] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
    SET NOCOUNT ON;
BEGIN TRANSACTION;

BEGIN TRY
        DECLARE @NewUserId INT;

INSERT INTO EmailAlertUsers (FirstName, LastName, Email, ContactTypeId)
VALUES (@FirstName, @LastName, @Email, @ContactTypeId);

SET @NewUserId = SCOPE_IDENTITY();

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
        THROW;
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