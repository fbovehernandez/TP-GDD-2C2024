/* TEST VALIDACION AGRUPAMIENTO MASIVO --> CASO ID 33 */

SELECT  
				l.localidad_id,
				YEAR(pago.pago_fecha),
				MONTH(pago.pago_fecha),
				medioxpago.id_medio_de_pago, 
				tipomediopago.id_medio_pago,
				detallepago.detalle_pago_cuotas,
				pago.pago_importe
	FROM SARTEN_QUE_LADRA.Pago pago JOIN SARTEN_QUE_LADRA.Venta venta ON pago.venta_codigo = venta.venta_codigo
									JOIN SARTEN_QUE_LADRA.Envio envio ON pago.venta_codigo = envio.venta_codigo
									JOIN SARTEN_QUE_LADRA.Cliente c ON c.cliente_id = venta.cliente_id
									JOIN SARTEN_QUE_LADRA.DomicilioXUsuario dxu ON dxu.usuario_id = c.usuario_id
									JOIN SARTEN_QUE_LADRA.Domicilio dm ON dm.domicilio_id = dxu.domicilio_id
									JOIN SARTEN_QUE_LADRA.Localidad l ON l.localidad_id = dm.localidad_id
									JOIN SARTEN_QUE_LADRA.MedioXPago medioxpago ON pago.id_pago = medioxpago.id_pago
									JOIN SARTEN_QUE_LADRA.DetallePago detallepago ON medioxpago.id_detalle_pago = detallepago.detalle_pago_id
									JOIN SARTEN_QUE_LADRA.MedioPago mediopago ON medioxpago.id_medio_de_pago = mediopago.id_medio_de_pago
									JOIN SARTEN_QUE_LADRA.TipoMedioPago tipomediopago ON mediopago.tipo_medio_pago = tipomediopago.id_medio_pago
	WHERE l.localidad_id = 10243 AND YEAR(pago.pago_fecha) = 2025 AND MONTH(pago.pago_fecha) = 1 AND medioxpago.id_medio_de_pago = 1 AND tipomediopago.id_medio_pago = 1

/* Diferentes filas que cuando se agrupan en la de hechos lo hacen como una sola...
		10243	2025	1	1	1	12310.91
		10243	2025	1	1	1	17047.98
		10243	2025	1	1	1	7902.67
*/ 

/* PARA SELECCION DE TIEMPOS ID */
SELECT tiempo_id, mes, anio FROM SARTEN_QUE_LADRA.BI_Tiempo


/* PODRIA HACER ESTO PARA TODOS LOS CASOS, PERO PARECERIA QUE DA BIEN! 
/* 13	3	483338.02	12 */

SELECT * FROM SARTEN_QUE_LADRA.BI_Provincia p WHERE p.id = 12
SELECT * FROM SARTEN_QUE_LADRA.BI_Tiempo t WHERE t.tiempo_id = 13 -- ENERO 2026

SELECT f.factura_numero, p.provincia_nombre, f.factura_fecha, f.factura_total, df.detalle_factura_id, df.detalle_concepto_id, 
		df.detalle_factura_subtotal
FROM SARTEN_QUE_LADRA.Factura f 
JOIN SARTEN_QUE_LADRA.DetalleFactura df ON f.factura_numero = df.factura_numero
JOIN SARTEN_QUE_LADRA.Vendedor v ON v.vendedor_id = f.vendedor_id
JOIN SARTEN_QUE_LADRA.DomicilioXUsuario dxu ON v.usuario_id = dxu.usuario_id 
JOIN SARTEN_QUE_LADRA.Domicilio d ON dxu.domicilio_id = d.domicilio_id
JOIN SARTEN_QUE_LADRA.Localidad l ON l.localidad_id = d.localidad_id
JOIN SARTEN_QUE_LADRA.Provincia p ON p.provincia_id = l.provincia_id
WHERE YEAR(f.factura_fecha) = 2026 AND MONTH(f.factura_fecha) = 1 AND df.detalle_concepto_id = 3 
	AND p.provincia_id = 12
