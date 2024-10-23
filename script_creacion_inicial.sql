USE GD2C2024
GO
CREATE SCHEMA SARTEN_que_ladra 
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

CREATE TABLE SARTEN_QUE_LADRA.MarcaXProducto (
	producto_id NVARCHAR(50),
	marca_id DECIMAL(18,0),
	PRIMARY KEY (producto_id, marca_id),
);

CREATE TABLE SARTEN_QUE_LADRA.ProductoXSubrubro (
	producto_id NVARCHAR(50),
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
	producto_id NVARCHAR(50),
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
	id_medio_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	tipo_medio_pago NVARCHAR(50)
)

CREATE TABLE SARTEN_QUE_LADRA.MedioPago(
	id_tipo_medio_de_pago DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
	medio_de_pago NVARCHAR(50),
	tipo_medio_pago DECIMAL(18,0),
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

INSERT INTO SARTEN_QUE_LADRA.MarcaXProducto (producto_codigo, marca_id) 
	SELECT DISTINCT maestra.PRODUCTO_CODIGO, sarten.marca_id
	FROM gd_esquema.Maestra maestra JOIN SARTEN_QUE_LADRA.Marca sarten ON maestra.PRODUCTO_MARCA = sarten.marca_nombre
	WHERE PRODUCTO_CODIGO IS NOT NULL AND PRODUCTO_MARCA IS NOT NULL;

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

-- Creo que no hace falta migrar el domicilio por parte del envio ya que siempre seria el de un cliente
CREATE PROCEDURE SARTEN_QUE_LADRA.MIGRAR_DOMICILIO
AS BEGIN
	INSERT INTO SARTEN_QUE_LADRA.Domicilio(domicilio_calle, domicilio_cp, domicilio_depto, domicilio_nro_calle, 
		domicilio_piso, localidad_id)
	SELECT DISTINCT CLI_USUARIO_DOMICILIO_CALLE, CLI_USUARIO_DOMICILIO_CP, CLI_USUARIO_DOMICILIO_DEPTO,
		CLI_USUARIO_DOMICILIO_NRO_CALLE, CLI_USUARIO_DOMICILIO_PISO, l.localidad_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Localidad l on l.localidad_nombre = CLI_USUARIO_DOMICILIO_LOCALIDAD
	-- WHERE .. IS NOT NULL?

	UNION

	SELECT DISTINCT VEN_USUARIO_DOMICILIO_CALLE, VEN_USUARIO_DOMICILIO_CP, VEN_USUARIO_DOMICILIO_DEPTO,
		VEN_USUARIO_DOMICILIO_NRO_CALLE, VEN_USUARIO_DOMICILIO_PISO, l.localidad_id FROM gd_esquema.Maestra
	JOIN SARTEN_QUE_LADRA.Localidad l on l.localidad_nombre = VEN_USUARIO_DOMICILIO_LOCALIDAD
	-- WHERE .. IS NOT NULL?
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
