USE Marketplace;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cesar
-- Create date: <Create Date,,>
-- Description:	
-- =============================================
-- Prefijo_NumeroParaDocumentacion_NombreDeStoreProcedure
-- "CREATE" y despues se cambia a "ALTER" en caso de querer modificarlo
ALTER PROCEDURE SP_0007_Transacciones
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @NewSaleId INT
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Sales (CustomerID, SaleDate, Total) VALUES(1, GETDATE(), 1000)

			SET @NewSaleId = SCOPE_IDENTITY()

			INSERT INTO SaleDetails(SaleId, ProductId, Quantity, Price) VALUES(@NewSaleId, 1, 4, 15.30)
			INSERT INTO SaleDetails(SaleId, ProductId, Quantity, Price) VALUES(@NewSaleId, 'AProposito', 6, 24.50)

			UPDATE Products SET Stock = Stock - 4 WHERE ProductID = 1
			UPDATE Products SET Stock = Stock - 6 WHERE ProductID = 2

		SELECT 'Datos ingresados con Exito', COUNT(*) AS TotalSales FROM Sales;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SELECT 'Ah ocurrido un error, se ejecutara RollBack' AS Mensaje_Personalizado, COUNT(*) AS TotalSales FROM Sales;
		ROLLBACK TRANSACTION
		SELECT ERROR_MESSAGE() AS Mensaje_Error
	END CATCH
END
GO

-- SELECT COUNT(*) FROM Sales;
EXEC SP_0007_Transacciones