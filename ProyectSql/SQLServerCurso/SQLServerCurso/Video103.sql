USE [Marketplace];
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- Prefijo_NumeroParaDocumentacion_NombreDeStoreProcedure
ALTER PROCEDURE [dbo].[SP_0001_Inicio]
	@MinPrice Decimal(10, 2) = 0,
	@MaxPrice Decimal(10, 2) = 0
AS
BEGIN
	SET NOCOUNT ON;

	-- Las declaraciones se pueden hacer en cualquier parte dentro
	--	  del cuerpo del StoreProcedure.
	DECLARE @Indice INT = 1

	WHILE @Indice < 10
		BEGIN
			PRINT @Indice
			
			IF @Indice = 4
				BREAK -- Aborta el ciclo while

			IF @Indice = 5
				RETURN -- Aborta el store procedure sea el lugar donde este

			SET @Indice = @Indice + 1
		END
END
GO

Exec sp_0001_Inicio 1001, 500