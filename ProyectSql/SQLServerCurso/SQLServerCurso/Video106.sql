USE Marketplace;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE SP_0004_ApplyDiscount
	@DiscountAbove100 DECIMAL(4, 2),
	@DiscountBetween50And100 DECIMAL(4, 2),
	@DiscountBelow50 DECIMAL(4, 2)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @ProductId DECIMAL(10,2);
		DECLARE @CurrentPrice DECIMAL(10,2);
		DECLARE @Stock INT;
		DECLARE @NewPrice DECIMAL(10,2);

		DECLARE ProductCursor CURSOR FOR
			SELECT ProductID, Price, Stock FROM Products;

		OPEN ProductCursor;

		FETCH NEXT FROM ProductCursor INTO @ProductId, @CurrentPrice, @Stock;

		WHILE @@FETCH_STATUS = 0
			BEGIN
				IF  @Stock > 100
					SET @NewPrice = @CurrentPrice * (1 - (@DiscountAbove100 / 100))
				ELSE IF @Stock BETWEEN 50 AND 100
					SET @NewPrice = @CurrentPrice * (1 - (@DiscountBetween50And100 / 100))
				ELSE 
					SET @NewPrice = @CurrentPrice * (1 - (@DiscountBelow50 / 100))

				UPDATE Products SET Price = @NewPrice WHERE ProductID = @ProductId

				FETCH NEXT FROM ProductCursor INTO @ProductId, @CurrentPrice, @Stock
			END

		CLOSE ProductCursor
		DEALLOCATE ProductCursor
		
		PRINT('Ejecucion Realizado con Exito')
	END TRY
	BEGIN CATCH
		PRINT('Ha ocurrido un error durante la actualizacion')
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()

		PRINT 'Cursor Status: ' + CAST(CURSOR_STATUS('global', 'ProductCursor') 
			AS NVARCHAR(50));
		IF CURSOR_STATUS('global', 'ProductCursor') >= 0
		BEGIN
			PRINT('El cursor no fue cerrado debido al error')
			PRINT('Se procedera a cerrar el Cursor, de lo contrario 
				si intentamos correr el StoreProcedure nos marcara un error
				diciendo que ya existe el Cursor')
			CLOSE ProductCursor
			DEALLOCATE ProductCursor
		END
		
	END CATCH
END
GO

-- select * from Products;
EXEC SP_0004_ApplyDiscount 20, 15, 10