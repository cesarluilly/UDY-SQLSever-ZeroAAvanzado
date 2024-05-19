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
ALTER PROCEDURE SP_0002_Cursor
AS
BEGIN
	SET NOCOUNT ON;
	-- Declaramos una variables
	DECLARE @ProductId INT 
	DECLARE @Price DECIMAL(10, 2)
	DECLARE @NewPrice DECIMAL(10, 2)

	-- Declaramos el Cursor, los campos del cursor se pueden dejar en memoria para
	--	  dale mantenimiento
	DECLARE ProductCursor CURSOR FOR 
		SELECT ProductId, Price FROM Products;

	-- Cuando abrimos el cursor, ejecuta la la consulta y graba sus resultados
	--	  en ese espacio de memoria del cursor llamado "ProductCursor", 
	--Es como crear una tabla en memoria y se va a crear para poder manipularlo.
	-- Nota. En este funto es donde se va a ejecutar la sentencia "elect"
	OPEN ProductCursor

	-- Para poder recorrer esa tabla en memoria utlizamos FETCH
	-- Con FETCH NEXT lo que decimos es posicionate en el proximo y los valores
	--	  grabalos en las variables declaradas anteriormente
	-- Por lo tanto aqui nos posicionamos en el primer registro
	-- Esta instruccion afecta directamente a la variable @@FETCH_STATUS 
	-- Aqui lo que hacemos es tratar de posicionanos en el primer registro
	FETCH NEXT FROM ProductCursor INTO @ProductId, @Price
	
	--	Utilizamos una variable de sistema y lo que me esta diciendo es el status
	--	  del cursor que yo tengo abierto en memoria.
	-- Esto es muy util para saber que sucedio al final del registro o tambien
	--	  es para saber si estoy posicionado en un registro que no tiene absolutamente nada
	-- @@FETCH_STATUS = 0 Significa que todavia no eh llegado al final de sus registros
	--	  de la consulta.
	WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Aqui ponemos todas las intrucciones que quieramos procesar se ponen aqui adentro.
			IF @Price > 100
				SET @NewPrice = @Price + 100
			ELSE 
				SET @NewPrice = @Price

			-- Ahora para avanzar al siguiente registro, entonces esta instruccion afecta
			--	  directamente a la variable @@FETCH_STATUS 
			FETCH NEXT FROM ProductCursor INTO @ProductId, @Price

		END	  

	-- Importante cerrar el cursor, nota. El hecho de cerrar un cursor no lo quita de la memoria
	CLOSE ProductCursor;

	-- Necesitamos desalojar la memoria para tener los recursos optimos
	DEALLOCATE ProductCursor
END
GO

Exec sp_0002_Cursor