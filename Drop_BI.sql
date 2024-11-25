-- FKS
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Publicacion DROP CONSTRAINT fk_hechos_publicacion_tiempo_id_p;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Publicacion DROP CONSTRAINT fk_hechos_publicacion_marca_id;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Publicacion DROP CONSTRAINT fk_hechos_publicacion_pub_subrubro;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago DROP CONSTRAINT FK_Hechos_Pago_Localidad_Cliente;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago DROP CONSTRAINT FK_Hechos_Pago_Tiempo;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago DROP CONSTRAINT FK_Hechos_Pago_Medio_De_Pago;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago DROP CONSTRAINT FK_Hechos_Pago_Tipo_Medio_De_Pago;

ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO DROP CONSTRAINT FK_BI_HechosEnvio_LocCliente;
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO DROP CONSTRAINT FK_BI_HechosEnvio_ProvinciaAlmacen;
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO DROP CONSTRAINT FK_BI_HechosEnvio_Tiempo;
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_ENVIO DROP CONSTRAINT FK_BI_HechosEnvio_tipo_envio;

ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad DROP CONSTRAINT FK_BI_Localidad_Provincia;

ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA DROP CONSTRAINT FK_BI_HECHOS_FACTURA_PROVINCIA;
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA DROP CONSTRAINT FK_BI_HECHOS_FACTURA_Tiempo;
ALTER TABLE SARTEN_QUE_LADRA.BI_HECHOS_FACTURA DROP CONSTRAINT FK_BI_HECHOS_FACTURA_concepto;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT fk_hechos_venta_provincia;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT fk_hechos_venta_rango_etario;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT fk_hechos_venta_tiempo;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT fk_hechos_venta_rubro;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT fk_hechos_venta_localidad;

-- DROP FUNCTIONS
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Rango_Etario;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Cantidad_De_Domicilios;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.ENVIADOS_A_TIEMPO;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Tiempo;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Provincia_Vendedor;

-- DROP PROCEDURES
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Hechos_Venta;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Rango_Etario;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.MIGRAR_HECHOS_ENVIO;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_MIGRAR_LOCALIDAD;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_MIGRAR_PROVINCIA;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_MIGRAR_ENVIO;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Concepto;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_MIGRAR_TIEMPO;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Medio_De_Pago;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Tipo_Medio_De_Pago;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Pago;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Hechos_Publicacion;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Marca;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Hechos_Factura;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Rubro;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Subrubro;

-- DROP VIEWS
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.PROMEDIO_TIEMPO_PUBLICACIONES;
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.PROMEDIO_STOCK_PUBLICACION;
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.VENTA_PROMEDIO_MENSUAL;
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.RUBROS_MAYORES_VENTAS;
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.LOCALIDADES_MAYOR_IMPORTE_CUOTAS;
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.PORCENTAJE_ENVIOS_A_TIEMPO;
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.LOCALIDADES_MAS_PAGAS;
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.PORCENTAJE_FACTURACION_CONCEPTO;
DROP VIEW IF EXISTS SARTEN_QUE_LADRA.FACTURACION_PROVINCIA;

-- DROP TABLES
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Tiempo;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Tipo_envio;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Provincia;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Localidad;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_HECHOS_FACTURA;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Rango_Horario;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Rango_Etario;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Subrubro;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Rubro;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.Hechos_Venta;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_HECHOS_ENVIO;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Medio_De_Pago;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.Hechos_Pago;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_CONCEPTO;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.Hechos_Publicacion;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Marca;
