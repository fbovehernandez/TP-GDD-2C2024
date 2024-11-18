-- ============================== --
--          TABLAS				  --
-- ============================== --

CREATE TABLE SARTEN_QUE_LADRA.Hechos_Pago (
	pago_id DECIMAL(18,0) PRIMARY KEY,
	localidad_cliente_id DECIMAL(18,0), --FK
	detalle_pago_cuotas DECIMAL(18,0),
	tiempo_id DECIMAL(18,0), --FK
	medio_pago_id DECIMAL(18,0), --FK
	venta_id DECIMAL(18,0), --FK
	tipo_medio_pago_id DECIMAL(18,0) --FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Medio_De_Pago (
	medio_pago_id DECIMAL(18,0) PRIMARY KEY,
	medio_pago NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago (
	tipo_medio_pago_id DECIMAL(18,0) PRIMARY KEY,
	tipo_medio_pago NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Provincia (
    provincia_id DECIMAL(18,0) PRIMARY KEY,
    provincia_nombre NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Localidad (
    localidad_id DECIMAL(18,0) PRIMARY KEY,
    provincia_id DECIMAL(18,0),
    localidad_nombre NVARCHAR(50),
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Tiempo (
    tiempo_id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
    anio DECIMAL(18,0),
    mes DECIMAL(18,0),
    cuatrimestre DECIMAL(18,0),
);

-- ============================== --
--         CONSTRAINTS            --
-- ============================== --

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_localidad FOREIGN KEY (localidad_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_tiempo FOREIGN KEY (tiempo_id) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_medio_pago FOREIGN KEY (medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Medio_De_Pago;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_tipo_medio_pago FOREIGN KEY (tipo_medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago;

ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad ADD CONSTRAINT fk_bilocalidad_provincia FOREIGN KEY (provincia_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia;

-- ============================== -- 
--			FUNCTIONS	          --
-- ============================== --

GO

/*
WITH DatosEnvio AS (
  SELECT 
    SARTEN_QUE_LADRA.SELECT_TIEMPO(e.envio_fecha_hora_entrega) AS tiempo_id,
    SARTEN_QUE_LADRA.SELECT_LOCALIDAD_CLIENTE_POR_CLIENTE(l.localidad_id, @id_cliente) AS localidad_id,
    SARTEN_QUE_LADRA.SELECT_PROVINCIA_ALMACEN(p.provincia_id) AS provincia_id,
    SUM(SARTEN_QUE_LADRA.ENVIADOS_A_TIEMPO) AS enviados_a_tiempo,
    COUNT(envio_numero) AS total_envios
  -- Resto de la consulta
)
SELECT
  de.tiempo_id,
  de.localidad_id,
  p.provincia_id,
  COALESCE(de.e
nviados_a_tiempo, 100) AS enviados_a_tiempo,
  COALESCE(de.total_envios, 0) AS total_envios
FROM DatosEnvio de
RIGHT JOIN SARTEN_QUE_LADRA.Provincia p ON de.provincia_id = p.provincia_id
WHERE p.tipo_provincia = 'ALMACEN';

-----------------------------------------------------------------------------------

WITH Cliente_Localidades AS (
		SELECT COUNT(DISTINCT l.localidad_id) as cantidad, c.cliente_id, l.localidad_id
		FROM SARTEN_QUE_LADRA.Cliente c
			 JOIN SARTEN_QUE_LADRA.Usuario u ON u.usuario_id = c.usuario_id
             JOIN SARTEN_QUE_LADRA.DomicilioXUsuario dxu ON dxu.usuario_id = u.usuario_id
             JOIN SARTEN_QUE_LADRA.Domicilio d ON dxu.domicilio_id = d.domicilio_id 
             JOIN SARTEN_QUE_LADRA.Localidad l ON l.localidad_id = d.localidad_id
		WHERE c.cliente_id = @clien
te_id
		RETURN l.localidad_id		
	ELSE
		RETURN (SELECT cl.localidad_id FROM Cliente_Localidades cl)
*/

GO


-- NO RESUELVE EL PROBLEMA DE DOS O MAS LOCALIDADES POR PERSONA, PARA NINGÚN CASO. ESTÁ EN PROCESO
CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente(@cliente_id DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)
	SELECT DISTINCT @resultado = domicilio.localidad_id
	FROM SARTEN_QUE_LADRA.Domicilio domicilio JOIN SARTEN_QUE_LADRA.DomicilioXUsuario domicilioxusuario ON domicilio.domicilio_id = domicilioxusuario.domicilio_id
										JOIN SARTEN_QUE_LADRA.Cliente cliente ON domicilioxusuario.usuario_id = cliente.usuario_id
	WHERE cliente.cliente_id = @cliente_id
    RETURN @resultado
END

GO

SELECT SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente(cliente_id)
FROM SARTEN_QUE_LADRA.Cliente
WHERE cliente_id = 14071;

GO
-------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT cliente_id, domicilio.localidad_id
FROM SARTEN_QUE_LADRA.Domicilio domicilio JOIN SARTEN_QUE_LADRA.DomicilioXUsuario domicilioxusuario ON domicilio.domicilio_id = domicilioxusuario.domicilio_id
										JOIN SARTEN_QUE_LADRA.Cliente cliente ON domicilioxusuario.usuario_id = cliente.usuario_id
WHERE cliente_id = 14071;

SELECT DISTINCT cliente_id, COUNT(domicilio.localidad_id)
FROM SARTEN_QUE_LADRA.Domicilio domicilio JOIN SARTEN_QUE_LADRA.DomicilioXUsuario domicilioxusuario ON domicilio.domicilio_id = domicilioxusuario.domicilio_id
										JOIN SARTEN_QUE_LADRA.Cliente cliente ON domicilioxusuario.usuario_id = cliente.usuario_id
GROUP BY cliente_id
HAVING COUNT(domicilio.localidad_id) > 1;


-------- vamos a ver el cliente 14071
SELECT cliente_id, usuario_id
FROM SARTEN_QUE_LADRA.Cliente
WHERE cliente_id = 14071;

SELECT usuario_id, domicilio_id
FROM SARTEN_QUE_LADRA.DomicilioXUsuario
WHERE usuario_id = 14058;

SELECT domicilio_id, localidad_id
FROM SARTEN_QUE_LADRA.Domicilio
WHERE domicilio_id = 14632 OR domicilio_id = 18991; --localidades 4256 y 4157

-------------------------------------------------------------------------------------------------

GO

CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Tiempo(@fecha DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)
    SELECT @resultado = tiempo_id
    FROM SARTEN_QUE_LADRA.BI_TIEMPO t
    WHERE t.anio=YEAR(@fecha) AND t.mes=MONTH(@fecha) AND t.cuatrimestre=
CASE WHEN MONTH(@fecha) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(@fecha) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(@fecha) BETWEEN 9 AND 12 THEN 3 END
    RETURN @resultado
END

-- ============================== -- 
--      STORED PROCEDURES         --
-- ============================== --

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Localidad
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_Localidad
        (localidad_id, provincia_id, localidad_nombre)
    SELECT DISTINCT localidad_id, provincia_id, localidad_nombre FROM SARTEN_QUE_LADRA.Localidad
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Provincia
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_Provincia
        (provincia_id, provincia_nombre)
    SELECT DISTINCT provincia_id, provincia_nombre FROM SARTEN_QUE_LADRA.Provincia
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Tiempo
AS
BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_Tiempo
        (anio, mes, cuatrimestre)
    (SELECT DISTINCT YEAR(venta_fecha), MONTH(venta_fecha),
        CASE WHEN MONTH(venta_fecha) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(venta_fecha) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(venta_fecha) BETWEEN 9 AND 12 THEN 3 END
    FROM SARTEN_QUE_LADRA.Venta
    UNION
    SELECT DISTINCT YEAR(envio_fecha_hora_entrega), MONTH(envio_fecha_hora_entrega),
        CASE WHEN MONTH(envio_fecha_hora_entrega) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(envio_fecha_hora_entrega) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(envio_fecha_hora_entrega) BETWEEN 9 AND 12 THEN 3 END
    FROM SARTEN_QUE_LADRA.Envio
    UNION 
    SELECT DISTINCT YEAR(pago_fecha), MONTH(pago_fecha),
        CASE WHEN MONTH(pago_fecha) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(pago_fecha) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(pago_fecha) BETWEEN 9 AND 12 THEN 3 END
    FROM SARTEN_QUE_LADRA.Pago)
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Medio_De_Pago
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_Medio_De_Pago
		(medio_pago_id, medio_pago)
	SELECT  DISTINCT id_medio_de_pago, medio_de_pago
	FROM SARTEN_QUE_LADRA.MedioPago;
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Tipo_Medio_De_Pago
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago
		(tipo_medio_pago_id, tipo_medio_pago)
	SELECT  DISTINCT id_medio_pago, tipo_medio_pago
	FROM SARTEN_QUE_LADRA.TipoMedioPago;
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Pago
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Hechos_Pago
		(pago_id,
		localidad_cliente_id,
		detalle_pago_cuotas,
		tiempo_id,
		medio_pago_id,
		venta_id,
		tipo_medio_pago_id)
	SELECT DISTINCT pago.id_pago, SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente(venta.cliente_id), detallepago.detalle_pago_cuotas, SARTEN_QUE_LADRA.BI_Select_Tiempo(pago.pago_fecha), medioxpago.id_medio_de_pago, pago.venta_codigo, tipomediopago.id_medio_pago
	FROM SARTEN_QUE_LADRA.Pago pago JOIN SARTEN_QUE_LADRA.Venta venta ON pago.venta_codigo = venta.venta_codigo
									JOIN SARTEN_QUE_LADRA.MedioXPago medioxpago ON pago.id_pago = medioxpago.id_pago
									JOIN SARTEN_QUE_LADRA.DetallePago detallepago ON medioxpago.id_detalle_pago = detallepago.detalle_pago_id
									JOIN SARTEN_QUE_LADRA.MedioPago mediopago ON medioxpago.id_medio_de_pago = mediopago.id_medio_de_pago
									JOIN SARTEN_QUE_LADRA.TipoMedioPago tipomediopago ON mediopago.tipo_medio_pago = tipomediopago.id_medio_pago
END

-- ============================== -- 
--				EXEC	          --
-- ============================== --

EXEC SARTEN_QUE_LADRA.BI_Migrar_Provincia;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Localidad;

-- ============================== -- 
--				VIEWS	          --
-- ============================== --