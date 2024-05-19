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
ALTER PROCEDURE SP_0001_Inicio
	@MinPrice Decimal(10, 2) = 0,
	@MaxPrice Decimal(10, 2) = 0
AS
BEGIN
	SET NOCOUNT ON;
	-- Declaracion de variables y se puede inicializar
	DECLARE @MinSellerId Int = 1

	-- Declaracion de variable sin inicializacion
	DECLARE @MaxSellerId Int

	-- Asignacion de valor a una variable
	SET	@MaxSellerId = 1000
	SET @MinSellerId = 2

    SELECT * FROM Products 
	WHERE 
		Price BETWEEN @MinPrice AND @MaxPrice AND 
		SellerID BETWEEN @MinSellerId AND @MaxSellerId
END
GO
