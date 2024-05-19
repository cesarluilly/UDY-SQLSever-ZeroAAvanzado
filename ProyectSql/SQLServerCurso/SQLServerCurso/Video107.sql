USE Marketplace;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cesar
-- Create date: <Create Date,,>
-- Description:	Store procedure que en base a una venta que ya esta registrado(SellerId), 
--	  vamos a descontar del Stock del producto que ya tenemos.
-- =============================================
-- Prefijo_NumeroParaDocumentacion_NombreDeStoreProcedure
-- "CREATE" y despues se cambia a "ALTER" en caso de querer modificarlo
ALTER PROCEDURE SP_0005_ActualizarStockPorVenta
	@SellerId Int
AS
BEGIN
	SET NOCOUNT ON;
		
	BEGIN TRY
		DECLARE @ProductId INT
		DECLARE @Quantity INT

		DECLARE SaleDetailsCursor CURSOR FOR 
			SELECT ProductID, Quantity 
			FROM SaleDetails 
			WHERE SaleID = @SellerId;

		OPEN SaleDetailsCursor

		FETCH NEXT FROM SaleDetailsCursor INTO @ProductId, @Quantity

		WHILE @@FETCH_STATUS = 0
			BEGIN
				UPDATE Products SET Stock = Stock - @Quantity WHERE ProductID = @ProductId

				-- NOTA.- Es muy importante poner el FETCH NEXT FROM dentro del while, 
				--	  de lo contrario solo se estaria ciclando haciendo la misma operacion siempre.
				FETCH NEXT FROM SaleDetailsCursor INTO @ProductId, @Quantity
			END

		CLOSE SaleDetailsCursor
		DEALLOCATE SaleDetailsCursor
	END TRY
	BEGIN CATCH
		PRINT('Ha ocurrido un error durante la actualizacion')
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()

		IF CURSOR_STATUS('global', 'SaleDetailsCursor') >= 0
		BEGIN
			CLOSE SaleDetailsCursor
			DEALLOCATE SaleDetailsCursor
		END
	END CATCH
END
GO

EXEC SP_0005_ActualizarStockPorVenta 40