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

	DECLARE @Color VARCHAR(10) = ''
	DECLARE @ColorId INT = 1

	-- Sentencia CASE
	set @Color = (
		CASE WHEN @ColorId = 1 THEN 'Rojo'
			WHEN @ColorId = 2 THEN 'Verde'
			WHEN @ColorId = 3 THEN 'Azul'
		END)

	PRINT @Color
END
GO


Exec sp_0001_Inicio 