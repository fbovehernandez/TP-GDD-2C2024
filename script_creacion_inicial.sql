USE GD2C2024
GO
CREATE SCHEMA SARTEN_QUE_LADRA -- Ya existe
GO

-- ============================== --
--          TABLAS				  --
-- ============================== --

CREATE TABLE SARTEN_QUE_LADRA.Rubro (
	rubro_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	rubro_descripcion VARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Subrubro (
	subrubro_id DECIMAL(18,0) PRIMARY KEY,
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
	producto_codigo NVARCHAR(50) PRIMARY KEY,
	producto_descripcion NVARCHAR(50),
	subrubro_id DECIMAL(18,0),
	modelo_codigo DECIMAL(18,0),
	producto_precio DECIMAL(18,2),
);

CREATE TABLE SARTEN_QUE_LADRA.MarcaXProducto (
	producto_codigo NVARCHAR(50),
	marca_id DECIMAL(18,0),
	PRIMARY KEY (producto_codigo, marca_id),
);

CREATE TABLE SARTEN_QUE_LADRA.ProductoXSubrubro (
	producto_codigo NVARCHAR(50),
	subrubro_id DECIMAL(18,0),
	PRIMARY KEY (producto_codigo, subrubro_id),
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
	cliente_id DECIMAL(18,0) PRIMARY KEY,
	cliente_nombre NVARCHAR(50),
	cliente_apellido NVARCHAR(50),
	cliente_fecha_nac DATE,
	cliente_mail NVARCHAR(50),
	cliente_dni NVARCHAR(50),
	usuario_id DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.Vendedor(
	localidad_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
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
	venta_fecha DATETIME,
	venta_hora DATETIME,
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
	producto_codigo NVARCHAR(50),
	vendedor_id DECIMAL(18,0),
	almacen_codigo DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.Concepto (
	detalle_concepto_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	precio DECIMAL(18,2),
	cantidad DECIMAL(18,0),
	subtotal DECIMAL(18,2)
);

CREATE TABLE SARTEN_QUE_LADRA.DetalleFactura(
	detalle_factura_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	publicacion_codigo DECIMAL(18,0),
	detalle_concepto_id DECIMAL(18,0),
	detalle_factura_total DECIMAL(18,2),
	factura_numero DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.DetalleVenta(
	venta_codigo DECIMAL(18,0),
	detalle_concepto_id DECIMAL(18,0),
	publicacion_codigo DECIMAL(18,0),
	detalle_venta_total DECIMAL(18,2),
);

CREATE TABLE Pago (
	id_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	pago_importe DECIMAL(18,2),
	pago_fecha DATE 
)

CREATE TABLE DetallePago (
	detalle_pago_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	tarjeta_numero NVARCHAR(50),
	tarjeta_fecha_vencimiento DATE,
	detalle_pago_cuotas DECIMAL(18,0),
	id_medio_x_pago DECIMAL(18,0),
)

CREATE TABLE TipoMedioPago (
	id_medio_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	tipo_medio_pago NVARCHAR(50)
)

CREATE TABLE MedioPago(
	id_medio_de_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	medio_de_pago NVARCHAR(50),
	tipo_medio_pago DECIMAL(18,0),
);

CREATE TABLE MedioXPago(
	id_medio_x_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	id_pago DECIMAL(18,0),
	id_medio_de_pago DECIMAL(18,0),
	id_detalle_pago DECIMAL(18,0),
);

-- ============================== --
--         CONSTRAINTS            --
-- ============================== --

-- FK -> SubrubroXRubro
ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro ADD CONSTRAINT fk_subrubroxrubro_rubro_id FOREIGN KEY (rubro_id) REFERENCES SARTEN_QUE_LADRA.Rubro (rubro_id);
ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro ADD CONSTRAINT fk_subrubroxrubro_subrubro_id FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.Subrubro (subrubro_id);

-- FK -> Producto
ALTER TABLE SARTEN_QUE_LADRA.Producto ADD CONSTRAINT fk_producto_subrubro FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.Subrubro (subrubro_id);
ALTER TABLE SARTEN_QUE_LADRA.Producto ADD CONSTRAINT fk_producto_modelo FOREIGN KEY (modelo_codigo) REFERENCES SARTEN_QUE_LADRA.Modelo (modelo_codigo);

-- FK -> MarcaXProducto
ALTER TABLE SARTEN_QUE_LADRA.MarcaXProducto ADD CONSTRAINT fk_marcaproducto_producto FOREIGN KEY (producto_codigo) REFERENCES SARTEN_QUE_LADRA.Producto (producto_codigo);
ALTER TABLE SARTEN_QUE_LADRA.MarcaXProducto ADD CONSTRAINT fk_marcaproducto_marca FOREIGN KEY (marca_id) REFERENCES SARTEN_QUE_LADRA.Marca (marca_id);

-- FK -> ProductoXSubrubro
ALTER TABLE SARTEN_QUE_LADRA.ProductoXSubrubro ADD CONSTRAINT fk_productosubrubro_producto FOREIGN KEY (producto_codigo) REFERENCES SARTEN_QUE_LADRA.Producto (producto_codigo);
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
ALTER TABLE SARTEN_QUE_LADRA.Publicacion ADD CONSTRAINT fk_publicacion_producto FOREIGN KEY (producto_codigo) REFERENCES SARTEN_QUE_LADRA.Producto;
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
ALTER TABLE Pago ADD CONSTRAINT fk_pago_venta FOREIGN KEY (venta_codigo) REFERENCES Venta;

-- FK -> MedioXPago
ALTER TABLE MedioXPago ADD CONSTRAINT fk_mediopago_pago FOREIGN KEY (id_pago) REFERENCES Pago;
ALTER TABLE MedioXPago ADD CONSTRAINT fk_mediopago_mediodepago FOREIGN KEY (id_medio_de_pago) REFERENCES MedioPago;
ALTER TABLE MedioXPago ADD CONSTRAINT fk_mediopago_detallepago FOREIGN KEY (id_detalle_pago) REFERENCES DetallePago;

-- FK -> MedioPago
ALTER TABLE MedioPago ADD CONSTRAINT fk_mediopago_tipomediopago FOREIGN KEY (tipo_medio_pago) REFERENCES TipoMedioPago;

GO

-- ============================== -- 
--      STORED PROCEDURES         --
-- ============================== --

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

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MARCA 
AS BEGIN 
    INSERT INTO SARTEN_QUE_LADRA.Marca(marca_nombre)
	SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra
	WHERE PRODUCTO_MARCA IS NOT NULL
END

GO

-- ============================== -- 
--      EXEC PROCEDURES           --
-- ============================== --

EXEC SARTEN_QUE_LADRA.MIGRAR_PROVINCIA
EXEC SARTEN_QUE_LADRA.MIGRAR_MARCA


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

-- GITGITGIT
