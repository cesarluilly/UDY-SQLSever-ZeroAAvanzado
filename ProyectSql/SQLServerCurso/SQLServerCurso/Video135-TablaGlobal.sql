USE [Marketplace]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 19/05/2024 04:20:48 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--	CREAMOS UNA TABLA TEMPORAL LOCAL CON ##
CREATE TABLE [dbo].[##Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[Price] [decimal](10, 2) NULL,
	[Stock] [int] NULL,
	[SellerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- No puedo acceder a esta tabla, ya que es una tabla local y estas solo son visibles en la
--	  session(Pestaña de Query) donde se crearon
SELECT * FROM #Products;

-- Accediendo a tabla temporal global
SELECT * FROM ##Products;