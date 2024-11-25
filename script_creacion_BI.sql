/*** TABLAS ***/

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
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Localidad (
	localidad_id DECIMAL(18,0) PRIMARY KEY,
	provincia_id DECIMAL(18,0),
	localidad_nombre NVARCHAR(50),
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Rango_Horario (
    rango_horario_id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
    rango_horario VARCHAR(20)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Rango_Etario (
    rango_etario_id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
    rango_etario VARCHAR(20)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Subrubro (
	subrubro_id DECIMAL(18,0) PRIMARY KEY,
	subrubro_rubro NVARCHAR(50) 
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Rubro (
	rubro_id DECIMAL(18,0) PRIMARY KEY,
	rubro_descripcion VARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Hechos_Venta (
	venta_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	provincia_almacen_id DECIMAL(18,0),
	tiempo_id DECIMAL(18,0),
	rubro_id DECIMAL(18,0),
	localidad_cliente_id DECIMAL(18,0),
	rango_etario_cliente  DECIMAL(18,0),
	importe_venta DECIMAL(18,2)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO (
	id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	tiempo_id DECIMAL(18,0), -- FK
	provincia_almacen_id DECIMAL(18,0), -- FK
	loc_cliente_id DECIMAL(18,0), -- FK
	enviados_a_tiempo DECIMAL(18,0),
	costo_envios DECIMAL(18,0),
	total_enviados DECIMAL(18,0),
	tipo_envio DECIMAl(18,0) -- FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Medio_De_Pago (
	medio_pago_id DECIMAL(18,0) PRIMARY KEY,
	medio_pago NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago (
	tipo_medio_pago_id DECIMAL(18,0) PRIMARY KEY,
	tipo_medio_pago NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Hechos_Pago (
	pago_id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	localidad_cliente_id DECIMAL(18,0), --FK
	tiempo_id DECIMAL(18,0), --FK
	medio_pago_id DECIMAL(18,0), --FK
	importe_cuotas DECIMAL(18,0),
	tipo_medio_pago_id DECIMAL(18,0) --FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA (
	factura_id DECIMAL(18,0) PRIMARY KEY IDENTITY (1,1),
	tiempo_id DECIMAL(18,0), -- FK
	id_concepto DECIMAL(18,0), -- FK
	total_facturado DECIMAL(18,0),
	provincia_vendedor_id DECIMAL(18,0), -- FK
)

CREATE TABLE SARTEN_QUE_LADRA.BI_CONCEPTO (
	idx_concepto DECIMAL(18,0) PRIMARY KEY,
	concepto_desc NVARCHAR(50)
)

-- FK HECHOS PAGO
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT FK_Hechos_Pago_Localidad_Cliente FOREIGN KEY (localidad_cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad(localidad_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT FK_Hechos_Pago_Tiempo FOREIGN KEY (tiempo_id)  REFERENCES SARTEN_QUE_LADRA.BI_Tiempo(tiempo_id)
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT FK_Hechos_Pago_Medio_De_Pago FOREIGN KEY (medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Medio_De_Pago(medio_pago_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT FK_Hechos_Pago_Tipo_Medio_De_Pago FOREIGN KEY (tipo_medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago(tipo_medio_pago_id);

-- FK HECHOS ENVIOS
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO ADD CONSTRAINT FK_BI_HechosEnvio_LocCliente FOREIGN KEY (loc_cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad(localidad_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO ADD CONSTRAINT FK_BI_HechosEnvio_ProvinciaAlmacen FOREIGN KEY (provincia_almacen_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia(id);
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO ADD CONSTRAINT FK_BI_HechosEnvio_Tiempo FOREIGN KEY (tiempo_id) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo(tiempo_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO ADD CONSTRAINT FK_BI_HechosEnvio_tipo_envio FOREIGN KEY (tipo_envio) REFERENCES SARTEN_QUE_LADRA.BI_Tipo_envio(envio_id);

-- FK LOCALIDAD
ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad ADD CONSTRAINT FK_BI_Localidad_Provincia FOREIGN KEY (provincia_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia(id);

-- FK FACTURA
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA ADD CONSTRAINT FK_BI_HECHOS_FACTURA_PROVINCIA FOREIGN KEY (provincia_vendedor_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia(id);
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA ADD CONSTRAINT FK_BI_HECHOS_FACTURA_Tiempo FOREIGN KEY (tiempo_id) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo(tiempo_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA ADD CONSTRAINT FK_BI_HECHOS_FACTURA_concepto FOREIGN KEY (id_concepto) REFERENCES SARTEN_QUE_LADRA.BI_CONCEPTO(idx_concepto);

-- FK VENTA
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_provincia FOREIGN KEY (provincia_almacen_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia(id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_rango_etario FOREIGN KEY (rango_etario_cliente) REFERENCES SARTEN_QUE_LADRA.BI_Rango_Etario(rango_etario_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_tiempo FOREIGN KEY (tiempo_id) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo(tiempo_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_rubro FOREIGN KEY (rubro_id) REFERENCES SARTEN_QUE_LADRA.BI_Rubro(rubro_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_localidad FOREIGN KEY (localidad_cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad(localidad_id);

/****** FUNCIONES ******/

-- SELECCION RANGO ETARIO

GO
CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Rango_Etario(@fecha_nacimiento DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)
    DECLARE @edad INT;
    SET @edad = DATEDIFF(YEAR, @fecha_nacimiento, GETDATE());
    SELECT @resultado = rango_etario_id
    FROM SARTEN_QUE_LADRA.BI_Rango_Etario 
    WHERE rango_etario LIKE (CASE 
                            WHEN @edad < 25 THEN  '< 25'
                            WHEN @edad BETWEEN 25 AND 34 THEN  '25 - 35'
                            WHEN @edad BETWEEN 35 AND 49 THEN  '35 - 50'
                            WHEN @edad >= 50 THEN '> 50'
							END)
    RETURN @resultado
END

-- SELECCION DE LOCALIDAD SEGUN CLIENTE
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

-- SELECCION LOS QUE SE ENVIARON A TIEMPO
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

-- SELECCION TIEMPO
GO
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

-- SELECCION PROVINCIA DE ALMACEN
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

-- SELECCION PROVINCIA DE VENDEDOR (DISTINTO A LA DE ARRIBA)
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

/*** PROCEDURES ***/

GO
ALTER PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Hechos_Venta
AS BEGIN
   	WITH PreCalculados AS (
		SELECT 
			v.venta_codigo as Venta_codigo, 
			SARTEN_QUE_LADRA.BI_Select_Tiempo(v.venta_fecha) AS tiempo_id,
			SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente(v.cliente_id) AS localidad_cliente_id,
			SARTEN_QUE_LADRA.BI_Select_Rango_Etario(c.cliente_fecha_nac) AS rango_etario,
			SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen(publicacion.almacen_codigo) AS provincia_almacen_id
		FROM SARTEN_QUE_LADRA.Venta v
			JOIN SARTEN_QUE_LADRA.Cliente c ON c.cliente_id = v.cliente_id
			JOIN SARTEN_QUE_LADRA.DetalleVenta dv ON v.venta_codigo = dv.venta_codigo
			JOIN SARTEN_QUE_LADRA.Publicacion publicacion ON publicacion.publicacion_codigo = dv.publicacion_codigo
	)

	INSERT INTO SARTEN_QUE_LADRA.Hechos_Venta
		(provincia_almacen_id, rango_etario_cliente, tiempo_id, rubro_id, localidad_cliente_id, importe_venta)
	SELECT DISTINCT  
		pc.provincia_almacen_id,
		pc.rango_etario,
		pc.tiempo_id, 
		sxr.rubro_id, 
		pc.localidad_cliente_id,
		SUM(v.venta_total)
	FROM SARTEN_QUE_LADRA.Venta v
		JOIN PreCalculados pc ON pc.venta_codigo = v.venta_codigo
		JOIN SARTEN_QUE_LADRA.DetalleVenta dv ON v.venta_codigo = dv.venta_codigo
		JOIN SARTEN_QUE_LADRA.Publicacion publicacion ON publicacion.publicacion_codigo = dv.publicacion_codigo
		JOIN SARTEN_QUE_LADRA.Producto producto ON producto.producto_id = publicacion.producto_id
		JOIN SARTEN_QUE_LADRA.ProductoXSubrubro pxs ON pxs.producto_id = producto.producto_id
		JOIN SARTEN_QUE_LADRA.Subrubro subrubro ON subrubro.subrubro_id = pxs.subrubro_id
		JOIN SARTEN_QUE_LADRA.SubrubroXRubro sxr ON sxr.subrubro_id = subrubro.subrubro_id
	GROUP BY 
		pc.provincia_almacen_id,
		pc.tiempo_id,
		pc.localidad_cliente_id,
		sxr.rubro_id,
		rango_etario
END

EXEC SARTEN_QUE_LADRA.BI_Migrar_Hechos_Venta

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Rango_Etario
AS
BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_Rango_Etario
        (rango_etario)
    VALUES
        ('< 25')
    INSERT INTO SARTEN_QUE_LADRA.BI_Rango_Etario
        (rango_etario)
    VALUES
        ('25 - 35')
    INSERT INTO SARTEN_QUE_LADRA.BI_Rango_Etario
        (rango_etario)
    VALUES
        ('35 - 50')
    INSERT INTO SARTEN_QUE_LADRA.BI_Rango_Etario
        (rango_etario)
    VALUES
        ('> 50')
END

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_HECHOS_ENVIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.BI_HECHOS_ENVIO (
		tiempo_id, provincia_almacen_id, loc_cliente_id, enviados_a_tiempo, costo_envios, total_enviados, tipo_envio)
	SELECT SARTEN_QUE_LADRA.BI_Select_Tiempo(e.envio_fecha_hora_entrega),
		   SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen(am.almacen_codigo),
		   SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(c.cliente_id, e.envio_numero),
		   SUM(SARTEN_QUE_LADRA.ENVIADOS_A_TIEMPO(e.envio_horario_inicio, e.envio_horario_fin, e.envio_fecha_programada, e.envio_fecha_hora_entrega)),
		   SUM(e.envio_costo),
		   COUNT(e.envio_numero),
		   e.tipo_envio_id
	FROM SARTEN_QUE_LADRA.Envio e
		JOIN SARTEN_QUE_LADRA.Venta v ON v.venta_codigo = e.venta_codigo
		JOIN SARTEN_QUE_LADRA.Cliente c ON c.cliente_id = v.cliente_id
		JOIN SARTEN_QUE_LADRA.DetalleVenta dv ON dv.venta_codigo = v.venta_codigo
		JOIN SARTEN_QUE_LADRA.Publicacion p ON p.publicacion_codigo = dv.publicacion_codigo
		JOIN SARTEN_QUE_LADRA.Almacen am ON am.almacen_codigo = p.almacen_codigo
		GROUP BY SARTEN_QUE_LADRA.BI_Select_Tiempo(e.envio_fecha_hora_entrega),
				 SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(c.cliente_id, e.envio_numero),
				 SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen(am.almacen_codigo),
				 e.tipo_envio_id;
END

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
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_ENVIO -- tipo envio
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.BI_TIPO_ENVIO
		(envio_id, envio_nombre)
	SELECT DISTINCT tipo_envio_id, envio_nombre FROM SARTEN_QUE_LADRA.TipoEnvio
END

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Concepto
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_CONCEPTO
		(idx_concepto, concepto_desc)
	SELECT DISTINCT c.detalle_concepto_id, c.concepto_tipo
	FROM SARTEN_QUE_LADRA.Concepto c
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
	WHERE detallepago.detalle_pago_cuotas > 1 
	GROUP BY SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios(venta.cliente_id, envio.envio_numero), 
			 SARTEN_QUE_LADRA.BI_Select_Tiempo(pago.pago_fecha),		
			 medioxpago.id_medio_de_pago, 
			 tipomediopago.id_medio_pago
END

/*** VIEWS ***/

/* 6. Pago en Cuotas. Las 3 localidades con el mayor importe de pagos en cuotas,
según el medio de pago, mes y año. Se calcula sumando los importes totales de
todas las ventas en cuotas. Se toma la localidad del cliente (Si tiene más de una
dirección se toma a la que seleccionó el envío) */

CREATE VIEW SARTEN_QUE_LADRA.LOCALIDADES_MAYOR_IMPORTE_CUOTAS
AS
	SELECT TOP 3 hp.localidad_cliente_id, t.mes, t.anio, mdp.medio_pago, SUM(hp.importe_cuotas) 
			AS 'Importe por cuotas'
	FROM SARTEN_QUE_LADRA.Hechos_Pago hp 
		JOIN SARTEN_QUE_LADRA.BI_Tiempo t ON hp.tiempo_id = t.tiempo_id
		JOIN SARTEN_QUE_LADRA.BI_Localidad l ON hp.localidad_cliente_id = l.localidad_id
		JOIN SARTEN_QUE_LADRA.BI_Medio_De_Pago mdp ON mdp.medio_pago_id = hp.medio_pago_id
	GROUP BY hp.localidad_cliente_id, t.mes, t.anio, mdp.medio_pago
	ORDER BY SUM(hp.importe_cuotas) DESC

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

/* 3. Venta promedio mensual. Valor promedio de las ventas (en $) según la
provincia correspondiente a la ubicación del almacén para cada mes de cada año
Se calcula en función de la sumatoria del importe de las ventas sobre el total de
las mismas.*/

GO
CREATE VIEW SARTEN_QUE_LADRA.VENTA_PROMEDIO_MENSUAL
AS
	SELECT DISTINCT anio, mes, provincia_almacen_id, SUM(importe_venta) / ¿? 'Venta Promedio Mensual Según Provincia'
	FROM SARTEN_QUE_LADRA.Hechos_Venta venta
		JOIN SARTEN_QUE_LADRA.BI_Provincia provincia ON venta.provincia_almacen_id = provincia.id
		JOIN SARTEN_QUE_LADRA.BI_Tiempo tiempo ON venta.tiempo_id = tiempo.tiempo_id
	GROUP BY provincia_nombre, mes, anio

/* 4. Rendimiento de rubros. Los 5 rubros con mayores ventas para cada
cuatrimestre de cada año según la localidad y rango etario de los clientes. */

GO
CREATE VIEW SARTEN_QUE_LADRA.RUBROS_MAYORES_VENTAS
AS
	SELECT DISTINCT TOP 5 rb.rubro_descripcion, cuatrimestre, anio, l.localidad_nombre, re.rango_etario, 
					SUM(importe_venta) 'Venta por rubro'
	FROM SARTEN_QUE_LADRA.Hechos_Venta venta
		JOIN SARTEN_QUE_LADRA.BI_Localidad l ON l.localidad_id = venta.localidad_cliente_id
		JOIN SARTEN_QUE_LADRA.BI_Tiempo tiempo ON venta.tiempo_id = tiempo.tiempo_id
		JOIN SARTEN_QUE_LADRA.BI_Rubro rb ON rb.rubro_id = venta.rubro_id
		JOIN SARTEN_QUE_LADRA.BI_Rango_Etario re ON re.rango_etario_id = venta.rango_etario_cliente
	GROUP BY l.localidad_nombre, cuatrimestre, anio, re.rango_etario, rb.rubro_descripcion
	ORDER BY SUM(importe_venta) DESC

SELECT * FROM SARTEN_QUE_LADRA.RUBROS_MAYORES_VENTAS
