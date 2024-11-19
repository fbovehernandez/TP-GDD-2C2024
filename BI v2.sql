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

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_localidad FOREIGN KEY (localidad_cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_tiempo FOREIGN KEY (tiempo_id) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_medio_pago FOREIGN KEY (medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Medio_De_Pago;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_tipo_medio_pago FOREIGN KEY (tipo_medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago;

ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad ADD CONSTRAINT fk_bilocalidad_provincia FOREIGN KEY (provincia_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia;

-- ============================== -- 
--			FUNCTIONS	          --
-- ============================== --

GO

CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(@cliente_id DECIMAL(18,0), @envio_id DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)

	IF SARTEN_QUE_LADRA.BI_Cantidad_De_Domicilios(@cliente_id) = 1
		SET @resultado = SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente(@cliente_id)
	ELSE
		SELECT @resultado = localidad_id
		FROM SARTEN_QUE_LADRA.Envio envio JOIN SARTEN_QUE_LADRA.Domicilio domicilio ON envio.envio_domicilio = domicilio.domicilio_id
		WHERE envio.envio_numero = @envio_id

    RETURN @resultado
END

GO

CREATE FUNCTION SARTEN_QUE_LADRA.BI_Cantidad_De_Domicilios (@cliente_id DECIMAL(18,0))
RETURNS BIGINT
AS BEGIN
	DECLARE @resultado BIGINT

	SELECT @resultado = COUNT(DISTINCT domicilio.localidad_id) 
	FROM SARTEN_QUE_LADRA.Domicilio domicilio JOIN SARTEN_QUE_LADRA.DomicilioXUsuario domicilioxusuario ON domicilio.domicilio_id = domicilioxusuario.domicilio_id
										JOIN SARTEN_QUE_LADRA.Cliente cliente ON domicilioxusuario.usuario_id = cliente.usuario_id
	WHERE cliente.cliente_id = @cliente_id
	GROUP BY cliente.cliente_id

	RETURN @resultado
END

GO

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

CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Tiempo(@fecha DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)
    SELECT @resultado = tiempo_id
    FROM SARTEN_QUE_LADRA.BI_Tiempo t
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
	SELECT DISTINCT pago.id_pago, SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(venta.cliente_id, envio.envio_numero), detallepago.detalle_pago_cuotas, SARTEN_QUE_LADRA.BI_Select_Tiempo(pago.pago_fecha), medioxpago.id_medio_de_pago, pago.venta_codigo, tipomediopago.id_medio_pago
	FROM SARTEN_QUE_LADRA.Pago pago JOIN SARTEN_QUE_LADRA.Venta venta ON pago.venta_codigo = venta.venta_codigo
									JOIN SARTEN_QUE_LADRA.MedioXPago medioxpago ON pago.id_pago = medioxpago.id_pago
									JOIN SARTEN_QUE_LADRA.DetallePago detallepago ON medioxpago.id_detalle_pago = detallepago.detalle_pago_id
									JOIN SARTEN_QUE_LADRA.MedioPago mediopago ON medioxpago.id_medio_de_pago = mediopago.id_medio_de_pago
									JOIN SARTEN_QUE_LADRA.TipoMedioPago tipomediopago ON mediopago.tipo_medio_pago = tipomediopago.id_medio_pago
									JOIN SARTEN_QUE_LADRA.Envio envio ON pago.venta_codigo = envio.venta_codigo
END

GO

-- ============================== -- 
--				EXEC	          --
-- ============================== --

EXEC SARTEN_QUE_LADRA.BI_Migrar_Tiempo;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Provincia;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Localidad;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Medio_De_Pago;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Tipo_Medio_De_Pago;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Pago;

-- ============================== -- 
--				VIEWS	          --
-- ============================== --


-- ============================== -- 
--				TESTING	          --
-- ============================== --

SELECT *
FROM SARTEN_QUE_LADRA.Envio
WHERE envio_numero = 12990; --Envio Domicilio 14632

SELECT *
FROM SARTEN_QUE_LADRA.Envio
WHERE envio_numero = 40138; --Envio Domicilio 14632

SELECT * FROM SARTEN_QUE_LADRA.Domicilio
WHERE domicilio_id = 14632;

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
HAVING COUNT(domicilio.localidad_id) = 1;


-------- vamos a ver el cliente 14071 (multiple)
SELECT cliente_id, usuario_id
FROM SARTEN_QUE_LADRA.Cliente
WHERE cliente_id = 14071;

SELECT usuario_id, domicilio_id
FROM SARTEN_QUE_LADRA.DomicilioXUsuario
WHERE usuario_id = 14058;

SELECT domicilio_id, localidad_id
FROM SARTEN_QUE_LADRA.Domicilio
WHERE domicilio_id = 14632 OR domicilio_id = 18991; --localidades 4256 y 4157

SELECT SARTEN_QUE_LADRA.BI_Cantidad_De_Domicilios(cliente_id)
FROM SARTEN_QUE_LADRA.Cliente
WHERE cliente_id = 14071;

SELECT SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente(cliente_id)
FROM SARTEN_QUE_LADRA.Cliente
WHERE cliente_id = 14071;

SELECT TOP 1 cliente_id, envio.envio_numero, SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(cliente_id, envio.envio_numero)
FROM SARTEN_QUE_LADRA.Envio envio JOIN SARTEN_QUE_LADRA.Venta venta ON envio.venta_codigo = venta.venta_codigo
WHERE cliente_id = 14071; --16359

-------- vamos a ver el cliente 12565 (unico)
SELECT cliente_id, usuario_id
FROM SARTEN_QUE_LADRA.Cliente
WHERE cliente_id = 12565;

SELECT usuario_id, domicilio_id
FROM SARTEN_QUE_LADRA.DomicilioXUsuario
WHERE usuario_id = 12555;

SELECT domicilio_id, localidad_id
FROM SARTEN_QUE_LADRA.Domicilio
WHERE domicilio_id = 27848;--localidad 12273

SELECT SARTEN_QUE_LADRA.BI_Cantidad_De_Domicilios(cliente_id)
FROM SARTEN_QUE_LADRA.Cliente
WHERE cliente_id = 12565;

SELECT SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente(cliente_id)
FROM SARTEN_QUE_LADRA.Cliente
WHERE cliente_id = 12565;

SELECT DISTINCT cliente_id, envio.envio_numero, SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(cliente_id, envio.envio_numero)
FROM SARTEN_QUE_LADRA.Envio envio JOIN SARTEN_QUE_LADRA.Venta venta ON envio.venta_codigo = venta.venta_codigo
WHERE cliente_id = 12565; --16359

-------------------------------------------------------------------------------------------------

SELECT * FROM SARTEN_QUE_LADRA.Hechos_Pago WHERE pago_id = 94233;
-- BI_Pago: 94233 5562 12 2 5 130857 2
SELECT * FROM SARTEN_QUE_LADRA.Pago WHERE id_pago = 94233;
SELECT * FROM SARTEN_QUE_LADRA.Venta WHERE venta_codigo = 130857; --BIEN
SELECT * FROM SARTEN_QUE_LADRA.Envio WHERE venta_codigo = 130857;
SELECT SARTEN_QUE_LADRA.BI_Cantidad_De_Domicilios(cliente_id) FROM SARTEN_QUE_LADRA.Cliente WHERE cliente_id = 22681;
SELECT SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(22681, 7392); --BIEN
SELECT * FROM SARTEN_QUE_LADRA.MedioXPago WHERE id_pago = 94233; --BIEN
SELECT * FROM SARTEN_QUE_LADRA.DetallePago WHERE detalle_pago_id = 22196; --BIEN
SELECT * FROM SARTEN_QUE_LADRA.BI_Tiempo WHERE tiempo_id = 2; --BIEN
SELECT * FROM SARTEN_QUE_LADRA.MedioPago WHERE id_medio_de_pago = 5; --BIEN
