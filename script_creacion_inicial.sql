USE GD2C2024
GO
CREATE SCHEMA SARTEN_QUE_LADRA
GO

CREATE TABLE SARTEN_QUE_LADRA.Rubro (
	rubro_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	rubro_descripcion VARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.Subrubro (
	subrubro_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	subrubro_rubro NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.SubrubroXRubro (
	subrubro_id DECIMAL(18,0),
	rubro_id DECIMAL(18,0)
	PRIMARY KEY (subrubro_id, rubro_id)
)

ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro WITH CHECK ADD FOREIGN KEY (rubro_id) REFERENCES SARTEN_QUE_LADRA.Rubro
ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro WITH CHECK ADD FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.Subrubro

CREATE TABLE SARTEN_QUE_LADRA.Marca (
	marca_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	marca_nombre NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.Modelo (
	modelo_codigo DECIMAL(18,0) PRIMARY KEY,
	modelo_descripcion NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.Producto (
	producto_codigo NVARCHAR(50) PRIMARY KEY,
	producto_descripcion NVARCHAR(50),
	modelo_codigo DECIMAL(18,0),
	producto_precio DECIMAL(18,2),
	FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.Subrubro,
	FOREIGN KEY (modelo_codigo) REFERENCES SARTEN_QUE_LADRA.Modelo
)

CREATE TABLE SARTEN_QUE_LADRA.MarcaXProducto (
	producto_codigo NVARCHAR(50),
	marca_id DECIMAL(18,0),
	PRIMARY KEY (producto_codigo, marca_id),
	FOREIGN KEY (producto_codigo) REFERENCES SARTEN_QUE_LADRA.Producto,
	FOREIGN KEY (marca_id) REFERENCES SARTEN_QUE_LADRA.Marca
)

CREATE TABLE SARTEN_QUE_LADRA.ProductoXSubrubro (
	producto_codigo NVARCHAR(50),
	subrubro_id DECIMAL(18,0),
	PRIMARY KEY (producto_codigo, subrubro_id),
	FOREIGN KEY (producto_codigo) REFERENCES SARTEN_QUE_LADRA.Producto,
	FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.Subrubro
)

CREATE TABLE SARTEN_QUE_LADRA.Provincia(
	provincia_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	provincia_nombre NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.Localidad(
	localidad_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	provincia_id DECIMAL(18,0),
	localidad_nombre NVARCHAR(50),
	FOREIGN KEY (provincia_id) REFERENCES SARTEN_QUE_LADRA.Provincia
);

CREATE TABLE SARTEN_QUE_LADRA.Domicilio(
	domicilio_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	domicilio_calle NVARCHAR(50),
	domicilio_nro_calle DECIMAL(18,0),
	domicilio_piso DECIMAL(18,0),
	domicilio_depto NVARCHAR(50),
	domicilio_cp NVARCHAR(50),
	localidad_id DECIMAL(18,0),
	FOREIGN KEY (localidad_id) REFERENCES SARTEN_QUE_LADRA.Localidad
);

CREATE TABLE SARTEN_QUE_LADRA.Usuario (
	usuario_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	usuario_nombre NVARCHAR(50),
	usuario_password NVARCHAR(50),
	usuario_fecha_creacion DATE
)

CREATE TABLE SARTEN_QUE_LADRA.DomicilioXUsuario(
	usuario_id DECIMAL(18,0),
	domicilio_id DECIMAL(18,0),
	PRIMARY KEY (usuario_id, domicilio_id),
	FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario,
	FOREIGN KEY (domicilio_id) REFERENCES SARTEN_QUE_LADRA.Domicilio
);

CREATE TABLE SARTEN_QUE_LADRA.Cliente (
	cliente_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	cliente_nombre NVARCHAR(50),
	cliente_apellido NVARCHAR(50),
	cliente_fecha_nac DATE,
	cliente_mail NVARCHAR(50),
	cliente_dni NVARCHAR(50),
	usuario_id DECIMAL(18,0),
	FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario
)

CREATE TABLE SARTEN_QUE_LADRA.Vendedor(
	vendedor_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	vendedor_cuit NVARCHAR(50),
	vendedor_razon_social NVARCHAR(50),
	vendedor_mail NVARCHAR(50),
	usuario_id DECIMAL(18,0),
	FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario
);

CREATE TABLE SARTEN_QUE_LADRA.TipoEnvio (
	tipo_envio_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	envio_nombre NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.Venta ( 
	venta_codigo DECIMAL(18,0)  PRIMARY KEY, 
	cliente_id DECIMAL(18,0),
	venta_fecha DATETIME,
	FOREIGN KEY (cliente_id) REFERENCES SARTEN_QUE_LADRA.Cliente,
	venta_hora DATETIME,
	venta_total DECIMAL(18,2)
)

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
	FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.Venta,
	FOREIGN KEY (envio_domicilio) REFERENCES SARTEN_QUE_LADRA.Domicilio,
	FOREIGN KEY (tipo_envio_id) REFERENCES SARTEN_QUE_LADRA.TipoEnvio
)

CREATE TABLE SARTEN_QUE_LADRA.Factura(
	factura_numero DECIMAL(18,0) PRIMARY KEY,
	factura_fecha DATE,
	vendedor_id DECIMAL(18,0),
	factura_total DECIMAL(18,2),
	FOREIGN KEY (vendedor_id) REFERENCES SARTEN_QUE_LADRA.Vendedor
);

CREATE TABLE SARTEN_QUE_LADRA.Almacen(
	almacen_codigo DECIMAL(18,0) PRIMARY KEY,
	almacen_calle NVARCHAR(50),
	almacen_nro_calle DECIMAL(18,0),
	almacen_costo_dia_al DECIMAL(18,2),
	localidad_id DECIMAL(18,0),
	FOREIGN KEY (localidad_id) REFERENCES SARTEN_QUE_LADRA.Localidad
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
	FOREIGN KEY (producto_codigo) REFERENCES SARTEN_QUE_LADRA.Producto,
	FOREIGN KEY (vendedor_id) REFERENCES SARTEN_QUE_LADRA.Vendedor,
	FOREIGN KEY (almacen_codigo) REFERENCES SARTEN_QUE_LADRA.Almacen
)

CREATE TABLE SARTEN_QUE_LADRA.Concepto(
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
	FOREIGN KEY (publicacion_codigo) REFERENCES SARTEN_QUE_LADRA.Publicacion,
	FOREIGN KEY (detalle_concepto_id) REFERENCES SARTEN_QUE_LADRA.Concepto,
	FOREIGN KEY (factura_numero) REFERENCES SARTEN_QUE_LADRA.Factura
);

CREATE TABLE SARTEN_QUE_LADRA.DetalleVenta (
	detalle_venta_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	publicacion_codigo DECIMAL(18,0),
	detalle_cantidad NVARCHAR(50),
	detalle_subtotal DECIMAL(18,2),
	detalle_precio DECIMAL(18,2),
	FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.Venta,
	FOREIGN KEY (publicacion_codigo) REFERENCES SARTEN_QUE_LADRA.Publicacion
)

CREATE TABLE SARTEN_QUE_LADRA.Pago (
	id_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.Venta,
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
	id_medio_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	tipo_medio_pago NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.MedioPago(
	id_medio_de_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	medio_de_pago NVARCHAR(50),
	tipo_medio_pago DECIMAL(18,0),
	FOREIGN KEY (tipo_medio_pago) REFERENCES SARTEN_QUE_LADRA.TipoMedioPago
);

CREATE TABLE SARTEN_QUE_LADRA.MedioXPago(
	id_medio_x_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	id_pago DECIMAL(18,0),
	id_medio_de_pago DECIMAL(18,0),
	id_detalle_pago DECIMAL(18,0),
	FOREIGN KEY (id_pago) REFERENCES SARTEN_QUE_LADRA.Pago,
	FOREIGN KEY (id_medio_de_pago) REFERENCES SARTEN_QUE_LADRA.MedioPago,
	FOREIGN KEY (id_detalle_pago) REFERENCES SARTEN_QUE_LADRA.DetallePago
);

ALTER TABLE SARTEN_QUE_LADRA.DetallePago WITH CHECK ADD FOREIGN KEY (id_medio_x_pago) REFERENCES SARTEN_QUE_LADRA.MedioXPago
