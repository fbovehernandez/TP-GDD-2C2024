-- ============================== -- 
--			CONSTRAINTS	          --
-- ============================== --
ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad DROP CONSTRAINT IF EXISTS fk_bilocalidad_provincia;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago DROP CONSTRAINT IF EXISTS fk_hechos_pago_localidad;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago DROP CONSTRAINT IF EXISTS fk_hechos_pago_tiempo;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago DROP CONSTRAINT IF EXISTS fk_hechos_pago_medio_pago;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago DROP CONSTRAINT IF EXISTS fk_hechos_pago_tipo_medio_pago;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Publicacion DROP CONSTRAINT IF EXISTS fk_hechos_publicacion_subrubro;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Publicacion DROP CONSTRAINT IF EXISTS fk_hechos_publicacion_marca;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT IF EXISTS fk_hechos_venta_provincia;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT IF EXISTS fk_hechos_venta_rango_etario;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT IF EXISTS fk_hechos_venta_tiempo;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT IF EXISTS fk_hechos_venta_rubro;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Venta DROP CONSTRAINT IF EXISTS fk_hechos_venta_localidad;

-- ============================== -- 
--				TABLES	          --
-- ============================== --
SELECT * FROM sys.tables 
WHERE name LIKE 'BI%' OR name LIKE 'Hechos%';

DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Tiempo;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Localidad;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Provincia;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Rango_Horario;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Medio_De_Pago;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Tipo_Medio_De_Pago;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.Hechos_Pago;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Subrubro;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Marca;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.Hechos_Publicacion;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Rubro;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.BI_Rango_Etario;
DROP TABLE IF EXISTS SARTEN_QUE_LADRA.Hechos_Venta;

-- ============================== -- 
--			FUNCTIONS	          --
-- ============================== --

SELECT name, object_id, type, type_desc
FROM sys.objects
WHERE type IN ('TF', 'IF', 'FN') -- TF: Table-valued, IF: Inline Table-valued, FN: Scalar
ORDER BY name;

DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Cantidad_De_Domicilios;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Tiempo;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Rango_Horario;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Provincia_Almacen;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Rango_Etario;
DROP FUNCTION IF EXISTS SARTEN_QUE_LADRA.BI_Select_Almacen_Venta;

-- ============================== -- 
--			PROCEDURES	          --
-- ============================== --

SELECT name 
FROM sys.procedures
WHERE name LIKE 'BI%';

-- DROP DE TODAS LAS PROCEDURES
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Provincia;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Localidad;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Tiempo;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Medio_De_Pago;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Tipo_Medio_De_Pago;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Pago;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_MIGRAR_BI_Marca;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_MIGRAR_BI_Subrubro;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Hechos_Publicacion_Sin_Tiempo;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Rango_Horario;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Rubro;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Rango_Etario;
DROP PROCEDURE IF EXISTS SARTEN_QUE_LADRA.BI_Migrar_Hechos_Venta;

-- ============================== -- 
--				VIEWS	          --
-- ============================== --
