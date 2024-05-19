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
-- "CREATE" y despues se cambia a "ALTER" en caso de querer modificarlo
ALTER PROCEDURE [dbo].[SP_0001_Inicio]
	@MinPrice Decimal(10, 2) = 0,
	@MaxPrice Decimal(10, 2) = 0
AS
BEGIN
	SET NOCOUNT ON;

	-- Imprimir en consola, es muy utilizar cuando yo necesito depurar
	--	  en casos cuando no esta haciendo lo que yo necesito.
	PRINT @MinPrice
	PRINT @MaxPrice
	
	-- **IF sin bloque**
	IF @MinPrice > 1000
		PRINT 'IF de una sola linea. Es mayor a 1000'
		PRINT 'Print fuera del If, la identacion no cuenta'
	
	-- **IF con bloque**, ES BUENA PRACTICA SIEMPRE PONER EL BEGIN-END
	IF @MinPrice > 1000
		BEGIN
			PRINT 'MinPrice es mayor a 1000'
		END
	ELSE
		BEGIN
			PRINT 'MinPrice NO es mayor a 1000'
		END

	-- **IF EXISTS**
	IF EXISTS(SELECT * FROM Products WHERE Price = 100)
		PRINT 'Hay productos con precio de 100'
	ELSE
		PRINT 'NO hay productos con precio de 100'

END
GO

Exec sp_0001_Inicio 1001, 500