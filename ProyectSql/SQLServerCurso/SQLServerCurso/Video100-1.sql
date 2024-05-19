-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
--Off si identifico si los datos que voy a procesar tienen 
--	  valor de null, lo voy a tener que poner en Off
SET ANSI_NULLS ON 
GO
-- QUOTED_IDENTIFIER ON.- Lo que nos permite es utilizar como nombre
--	  de objetos, nombre de tablas, campo y demas parabras reservadas
--	  mientras este encerrado entre comillas.
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- Prefijo_NumeroParaDocumentacion_NombreDeStoreProcedure
CREATE PROCEDURE SP_0001_Inicio
	-- Add the parameters for the stored procedure here
	@MinPrice Decimal(10, 2) = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON; .- Para que se entienda mejor, cuando nosotros hacemos 
	--	  un insert o update dise cuantas filas afectadas, entonces eso
	--	  podemos eliminarlo con esta instruccion para que la consola no se llene
	--	  de esos mensajes.
	SET NOCOUNT ON;

    SELECT * FROM Products WHERE Price>=@MinPrice;
END
GO
