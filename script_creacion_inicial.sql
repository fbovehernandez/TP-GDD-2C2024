USE GD2C2024
GO
CREATE SCHEMA SARTEN_QUE_LADRA
GO

-- DROP SCHEMA SARTEN_QUE_LADRA;

-- ============================== --
--          TABLAS				  --
-- ============================== --

CREATE TABLE SARTEN_QUE_LADRA.Rubro (
	rubro_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	rubro_descripcion VARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Subrubro (
	subrubro_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	subrubro_rubro NVARCHAR(50)
); 

CREATE TABLE SARTEN_QUE_LADRA.SubrubroXRubro (
	subrubro_id DECIMAL(18,0),
	rubro_id DECIMAL(18,0),
	PRIMARY KEY (subrubro_id, rubro_id)
);

CREATE TABLE SARTEN_QUE_LADRA.Marca (
	marca_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	marca_nombre NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Modelo (
	modelo_codigo DECIMAL(18,0) PRIMARY KEY,
	modelo_descripcion NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Producto (
	producto_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	producto_codigo NVARCHAR(50),
	producto_descripcion NVARCHAR(50),
	producto_precio DECIMAL(18,2),
);

CREATE TABLE SARTEN_QUE_LADRA.ModeloXProducto (
	producto_id DECIMAL(18,0),
	modelo_id DECIMAL(18,0),
	PRIMARY KEY (producto_id, modelo_id)
);

CREATE TABLE SARTEN_QUE_LADRA.MarcaXProducto (
	producto_id DECIMAL(18,0),
	marca_id DECIMAL(18,0),
	PRIMARY KEY (producto_id, marca_id),
);

CREATE TABLE SARTEN_QUE_LADRA.ProductoXSubrubro (
	producto_id DECIMAL(18,0),
	subrubro_id DECIMAL(18,0),
	PRIMARY KEY (producto_id, subrubro_id),
);

CREATE TABLE SARTEN_QUE_LADRA.Provincia (
	provincia_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	provincia_nombre NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Localidad (
	localidad_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	provincia_id DECIMAL(18,0),
	localidad_nombre NVARCHAR(50),
);

CREATE TABLE SARTEN_QUE_LADRA.Domicilio(
	domicilio_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	domicilio_calle NVARCHAR(50),
	domicilio_nro_calle DECIMAL(18,0),
	domicilio_piso DECIMAL(18,0),
	domicilio_depto NVARCHAR(50),
	domicilio_cp NVARCHAR(50),
	localidad_id DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.Usuario (
	usuario_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	usuario_nombre NVARCHAR(50),
	usuario_password NVARCHAR(50),
	usuario_fecha_creacion DATE
);

CREATE TABLE SARTEN_QUE_LADRA.DomicilioXUsuario(
	usuario_id DECIMAL(18,0),
	domicilio_id DECIMAL(18,0),
	PRIMARY KEY (usuario_id, domicilio_id),
);

CREATE TABLE SARTEN_QUE_LADRA.Cliente (
	cliente_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	cliente_nombre NVARCHAR(50),
	cliente_apellido NVARCHAR(50),
	cliente_fecha_nac DATE,
	cliente_mail NVARCHAR(50),
	cliente_dni NVARCHAR(50),
	usuario_id DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.Vendedor(
	vendedor_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	vendedor_cuit NVARCHAR(50),
	vendedor_razon_social NVARCHAR(50),
	vendedor_mail NVARCHAR(50),
	usuario_id DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.TipoEnvio (
	tipo_envio_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	envio_nombre NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Venta ( 
	venta_codigo DECIMAL(18,0) PRIMARY KEY, 
	cliente_id DECIMAL(18,0),
	venta_fecha DATE,
	venta_hora TIME,
	venta_total DECIMAL(18,2)
);

CREATE TABLE SARTEN_QUE_LADRA.Envio (
	envio_numero DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	envio_domicilio DECIMAL(18,0),
	envio_fecha_programada DATETIME,
	envio_horario_inicio DECIMAL(18,0),
	envio_horario_fin DECIMAL(18,0),
	envio_costo DECIMAL(18,2),
	envio_fecha_hora_entrega DATETIME,
	tipo_envio_id DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.Factura(
	factura_numero DECIMAL(18,0) PRIMARY KEY,
	factura_fecha DATE,
	vendedor_id DECIMAL(18,0),
	factura_total DECIMAL(18,2),
);

CREATE TABLE SARTEN_QUE_LADRA.Almacen(
	almacen_codigo DECIMAL(18,0) PRIMARY KEY,
	almacen_calle NVARCHAR(50),
	almacen_nro_calle DECIMAL(18,0),
	almacen_costo_dia_al DECIMAL(18,2),
	localidad_id DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.Publicacion (
	publicacion_codigo DECIMAL(18,0) PRIMARY KEY,
	publicacion_descripcion NVARCHAR(50),
	publicacion_stock DECIMAL(18,0),
	publicacion_fecha_fin DATE,
	publicacion_fecha_inicio DATE,
	publicacion_precio DECIMAL(18,2),
	publicacion_costo DECIMAL(18,2),
	publicacion_porc_venta DECIMAL(18,2),
	producto_id DECIMAL(18,0),
	vendedor_id DECIMAL(18,0),
	almacen_codigo DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.Concepto (
	detalle_concepto_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	precio DECIMAL(18,2),
	cantidad DECIMAL(18,0),
	subtotal DECIMAL(18,2)
);

CREATE TABLE SARTEN_QUE_LADRA.DetalleFactura (
	detalle_factura_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	publicacion_codigo DECIMAL(18,0),
	detalle_concepto_id DECIMAL(18,0),
	detalle_factura_total DECIMAL(18,2),
	factura_numero DECIMAL(18,0),
	detalle_factura_tipo NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.DetalleVenta(
	detalle_venta_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	detalle_concepto_id DECIMAL(18,0),
	publicacion_codigo DECIMAL(18,0),
	detalle_venta_total DECIMAL(18,2),
);

CREATE TABLE SARTEN_QUE_LADRA.Pago (
	id_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	pago_importe DECIMAL(18,2),
	pago_fecha DATE 
)

CREATE TABLE SARTEN_QUE_LADRA.DetallePago (
	detalle_pago_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	tarjeta_numero NVARCHAR(50),
	tarjeta_fecha_vencimiento DATE,
	detalle_pago_cuotas DECIMAL(18,0),
	id_medio_x_pago DECIMAL(18,0),
)

CREATE TABLE SARTEN_QUE_LADRA.TipoMedioPago (
	id_tipo_medio_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	tipo_medio_pago NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.MedioPago(
	id_medio_de_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	medio_de_pago NVARCHAR(50),
	id_tipo_medio_pago DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.MedioXPago(
	id_medio_x_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	id_pago DECIMAL(18,0),
	id_medio_de_pago DECIMAL(18,0),
	id_detalle_pago DECIMAL(18,0),
);

-- ============================== -- 
--      STORED PROCEDURES         --
-- ============================== --

GO

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_LOCALIDAD
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Localidad(localidad_nombre, provincia_id) 

    SELECT DISTINCT CLI_USUARIO_DOMICILIO_LOCALIDAD, p.provincia_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_nombre = CLI_USUARIO_DOMICILIO_PROVINCIA
    WHERE CLI_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL

	UNION

	SELECT DISTINCT VEN_USUARIO_DOMICILIO_LOCALIDAD, p.provincia_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_nombre = VEN_USUARIO_DOMICILIO_PROVINCIA
    WHERE VEN_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL

	UNION

	SELECT DISTINCT ALMACEN_Localidad, p.provincia_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_nombre = ALMACEN_Localidad
    WHERE ALMACEN_Localidad IS NOT NULL
END

GO

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MARCAXPRODUCTO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.MarcaXProducto (producto_id, marca_id) 
	SELECT DISTINCT producto_id, marca_id
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Marca marca ON maestra.PRODUCTO_MARCA = marca.marca_nombre
									JOIN SARTEN_QUE_LADRA.Producto producto ON maestra.PRODUCTO_CODIGO = producto.producto_codigo AND maestra.PRODUCTO_PRECIO = producto.producto_precio
	WHERE maestra.PRODUCTO_CODIGO IS NOT NULL AND PRODUCTO_MARCA IS NOT NULL;
END

SELECT PRODUCTO_CODIGO, PRODUCTO_DESCRIPCION,
	PRODUCTO_MARCA, PRODUCTO_MOD_CODIGO, PRODUCTO_PRECIO, PRODUCTO_SUB_RUBRO, PRODUCTO_RUBRO_DESCRIPCION from gd_esquema.Maestra
WHERE PRODUCTO_CODIGO = 'Codigo:6131231312' and PRODUCTO_SUB_RUBRO = 'Sub_Rubro Nº476791'

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PRODUCTO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Producto(producto_codigo, producto_descripcion, producto_precio)
	SELECT DISTINCT PRODUCTO_CODIGO, PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO from gd_esquema.Maestra
	WHERE PRODUCTO_CODIGO IS NOT NULL
END

EXEC SARTEN_QUE_LADRA.MIGRAR_PRODUCTO

SELECT DISTINCT PRODUCTO_CODIGO, PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO FROM gd_esquema.Maestra -- 6894
where PRODUCTO_CODIGO = 'Codigo:0131231312'

SELECT * FROM SARTEN_QUE_LADRA.Marca

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PROVINCIA 
AS BEGIN 
    INSERT INTO SARTEN_QUE_LADRA.Provincia(provincia_nombre) 
    SELECT DISTINCT CLI_USUARIO_DOMICILIO_PROVINCIA FROM gd_esquema.Maestra
    WHERE CLI_USUARIO_DOMICILIO_PROVINCIA IS NOT NULL

    UNION

    SELECT DISTINCT VEN_USUARIO_DOMICILIO_PROVINCIA FROM gd_esquema.Maestra
    WHERE VEN_USUARIO_DOMICILIO_PROVINCIA IS NOT NULL

    UNION

    SELECT DISTINCT ALMACEN_PROVINCIA FROM gd_esquema.Maestra
    WHERE ALMACEN_PROVINCIA IS NOT NULL;
END
GO

-- DROP TABLE SARTEN_QUE_LADRA.Marca

-- Incialmente esta migrado con el ID, habria que cambiarlo o si queda asi, dejarlo (VER)
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MARCA 
AS BEGIN 
    INSERT INTO SARTEN_QUE_LADRA.Marca(marca_nombre)
	SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra
	WHERE PRODUCTO_MARCA IS NOT NULL
END

GO

INSERT INTO SARTEN_QUE_LADRA.MarcaXProducto (producto_id, marca_id) 
	SELECT DISTINCT producto_id, sarten.marca_id
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Marca sarten ON maestra.PRODUCTO_MARCA = sarten.marca_nombre
									JOIN SARTEN_QUE_LADRA.Producto producto ON maestra.
	WHERE producto_id IS NOT NULL AND PRODUCTO_MARCA IS NOT NULL;

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_LOCALIDAD
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Localidad(localidad_nombre, provincia_id) 

    SELECT DISTINCT CLI_USUARIO_DOMICILIO_LOCALIDAD, p.provincia_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_nombre = CLI_USUARIO_DOMICILIO_PROVINCIA
    WHERE CLI_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL

	UNION

	SELECT DISTINCT VEN_USUARIO_DOMICILIO_LOCALIDAD, p.provincia_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_nombre = VEN_USUARIO_DOMICILIO_PROVINCIA
    WHERE VEN_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL

	UNION

	SELECT DISTINCT ALMACEN_Localidad, p.provincia_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_nombre = ALMACEN_Localidad
    WHERE ALMACEN_Localidad IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DOMICILIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Domicilio(domicilio_calle, domicilio_cp, domicilio_depto, domicilio_nro_calle, domicilio_piso, localidad_id)
	SELECT DISTINCT CLI_USUARIO_DOMICILIO_CALLE, CLI_USUARIO_DOMICILIO_CP, CLI_USUARIO_DOMICILIO_DEPTO,
		CLI_USUARIO_DOMICILIO_NRO_CALLE, CLI_USUARIO_DOMICILIO_PISO, l.localidad_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Localidad l ON
	l.localidad_nombre = CLI_USUARIO_DOMICILIO_LOCALIDAD
	JOIN SARTEN_QUE_LADRA.Provincia p ON
	p.provincia_nombre = [CLI_USUARIO_DOMICILIO_PROVINCIA]
	-- WHERE .. IS NOT NULL?

	UNION

	SELECT DISTINCT VEN_USUARIO_DOMICILIO_CALLE, VEN_USUARIO_DOMICILIO_CP, VEN_USUARIO_DOMICILIO_DEPTO,
		VEN_USUARIO_DOMICILIO_NRO_CALLE, VEN_USUARIO_DOMICILIO_PISO, l.localidad_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Localidad l on l.localidad_nombre = VEN_USUARIO_DOMICILIO_LOCALIDAD
	JOIN SARTEN_QUE_LADRA.Provincia p ON
	p.provincia_nombre = [VEN_USUARIO_DOMICILIO_PROVINCIA]
	-- WHERE .. IS NOT NULL?
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_TIPO_ENVIO
AS BEGIN
		INSERT INTO SARTEN_QUE_LADRA.TipoEnvio(envio_nombre)
		SELECT DISTINCT ENVIO_TIPO from gd_esquema.Maestra
		WHERE ENVIO_TIPO IS NOT NULL
END
GO

-- Idem arriba, ver si conviene que tenga el ID
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MODELO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Modelo(modelo_codigo, modelo_descripcion)
	SELECT DISTINCT PRODUCTO_MOD_CODIGO, PRODUCTO_MOD_DESCRIPCION from gd_esquema.Maestra
	WHERE PRODUCTO_MOD_CODIGO IS NOT NULL
END
GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_ALMACEN
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Almacen(almacen_codigo, almacen_calle, almacen_nro_calle, almacen_costo_dia_al, localidad_id)
	SELECT ALMACEN_CODIGO, ALMACEN_CALLE, ALMACEN_NRO_CALLE, ALMACEN_COSTO_DIA_AL from gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Localidad l ON l.localidad_nombre = ALMACEN_Localidad
	WHERE ALMACEN_CODIGO IS NOT NULL
END
GO

DROP PROCEDURE SARTEN_QUE_LADRA.MIGRAR_USUARIO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_USUARIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Usuario(usuario_nombre, usuario_password, usuario_fecha_creacion)
	SELECT DISTINCT CLI_USUARIO_NOMBRE, CLI_USUARIO_PASS, CLI_USUARIO_FECHA_CREACION from gd_esquema.Maestra
	
	UNION 

	SELECT DISTINCT VEN_USUARIO_NOMBRE, VEN_USUARIO_PASS, VEN_USUARIO_FECHA_CREACION from gd_esquema.Maestra
END 
GO

EXEC SARTEN_QUE_LADRA.MIGRAR_USUARIO

SELECT * from SARTEN_QUE_LADRA.Usuario

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_CLIENTE
AS BEGIN
	-- CREO QUE SI PASA ESO DE QUE HAY VARIOS CLIENTES CON MISMO USUARIO, LO VOY A VER CUANDO LO MIGRE, PORQUE SINO
	-- ME ESTOY VOLVIENDO LOCO Y NO LO VEO
END
GO

----------------------------------------------------------------------------------------------------

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_RUBRO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Rubro (rubro_descripcion)
	SELECT PRODUCTO_RUBRO_DESCRIPCION
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL;
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_SUBRUBROXRUBRO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.SubrubroXRubro (subrubro_id, rubro_id)
	SELECT DISTINCT subrubro.subrubro_id, rubro.rubro_id
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Rubro rubro ON maestra.PRODUCTO_RUBRO_DESCRIPCION = rubro.rubro_descripcion
									JOIN SARTEN_QUE_LADRA.Subrubro subrubro ON maestra.PRODUCTO_SUB_RUBRO = subrubro.subrubro_rubro
	WHERE PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL AND PRODUCTO_SUB_RUBRO IS NOT NULL;
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_SUBRUBRO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Subrubro (subrubro_rubro)
	SELECT DISTINCT PRODUCTO_SUB_RUBRO
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_SUB_RUBRO IS NOT NULL;
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PRODUCTOXSUBRUBRO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.ProductoXSubrubro (producto_id, subrubro_id)
	SELECT DISTINCT producto_id, subrubro_id
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Producto producto ON maestra.PRODUCTO_CODIGO = producto.producto_codigo
										AND maestra.PRODUCTO_DESCRIPCION = producto.producto_descripcion
										AND maestra.PRODUCTO_PRECIO = producto.producto_precio
									JOIN SARTEN_QUE_LADRA.Subrubro subrubro ON maestra.PRODUCTO_SUB_RUBRO = subrubro.subrubro_rubro
	WHERE maestra.PRODUCTO_CODIGO IS NOT NULL AND PRODUCTO_SUB_RUBRO IS NOT NULL;
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_CONCEPTO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Concepto (precio, cantidad, subtotal)
	SELECT DISTINCT FACTURA_DET_PRECIO, FACTURA_DET_CANTIDAD, FACTURA_DET_SUBTOTAL
	FROM gd_esquema.Maestra maestra
	WHERE FACTURA_DET_PRECIO IS NOT NULL AND FACTURA_DET_CANTIDAD IS NOT NULL AND FACTURA_DET_SUBTOTAL IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DETALLE_FACTURA
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.DetalleFactura (publicacion_codigo, detalle_concepto_id, detalle_factura_total, factura_numero, detalle_factura_tipo)
	SELECT DISTINCT maestra.publicacion_codigo, concepto.detalle_concepto_id, concepto.precio * concepto.cantidad, maestra.FACTURA_NUMERO, maestra.FACTURA_DET_TIPO
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Concepto concepto ON maestra.FACTURA_DET_PRECIO = concepto.precio 
										AND maestra.FACTURA_DET_CANTIDAD = concepto.cantidad
										AND maestra.FACTURA_DET_SUBTOTAL = concepto.subtotal
	WHERE maestra.PUBLICACION_CODIGO IS NOT NULL AND maestra.FACTURA_NUMERO IS NOT NULL AND maestra.FACTURA_DET_TIPO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_FACTURA
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Factura (factura_numero, factura_fecha, vendedor_id, factura_total)
	SELECT DISTINCT FACTURA_NUMERO, FACTURA_FECHA, vendedor.vendedor_id, FACTURA_TOTAL
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Vendedor vendedor ON maestra.VENDEDOR_CUIT = vendedor.vendedor_cuit
										AND maestra.VENDEDOR_RAZON_SOCIAL = vendedor.vendedor_razon_social
										AND maestra.VENDEDOR_MAIL = vendedor.vendedor_mail
									JOIN SARTEN_QUE_LADRA.Usuario usuario ON maestra.VEN_USUARIO_NOMBRE = usuario.usuario_nombre
										AND maestra.VEN_USUARIO_PASS = usuario.usuario_password
										AND maestra.VEN_USUARIO_FECHA_CREACION = usuario.usuario_fecha_creacion
	WHERE FACTURA_NUMERO IS NOT NULL AND FACTURA_FECHA IS NOT NULL AND FACTURA_TOTAL IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MODELOXPRODUCTO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.ModeloXProducto (producto_id, modelo_id)
	SELECT DISTINCT producto_id, modelo_codigo
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Producto producto ON maestra.PRODUCTO_CODIGO = producto.producto_codigo
										AND maestra.PRODUCTO_DESCRIPCION = producto.producto_descripcion
										AND maestra.PRODUCTO_PRECIO = producto.producto_precio
									JOIN SARTEN_QUE_LADRA.Modelo modelo ON maestra.PRODUCTO_MOD_CODIGO = modelo.modelo_codigo
										AND maestra.PRODUCTO_MOD_DESCRIPCION = modelo.modelo_descripcion
	WHERE producto_id IS NOT NULL AND modelo_codigo IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PUBLICACION
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Publicacion (publicacion_codigo, publicacion_descripcion, publicacion_stock, publicacion_fecha_fin, 
		publicacion_fecha_inicio, publicacion_precio, publicacion_costo, publicacion_porc_venta, producto_id, vendedor_id, almacen_codigo)
	SELECT DISTINCT maestra.PUBLICACION_CODIGO, PUBLICACION_DESCRIPCION, PUBLICACION_STOCK, PUBLICACION_FECHA_V, PUBLICACION_FECHA, PUBLICACION_PRECIO, 
		PUBLICACION_COSTO, PUBLICACION_PORC_VENTA, producto_id, vendedor_id, ALMACEN_CODIGO
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Producto producto ON maestra.PRODUCTO_CODIGO = producto.producto_codigo
										AND maestra.PRODUCTO_DESCRIPCION = producto.producto_descripcion
										AND maestra.PRODUCTO_PRECIO = producto.producto_precio
									JOIN SARTEN_QUE_LADRA.Vendedor vendedor ON maestra.VENDEDOR_CUIT = vendedor.vendedor_cuit
										AND maestra.VENDEDOR_RAZON_SOCIAL = vendedor.vendedor_razon_social
										AND maestra.VENDEDOR_MAIL = vendedor.vendedor_mail
									JOIN SARTEN_QUE_LADRA.Usuario usuario ON maestra.VEN_USUARIO_NOMBRE = usuario.usuario_nombre
										AND maestra.VEN_USUARIO_PASS = usuario.usuario_password
										AND maestra.VEN_USUARIO_FECHA_CREACION = usuario.usuario_fecha_creacion
	WHERE maestra.PUBLICACION_CODIGO IS NOT NULL AND PUBLICACION_DESCRIPCION IS NOT NULL AND PUBLICACION_STOCK IS NOT NULL AND PUBLICACION_FECHA_V IS NOT NULL 
		AND PUBLICACION_FECHA IS NOT NULL AND PUBLICACION_PRECIO IS NOT NULL AND PUBLICACION_COSTO IS NOT NULL AND PUBLICACION_PORC_VENTA IS NOT NULL 
		AND producto_id IS NOT NULL AND vendedor_id IS NOT NULL AND ALMACEN_CODIGO IS NOT NULL
END

GO

---------------------------------------------

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_ENVIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Envio(envio_numero, venta_codigo, envio_domicilio, envio_fecha_programada, envio_horario_inicio, envio_horario_fin, envio_costo, envio_fecha_hora_entrega, tipo_envio_id)
	SELECT DISTINCT VENTA_CODIGO, d.domicilio_id, ENVIO_FECHA_PROGAMADA, ENVIO_HORA_INICIO, ENVIO_HORA_FIN_INICIO, ENVIO_COSTO, ENVIO_FECHA_ENTREGA, t.tipo_envio_id from gd_esquema.Maestra 
	JOIN SARTEN_QUE_LADRA.Domicilio d ON 
    CLI_USUARIO_DOMICILIO_CALLE = d.domicilio_calle AND
    CLI_USUARIO_DOMICILIO_NRO_CALLE = d.domicilio_nro_calle AND
    CLI_USUARIO_DOMICILIO_PISO = d.domicilio_piso AND
	[CLI_USUARIO_DOMICILIO_DEPTO] = d.domicilio_depto AND
    CLI_USUARIO_DOMICILIO_CP = d.domicilio_cp
	JOIN SARTEN_QUE_LADRA.TipoEnvio t ON 
	ENVIO_TIPO = t.envio_nombre;
END

GO
---------------------
-------------------------------------------
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_TIPO_MEDIO_PAGO
AS BEGIN

	INSERT INTO SARTEN_QUE_LADRA.TipoMedioPago(tipo_medio_pago)
	SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO
	FROM gd_esquema.Maestra
	WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL

END

--MedioPago
GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MEDIO_PAGO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.MedioPago(medio_de_pago,id_tipo_medio_pago)
	SELECT DISTINCT tm.PAGO_MEDIO_PAGO, tmp.id_tipo_medio_pago --pasa a llamarse id_tipo_medio_pago
	FROM gd_esquema.Maestra tm, SARTEN_QUE_LADRA.TipoMedioPago tmp
	WHERE PAGO_MEDIO_PAGO IS NOT NULL AND
		   tmp.tipo_medio_pago = tm.PAGO_TIPO_MEDIO_PAGO
END
--Tabla temporal para ayudar con MedioXPago

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.AYUDA_PARA_MIGRAR_MEDIO_X_PAGO
AS BEGIN
	CREATE TABLE #PagoMedioDetalle(
		   venta_codigo decimal(18, 0), pago_importe decimal(18, 0), pago_fecha date, --Pago
		   tarjeta_numero NVARCHAR(50), tarjeta_fecha_vencimiento date, detalle_pago_cuotas decimal(18, 0), --DetallePago 
		   medio_de_pago NVARCHAR(50),id_medio_de_pago decimal(18, 0) NULL  --MedioPago
			)
	ALTER TABLE #PagoMedioDetalle
	ALTER COLUMN tarjeta_numero NVARCHAR(50)
	COLLATE Modern_Spanish_CI_AS
	ALTER TABLE #PagoMedioDetalle
	ALTER COLUMN medio_de_pago NVARCHAR(50)
	COLLATE Modern_Spanish_CI_AS
	INSERT INTO #PagoMedioDetalle(
		   venta_codigo, pago_importe, pago_fecha, --Pago
		   tarjeta_numero, tarjeta_fecha_vencimiento, detalle_pago_cuotas, --DetallePago 
		   medio_de_pago, id_medio_de_pago)
	SELECT tm.VENTA_CODIGO, tm.PAGO_IMPORTE, tm.PAGO_FECHA, --Pago 
		   tm.PAGO_NRO_TARJETA, tm.PAGO_FECHA_VENC_TARJETA, tm.PAGO_CANT_CUOTAS,--DetallePago
		   tm.PAGO_MEDIO_PAGO, mp.id_medio_de_pago--MedioPago con el id_medio_de_pago ya asignado
	FROM gd_esquema.Maestra tm
	LEFT JOIN  SARTEN_QUE_LADRA.MedioPago mp ON (mp.medio_de_pago = tm.PAGO_MEDIO_PAGO)
	WHERE tm.VENTA_CODIGO IS NOT NULL
END

--Pago
GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PAGO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Pago(venta_codigo, pago_importe, pago_fecha)
	SELECT venta_codigo, pago_importe, pago_fecha
	FROM SARTEN_QUE_LADRA.#PagoMedioDetalle
END

--DetallePago
GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DETALLE_PAGO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.DetallePago(tarjeta_numero, tarjeta_fecha_vencimiento, detalle_pago_cuotas)
	SELECT tarjeta_numero, tarjeta_fecha_vencimiento, detalle_pago_cuotas
	FROM SARTEN_QUE_LADRA.#PagoMedioDetalle
END

--MedioXPago
GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MEDIO_X_PAGO
	AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.MedioXPago(id_medio_de_pago, id_pago, id_detalle_pago)
	SELECT pmd.id_medio_de_pago, p.id_pago, dp.detalle_pago_id
	FROM SARTEN_QUE_LADRA.#PagoMedioDetalle pmd LEFT JOIN SARTEN_QUE_LADRA.Pago p ON (p.venta_codigo = pmd.venta_codigo) LEFT JOIN SARTEN_QUE_LADRA.DetallePago dp ON (dp.tarjeta_numero = pmd.tarjeta_numero)
END

GO
--Venta
--No funciona la conversion de Datetime a date ni a time
/*
GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_VENTA
AS BEGIN
INSERT INTO SARTEN_QUE_LADRA.Venta(venta_codigo, venta_fecha, venta_hora, venta_total)
SELECT VENTA_CODIGO, CONVERT(DATE, VENTA_FECHA), CONVERT(TIME, VENTA_FECHA), VENTA_TOTAL FROM gd_esquema.Maestra --Se podría aprovechar  #PagoMedioDetalle agregando un par de columnas
WHERE VENTA_CODIGO IS NOT NULL
END
*/

--------------------------------------------------------------
---- !

-- Esta si la cree, me caigo a los pedazos

SELECT  CLI_USUARIO_NOMBRE, 
		CLI_USUARIO_PASS,
		CLI_USUARIO_FECHA_CREACION 
from gd_esquema.Maestra

SELECT CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DNI, CLIENTE_FECHA_NAC, CLIENTE_MAIL from gd_esquema.Maestra
WHERE CLIENTE_NOMBRE IS NOT NULL
ORDER BY CLIENTE_NOMBRE, CLIENTE_APELLIDO

SELECT DISTINCT ALMACEN_CODIGO, ALMACEN_CALLE, ALMACEN_COSTO_DIA_AL, ALMACEN_NRO_CALLE, ALMACEN_Localidad, ALMACEN_PROVINCIA from gd_esquema.Maestra
SELECT DISTINCT PRODUCTO_CODIGO, PRODUCTO_MARCA from gd_esquema.Maestra

SELECT DISTINCT PRODUCTO_MOD_CODIGO, PRODUCTO_MOD_DESCRIPCION FROM gd_esquema.Maestra
where PRODUCTO_CODIGO = 'Codigo:6131231312'

SELECT  ENVIO_COSTO
		ENVIO_TIPO, 
		COUNT(*) from gd_esquema.Maestra
group by ENVIO_TIPO

SELECT DISTINCT CLI_USUARIO_NOMBRE, CLI_USUARIO_PASS, CLI_USUARIO_FECHA_CREACION,
			COUNT(*), COUNT(DISTINCT CLI_USUARIO_FECHA_CREACION) FROM gd_esquema.Maestra
GROUP BY CLI_USUARIO_NOMBRE, CLI_USUARIO_PASS, CLI_USUARIO_FECHA_CREACION
ORDER BY CLI_USUARIO_NOMBRE

SELECT 
*
FROM gd_esquema.Maestra


SELECT * FROM SARTEN_QUE_LADRA.Localidad a JOIN SARTEN_QUE_LADRA.Localidad b ON a.localidad_id = b.localidad_id
WHERE a.localidad_id != b.localidad_id and a.localidad_nombre = b.localidad_nombre

SELECT Provincia_id, provincia_nombre from SARTEN_QUE_LADRA.Provincia

SELECT 
	CLI_USUARIO_DOMICILIO_LOCALIDAD,
	CLI_USUARIO_DOMICILIO_PROVINCIA,
	VEN_USUARIO_DOMICILIO_LOCALIDAD,
	VEN_USUARIO_DOMICILIO_PROVINCIA,
	ALMACEN_Localidad,
	ALMACEN_PROVINCIA
from gd_esquema.Maestra

SELECT 
  CLIENTE_NOMBRE,
  CLIENTE_APELLIDO,
  CLIENTE_DNI,
  CLI_USUARIO_NOMBRE,
  CLI_USUARIO_PASS,
  CLI_USUARIO_FECHA_CREACION
FROM gd_esquema.Maestra
WHERE CLIENTE_NOMBRE = 'AARON' and CLI_USUARIO_FECHA_CREACION  = '2002-02-17'

SELECT VENDEDOR_MAIL, VEN_USUARIO_NOMBRE, VEN_USUARIO_PASS FROM gd_esquema.Maestra

-- ============================== -- 
--      EXEC PROCEDURES           --
-- ============================== --

EXEC SARTEN_QUE_LADRA.MIGRAR_PROVINCIA
EXEC SARTEN_QUE_LADRA.MIGRAR_MARCA
EXEC SARTEN_QUE_LADRA.MIGRAR_LOCALIDAD


-- BOLUDECES PARA PROBAR COSAS

select marca_nombre from SARTEN_QUE_LADRA.Marca

SELECT DISTINCT producto_marca from gd_esquema.Maestra
where PRODUCTO_MARCA IS NOT NULL

-- SI, HAY 4 MARCAS

SELECT PRODUCTO_MARCA from gd_esquema.Maestra
WHERE PRODUCTO_MARCA IS NOT NULL

EXEC SARTEN_QUE_LADRA.MIGRAR_PROVINCIA
DROP TABLE SARTEN_QUE_LADRA.Provincia
-- SELECT * FROM SARTEN_QUE_LADRA.Provincia 

-- DROP TABLE SARTEN_QUE_LADRA.ProductoX

CREATE TABLE SARTEN_QUE_LADRA.ProductoX (
	producto_codigo NVARCHAR(50) PRIMARY KEY,
	producto_descripcion NVARCHAR(50),
	producto_precio DECIMAL(18,2),
)

GO 

-- DROP PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PRODUCTO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PRODUCTO
AS BEGIN
INSERT INTO SARTEN_QUE_LADRA.ProductoX(producto_codigo, producto_descripcion, producto_precio)
	SELECT PRODUCTO_CODIGO, PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO, PRODUCTO_MARCA
	from gd_esquema.Maestra
	WHERE PRODUCTO_CODIGO IS NOT NULL

	PRINT 'Migración completada exitosamente.'
END
GO

EXEC SARTEN_QUE_LADRA.MIGRAR_PRODUCTO

SELECT * FROM SARTEN_QUE_LADRA.ProductoX

SELECT DISTINCT 
	PUBLICACION_CODIGO,
	PRODUCTO_CODIGO
FROM gd_esquema.Maestra
ORDER BY PUBLICACION_CODIGO

SELECT *
FROM gd_esquema.Maestra
WHERE PUBLICACION_CODIGO = '556925'

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'SARTEN_QUE_LADRA'

  SELECT *
FROM sys.objects
WHERE name = 'ProductoX'
  AND type = 'U';  -- 'U' es para tablas de usuario

  SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'ProductoX';

DROP TABLE SARTEN_QUE_LADRA.ProductoX;


-- ============================== --
--         CONSTRAINTS            --
-- ============================== --

-- FK -> SubrubroXRubro
ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro ADD CONSTRAINT fk_subrubroxrubro_rubro_id FOREIGN KEY (rubro_id) REFERENCES SARTEN_QUE_LADRA.Rubro (rubro_id);
ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro ADD CONSTRAINT fk_subrubroxrubro_subrubro_id FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.Subrubro (subrubro_id);

-- FK -> ModeloXProducto
ALTER TABLE SARTEN_QUE_LADRA.ModeloXProducto ADD CONSTRAINT fk_modeloproducto_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.Producto (producto_id);
ALTER TABLE SARTEN_QUE_LADRA.ModeloXProducto ADD CONSTRAINT fk_modeloproducto_modelo FOREIGN KEY (modelo_id) REFERENCES SARTEN_QUE_LADRA.Modelo (modelo_id);

-- FK -> MarcaXProducto
ALTER TABLE SARTEN_QUE_LADRA.MarcaXProducto ADD CONSTRAINT fk_marcaproducto_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.Producto (producto_id);
ALTER TABLE SARTEN_QUE_LADRA.MarcaXProducto ADD CONSTRAINT fk_marcaproducto_marca FOREIGN KEY (marca_id) REFERENCES SARTEN_QUE_LADRA.Marca (marca_id);

-- FK -> ProductoXSubrubro
ALTER TABLE SARTEN_QUE_LADRA.ProductoXSubrubro ADD CONSTRAINT fk_productosubrubro_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.Producto (producto_id);
ALTER TABLE SARTEN_QUE_LADRA.ProductoXSubrubro ADD CONSTRAINT fk_productosubrubro_subrubro FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.Subrubro (subrubro_id);

-- FK -> Localidad
ALTER TABLE SARTEN_QUE_LADRA.Localidad ADD CONSTRAINT fk_localidad_provincia FOREIGN KEY (provincia_id) REFERENCES SARTEN_QUE_LADRA.Provincia (provincia_id);
ALTER TABLE SARTEN_QUE_LADRA.Domicilio ADD CONSTRAINT fk_domicilio_localidad FOREIGN KEY (localidad_id) REFERENCES SARTEN_QUE_LADRA.Localidad (localidad_id);

-- FK -> DomicilioXUsuario
ALTER TABLE SARTEN_QUE_LADRA.DomicilioXUsuario ADD CONSTRAINT fk_domiciliousuario_usuario FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario (usuario_id);
ALTER TABLE SARTEN_QUE_LADRA.DomicilioXUsuario ADD CONSTRAINT fk_domiciliousuario_domicilio FOREIGN KEY (domicilio_id) REFERENCES SARTEN_QUE_LADRA.Domicilio (domicilio_id);

-- FK -> Cliente
ALTER TABLE SARTEN_QUE_LADRA.Cliente ADD CONSTRAINT fk_cliente_usuario FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario (usuario_id);
ALTER TABLE SARTEN_QUE_LADRA.Vendedor ADD CONSTRAINT fk_vendedor_usuario FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario (usuario_id);

-- FK -> Envio
ALTER TABLE SARTEN_QUE_LADRA.Envio ADD CONSTRAINT fk_envio_venta FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.Venta (venta_codigo);
ALTER TABLE SARTEN_QUE_LADRA.Envio ADD CONSTRAINT fk_envio_domicilio FOREIGN KEY (envio_domicilio) REFERENCES SARTEN_QUE_LADRA.Domicilio (domicilio_id);
ALTER TABLE SARTEN_QUE_LADRA.Envio ADD CONSTRAINT fk_envio_tipo_envio FOREIGN KEY (tipo_envio_id) REFERENCES SARTEN_QUE_LADRA.TipoEnvio (tipo_envio_id);

-- FK -> Factura
ALTER TABLE SARTEN_QUE_LADRA.Factura ADD CONSTRAINT fk_factura_vendedor FOREIGN KEY (vendedor_id) REFERENCES SARTEN_QUE_LADRA.Vendedor (localidad_id);

-- FK -> Almacen
ALTER TABLE SARTEN_QUE_LADRA.Almacen ADD CONSTRAINT fk_almacen_localidad FOREIGN KEY (localidad_id) REFERENCES SARTEN_QUE_LADRA.Localidad;

-- FK -> Publicacion
ALTER TABLE SARTEN_QUE_LADRA.Publicacion ADD CONSTRAINT fk_publicacion_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.Producto;
ALTER TABLE SARTEN_QUE_LADRA.Publicacion ADD CONSTRAINT fk_publicacion_vendedor FOREIGN KEY (vendedor_id) REFERENCES SARTEN_QUE_LADRA.Vendedor;
ALTER TABLE SARTEN_QUE_LADRA.Publicacion ADD CONSTRAINT fk_publicacion_almacen FOREIGN KEY (almacen_codigo) REFERENCES SARTEN_QUE_LADRA.Almacen;

-- FK -> DetalleFactura
ALTER TABLE SARTEN_QUE_LADRA.DetalleFactura ADD CONSTRAINT fk_detallefactura_publicacion FOREIGN KEY (publicacion_codigo) REFERENCES SARTEN_QUE_LADRA.Publicacion;
ALTER TABLE SARTEN_QUE_LADRA.DetalleFactura ADD CONSTRAINT fk_detallefactura_concepto FOREIGN KEY (detalle_concepto_id) REFERENCES SARTEN_QUE_LADRA.Concepto;
ALTER TABLE SARTEN_QUE_LADRA.DetalleFactura ADD CONSTRAINT fk_detallefactura_factura FOREIGN KEY (factura_numero) REFERENCES SARTEN_QUE_LADRA.Factura;

-- FK -> DetalleVenta
ALTER TABLE SARTEN_QUE_LADRA.DetalleVenta ADD CONSTRAINT fk_detalleventa_venta FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.Venta;
ALTER TABLE SARTEN_QUE_LADRA.DetalleVenta ADD CONSTRAINT fk_detalleventa_concepto FOREIGN KEY (detalle_concepto_id) REFERENCES SARTEN_QUE_LADRA.Concepto;
ALTER TABLE SARTEN_QUE_LADRA.DetalleVenta ADD CONSTRAINT fk_detalleventa_publicacion FOREIGN KEY (publicacion_codigo) REFERENCES SARTEN_QUE_LADRA.Publicacion;

-- FK -> Pago
ALTER TABLE SARTEN_QUE_LADRA.Pago ADD CONSTRAINT fk_pago_venta FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.Venta;

-- FK -> MedioXPago
ALTER TABLE SARTEN_QUE_LADRA.MedioXPago ADD CONSTRAINT fk_mediopago_pago FOREIGN KEY (id_pago) REFERENCES SARTEN_QUE_LADRA.Pago;
ALTER TABLE SARTEN_QUE_LADRA.MedioXPago ADD CONSTRAINT fk_mediopago_mediodepago FOREIGN KEY (id_medio_de_pago) REFERENCES SARTEN_QUE_LADRA.MedioPago;
ALTER TABLE SARTEN_QUE_LADRA.MedioXPago ADD CONSTRAINT fk_mediopago_detallepago FOREIGN KEY (id_detalle_pago) REFERENCES SARTEN_QUE_LADRA.DetallePago;

-- FK -> MedioPago
ALTER TABLE SARTEN_QUE_LADRA.MedioPago ADD CONSTRAINT fk_mediopago_tipomediopago FOREIGN KEY (tipo_medio_pago) REFERENCES SARTEN_QUE_LADRA.TipoMedioPago;

GO
