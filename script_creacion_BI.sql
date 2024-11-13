-- ============================== --
--				TABLAS            --
-- ============================== --

CREATE TABLE SARTEN_QUE_LADRA.BI_Venta (
	venta_codigo DECIMAL(18,0) PRIMARY KEY,
	venta_total DECIMAL(18,2), 
	venta_tiempo DECIMAL(18,0), --FK
	cliente_id DECIMAL(18,0) --FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Ubicacion (
	ubicacion_id DECIMAL(18,0) PRIMARY KEY,
	provincia_id DECIMAL(18,0), 
	provincia_nombre NVARCHAR(50),
	localidad_id DECIMAL(18,0),
	localidad_nombre NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Tiempo (
	tiempo_id DECIMAL(18,0) PRIMARY KEY,
	mes DECIMAL(2,0),
	cuatrimestre DECIMAL(1,0),
	anio DECIMAL(4,0)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_DetalleVenta (
	detalle_venta_id DECIMAL(18,0) PRIMARY KEY,
	venta_codigo DECIMAL(18,0), --FK
	publicacion_codigo DECIMAL(18,0) --FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Publicacion (
	publicacion_codigo DECIMAL(18,0) PRIMARY KEY,
	almacen_codigo DECIMAL(18,0), --FK
	producto_id DECIMAL (18,0) --FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Almacen (
	almacen_codigo DECIMAL(18,0) PRIMARY KEY,
	ubicacion_id DECIMAL(18,0) --FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Producto (
	producto_id DECIMAL(18,0) PRIMARY KEY
);

CREATE TABLE SARTEN_QUE_LADRA.BI_ProductoXSubrubro (
	producto_id DECIMAL(18,0), -- FK
	subrubro_id DECIMAL(18,0), --FK
	PRIMARY KEY (producto_id, subrubro_id)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Subrubro (
	subrubro_id DECIMAL(18,0) PRIMARY KEY
);

CREATE TABLE SARTEN_QUE_LADRA.BI_SubrubroXRubro (
	subrubro_id DECIMAL(18,0),
	rubro_id DECIMAL(18,0),
	PRIMARY KEY (subrubro_id, rubro_id)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Rubro (
	rubro_id DECIMAL(18,0) PRIMARY KEY,
	rubro_descripcion NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Cliente (
	cliente_id DECIMAL(18,0) PRIMARY KEY,
	cliente_rango_etario DECIMAL(18,0), --FK
	usuario_id DECIMAL(18,0) --FK
);

CREATE TABLE SARTEN_QUE_LADRA.BI_RangoEtario (
    rango_etario_id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
    rango_etario VARCHAR(20)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Usuario (
	usuario_id DECIMAL(18,0) PRIMARY KEY
);

CREATE TABLE SARTEN_QUE_LADRA.BI_DomicilioXUsuario (
	usuario_id DECIMAL(18,0), --FK
	domicilio_id DECIMAL(18,0), -- FK
	PRIMARY KEY (usuario_id, domicilio_id)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_Domicilio (
	domicilio_id DECIMAL(18,0) PRIMARY KEY,
	domicilio_ubicacion DECIMAL(18,0) --FK
);

-- ============================== --
--         CONSTRAINTS            --
-- ============================== --

ALTER TABLE SARTEN_QUE_LADRA.BI_Venta ADD CONSTRAINT fk_venta_tiempo FOREIGN KEY (venta_tiempo) REFERENCES SARTEN_QUE_LADRA.BI_Tiempo (tiempo_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_Venta ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (cliente_id) REFERENCES SARTEN_QUE_LADRA.BI_Cliente (cliente_id);

ALTER TABLE SARTEN_QUE_LADRA.BI_DetalleVenta ADD CONSTRAINT fk_detalleVenta_codigo FOREIGN KEY (venta_codigo) REFERENCES SARTEN_QUE_LADRA.BI_Venta (venta_codigo);
ALTER TABLE SARTEN_QUE_LADRA.BI_DetalleVenta ADD CONSTRAINT fk_detalleVenta_publicacion FOREIGN KEY (pubicacion_codigo) REFERENCES SARTEN_QUE_LADRA.BI_Publicacion (publicacion_codigo);

ALTER TABLE SARTEN_QUE_LADRA.BI_Publicacion ADD CONSTRAINT fk_publicacion_almacen FOREIGN KEY (almacen_codigo) REFERENCES SARTEN_QUE_LADRA.BI_Almacen (almacen_codigo);
ALTER TABLE SARTEN_QUE_LADRA.BI_Publicacion ADD CONSTRAINT fk_publicacion_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.BI_Producto (producto_id);

ALTER TABLE SARTEN_QUE_LADRA.BI_Almacen ADD CONSTRAINT fk_almacen_ubicacion FOREIGN KEY (ubicacion_id) REFERENCES SARTEN_QUE_LADRA.BI_Almacen (almacen_codigo);

ALTER TABLE SARTEN_QUE_LADRA.BI_ProductoXSubrubro ADD CONSTRAINT fk_productoxsubrubro_producto FOREIGN KEY (producto_id) REFERENCES SARTEN_QUE_LADRA.BI_Producto (producto_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_ProductoXSubrubro ADD CONSTRAINT fk_productoxsubrubro_subrubro FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.BI_Subrubro (subrubro_id);

ALTER TABLE SARTEN_QUE_LADRA.BI_SubrubroXRubro ADD CONSTRAINT fk_subrubroxrubro_subrubro FOREIGN KEY (subrubro_id) REFERENCES SARTEN_QUE_LADRA.BI_Subrubro (subrubro_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_SubrubroXRubro ADD CONSTRAINT fk_subrubroxrubro_rubro FOREIGN KEY (rubro_id) REFERENCES SARTEN_QUE_LADRA.BI_Rubro (rubro_id);

ALTER TABLE SARTEN_QUE_LADRA.BI_Cliente ADD CONSTRAINT fk_cliente_rangoetario FOREIGN KEY (cliente_rango_etario) REFERENCES SARTEN_QUE_LADRA.BI_RangoEtario (rango_etario_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_Cliente ADD CONSTRAINT fk_cliente_usuario FOREIGN KEY (cliente_usuario) REFERENCES SARTEN_QUE_LADRA.BI_Usuario (usuario_id);

ALTER TABLE SARTEN_QUE_LADRA.BI_DomicilioXUsuario ADD CONSTRAINT fk_domicilioxusuario_usuario FOREIGN KEY (usuario_id) REFERENCES SARTEN_QUE_LADRA.BI_Usuario (usuario_id);
ALTER TABLE SARTEN_QUE_LADRA.BI_DomicilioXUsuario ADD CONSTRAINT fk_domicilioxusuario_domicilio FOREIGN KEY (domicilio_id) REFERENCES SARTEN_QUE_LADRA.BI_Domicilio (domicilio_id);

ALTER TABLE SARTEN_QUE_LADRA.BI_Domicilio ADD CONSTRAINT fk_domicilio_ubicacion FOREIGN KEY (domicilio_ubicacion) REFERENCES SARTEN_QUE_LADRA.BI_Ubicacion (ubicacion_id);

GO

-- ============================== --
--				 VIEWS            --
-- ============================== --

-- 3
CREATE VIEW SARTEN_QUE_LADRA.VENTA_PROMEDIO_MENSUAL
AS
	SELECT provincia_nombre, mes, anio 'Año', SUM(venta_total) / COUNT(DISTINCT venta_total) 'Venta Promedio Mensual Según Provincia'
	FROM SARTEN_QUE_LADRA.BI_Venta v 
		JOIN SARTEN_QUE_LADRA.BI_Tiempo t ON v.venta_tiempo = t.tiempo_id
		JOIN SARTEN_QUE_LADRA.BI_DetalleVenta dv ON v.venta_codigo = dv.venta_codigo
		JOIN SARTEN_QUE_LADRA.BI_Publicacion p ON dv.publicacion_codigo = p.publicacion_codigo
		JOIN SARTEN_QUE_LADRA.BI_Almacen a ON p.almacen_codigo = a.almacen_codigo
		JOIN SARTEN_QUE_LADRA.BI_Ubicacion u ON a.ubicacion_id = u.ubicacion_id
	GROUP BY provincia_id, mes, anio

GO

-- 4
CREATE VIEW SARTEN_QUE_LADRA.RENDIMIENTO_DE_RUBROS
AS
	SELECT TOP 5 rubro_descripcion, COUNT(DISTINCT v.venta_codigo) 'Cantidad de Ventas', cuatrimestre, anio 'Año', localidad_nombre, rango_etario
	FROM SARTEN_QUE_LADRA.BI_Venta v
		JOIN SARTEN_QUE_LADRA.BI_Tiempo t ON v.venta_tiempo = t.tiempo_id
		JOIN SARTEN_QUE_LADRA.BI_DetalleVenta dv ON v.venta_codigo = dv.venta_codigo
		JOIN SARTEN_QUE_LADRA.BI_Publicacion publi ON dv.publicacion_codigo = publi.publicacion_codigo
		JOIN SARTEN_QUE_LADRA.BI_Producto prod ON publi.producto_id = prod.producto_id
		JOIN SARTEN_QUE_LADRA.BI_ProductoXSubrubro pxs ON prod.producto_id = pxs.producto_id
		JOIN SARTEN_QUE_LADRA.BI_Subrubro s ON pxs.subrubro_id = s.subrubro_id
		JOIN SARTEN_QUE_LADRA.BI_SubrubroXRubro sxr ON s.subrubro_id = sxr.subrubro_id
		JOIN SARTEN_QUE_LADRA.BI_Rubro r ON sxr.rubro_id = r.rubro_id
		JOIN SARTEN_QUE_LADRA.BI_Cliente c ON v.cliente_id = c.cliente_id
		JOIN SARTEN_QUE_LADRA.BI_RangoEtario re ON c.cliente_rango_etario = re.rango_etario_id
		JOIN SARTEN_QUE_LADRA.BI_Usuario usu ON c.usuario_id = usu.usuario_id
		JOIN SARTEN_QUE_LADRA.BI_DomicilioXUsuario dxu ON usu.usuario_id = dxu.usuario_id
		JOIN SARTEN_QUE_LADRA.BI_Domicilio d ON dxu.domicilio_id = dxu.domicilio_id
		JOIN SARTEN_QUE_LADRA.BI_Ubicacion ubi ON d.domicilio_ubicacion = ubi.ubicacion_id
	GROUP BY rubro_descripcion, cuatrimestre, anio, localidad_nombre, rango_etario
	ORDER BY COUNT(DISTINCT v.venta_codigo) ASC;
GO
