USE GD2C2024
GO
--CREATE SCHEMA SARTEN_QUE_LADRA
GO

-- ============================== --
--          TABLAS		  --
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

CREATE TABLE SARTEN_QUE_LADRA.ModeloXProducto (
	producto_id DECIMAL(18,0),
	modelo_id DECIMAL(18,0),
	PRIMARY KEY (producto_id, modelo_id)
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
	producto_id DECIMAL(18,0),
	vendedor_id DECIMAL(18,0), -- Por ahora lo dejo como vendedor ID
	almacen_codigo DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.Concepto (
	detalle_concepto_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	concepto_tipo NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.DetalleFactura (
	detalle_factura_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	publicacion_codigo DECIMAL(18,0),
	detalle_concepto_id DECIMAL(18,0),
	factura_numero DECIMAL(18,0),
	detalle_factura_precio DECIMAL(18,2),
	detalle_factura_cantidad DECIMAL(18,0),
	detalle_factura_subtotal DECIMAL(18,2)
);

CREATE TABLE SARTEN_QUE_LADRA.DetalleVenta(
	detalle_venta_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	venta_codigo DECIMAL(18,0),
	publicacion_codigo DECIMAL(18,0),
	detalle_cantidad DECIMAL(18,0),
	detalle_subtotal DECIMAL(18,0),
	detalle_precio DECIMAL(18,2),
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
)

CREATE TABLE SARTEN_QUE_LADRA.TipoMedioPago (
	id_medio_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	tipo_medio_pago NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.MedioPago(
	id_medio_de_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	medio_de_pago NVARCHAR(50),
	tipo_medio_pago DECIMAL(18,0)
);

CREATE TABLE SARTEN_QUE_LADRA.MedioXPago(
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

-- FK -> ModeloXProducto
ALTER TABLE SARTEN_QUE_LADRA.ModeloXProducto ADD CONSTRAINT fk_modeloproducto_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.Producto (producto_id);
ALTER TABLE SARTEN_QUE_LADRA.ModeloXProducto ADD CONSTRAINT fk_modeloproducto_modelo FOREIGN KEY (modelo_id) REFERENCES SARTEN_QUE_LADRA.Modelo (modelo_codigo);

-- FK -> MarcaXProducto
ALTER TABLE SARTEN_QUE_LADRA.MarcaXProducto ADD CONSTRAINT fk_marcaproducto_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.Producto (producto_id);
ALTER TABLE SARTEN_QUE_LADRA.MarcaXProducto ADD CONSTRAINT fk_marcaproducto_marca FOREIGN KEY (marca_id) REFERENCES SARTEN_QUE_LADRA.Marca (marca_id);

-- FK -> ProductoXSubrubro
ALTER TABLE SARTEN_QUE_LADRA.ProductoXSubrubro ADD CONSTRAINT fk_productosubrubro_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.Producto (producto_id);
ALTER TABLE SARTEN_QUE_LADRA.ProductoXSubrubro ADD CONSTRAINT fk_productosubrubro_subrubro FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.Subrubro (subrubro_id);

-- FK -> Localidad
ALTER TABLE SARTEN_QUE_LADRA.Localidad ADD CONSTRAINT fk_localidad_provincia FOREIGN KEY (provincia_id) REFERENCES SARTEN_QUE_LADRA.Provincia (provincia_id);

-- FK -> Domicilio
ALTER TABLE SARTEN_QUE_LADRA.Domicilio ADD CONSTRAINT fk_domicilio_localidad FOREIGN KEY (localidad_id) REFERENCES SARTEN_QUE_LADRA.Localidad (localidad_id);

-- FK -> DomicilioXUsuario
ALTER TABLE SARTEN_QUE_LADRA.DomicilioXUsuario ADD CONSTRAINT fk_domiciliousuario_usuario FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario (usuario_id);
ALTER TABLE SARTEN_QUE_LADRA.DomicilioXUsuario ADD CONSTRAINT fk_domiciliousuario_domicilio FOREIGN KEY (domicilio_id) REFERENCES SARTEN_QUE_LADRA.Domicilio (domicilio_id);

-- FK -> Cliente y vendedor
ALTER TABLE SARTEN_QUE_LADRA.Cliente ADD CONSTRAINT fk_cliente_usuario FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario (usuario_id);
ALTER TABLE SARTEN_QUE_LADRA.Vendedor ADD CONSTRAINT fk_vendedor_usuario FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.Usuario (usuario_id);

-- FK -> Envio
ALTER TABLE SARTEN_QUE_LADRA.Envio ADD CONSTRAINT fk_envio_venta FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.Venta (venta_codigo);
ALTER TABLE SARTEN_QUE_LADRA.Envio ADD CONSTRAINT fk_envio_domicilio FOREIGN KEY (envio_domicilio) REFERENCES SARTEN_QUE_LADRA.Domicilio (domicilio_id);
ALTER TABLE SARTEN_QUE_LADRA.Envio ADD CONSTRAINT fk_envio_tipo_envio FOREIGN KEY (tipo_envio_id) REFERENCES SARTEN_QUE_LADRA.TipoEnvio (tipo_envio_id);

-- FK -> Factura
ALTER TABLE SARTEN_QUE_LADRA.Factura ADD CONSTRAINT fk_factura_vendedor FOREIGN KEY (vendedor_id) REFERENCES SARTEN_QUE_LADRA.Vendedor (vendedor_id);

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
ALTER TABLE SARTEN_QUE_LADRA.DetalleVenta ADD CONSTRAINT fk_detalleventa_publicacion FOREIGN KEY (publicacion_codigo) REFERENCES SARTEN_QUE_LADRA.Publicacion;

-- FK -> Venta
ALTER TABLE SARTEN_QUE_LADRA.Venta ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (cliente_id) REFERENCES SARTEN_QUE_LADRA.Cliente;

-- FK -> Pago
ALTER TABLE SARTEN_QUE_LADRA.Pago ADD CONSTRAINT fk_pago_venta FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.Venta;

-- FK -> MedioXPago
ALTER TABLE SARTEN_QUE_LADRA.MedioXPago ADD CONSTRAINT fk_mediopago_pago FOREIGN KEY (id_pago) REFERENCES SARTEN_QUE_LADRA.Pago;
ALTER TABLE SARTEN_QUE_LADRA.MedioXPago ADD CONSTRAINT fk_mediopago_mediodepago FOREIGN KEY (id_medio_de_pago) REFERENCES SARTEN_QUE_LADRA.MedioPago;
ALTER TABLE SARTEN_QUE_LADRA.MedioXPago ADD CONSTRAINT fk_mediopago_detallepago FOREIGN KEY (id_detalle_pago) REFERENCES SARTEN_QUE_LADRA.DetallePago;

-- FK -> MedioPago
ALTER TABLE SARTEN_QUE_LADRA.MedioPago ADD CONSTRAINT fk_mediopago_tipomediopago FOREIGN KEY (tipo_medio_pago) REFERENCES SARTEN_QUE_LADRA.TipoMedioPago;

GO

-- ============================== -- 
--      STORED PROCEDURES         --
-- ============================== --

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
	JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_nombre = ALMACEN_PROVINCIA
    WHERE ALMACEN_Localidad IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DOMICILIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Domicilio(domicilio_calle, domicilio_cp, domicilio_depto, domicilio_nro_calle, domicilio_piso, localidad_id)
	SELECT DISTINCT CLI_USUARIO_DOMICILIO_CALLE, CLI_USUARIO_DOMICILIO_CP, CLI_USUARIO_DOMICILIO_DEPTO,
        CLI_USUARIO_DOMICILIO_NRO_CALLE, CLI_USUARIO_DOMICILIO_PISO, loc.localidad_id
    FROM gd_esquema.Maestra m
    JOIN (
        -- Subconsulta para combinar Localidad y Provincia
        SELECT l.localidad_id, l.localidad_nombre, p.provincia_nombre
        FROM SARTEN_QUE_LADRA.Localidad l
        JOIN SARTEN_QUE_LADRA.Provincia p ON l.provincia_id = p.provincia_id
    ) AS loc ON loc.localidad_nombre = m.CLI_USUARIO_DOMICILIO_LOCALIDAD
            AND loc.provincia_nombre = m.CLI_USUARIO_DOMICILIO_PROVINCIA
    WHERE m.CLI_USUARIO_DOMICILIO_CALLE IS NOT NULL

	UNION

	SELECT DISTINCT VEN_USUARIO_DOMICILIO_CALLE, VEN_USUARIO_DOMICILIO_CP, VEN_USUARIO_DOMICILIO_DEPTO,
		VEN_USUARIO_DOMICILIO_NRO_CALLE, VEN_USUARIO_DOMICILIO_PISO, loc.localidad_id 
	FROM gd_esquema.Maestra m
	JOIN (
        -- Subconsulta para combinar Localidad y Provincia
        SELECT l.localidad_id, l.localidad_nombre, p.provincia_nombre
        FROM SARTEN_QUE_LADRA.Localidad l
        JOIN SARTEN_QUE_LADRA.Provincia p ON l.provincia_id = p.provincia_id
		) AS loc ON loc.localidad_nombre = m.VEN_USUARIO_DOMICILIO_LOCALIDAD
            AND loc.provincia_nombre = m.VEN_USUARIO_DOMICILIO_PROVINCIA
	WHERE VEN_USUARIO_DOMICILIO_CALLE IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MARCA 
AS BEGIN 
    INSERT INTO SARTEN_QUE_LADRA.Marca(marca_nombre)
	SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra
	WHERE PRODUCTO_MARCA IS NOT NULL
END

GO

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
	SELECT DISTINCT ALMACEN_CODIGO, ALMACEN_CALLE, ALMACEN_NRO_CALLE, ALMACEN_COSTO_DIA_AL, loc.localidad_id from gd_esquema.Maestra m
	JOIN (
        -- Subconsulta para combinar Localidad y Provincia
        SELECT l.localidad_id, l.localidad_nombre, p.provincia_nombre
        FROM SARTEN_QUE_LADRA.Localidad l
        JOIN SARTEN_QUE_LADRA.Provincia p ON l.provincia_id = p.provincia_id
		) AS loc ON loc.localidad_nombre = m.ALMACEN_Localidad
            AND loc.provincia_nombre = m.ALMACEN_PROVINCIA
	WHERE ALMACEN_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PRODUCTO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Producto(producto_codigo, producto_descripcion, producto_precio)
	SELECT DISTINCT PRODUCTO_CODIGO, PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO from gd_esquema.Maestra
	WHERE PRODUCTO_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MARCAXPRODUCTO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.MarcaXProducto (producto_id, marca_id) 
	SELECT DISTINCT producto_id, marca_id
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Marca marca ON maestra.PRODUCTO_MARCA = marca.marca_nombre
									JOIN SARTEN_QUE_LADRA.Producto producto ON maestra.PRODUCTO_CODIGO = producto.producto_codigo 
													AND maestra.PRODUCTO_PRECIO = producto.producto_precio
													AND maestra.PRODUCTO_DESCRIPCION = producto.producto_descripcion
	WHERE maestra.PRODUCTO_CODIGO IS NOT NULL AND PRODUCTO_MARCA IS NOT NULL;
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
	WHERE maestra.PRODUCTO_CODIGO IS NOT NULL AND maestra.PRODUCTO_MOD_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_TIPO_ENVIO
AS BEGIN
		INSERT INTO SARTEN_QUE_LADRA.TipoEnvio(envio_nombre)
		SELECT DISTINCT ENVIO_TIPO from gd_esquema.Maestra
		WHERE ENVIO_TIPO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_USUARIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Usuario(usuario_nombre, usuario_password, usuario_fecha_creacion)
	SELECT DISTINCT CLI_USUARIO_NOMBRE, CLI_USUARIO_PASS, CLI_USUARIO_FECHA_CREACION from gd_esquema.Maestra
	WHERE CLI_USUARIO_NOMBRE IS NOT NULL

	UNION 

	SELECT DISTINCT VEN_USUARIO_NOMBRE, VEN_USUARIO_PASS, VEN_USUARIO_FECHA_CREACION from gd_esquema.Maestra
	WHERE VEN_USUARIO_NOMBRE IS NOT NULL
END 

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_CLIENTE
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Cliente(cliente_nombre, cliente_apellido, cliente_fecha_nac, cliente_mail, cliente_dni, usuario_id)
	SELECT DISTINCT CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_FECHA_NAC, CLIENTE_MAIL, CLIENTE_DNI, u.usuario_id from gd_esquema.Maestra 
		JOIN SARTEN_QUE_LADRA.Usuario u ON 
		(CLI_USUARIO_NOMBRE = u.usuario_nombre AND
		CLI_USUARIO_PASS = u.usuario_password AND
		CLI_USUARIO_FECHA_CREACION = u.usuario_fecha_creacion)
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_VENDEDOR
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Vendedor(vendedor_cuit, vendedor_razon_social, vendedor_mail, usuario_id)
	SELECT DISTINCT VENDEDOR_CUIT, VENDEDOR_RAZON_SOCIAL, VENDEDOR_MAIL, u.usuario_id from gd_esquema.Maestra 
	JOIN SARTEN_QUE_LADRA.Usuario u ON 
		VEN_USUARIO_NOMBRE = u.usuario_nombre AND
		VEN_USUARIO_PASS = u.usuario_password AND
		VEN_USUARIO_FECHA_CREACION = u.usuario_fecha_creacion
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_VENTA
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Venta(venta_codigo, cliente_id, venta_fecha, venta_hora, venta_total)
	SELECT DISTINCT VENTA_CODIGO, c.cliente_id, VENTA_FECHA, NULL, VENTA_TOTAL -- CONSTRAINT DEFAULT NULL 
	FROM gd_esquema.Maestra m
	JOIN SARTEN_QUE_LADRA.Cliente c ON 
		 m.CLIENTE_NOMBRE = c.cliente_nombre AND 
		 m.CLIENTE_APELLIDO = c.cliente_apellido AND
		 m.CLIENTE_FECHA_NAC = c.cliente_fecha_nac AND
		 m.CLIENTE_MAIL = c.cliente_mail AND
		 m.CLIENTE_DNI = c.cliente_dni
	WHERE VENTA_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_ENVIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Envio (venta_codigo, envio_domicilio, envio_fecha_programada, envio_horario_inicio, envio_horario_fin, 
										envio_costo, envio_fecha_hora_entrega, tipo_envio_id)
	SELECT DISTINCT VENTA_CODIGO, d.domicilio_id, ENVIO_FECHA_PROGAMADA, ENVIO_HORA_INICIO, ENVIO_HORA_FIN_INICIO, ENVIO_COSTO, ENVIO_FECHA_ENTREGA, t.tipo_envio_id 
	FROM gd_esquema.Maestra JOIN SARTEN_QUE_LADRA.Domicilio d ON CLI_USUARIO_DOMICILIO_CALLE = d.domicilio_calle 
								AND CLI_USUARIO_DOMICILIO_NRO_CALLE = d.domicilio_nro_calle 
								AND CLI_USUARIO_DOMICILIO_PISO = d.domicilio_piso 
								AND CLI_USUARIO_DOMICILIO_DEPTO = d.domicilio_depto 
								AND CLI_USUARIO_DOMICILIO_CP = d.domicilio_cp
							JOIN SARTEN_QUE_LADRA.Localidad l ON CLI_USUARIO_DOMICILIO_LOCALIDAD = l.localidad_nombre
							JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_id = l.provincia_id
							JOIN SARTEN_QUE_LADRA.TipoEnvio t ON ENVIO_TIPO = t.envio_nombre;
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PUBLICACION
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Publicacion (publicacion_codigo, publicacion_descripcion, publicacion_stock, publicacion_fecha_fin, 
		publicacion_fecha_inicio, publicacion_precio, publicacion_costo, publicacion_porc_venta, producto_id, vendedor_id, almacen_codigo)
	SELECT DISTINCT PUBLICACION_CODIGO, PUBLICACION_DESCRIPCION, PUBLICACION_STOCK, PUBLICACION_FECHA_V, PUBLICACION_FECHA, PUBLICACION_PRECIO, 
		PUBLICACION_COSTO, PUBLICACION_PORC_VENTA, producto.producto_id, vendedor.vendedor_id, maestra.ALMACEN_CODIGO
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Producto producto ON maestra.PRODUCTO_CODIGO = producto.producto_codigo
										AND maestra.PRODUCTO_DESCRIPCION = producto.producto_descripcion
										AND maestra.PRODUCTO_PRECIO = producto.producto_precio
									JOIN SARTEN_QUE_LADRA.Almacen almacen ON maestra.ALMACEN_CODIGO = almacen.almacen_codigo 
									JOIN SARTEN_QUE_LADRA.Vendedor vendedor ON
										maestra.VENDEDOR_CUIT = vendedor.vendedor_cuit AND
										maestra.VENDEDOR_MAIL = vendedor.vendedor_mail AND
										maestra.VENDEDOR_RAZON_SOCIAL = vendedor.vendedor_razon_social
	WHERE maestra.PUBLICACION_CODIGO IS NOT NULL
END

GO

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DETALLE_FACTURA
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.DetalleFactura (publicacion_codigo, detalle_concepto_id, factura_numero, detalle_factura_precio, detalle_factura_cantidad, detalle_factura_subtotal)
	SELECT DISTINCT maestra.PUBLICACION_CODIGO, concepto.detalle_concepto_id, maestra.FACTURA_NUMERO, FACTURA_DET_PRECIO, FACTURA_DET_CANTIDAD, FACTURA_DET_SUBTOTAL
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Publicacion p ON p.publicacion_codigo = maestra.PUBLICACION_CODIGO	
	JOIN SARTEN_QUE_LADRA.Concepto concepto on maestra.FACTURA_DET_TIPO = concepto_tipo
	WHERE maestra.PUBLICACION_CODIGO IS NOT NULL AND maestra.FACTURA_NUMERO IS NOT NULL AND maestra.FACTURA_DET_TIPO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DOMICILIOXUSUARIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.DomicilioXUsuario (usuario_id, domicilio_id)
	SELECT DISTINCT usuario_id, domicilio_id
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Usuario usuario ON maestra.CLI_USUARIO_NOMBRE = usuario.usuario_nombre 
										AND maestra.CLI_USUARIO_PASS = usuario.usuario_password 
										AND maestra.CLI_USUARIO_FECHA_CREACION = usuario.usuario_fecha_creacion
									JOIN SARTEN_QUE_LADRA.Domicilio domicilio ON maestra.CLI_USUARIO_DOMICILIO_CALLE = domicilio.domicilio_calle
										AND maestra.CLI_USUARIO_DOMICILIO_CP = domicilio.domicilio_cp
										AND maestra.CLI_USUARIO_DOMICILIO_NRO_CALLE = domicilio.domicilio_nro_calle
										AND maestra.CLI_USUARIO_DOMICILIO_PISO = domicilio.domicilio_piso
										AND maestra.CLI_USUARIO_DOMICILIO_DEPTO = domicilio.domicilio_depto
									JOIN SARTEN_QUE_LADRA.Localidad localidad ON localidad.localidad_id = domicilio.localidad_id
									JOIN SARTEN_QUE_LADRA.Provincia provincia ON provincia.provincia_id = localidad.provincia_id
	UNION
	SELECT DISTINCT usuario_id, domicilio_id
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Usuario usuario ON maestra.VEN_USUARIO_NOMBRE = usuario.usuario_nombre 
										AND maestra.VEN_USUARIO_PASS = usuario.usuario_password 
										AND maestra.VEN_USUARIO_FECHA_CREACION = usuario.usuario_fecha_creacion
									JOIN SARTEN_QUE_LADRA.Domicilio domicilio ON maestra.VEN_USUARIO_DOMICILIO_CALLE = domicilio.domicilio_calle
										AND maestra.VEN_USUARIO_DOMICILIO_CP = domicilio.domicilio_cp
										AND maestra.VEN_USUARIO_DOMICILIO_NRO_CALLE = domicilio.domicilio_nro_calle
										AND maestra.VEN_USUARIO_DOMICILIO_PISO = domicilio.domicilio_piso
										AND maestra.VEN_USUARIO_DOMICILIO_DEPTO = domicilio.domicilio_depto
									JOIN SARTEN_QUE_LADRA.Localidad localidad ON localidad.localidad_id = domicilio.localidad_id
									JOIN SARTEN_QUE_LADRA.Provincia provincia ON provincia.provincia_id = localidad.provincia_id
	WHERE usuario_id IS NOT NULL AND domicilio_id IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_CONCEPTO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Concepto (concepto_tipo)
	SELECT DISTINCT FACTURA_DET_TIPO
	FROM gd_esquema.Maestra maestra
	WHERE FACTURA_DET_TIPO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_FACTURA
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Factura (factura_numero, factura_fecha, vendedor_id, factura_total)
	SELECT DISTINCT FACTURA_NUMERO, FACTURA_FECHA, p.vendedor_id, FACTURA_TOTAL
	FROM gd_esquema.Maestra m
	JOIN SARTEN_QUE_LADRA.Publicacion p ON
		p.publicacion_codigo = m.PUBLICACION_CODIGO
	WHERE FACTURA_NUMERO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DETALLE_VENTA
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.DetalleVenta(venta_codigo, publicacion_codigo, detalle_cantidad, detalle_subtotal, detalle_precio)
	SELECT DISTINCT VENTA_CODIGO, PUBLICACION_CODIGO, VENTA_DET_CANT, VENTA_DET_SUB_TOTAL, VENTA_DET_PRECIO
	FROM gd_esquema.Maestra
	WHERE VENTA_CODIGO IS NOT NULL AND PUBLICACION_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_RUBRO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Rubro (rubro_descripcion)
	SELECT DISTINCT PRODUCTO_RUBRO_DESCRIPCION
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

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_PAGO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Pago(venta_codigo, pago_importe, pago_fecha)
	SELECT DISTINCT VENTA_CODIGO, PAGO_IMPORTE, PAGO_FECHA FROM gd_esquema.Maestra
	WHERE VENTA_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DETALLE_PAGO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.DetallePago(tarjeta_numero, tarjeta_fecha_vencimiento, detalle_pago_cuotas)
	SELECT DISTINCT PAGO_NRO_TARJETA, PAGO_FECHA_VENC_TARJETA, PAGO_CANT_CUOTAS FROM gd_esquema.Maestra
	WHERE PAGO_NRO_TARJETA IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_TIPO_MEDIO_PAGO
AS BEGIN

	INSERT INTO SARTEN_QUE_LADRA.TipoMedioPago(tipo_medio_pago)
	SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO
	FROM gd_esquema.Maestra
	WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MEDIO_PAGO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.MedioPago(medio_de_pago, tipo_medio_pago)
	SELECT DISTINCT PAGO_MEDIO_PAGO, t.id_medio_pago 
	FROM gd_esquema.Maestra JOIN SARTEN_QUE_LADRA.TipoMedioPago t ON PAGO_TIPO_MEDIO_PAGO = t.tipo_medio_pago
	WHERE PAGO_MEDIO_PAGO IS NOT NULL
END

GO

CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_MEDIOXPAGO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.MedioXPago(id_pago, id_medio_de_pago, id_detalle_pago)
	SELECT DISTINCT p.id_pago, mp.id_medio_de_pago, dp.detalle_pago_id FROM gd_esquema.Maestra m 
	JOIN SARTEN_QUE_LADRA.Pago p ON m.VENTA_CODIGO = p.venta_codigo AND 
									m.PAGO_IMPORTE = p.pago_importe AND
									m.PAGO_FECHA = p.pago_fecha
	JOIN SARTEN_QUE_LADRA.DetallePago dp ON m.PAGO_NRO_TARJETA = dp.tarjeta_numero AND
									    m.PAGO_FECHA_VENC_TARJETA = dp.tarjeta_fecha_vencimiento AND
										m.PAGO_CANT_CUOTAS = dp.detalle_pago_cuotas
	JOIN SARTEN_QUE_LADRA.MedioPago mp ON m.PAGO_MEDIO_PAGO = mp.medio_de_pago
	JOIN SARTEN_QUE_LADRA.TipoMedioPago tp ON mp.tipo_medio_pago = tp.id_medio_pago
	WHERE m.VENTA_CODIGO IS NOT NULL -- No hacen falta mas CONSTRAINTS
END

GO

-- ============================== -- 
--      EXEC PROCEDURES         --
-- ============================== --

EXEC SARTEN_QUE_LADRA.MIGRAR_PROVINCIA;
EXEC SARTEN_QUE_LADRA.MIGRAR_LOCALIDAD;
EXEC SARTEN_QUE_LADRA.MIGRAR_DOMICILIO;
EXEC SARTEN_QUE_LADRA.MIGRAR_MARCA;
EXEC SARTEN_QUE_LADRA.MIGRAR_MODELO;
EXEC SARTEN_QUE_LADRA.MIGRAR_ALMACEN;
EXEC SARTEN_QUE_LADRA.MIGRAR_PRODUCTO;
EXEC SARTEN_QUE_LADRA.MIGRAR_MARCAXPRODUCTO;
EXEC SARTEN_QUE_LADRA.MIGRAR_MODELOXPRODUCTO;
EXEC SARTEN_QUE_LADRA.MIGRAR_TIPO_ENVIO;
EXEC SARTEN_QUE_LADRA.MIGRAR_USUARIO;
EXEC SARTEN_QUE_LADRA.MIGRAR_CLIENTE;
EXEC SARTEN_QUE_LADRA.MIGRAR_VENDEDOR;
EXEC SARTEN_QUE_LADRA.MIGRAR_VENTA;
EXEC SARTEN_QUE_LADRA.MIGRAR_ENVIO;
EXEC SARTEN_QUE_LADRA.MIGRAR_CONCEPTO;
EXEC SARTEN_QUE_LADRA.MIGRAR_PUBLICACION;
EXEC SARTEN_QUE_LADRA.MIGRAR_FACTURA;
EXEC SARTEN_QUE_LADRA.MIGRAR_DETALLE_FACTURA;
EXEC SARTEN_QUE_LADRA.MIGRAR_DOMICILIOXUSUARIO;
EXEC SARTEN_QUE_LADRA.MIGRAR_DETALLE_VENTA;
EXEC SARTEN_QUE_LADRA.MIGRAR_RUBRO;
EXEC SARTEN_QUE_LADRA.MIGRAR_SUBRUBRO;
EXEC SARTEN_QUE_LADRA.MIGRAR_SUBRUBROXRUBRO;
EXEC SARTEN_QUE_LADRA.MIGRAR_PRODUCTOXSUBRUBRO;
EXEC SARTEN_QUE_LADRA.MIGRAR_DETALLE_PAGO;
EXEC SARTEN_QUE_LADRA.MIGRAR_PAGO;
EXEC SARTEN_QUE_LADRA.MIGRAR_TIPO_MEDIO_PAGO;
EXEC SARTEN_QUE_LADRA.MIGRAR_MEDIO_PAGO;
EXEC SARTEN_QUE_LADRA.MIGRAR_MEDIOXPAGO;