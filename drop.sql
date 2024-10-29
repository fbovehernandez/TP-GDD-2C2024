-- DROP CONSTRAINTS
ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro DROP CONSTRAINT fk_subrubroxrubro_rubro_id;
ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro DROP CONSTRAINT fk_subrubroxrubro_subrubro_id;

ALTER TABLE SARTEN_QUE_LADRA.MarcaXProducto DROP CONSTRAINT fk_marcaproducto_producto;
ALTER TABLE SARTEN_QUE_LADRA.MarcaXProducto DROP CONSTRAINT fk_marcaproducto_marca;

ALTER TABLE SARTEN_QUE_LADRA.ModeloXProducto DROP CONSTRAINT fk_modeloproducto_producto;
ALTER TABLE SARTEN_QUE_LADRA.ModeloXProducto DROP CONSTRAINT fk_modeloproducto_modelo;

ALTER TABLE SARTEN_QUE_LADRA.ProductoXSubrubro DROP CONSTRAINT fk_productosubrubro_producto;
ALTER TABLE SARTEN_QUE_LADRA.ProductoXSubrubro DROP CONSTRAINT fk_productosubrubro_subrubro;

ALTER TABLE SARTEN_QUE_LADRA.Localidad DROP CONSTRAINT fk_localidad_provincia;

ALTER TABLE SARTEN_QUE_LADRA.Domicilio DROP CONSTRAINT fk_domicilio_localidad;

ALTER TABLE SARTEN_QUE_LADRA.DomicilioXUsuario DROP CONSTRAINT fk_domiciliousuario_usuario;
ALTER TABLE SARTEN_QUE_LADRA.DomicilioXUsuario DROP CONSTRAINT fk_domiciliousuario_domicilio;

ALTER TABLE SARTEN_QUE_LADRA.Cliente DROP CONSTRAINT fk_cliente_usuario;

ALTER TABLE SARTEN_QUE_LADRA.Vendedor DROP CONSTRAINT fk_vendedor_usuario;

ALTER TABLE SARTEN_QUE_LADRA.Envio DROP CONSTRAINT fk_envio_venta;
ALTER TABLE SARTEN_QUE_LADRA.Envio DROP CONSTRAINT fk_envio_domicilio;
ALTER TABLE SARTEN_QUE_LADRA.Envio DROP CONSTRAINT fk_envio_tipo_envio;

ALTER TABLE SARTEN_QUE_LADRA.Factura DROP CONSTRAINT fk_factura_vendedor;

ALTER TABLE SARTEN_QUE_LADRA.Almacen DROP CONSTRAINT fk_almacen_localidad;

ALTER TABLE SARTEN_QUE_LADRA.Publicacion DROP CONSTRAINT fk_publicacion_producto;
ALTER TABLE SARTEN_QUE_LADRA.Publicacion DROP CONSTRAINT fk_publicacion_vendedor;
ALTER TABLE SARTEN_QUE_LADRA.Publicacion DROP CONSTRAINT fk_publicacion_almacen;

ALTER TABLE SARTEN_QUE_LADRA.DetalleFactura DROP CONSTRAINT fk_detallefactura_publicacion;
ALTER TABLE SARTEN_QUE_LADRA.DetalleFactura DROP CONSTRAINT fk_detallefactura_concepto;
ALTER TABLE SARTEN_QUE_LADRA.DetalleFactura DROP CONSTRAINT fk_detallefactura_factura;

ALTER TABLE SARTEN_QUE_LADRA.DetalleVenta DROP CONSTRAINT fk_detalleventa_venta;
ALTER TABLE SARTEN_QUE_LADRA.DetalleVenta DROP CONSTRAINT fk_detalleventa_concepto;
ALTER TABLE SARTEN_QUE_LADRA.DetalleVenta DROP CONSTRAINT fk_detalleventa_publicacion;

ALTER TABLE SARTEN_QUE_LADRA.Pago DROP CONSTRAINT fk_subrubroxrubro_rubro_id;

ALTER TABLE SARTEN_QUE_LADRA.SubrubroXRubro DROP CONSTRAINT fk_pago_venta;

ALTER TABLE SARTEN_QUE_LADRA.MedioXPago DROP CONSTRAINT fk_mediopago_pago;
ALTER TABLE SARTEN_QUE_LADRA.MedioXPago DROP CONSTRAINT fk_mediopago_mediodepago;
ALTER TABLE SARTEN_QUE_LADRA.MedioXPago DROP CONSTRAINT fk_mediopago_detallepago;

ALTER TABLE SARTEN_QUE_LADRA.MedioPago DROP CONSTRAINT fk_mediopago_tipomediopago;

ALTER TABLE SARTEN_QUE_LADRA.Venta DROP CONSTRAINT fk_venta_cliente

-- DROP DE TODAS LAS TABLAS
DROP TABLE SARTEN_QUE_LADRA.Almacen;
DROP TABLE SARTEN_QUE_LADRA.Cliente;
DROP TABLE SARTEN_QUE_LADRA.Concepto;
DROP TABLE SARTEN_QUE_LADRA.DetallePago;
DROP TABLE SARTEN_QUE_LADRA.DetalleFactura;
DROP TABLE SARTEN_QUE_LADRA.DetalleVenta;
DROP TABLE SARTEN_QUE_LADRA.Domicilio;
DROP TABLE SARTEN_QUE_LADRA.DomicilioXUsuario;
DROP TABLE SARTEN_QUE_LADRA.Envio;
DROP TABLE SARTEN_QUE_LADRA.Factura;
DROP TABLE SARTEN_QUE_LADRA.Localidad;
DROP TABLE SARTEN_QUE_LADRA.Marca;
DROP TABLE SARTEN_QUE_LADRA.MarcaXProducto;
DROP TABLE SARTEN_QUE_LADRA.MedioPago;
DROP TABLE SARTEN_QUE_LADRA.MedioXPago;
DROP TABLE SARTEN_QUE_LADRA.Modelo;
DROP TABLE SARTEN_QUE_LADRA.ModeloXProducto;
DROP TABLE SARTEN_QUE_LADRA.Pago;
DROP TABLE SARTEN_QUE_LADRA.Producto;
DROP TABLE SARTEN_QUE_LADRA.ProductoXSubrubro;
DROP TABLE SARTEN_QUE_LADRA.Publicacion;
DROP TABLE SARTEN_QUE_LADRA.Provincia;
DROP TABLE SARTEN_QUE_LADRA.TipoMedioPago;
DROP TABLE SARTEN_QUE_LADRA.TipoEnvio;
DROP TABLE SARTEN_QUE_LADRA.Usuario;
DROP TABLE SARTEN_QUE_LADRA.Vendedor;
DROP TABLE SARTEN_QUE_LADRA.Venta;
DROP TABLE SARTEN_QUE_LADRA.Rubro;
DROP TABLE SARTEN_QUE_LADRA.Subrubro;
DROP TABLE SARTEN_QUE_LADRA.SubrubroXRubro;

-- QUERY PARA VER TODAS LAS FK PRESENTES
SELECT 
    fk.name AS FK_name, 
    tp.name AS Table_name 
FROM sys.foreign_keys AS fk
INNER JOIN sys.tables AS tp ON fk.parent_object_id = tp.object_id
WHERE tp.name IN ('Almacen', 'Cliente', 'Concepto', 'DetalleFactura', 'DetallePago', 'DetalleVenta', 
'Domicilio', 
'DomicilioXUsuario', 'Envio', 'Factura', 
'Localidad', 'Marca', 
'MarcaXProducto', 'MedioPago', 'MedioXPago', 'Modelo', 'ModeloXProducto', 'Pago', 'Producto', 'ProductoXSubrubro',
'Publicacion', 
'Provincia', 'Rubro', 'Subrubro', 'SubrubroXRubro', 'TipoEnvio', 'TipoMedioPago', 'Usuario', 
'Vendedor', 
'Venta');

-- QUERY PARA VER TODAS LAS TABLAS EXISTENTES ENTRE LA LISTA
SELECT * FROM sys.tables WHERE name IN ('Almacen', 'Cliente', 'Concepto', 'DetalleFactura', 'DetallePago', 'DetalleVenta', 
'Domicilio', 'DomicilioXUsuario', 'Envio', 'Factura', 'Localidad', 'Marca', 
'MarcaXProducto', 'MedioPago', 'MedioXPago', 'Modelo', 'ModeloXProducto', 'Pago', 'Producto', 'ProductoXSubrubro',
'Publicacion', 'Provincia', 'Rubro', 'Subru
bro', 'SubrubroXRubro', 'TipoEnvio', 'TipoMedioPago', 'Usuario', 
'Vendedor', 
'Venta');
