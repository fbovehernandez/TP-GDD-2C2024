USE GD2C2024
GO

DROP TABLE SARTEN_QUE_LADRA.BI_Tiempo
DROP TABLE SARTEN_QUE_LADRA.BI_Tipo_envio
DROP TABLE SARTEN_QUE_LADRA.BI_Provincia
DROP TABLE SARTEN_QUE_LADRA.BI_Localidad
DROP TABLE SARTEN_QUE_LADRA.BI_Hechos_envio

ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO DROP CONSTRAINT FK_BI_HechosEnvio_LocCliente;
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO DROP CONSTRAINT FK_BI_HechosEnvio_ProvinciaAlmacen;
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO DROP CONSTRAINT FK_BI_HechosEnvio_Tiempo;
ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad DROP CONSTRAINT FK_BI_Localidad_Provincia;

CREATE TABLE SARTEN_QUE_LADRA.BI_Tiempo (
	tiempo_id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	mes DECIMAL(2,0),
	cuatrimestre DECIMAL(1,0),
	anio DECIMAL(4,0)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Tipo_envio (
	envio_id DECIMAL(18,0) PRIMARY KEY,
	envio_nombre NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Provincia (
	id DECIMAL(18,0) PRIMARY KEY,
	provincia_nombre NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.BI_Localidad (
	localidad_id DECIMAL(18,0) PRIMARY KEY,
	provincia_id DECIMAL(18,0),
	localidad_nombre NVARCHAR(50),
);

CREATE TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO (
	id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	tiempo_id DECIMAL(18,0),
	provincia_almacen_id DECIMAL(18,0),
	loc_cliente_id DECIMAL(18,0),
	enviados_a_tiempo DECIMAL(18,0),
	costo_envios DECIMAL(18,0),
	total_enviados DECIMAL(18,0)
);

ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad ADD CONSTRAINT FK_BI_Localidad_Provincia FOREIGN KEY (provincia_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia(id);
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO ADD CONSTRAINT FK_BI_HechosEnvio_LocCliente FOREIGN KEY (loc_cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad(localidad_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO ADD CONSTRAINT FK_BI_HechosEnvio_ProvinciaAlmacen FOREIGN KEY (provincia_almacen_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia(id);
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO ADD CONSTRAINT FK_BI_HechosEnvio_Tiempo FOREIGN KEY (tiempo_id) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo(tiempo_id);

-- MIGRACIONES --

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_LOCALIDAD
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.BI_LOCALIDAD
		(localidad_id, provincia_id, localidad_nombre)
	SELECT DISTINCT localidad_id, provincia_id, localidad_nombre FROM SARTEN_QUE_LADRA.Localidad
END

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_PROVINCIA 
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.BI_PROVINCIA
		(id, provincia_nombre)
	SELECT DISTINCT provincia_id, provincia_nombre FROM SARTEN_QUE_LADRA.Provincia
END

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_ENVIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.BI_TIPO_ENVIO
		(envio_id, envio_nombre)
	SELECT DISTINCT tipo_envio_id, envio_nombre FROM SARTEN_QUE_LADRA.TipoEnvio
END

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_TIEMPO
AS
BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_TIEMPO
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
	-- ORDER BY YEAR(venta_fecha), incluye todas las fechas...
END

GO
CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen(@almacen_id DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @id DECIMAL(18,0)
    SELECT DISTINCT @id = pr.id FROM SARTEN_QUE_LADRA.BI_Provincia pr
    WHERE pr.id = (SELECT p.provincia_id FROM SARTEN_QUE_LADRA.Provincia p
        JOIN SARTEN_QUE_LADRA.Localidad l ON l.provincia_id = p.provincia_id
        JOIN SARTEN_QUE_LADRA.Almacen a ON l.localidad_id = a.localidad_id
        WHERE @almacen_id = a.almacen_codigo)
    RETURN @id
END

-- > 

DROP PROCEDURE SARTEN_QUE_LADRA.MIGRAR_HECHOS_ENVIO

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_HECHOS_ENVIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.BI_HECHOS_ENVIO (
		tiempo_id, provincia_almacen_id, loc_cliente_id, enviados_a_tiempo, costo_envios, total_enviados)
	SELECT SARTEN_QUE_LADRA.BI_Select_Tiempo(e.envio_fecha_hora_entrega),
		   SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen(am.almacen_codigo),
		   SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(c.cliente_id, e.envio_numero),
		   SUM(SARTEN_QUE_LADRA.ENVIADOS_A_TIEMPO(e.envio_horario_inicio, e.envio_horario_fin, e.envio_fecha_programada, e.envio_fecha_hora_entrega)),
		   SUM(e.envio_costo),
		   COUNT(e.envio_numero)
	FROM SARTEN_QUE_LADRA.Envio e
		JOIN SARTEN_QUE_LADRA.Venta v ON v.venta_codigo = e.venta_codigo
		JOIN SARTEN_QUE_LADRA.Cliente c ON c.cliente_id = v.cliente_id
		JOIN SARTEN_QUE_LADRA.DetalleVenta dv ON dv.venta_codigo = v.venta_codigo
		JOIN SARTEN_QUE_LADRA.Publicacion p ON p.publicacion_codigo = dv.publicacion_codigo
		JOIN SARTEN_QUE_LADRA.Almacen am ON am.almacen_codigo = p.almacen_codigo
		GROUP BY SARTEN_QUE_LADRA.BI_Select_Tiempo(e.envio_fecha_hora_entrega),
				 SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(c.cliente_id, e.envio_numero),
				 SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen(am.almacen_codigo)
END

EXEC SARTEN_QUE_LADRA.MIGRAR_HECHOS_ENVIO

CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Tiempo(@fecha DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @id DECIMAL(18,0)
    SELECT @id = tiempo_id
    FROM SARTEN_QUE_LADRA.BI_Tiempo t
    WHERE t.anio=YEAR(@fecha) AND t.mes=MONTH(@fecha) AND t.cuatrimestre=
		CASE WHEN MONTH(@fecha) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(@fecha) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(@fecha) BETWEEN 9 AND 12 THEN 3 END
    RETURN @id
END

SELECT * FROM SARTEN_QUE_LADRA.Envio

GO
CREATE FUNCTION SARTEN_QUE_LADRA.ENVIADOS_A_TIEMPO(@hora_inicio DECIMAL(18,0), @hora_fin DECIMAL(18,0), @fecha_programada DATETIME, @fecha_entrega DATETIME)
RETURNS INT
AS BEGIN
    DECLARE @a_tiempo INT
    IF CAST(@fecha_programada AS DATE) = CAST(@fecha_entrega AS DATE)
		BEGIN
			DECLARE @hora_entrega DECIMAL(18,0);
			SET @hora_entrega = DATEPART(HOUR, @fecha_entrega);
			IF @hora_entrega BETWEEN @hora_inicio AND @hora_fin
				SET @a_tiempo = 1;
			ELSE 
				SET @a_tiempo = 0; 
		END;
    ELSE
		SET @a_tiempo = 0;
	RETURN @a_tiempo;
END

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


SELECT * FROM SARTEN_QUE_LADRA.BI_HECHOS_ENVIO

-- CALCULO DE LAS VIEWS

/* 7. Porcentaje de cumplimiento de envíos en los tiempos programados por
provincia (del almacén) por año/mes (desvío). Se calcula teniendo en cuenta los
envíos cumplidos sobre el total de envíos para el período. */

GO
CREATE VIEW SARTEN_QUE_LADRA.PORCENTAJE_ENVIOS_A_TIEMPO
AS
    SELECT SUM(e.enviados_a_tiempo) * 100 / SUM(e.total_enviados) AS 'Porcentaje de cumplimiento', 
			t.mes AS 'Mes', t.anio AS 'Año', e.provincia_almacen_id 'Provincia Almacen'
    FROM SARTEN_QUE_LADRA.BI_HECHOS_ENVIO e
    JOIN SARTEN_QUE_LADRA.BI_TIEMPO t ON e.tiempo_id = t.tiempo_id
	JOIN SARTEN_QUE_LADRA.BI_Provincia p ON p.id = e.provincia_almacen_id
    GROUP BY t.mes, t.anio, e.provincia_almacen_id

SELECT * FROM SARTEN_QUE_LADRA.PORCENTAJE_ENVIOS_A_TIEMPO

/* 8. Localidades que pagan mayor costo de envío. Las 5 localidades (tomando la
localidad del cliente) con mayor costo de envío. */
GO
CREATE VIEW SARTEN_QUE_LADRA.LOCALIDADES_MAS_PAGAS
AS
	SELECT TOP 5 e.loc_cliente_id, SUM(e.costo_envios) AS 'Costos de envio' 
	FROM SARTEN_QUE_LADRA.BI_HECHOS_ENVIO e
	JOIN SARTEN_QUE_LADRA.BI_Localidad l ON e.loc_cliente_id = l.localidad_id
	GROUP BY e.loc_cliente_id
	ORDER BY SUM(e.costo_envios) DESC

SELECT * FROM SARTEN_QUE_LADRA.LOCALIDADES_MAS_PAGAS



/* ------------------------------------- VIEWS 9 Y 10 ------------------------------------------ */

/* 9. Porcentaje de facturación por concepto para cada mes de cada año. Se calcula
en función del total del concepto sobre el total del período.

10. Facturación por provincia. Monto facturado según la provincia del vendedor
para cada cuatrimestre de cada año
*/bv

ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA DROP CONSTRAINT FK_BI_HECHOS_FACTURA_PROVINCIA;
DROP TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA
DROP PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Hechos_Factura

CREATE TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA (
	factura_id DECIMAL(18,0) PRIMARY KEY IDENTITY (1,1),
	tiempo_id DECIMAL(18,0),
	id_concepto DECIMAL(18,0), -- FK
	total_facturado DECIMAL(18,0),
	provincia_vendedor_id DECIMAL(18,0),
)

SELECT * FROM SARTEN_QUE_LADRA.DetalleFactura
SELECT * FROM SARTEN_QUE_LADRA.Concepto

ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA ADD CONSTRAINT FK_BI_HECHOS_FACTURA_PROVINCIA FOREIGN KEY (provincia_vendedor_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia(id);

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Hechos_Factura
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_HECHOS_FACTURA (
		tiempo_id, id_concepto, total_facturado, provincia_vendedor_id)
    SELECT DISTINCT  
		SARTEN_QUE_LADRA.BI_Select_Tiempo(f.factura_fecha), 
		df.detalle_concepto_id,
		SUM(df.detalle_factura_subtotal),
		SARTEN_QUE_LADRA.BI_Select_Provincia_Vendedor(f.vendedor_id)
	FROM SARTEN_QUE_LADRA.DetalleFactura df 
	JOIN SARTEN_QUE_LADRA.Factura f ON df.factura_numero = f.factura_numero
	JOIN SARTEN_QUE_LADRA.Concepto cf ON cf.detalle_concepto_id = df.detalle_concepto_id
	GROUP BY  SARTEN_QUE_LADRA.BI_Select_Tiempo(f.factura_fecha),
			  SARTEN_QUE_LADRA.BI_Select_Provincia_Vendedor(f.vendedor_id),
			  df.detalle_concepto_id
END

/* PODRIA HACER ESTO PARA TODOS LOS CASOS, PERO PARECERIA QUE DA BIEN! 
/* 13	3	483338.02	12 */

SELECT * FROM SARTEN_QUE_LADRA.BI_Provincia p WHERE p.id = 12
SELECT * FROM SARTEN_QUE_LADRA.BI_Tiempo t WHERE t.tiempo_id = 13 -- ENERO 2026

SELECT f.factura_numero, p.provincia_nombre, f.factura_fecha, f.factura_total, df.detalle_factura_id, df.detalle_concepto_id, 
		df.detalle_factura_subtotal
FROM SARTEN_QUE_LADRA.Factura f 
JOIN SARTEN_QUE_LADRA.DetalleFactura df ON f.factura_numero = df.factura_numero
JOIN SARTEN_QUE_LADRA.Vendedor v ON v.vendedor_id = f.vendedor_id
JOIN SARTEN_QUE_LADRA.DomicilioXUsuario dxu ON v.usuario_id = dxu.usuario_id 
JOIN SARTEN_QUE_LADRA.Domicilio d ON dxu.domicilio_id = d.domicilio_id
JOIN SARTEN_QUE_LADRA.Localidad l ON l.localidad_id = d.localidad_id
JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_id = l.provincia_id
WHERE YEAR(f.factura_fecha) = 2026 AND MONTH(f.factura_fecha) = 1 AND df.detalle_concepto_id = 3 
	AND p.provincia_id = 12
*/

SELECT * FROM SARTEN_QUE_LADRA.BI_HECHOS_FACTURA h
WHERE h.tiempo_id = 13
ORDER BY h.id_concepto

SELECT * FROM SARTEN_QUE_LADRA.DetalleFactura
SELECT * FROM SARTEN_QUE_LADRA.Concepto

/* ESTA ES OTRA MANERA DE HACER EL SELECT DE PROVINCIA SOBRE UNA ENTIDAD X */
GO
CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Provincia_Vendedor(@vendedor DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)

	SELECT DISTINCT @resultado = p.provincia_id
	FROM SARTEN_QUE_LADRA.Provincia p 
		JOIN SARTEN_QUE_LADRA.Localidad l ON l.provincia_id = p.provincia_id
		JOIN SARTEN_QUE_LADRA.Domicilio domicilio ON domicilio.localidad_id = l.localidad_id
		JOIN SARTEN_QUE_LADRA.DomicilioXUsuario domicilioxusuario ON domicilio.domicilio_id = domicilioxusuario.domicilio_id
		JOIN SARTEN_QUE_LADRA.Vendedor v ON domicilioxusuario.usuario_id = v.usuario_id
	WHERE v.vendedor_id = @vendedor
    RETURN @resultado
END

/* ----- EXEC ----- */
EXEC SARTEN_QUE_LADRA.BI_MIGRAR_PROVINCIA;
EXEC SARTEN_QUE_LADRA.BI_MIGRAR_LOCALIDAD;
EXEC SARTEN_QUE_LADRA.BI_MIGRAR_ENVIO;
EXEC SARTEN_QUE_LADRA.BI_MIGRAR_TIEMPO;
EXEC SARTEN_QUE_LADRA.MIGRAR_HECHOS_ENVIO;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Hechos_Factura

/* VIEWS FACTURACION */ 

-- VER SI LE PIFIARON AL ENUNCIADO CUANDO PONEN EL CALCULO DEL PORCENTAJE 

GO
CREATE VIEW SARTEN_QUE_LADRA.VIEW9
AS
	SELECT c.detalle_concepto_id, t.mes, t.anio, SUM(hf.total_facturado) * 100 / (SELECT SUM(hf2.total_facturado) FROM SARTEN_QUE_LADRA.BI_HECHOS_FACTURA hf2
																		WHERE hf2.id_concepto = c.detalle_concepto_id)
			AS 'Porcentaje de Facturacion'
	FROM SARTEN_QUE_LADRA.BI_HECHOS_FACTURA hf 
	JOIN SARTEN_QUE_LADRA.BI_Tiempo t ON hf.tiempo_id = t.tiempo_id
	JOIN SARTEN_QUE_LADRA.Concepto c ON c.detalle_concepto_id = hf.id_concepto -- ACA FALTA HACER LA DE BI
	GROUP BY c.detalle_concepto_id, t.mes, t.anio

SELECT * FROM SARTEN_QUE_LADRA.VIEW9


GO
CREATE VIEW SARTEN_QUE_LADRA.VIEW10
AS
	SELECT hf.provincia_vendedor_id, t.cuatrimestre, t.anio, SUM(hf.total_facturado) 
			AS 'Total Facturado'
	FROM SARTEN_QUE_LADRA.BI_HECHOS_FACTURA hf 
	JOIN SARTEN_QUE_LADRA.BI_Tiempo t ON hf.tiempo_id = t.tiempo_id
	JOIN SARTEN_QUE_LADRA.BI_Provincia p ON p.id = hf.provincia_vendedor_id
	GROUP BY hf.provincia_vendedor_id, t.cuatrimestre, t.anio

SELECT * FROM SARTEN_QUE_LADRA.VIEW10


/*** PAGOS ***/

CREATE TABLE SARTEN_QUE_LADRA.BI_Medio_De_Pago (
	medio_pago_id DECIMAL(18,0) PRIMARY KEY,
	medio_pago NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago (
	tipo_medio_pago_id DECIMAL(18,0) PRIMARY KEY,
	tipo_medio_pago NVARCHAR(50)
);

SELECT * FROM SARTEN_QUE_LADRA.Pago

CREATE TABLE SARTEN_QUE_LADRA.Hechos_Pago (
	pago_id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	localidad_cliente_id DECIMAL(18,0), --FK
	tiempo_id DECIMAL(18,0), --FK
	medio_pago_id DECIMAL(18,0), --FK
	importe_cuotas DECIMAL(18,0),
	tipo_medio_pago_id DECIMAL(18,0) --FK
);

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT FK_Hechos_Pago_Localidad_Cliente FOREIGN KEY (localidad_cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad(localidad_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT FK_Hechos_Pago_Tiempo FOREIGN KEY (tiempo_id)  REFERENCES SARTEN_QUE_LADRA.BI_Tiempo(tiempo_id)

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT FK_Hechos_Pago_Medio_De_Pago FOREIGN KEY (medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Medio_De_Pago(medio_pago_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT FK_Hechos_Pago_Tipo_Medio_De_Pago FOREIGN KEY (tipo_medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago(tipo_medio_pago_id);


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

EXEC SARTEN_QUE_LADRA.BI_Migrar_Tipo_Medio_De_Pago
EXEC SARTEN_QUE_LADRA.BI_Migrar_Medio_De_Pago
SELECT * FROM SARTEN_QUE_LADRA.BI_Medio_De_Pago
SELECT * FROM SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago

GO

DROP PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Pago

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Pago
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Hechos_Pago
		(localidad_cliente_id, tiempo_id, medio_pago_id, tipo_medio_pago_id, importe_cuotas)
	SELECT DISTINCT 
				SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(venta.cliente_id, envio.envio_numero), 
				SARTEN_QUE_LADRA.BI_Select_Tiempo(pago.pago_fecha),
				medioxpago.id_medio_de_pago, 
				tipomediopago.id_medio_pago,
				SUM(pago.pago_importe * detallepago.detalle_pago_cuotas)
	FROM SARTEN_QUE_LADRA.Pago pago JOIN SARTEN_QUE_LADRA.Venta venta ON pago.venta_codigo = venta.venta_codigo
									JOIN SARTEN_QUE_LADRA.Envio envio ON pago.venta_codigo = envio.venta_codigo
									-- 
									JOIN SARTEN_QUE_LADRA.MedioXPago medioxpago ON pago.id_pago = medioxpago.id_pago
									JOIN SARTEN_QUE_LADRA.DetallePago detallepago ON medioxpago.id_detalle_pago = detallepago.detalle_pago_id
									JOIN SARTEN_QUE_LADRA.MedioPago mediopago ON medioxpago.id_medio_de_pago = mediopago.id_medio_de_pago
									JOIN SARTEN_QUE_LADRA.TipoMedioPago tipomediopago ON mediopago.tipo_medio_pago = tipomediopago.id_medio_pago
	WHERE detallepago.detalle_pago_cuotas > 1 -- De todas formas ninguna parece ser = 1
	GROUP BY SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(venta.cliente_id, envio.envio_numero), 
			 SARTEN_QUE_LADRA.BI_Select_Tiempo(pago.pago_fecha),		
			 medioxpago.id_medio_de_pago, 
			 tipomediopago.id_medio_pago
END

SELECT * FROM SARTEN_QUE_LADRA.MedioXPago
SELECT * FROM SARTEN_QUE_LADRA.MedioPago
SELECT * FROM SARTEN_QUE_LADRA.TipoMedioPago

SELECT * FROM SARTEN_QUE_LADRA.Hechos_Pago

/* TEST VALIDACION AGRUPAMIENTO MASIVO --> CASO ID 33 */

SELECT  
				l.localidad_id,
				YEAR(pago.pago_fecha),
				MONTH(pago.pago_fecha),
				medioxpago.id_medio_de_pago, 
				tipomediopago.id_medio_pago,
				detallepago.detalle_pago_cuotas,
				pago.pago_importe
	FROM SARTEN_QUE_LADRA.Pago pago JOIN SARTEN_QUE_LADRA.Venta venta ON pago.venta_codigo = venta.venta_codigo
									JOIN SARTEN_QUE_LADRA.Envio envio ON pago.venta_codigo = envio.venta_codigo
									JOIN SARTEN_QUE_LADRA.Cliente c ON c.cliente_id = venta.cliente_id
									JOIN SARTEN_QUE_LADRA.DomicilioXUsuario dxu ON dxu.usuario_id = c.usuario_id
									JOIN SARTEN_QUE_LADRA.Domicilio dm ON dm.domicilio_id = dxu.domicilio_id
									JOIN SARTEN_QUE_LADRA.Localidad l ON l.localidad_id = dm.localidad_id
									JOIN SARTEN_QUE_LADRA.MedioXPago medioxpago ON pago.id_pago = medioxpago.id_pago
									JOIN SARTEN_QUE_LADRA.DetallePago detallepago ON medioxpago.id_detalle_pago = detallepago.detalle_pago_id
									JOIN SARTEN_QUE_LADRA.MedioPago mediopago ON medioxpago.id_medio_de_pago = mediopago.id_medio_de_pago
									JOIN SARTEN_QUE_LADRA.TipoMedioPago tipomediopago ON mediopago.tipo_medio_pago = tipomediopago.id_medio_pago
	WHERE l.localidad_id = 10243 AND YEAR(pago.pago_fecha) = 2025 AND MONTH(pago.pago_fecha) = 1 AND medioxpago.id_medio_de_pago = 1 AND tipomediopago.id_medio_pago = 1

/* Diferentes filas que cuando se agrupan en la de hechos lo hacen como una sola...
		10243	2025	1	1	1	12310.91
		10243	2025	1	1	1	17047.98
		10243	2025	1	1	1	7902.67
*/ 

/* PARA SELECCION DE TIEMPOS ID */
SELECT tiempo_id, mes, anio FROM SARTEN_QUE_LADRA.BI_Tiempo

/* 6. Pago en Cuotas. Las 3 localidades con el mayor importe de pagos en cuotas,
según el medio de pago, mes y año. Se calcula sumando los importes totales de
todas las ventas en cuotas. Se toma la localidad del cliente (Si tiene más de una
dirección se toma a la que seleccionó el envío) */

GO
CREATE VIEW SARTEN_QUE_LADRA.VIEW6ajdsdsaj

AS
	SELECT TOP 3 hp.localidad_cliente_id, t.mes, t.anio, mdp.medio_pago, SUM(hp.importe_cuotas) 
			AS 'Importe por cuotas'
	FROM SARTEN_QUE_LADRA.Hechos_Pago hp 
		JOIN SARTEN_QUE_LADRA.BI_Tiempo t ON hp.tiempo_id = t.tiempo_id
		JOIN SARTEN_QUE_LADRA.BI_Localidad l ON hp.localidad_cliente_id = l.localidad_id
		JOIN SARTEN_QUE_LADRA.BI_Medio_De_Pago mdp ON mdp.medio_pago_id = hp.medio_pago_id
	GROUP BY hp.localidad_cliente_id, t.mes, t.anio, mdp.medio_pago
	ORDER BY SUM(hp.importe_cuotas) DESC

SELECT * from SARTEN_QUE_LADRA.MedioPago
SELECT * FROM SARTEN_QUE_LADRA.VIEW6

-- TENGO QUE RE-PROBAR TODO ESTO POR EL TEMA DE LAS CUOTAS.

/***** VENTAS *****/
