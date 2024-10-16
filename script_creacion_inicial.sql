USE GD2C2024
GO
CREATE SCHEMA SARTEN_QUE_LADRA
GO
USE GD2C2024
GO
CREATE SCHEMA SARTEN_QUE_LADRA
GO

CREATE TABLE Rubro (
	rubro_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	rubro_descripcion VARCHAR(50)
)

CREATE TABLE Subrubro (
	subrubro_id DECIMAL(18,0) PRIMARY KEY,
	subrubro_rubro NVARCHAR(50)
)

CREATE TABLE SubrubroXRubro (
	subrubro_id DECIMAL(18,0),
	rubro_id DECIMAL(18,0)
	PRIMARY KEY (subrubro_id, rubro_id)
)

ALTER TABLE SubrubroXRubro WITH CHECK ADD FOREIGN KEY (rubro_id) references Rubro
ALTER TABLE SubrubroXRubro WITH CHECK ADD FOREIGN KEY (subrubro_id) references Subrubro

CREATE TABLE Marca (
	marca_id DECIMAL(18,0) PRIMARY KEY,
	marca_nombre NVARCHAR(50)
)

CREATE TABLE Modelo (
	modelo_codigo DECIMAL(18,0) PRIMARY KEY,
	modelo_descripcion NVARCHAR(50)
)

CREATE TABLE Producto (
	producto_codigo NVARCHAR(50) PRIMARY KEY,
	producto_descripcion NVARCHAR(50),
	subrubro_id DECIMAL(18,0),
	modelo_codigo DECIMAL(18,0),
	producto_precio DECIMAL(18,2),
	FOREIGN KEY (subrubro_id) REFERENCES Subrubro,
	FOREIGN KEY (modelo_codigo) REFERENCES Modelo
)

CREATE TABLE MarcaXProducto (
	producto_codigo NVARCHAR(50),
	marca_id DECIMAL(18,0),
	PRIMARY KEY (producto_codigo, marca_id),
	FOREIGN KEY (producto_codigo) REFERENCES Producto,
	FOREIGN KEY (marca_id) REFERENCES Marca
)

CREATE TABLE ProductoXSubrubro (
	producto_codigo NVARCHAR(50),
	subrubro_id DECIMAL(18,0),
	PRIMARY KEY (producto_codigo, subrubro_id),
	FOREIGN KEY (producto_codigo) REFERENCES Producto,
	FOREIGN KEY (subrubro_id) REFERENCES Subrubro
)

CREATE TABLE Provincia(
	provincia_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	provincia_nombre NVARCHAR(50)
);

CREATE TABLE Localidad(
	localidad_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	provincia_id DECIMAL(18,0),
	localidad_nombre NVARCHAR(50),
	FOREIGN KEY (provincia_id) REFERENCES Provincia
);

CREATE TABLE Domicilio(
	domicilio_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	domicilio_calle NVARCHAR(50),
	domicilio_nro_calle DECIMAL(18,0),
	domicilio_piso DECIMAL(18,0),
	domicilio_depto NVARCHAR(50),
	domicilio_cp NVARCHAR(50),
	localidad_id DECIMAL(18,0),
	FOREIGN KEY (localidad_id) REFERENCES Localidad
);

CREATE TABLE Usuario (
	usuario_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	usuario_nombre NVARCHAR(50),
	usuario_password NVARCHAR(50),
	usuario_fecha_creacion DATE
)

CREATE TABLE DomicilioXUsuario(
	usuario_id DECIMAL(18,0),
	domicilio_id DECIMAL(18,0),
	PRIMARY KEY (usuario_id, domicilio_id),
	FOREIGN KEY (usuario_id) REFERENCES Usuario,
	FOREIGN KEY (domicilio_id) REFERENCES Domicilio
);

CREATE TABLE Cliente (
	cliente_id DECIMAL(18,0) PRIMARY KEY,
	cliente_nombre NVARCHAR(50),
	cliente_apellido NVARCHAR(50),
	cliente_fecha_nac DATE,
	cliente_mail NVARCHAR(50),
	cliente_dni NVARCHAR(50),
	usuario_id DECIMAL(18,0),
	FOREIGN KEY (usuario_id) REFERENCES Usuario
)

CREATE TABLE Vendedor(
	localidad_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	vendedor_cuit NVARCHAR(50),
	vendedor_razon_social NVARCHAR(50),
	vendedor_mail NVARCHAR(50),
	usuario_id DECIMAL(18,0),
	FOREIGN KEY (usuario_id) REFERENCES Usuario
);

CREATE TABLE TipoEnvio (
	tipo_envio_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	envio_nombre NVARCHAR(50)
)

CREATE TABLE Venta ( 
	venta_codigo DECIMAL(18,0)  PRIMARY KEY, 
	cliente_id DECIMAL(18,0),
	venta_fecha DATETIME,
	FOREIGN KEY (cliente_id) REFERENCES Cliente,
	venta_hora DATETIME,
	venta_total DECIMAL(18,2)
)

CREATE TABLE Envio (
	envio_numero DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	envio_domicilio DECIMAL(18,0),
	envio_fecha_programada DATETIME,
	envio_horario_inicio DECIMAL(18,0),
	envio_horario_fin DECIMAL(18,0),
	envio_costo DECIMAL(18,2),
	envio_fecha_hora_entrega DATETIME,
	tipo_envio_id DECIMAL(18,0),
	FOREIGN KEY (venta_codigo) REFERENCES Venta,
	FOREIGN KEY (envio_domicilio) REFERENCES Domicilio,
	FOREIGN KEY (tipo_envio_id) REFERENCES TipoEnvio
)

CREATE TABLE Factura(
	factura_numero DECIMAL(18,0) PRIMARY KEY,
	factura_fecha DATE,
	vendedor_id DECIMAL(18,0),
	factura_total DECIMAL(18,2),
	FOREIGN KEY (vendedor_id) REFERENCES Vendedor
);

CREATE TABLE Almacen(
	almacen_codigo DECIMAL(18,0) PRIMARY KEY,
	almacen_calle NVARCHAR(50),
	almacen_nro_calle DECIMAL(18,0),
	almacen_costo_dia_al DECIMAL(18,2),
	localidad_id DECIMAL(18,0),
	FOREIGN KEY (localidad_id) REFERENCES Localidad
);

CREATE TABLE Publicacion (
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
	FOREIGN KEY (producto_codigo) REFERENCES Producto,
	FOREIGN KEY (vendedor_id) REFERENCES Vendedor,
	FOREIGN KEY (almacen_codigo) REFERENCES Almacen
)

CREATE TABLE Concepto(
	detalle_concepto_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	precio DECIMAL(18,2),
	cantidad DECIMAL(18,0),
	subtotal DECIMAL(18,2)
);

CREATE TABLE DetalleFactura(
	detalle_factura_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	publicacion_codigo DECIMAL(18,0),
	detalle_concepto_id DECIMAL(18,0),
	detalle_factura_total DECIMAL(18,2),
	factura_numero DECIMAL(18,0),
	FOREIGN KEY (publicacion_codigo) REFERENCES Publicacion,
	FOREIGN KEY (detalle_concepto_id) REFERENCES Concepto,
	FOREIGN KEY (factura_numero) REFERENCES Factura
);

CREATE TABLE DetalleVenta (
	detalle_venta_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	publicacion_codigo DECIMAL(18,0),
	detalle_cantidad NVARCHAR(50),
	detalle_subtotal DECIMAL(18,2),
	detalle_precio DECIMAL(18,2),
	FOREIGN KEY (venta_codigo) REFERENCES Venta,
	FOREIGN KEY (publicacion_codigo) REFERENCES Publicacion
)

CREATE TABLE Pago (
	id_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	FOREIGN KEY (venta_codigo) REFERENCES Venta,
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
	FOREIGN KEY (tipo_medio_pago) REFERENCES TipoMedioPago
);

CREATE TABLE MedioXPago(
	id_medio_x_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	id_pago DECIMAL(18,0),
	id_medio_de_pago DECIMAL(18,0),
	id_detalle_pago DECIMAL(18,0),
	FOREIGN KEY (id_pago) REFERENCES Pago,
	FOREIGN KEY (id_medio_de_pago) REFERENCES MedioPago,
	FOREIGN KEY (id_detalle_pago) REFERENCES DetallePago
);

ALTER TABLE DetallePago WITH CHECK ADD FOREIGN KEY (id_medio_x_pago) REFERENCES MedioXPago


