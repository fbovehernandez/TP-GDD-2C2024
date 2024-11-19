-- ============================== -- 
--			CONSTRAINTS	          --
-- ============================== --
ALTER TABLE SARTEN_QUE_LADRA.BI_Localidad
DROP CONSTRAINT fk_bilocalidad_provincia;

ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago 
DROP CONSTRAINT fk_hechos_pago_localidad;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago
DROP CONSTRAINT fk_hechos_pago_tiempo;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago 
DROP CONSTRAINT fk_hechos_pago_medio_pago;
ALTER TABLE SARTEN_QUE_LADRA.Hechos_Pago 
DROP CONSTRAINT fk_hechos_pago_tipo_medio_pago;

-- ============================== -- 
--				TABLES	          --
-- ============================== --
SELECT * FROM sys.tables 
WHERE name LIKE 'BI%' OR name LIKE 'Hechos%';

DROP TABLE SARTEN_QUE_LADRA.BI_Localidad;
DROP TABLE SARTEN_QUE_LADRA.BI_Provincia;

-- ============================== -- 
--			FUNCTIONS	          --
-- ============================== --

SELECT name, object_id, type, type_desc
FROM sys.objects
WHERE type IN ('TF', 'IF', 'FN') -- TF: Table-valued, IF: Inline Table-valued, FN: Scalar
ORDER BY name;;

DROP FUNCTION SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente_Segun_Cantidad_De_Domicilios;
DROP FUNCTION SARTEN_QUE_LADRA.BI_Select_Localidad_Cliente;
DROP FUNCTION SARTEN_QUE_LADRA.BI_Cantidad_De_Domicilios;
DROP FUNCTION SARTEN_QUE_LADRA.BI_Select_Tiempo;

-- ============================== -- 
--			PROCEDURES	          --
-- ============================== --

SELECT name 
FROM sys.procedures
WHERE name LIKE 'BI%';

-- DROP DE TODAS LAS PROCEDURES
DROP PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Provincia;
DROP PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Localidad;
DROP PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Tiempo;
DROP PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Medio_De_Pago;
DROP PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Tipo_Medio_De_Pago;
DROP PROCEDURE SARTEN_QUE_LADRA.BI_Migrar_Pago;
