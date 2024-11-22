USE GD2C2024
GO
CREATE SCHEMA SARTEN_QUE_LADRA
GO

-- ============================== --
--          TABLAS				  --
-- ============================== --

CREATE TABLE SARTEN_QUE_LADRA.BI_Tiempo (
    tiempo_id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    anio DECIMAL(18,0),
    mes DECIMAL(18,0),
    cuatrimestre DECIMAL(18,0)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Localidad (
    localidad_id DECIMAL(18,0) PRIMARY KEY,
    provincia_id DECIMAL(18,0),
    localidad_nombre NVARCHAR(50),
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Provincia (
    provincia_id DECIMAL(18,0) PRIMARY KEY,
    provincia_nombre NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.BI_Rango_Horario (
    rango_horario_id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    rango_horario VARCHAR(20)
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
	pago_id DECIMAL(18,0) PRIMARY KEY,
	localidad_cliente_id DECIMAL(18,0), --FK
	detalle_pago_cuotas DECIMAL(18,0),
	tiempo_id DECIMAL(18,0), --FK
	medio_pago_id DECIMAL(18,0), --FK
	venta_id DECIMAL(18,0), --FK
	tipo_medio_pago_id DECIMAL(18,0) --FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Subrubro (
	subrubro_id DECIMAL(18,0) PRIMARY KEY,
	subrubro_rubro NVARCHAR(50) 
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Marca (
	marca_id DECIMAL(18,0) PRIMARY KEY,
	marca_nombre NVARCHAR
)

CREATE TABLE SARTEN_QUE_LADRA.Hechos_Publicacion (
	publicacion_id DECIMAL(18,0) PRIMARY KEY,
	publicacion_subrubro_id DECIMAL(18,0),
	tiempo_publicada_id DECIMAL(18,0),
	marca_id DECIMAL(18,0)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Rubro (
	rubro_id DECIMAL(18,0) PRIMARY KEY,
	rubro_descripcion VARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Rango_Etario (
    rango_etario_id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    rango_etario VARCHAR(20)
);

CREATE TABLE SARTEN_QUE_LADRA.Hechos_Venta (
	venta_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	provincia_almacen_id DECIMAL(18,0),
	tiempo_id DECIMAL(18,0),
	rubro_id DECIMAL(18,0),
	localidad_cliente_id DECIMAL(18,0),
	rango_etario_cliente  DECIMAL(18,0),
	rango_horario_id  DECIMAL(18,0),
	venta_total DECIMAL(18,2)
);

-- ============================== --
--         CONSTRAINTS            --
-- ============================== --
ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad ADD CONSTRAINT fk_bilocalidad_provincia FOREIGN KEY (provincia_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_localidad FOREIGN KEY (localidad_cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad(localidad_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_tiempo FOREIGN KEY (tiempo_id) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_medio_pago FOREIGN KEY (medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Medio_De_Pago;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago ADD CONSTRAINT fk_hechos_pago_tipo_medio_pago FOREIGN KEY (tipo_medio_pago_id) REFERENCES SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Publicacion ADD CONSTRAINT fk_hechos_publicacion_subrubro FOREIGN KEY (publicacion_subrubro_id) REFERENCES SARTEN_QUE_LADRA.BI_Subrubro(subrubro_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Publicacion ADD CONSTRAINT fk_hechos_publicacion_marca FOREIGN KEY (marca_id) REFERENCES SARTEN_QUE_LADRA.BI_Marca;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_provincia FOREIGN KEY (provincia_almacen_id) REFERENCES SARTEN_QUE_LADRA.BI_Provincia(provincia_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_rango_etario FOREIGN KEY (rango_etario_cliente) REFERENCES SARTEN_QUE_LADRA.BI_Rango_Etario(rango_etario_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_tiempo FOREIGN KEY (tiempo_id) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo(tiempo_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_rubro FOREIGN KEY (rubro_id) REFERENCES SARTEN_QUE_LADRA.BI_Rubro(rubro_id);
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta ADD CONSTRAINT fk_hechos_venta_localidad FOREIGN KEY (localidad_cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Localidad(localidad_id);

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
	FROM SARTEN_QUE_LADRA.Domicilio domicilio 
		JOIN SARTEN_QUE_LADRA.DomicilioXUsuario domicilioxusuario ON domicilio.domicilio_id = domicilioxusuario.domicilio_id
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

GO

CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Rango_Horario(@venta_hora DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)
    DECLARE @hora DATETIME;
    SET @hora = CONVERT(TIME, @venta_hora);
    SELECT @resultado = rango_horario_id
    FROM SARTEN_QUE_LADRA.BI_RANGO_HORARIO
    WHERE rango_horario LIKE (CASE 
                            WHEN @hora BETWEEN '00:00' AND '06:00' OR @hora IS NULL THEN  '00:00 - 06:00'
                            WHEN @hora BETWEEN '06:00' AND '12:00' THEN  '06:00 - 12:00'
                            WHEN @hora BETWEEN '12:00' AND '18:00' THEN  '12:00 - 18:00'
                            WHEN @hora BETWEEN '18:00' AND '24:00' THEN '18:00 - 24:00'
							END)
    RETURN @resultado
END

GO

CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen(@almacen_id DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS BEGIN
	DECLARE @id DECIMAL(18,0)
    SELECT DISTINCT @id = pr.provincia_id FROM SARTEN_QUE_LADRA.BI_Provincia pr
	WHERE pr.provincia_id = (SELECT p.provincia_id FROM SARTEN_QUE_LADRA.Provincia p
		JOIN SARTEN_QUE_LADRA.Localidad l ON l.provincia_id = p.provincia_id
		JOIN SARTEN_QUE_LADRA.Almacen a ON l.localidad_id = a.localidad_id
		WHERE @almacen_id = a.almacen_codigo)
	RETURN @id
END

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

GO

CREATE FUNCTION SARTEN_QUE_LADRA.BI_Select_Almacen_Venta(@venta_id DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)

	SELECT DISTINCT @resultado = a.almacen_codigo
	FROM SARTEN_QUE_LADRA.Venta v 
		JOIN SARTEN_QUE_LADRA.DetalleVenta dv ON dv.venta_codigo = v.venta_codigo
		JOIN SARTEN_QUE_LADRA.Publicacion p ON p.publicacion_codigo = dv.publicacion_codigo
		JOIN SARTEN_QUE_LADRA.Almacen a ON a.almacen_codigo = p.almacen_codigo
	WHERE v.venta_codigo = @venta_id
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

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Marca
AS
BEGIN
	INSERT INTO SARTEN_QUE_LADRA.BI_Marca (marca_id, marca_nombre)
	SELECT DISTINCT marca_id, marca_nombre
	FROM SARTEN_QUE_LADRA.Marca
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Subrubro
AS
BEGIN
	INSERT INTO SARTEN_QUE_LADRA.BI_Subrubro (subrubro_id, subrubro_rubro)
	SELECT subrubro_id, subrubro_rubro
	FROM SARTEN_QUE_LADRA.Subrubro
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Hechos_Publicacion_Sin_Tiempo
AS
BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Hechos_Publicacion (publicacion_id, publicacion_subrubro_id, marca_id)
	SELECT p.publicacion_codigo, prXs.subrubro_id, mXpr.marca_id
	FROM SARTEN_QUE_LADRA.Publicacion p JOIN SARTEN_QUE_LADRA.Producto pr ON (p.producto_id = pr.producto_id)
										JOIN SARTEN_QUE_LADRA.ProductoXSubrubro prXs ON (prXs.producto_id = pr.producto_id)
										JOIN SARTEN_QUE_LADRA.MarcaXProducto mXpr ON (mXpr.producto_id = pr.producto_id)
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Rango_Horario
AS
BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_Rango_Horario
        (rango_horario)
    VALUES
        ('00:00 - 06:00')
    INSERT INTO SARTEN_QUE_LADRA.BI_Rango_Horario
        (rango_horario)
    VALUES
        ('06:00 - 12:00')
    INSERT INTO SARTEN_QUE_LADRA.BI_Rango_Horario
        (rango_horario)
    VALUES
        ('12:00 - 18:00')
    INSERT INTO SARTEN_QUE_LADRA.BI_Rango_Horario
        (rango_horario)
    VALUES
        ('18:00 - 24:00')
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Rubro
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_Rubro
		SELECT DISTINCT rubro_id, rubro_descripcion FROM SARTEN_QUE_LADRA.Rubro
END

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

CREATE PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Hechos_Venta
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.Hechos_Venta
        (venta_codigo, provincia_almacen_id, tiempo_id, rubro_id, localidad_cliente_id,	rango_etario_cliente, rango_horario_id, venta_total)
    SELECT DISTINCT v.venta_codigo, SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen(SARTEN_QUE_LADRA.BI_Select_Almacen_Venta(v.venta_codigo)), 
		SARTEN_QUE_LADRA.BI_Select_Tiempo(v.venta_fecha), rubro_id, SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente(v.cliente_id), 
		SARTEN_QUE_LADRA.BI_Select_Rango_Etario(c.cliente_fecha_nac), SARTEN_QUE_LADRA.BI_Select_Rango_Horario(v.venta_hora), v.venta_total
	FROM SARTEN_QUE_LADRA.Venta v
		JOIN SARTEN_QUE_LADRA.DetalleVenta dv ON v.venta_codigo = dv.venta_codigo
		JOIN SARTEN_QUE_LADRA.Publicacion publicacion ON publicacion.publicacion_codigo = dv.publicacion_codigo
		JOIN SARTEN_QUE_LADRA.Producto producto ON producto.producto_id = publicacion.producto_id
		JOIN SARTEN_QUE_LADRA.ProductoXSubrubro pxs ON pxs.producto_id = producto.producto_id
		JOIN SARTEN_QUE_LADRA.Subrubro subrubro ON subrubro.subrubro_id = pxs.subrubro_id
		JOIN SARTEN_QUE_LADRA.SubrubroXRubro sxr ON sxr.subrubro_id = subrubro.subrubro_id
		JOIN SARTEN_QUE_LADRA.Cliente c ON c.cliente_id = v.cliente_id
END

-- ============================== -- 
--				EXEC	          --
-- ============================== --

-- EN ESTE ORDEN FUNCIONA
EXEC SARTEN_QUE_LADRA.BI_Migrar_Tiempo;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Provincia;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Localidad;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Medio_De_Pago;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Tipo_Medio_De_Pago;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Pago;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Rubro;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Rango_Etario;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Rango_Horario;
EXEC SARTEN_QUE_LADRA.BI_Migrar_Hechos_Venta;

-- ============================== -- 
--				VIEWS	          --
-- ============================== --

/*
3. Venta promedio mensual. Valor promedio de las ventas (en $) según la
provincia correspondiente a la ubicación del almacén para cada mes de cada año
Se calcula en función de la sumatoria del importe de las ventas sobre el total de
las mismas.

TODO: Que funcione.
*/
GO

CREATE VIEW SARTEN_QUE_LADRA.VENTA_PROMEDIO_MENSUAL
AS
	SELECT provincia_nombre, mes, anio 'año', SUM(venta_total) / COUNT(DISTINCT venta_total) 'Venta Promedio Mensual Según Provincia'
	FROM SARTEN_QUE_LADRA.Hechos_Venta venta
		JOIN SARTEN_QUE_LADRA.BI_Provincia provincia ON venta.provincia_almacen_id = provincia.provincia_id
		JOIN SARTEN_QUE_LADRA.BI_Tiempo tiempo ON venta.tiempo_id = tiempo.tiempo_id
	GROUP BY provincia_id, mes, anio

/*
4. Rendimiento de rubros. Los 5 rubros con mayores ventas para cada
cuatrimestre de cada año según la localidad y rango etario de los clientes.

TODO: Revisar porque ya no existe VentaXRubro.
*/
GO

CREATE VIEW SARTEN_QUE_LADRA.RENDIMIENTO_DE_RUBROS
AS
	SELECT rubro_descripcion, COUNT(venta.venta_id) cantidad_de_ventas, cuatrimestre, localidad.localidad_nombre, rango_etario
	FROM SARTEN_QUE_LADRA.Hechos_Venta venta 
		JOIN SARTEN_QUE_LADRA.BI_VentaXRubro vxr ON venta.venta_id = vxr.venta_id
		JOIN SARTEN_QUE_LADRA.BI_Rubro rubro ON vxr.rubro_id = rubro.rubro_id
		JOIN SARTEN_QUE_LADRA.BI_Tiempo tiempo ON venta.venta_id = tiempo.tiempo_id
		JOIN SARTEN_QUE_LADRA.BI_Rango_Etario rango_etario ON venta.rango_etario_cliente = rango_etario.rango_etario_id
		JOIN SARTEN_QUE_LADRA.BI_Localidad localidad ON venta.localidad_cliente_id = localidad.localidad_id
GO
