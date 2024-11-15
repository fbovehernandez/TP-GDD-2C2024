USE GD2C2024
GO

CREATE TABLE SARTEN_QUE_LADRA.BI_TIEMPO
(
    tiempo_id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
    anio DECIMAL(18,0),
    mes DECIMAL(18,0),
    cuatrimestre DECIMAL(18,0),
);

CREATE TABLE SARTEN_QUE_LADRA.BI_TIPO_ENVIO (
    envio_id DECIMAL(18,0) PRIMARY KEY,
    envio_nombre NVARCHAR(50)
);

CREATE TABLE SARTEN_QUE_LADRA.BI_PROVINCIA (
    id DECIMAL(18,0) PRIMARY KEY,
    provincia_nombre NVARCHAR(50)
)
CREATE TABLE SARTEN_QUE_LADRA_BI_LOCALIDAD (
    localidad_id DECIMAL(18,0) PRIMARY KEY,
    provincia_id DECIMAL(18,0),
    localidad_nombre NVARCHAR(50),
    FOREIGN KEY(provincia_id) REFERENCES SARTEN_QUE_LADRA.BI_PROVINCIA(id)
);

CREATE TABLE BI_HECHOS_ENVIO (
    id DECIMAL(18,0),
    tiempo_id DECIMAL(18,0),
    loc_almacen_id DECIMAL(18,0),
    enviados_a_tiempo DECIMAL(18,0),
    total_envios DECIMAL(18,0),
    PRIMARY KEY (id, tiempo_id, loc_almacen_id)
)

-- MIGRACIONES --

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_LOCALIDAD
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA_BI_LOCALIDAD
        (localidad_id, provincia_id, localidad_nombre)
    SELECT DISTINCT localidad_id, provincia_id, localidad_nombre FROM SARTEN_QUE_LADRA.Localidad
END

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_PROVINCIA 
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_PROVINCIA
        (id, provincia_nombre)
    SELECT DISTINCT provincia_id, provincia_nombre FROM SARTEN_QUE_LADRA.Provincia
END

GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_ENVIO
AS BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_TIPO_ENVIO
        (envio_id, envio_nombre)
    SELECT DISTINCT tipo_envio_id, envio_nombre FROM SARTEN_QUE_LADRA.TipoEnvio
END
GO
CREATE PROCEDURE SARTEN_QUE_LADRA.BI_MIGRAR_TIEMPO
AS
BEGIN
    INSERT INTO SARTEN_QUE_LADRA.BI_TIEMPO
        (anio, mes, cuatrimestre)
    (SELECT DISTINCT YEAR(venta_fecha), MONTH(venta_fecha),
        CASE WHEN MONTH(venta_fecha) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(venta_fecha) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(venta_fecha) BETWEEN 9 AND 12 THEN 3 END
    FROM SARTEN_QUE_LADRA.Venta
    UNION
    SELECT DISTINCT YEAR(envio_fecha_hora_entrega), MONTH(envio_fecha_hora_entrega),
        CASE WHEN MONTH(envio_fecha_hora_entrega) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(envio_fecha_hora_entrega) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(envio_fecha_hora_entrega) BETWEEN 9 AND 12 THEN 3 END
    FROM SARTEN_QUE_LADRA.Envio
    UNION 
    SELECT DISTINCT YEAR(pago_fecha), MONTH(pago_fecha),
        CASE WHEN MONTH(pago_fecha) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(pago_fecha) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(pago_fecha) BETWEEN 9 AND 12 THEN 3 END
    FROM SARTEN_QUE_LADRA.Pago)
    -- ORDER BY YEAR(venta_fecha)
END
