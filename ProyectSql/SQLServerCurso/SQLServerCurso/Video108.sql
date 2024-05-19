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
ALTER PROCEDURE SP_0006_ObtenerVentaDeCadaVendedor
	@MontoMinimo DECIMAL(10, 2)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SellerId INT, @TotalVentas DECIMAL(10, 2)
		
	BEGIN TRY
		DECLARE VendedoresCursor CURSOR FOR 
		-- Si no tuvieramos que utilizar Cursor, se puede realizar con 
		--	  Having, pero como lo vamos a realizar con Cursores, 
		--	  no necesitamos de Having ya que lo vamos a hacer por cursor.
			SELECT 
				Prod.SellerID, SUM(SalDet.Price * SalDet.Quantity) AS TotalSales
			FROM 
				SaleDetails SalDet
			JOIN 
				Products Prod
			ON 
				Prod.ProductID = SalDet.ProductID
			GROUP BY 
				Prod.SellerID;

		OPEN VendedoresCursor;

		FETCH NEXT FROM VendedoresCursor INTO @SellerId, @TotalVentas

		WHILE @@FETCH_STATUS = 0
			BEGIN
				IF @TotalVentas > @MontoMinimo
					BEGIN
						PRINT 'Vendedor ID : ' + CAST(@SellerId AS VARCHAR(10)) + 
							'- Su total de ventas este mes es : ' + CAST(@TotalVentas AS VARCHAR(20))
					END

				FETCH NEXT FROM VendedoresCursor INTO @SellerId, @TotalVentas
			END

			CLOSE VendedoresCursor
			DEALLOCATE VendedoresCursor
	END TRY
	BEGIN CATCH
		PRINT('Ha ocurrido un error durante la actualizacion')
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()

		IF CURSOR_STATUS('global', 'SaleDetailsCursor') >= 0
		BEGIN
			CLOSE VendedoresCursor
			DEALLOCATE VendedoresCursor
		END
	END CATCH
END
GO

EXEC SP_0006_ObtenerVentaDeCadaVendedor 41850