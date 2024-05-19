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
ALTER PROCEDURE SP_0003_ManejoErrores
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRY

		THROW 51000, 'Hubo un error calculando el Precio', 1 

	END TRY
	BEGIN CATCH

		PRINT 'Numero de error: ' + CAST(ERROR_NUMBER() AS VARCHAR(50))
		
	END CATCH


END
GO

Exec SP_0003_ManejoErrores