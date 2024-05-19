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
		
		DECLARE @Valor INT = 1/0
		PRINT 'Esto no se mostrara si hay u error previo' 

	END TRY
	BEGIN CATCH

		PRINT 'Ha ocurrido un error:';

	END CATCH

END
GO

Exec SP_0003_ManejoErrores