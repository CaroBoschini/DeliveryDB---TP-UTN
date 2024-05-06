USE [GD1C2023]
GO

CREATE SCHEMA [ULTRA_CAD_23]
GO

CREATE PROCEDURE ULTRA_CAD_23.migrarDatos
AS
BEGIN
/****** Object:  Schema [ULTRA_CAD_23] ******/


CREATE TABLE ULTRA_CAD_23.TIPO_MEDIO_PAGO (
	TIPO_MEDIO_PAGO_COD INT  NOT NULL PRIMARY KEY IDENTITY(1,1),
	TIPO_MEDIO_PAGO NVARCHAR(50) NOT NULL
);

CREATE TABLE ULTRA_CAD_23.TIPO_RECLAMO (
	RECLAMO_COD INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	RECLAMO_NOMBRE NVARCHAR(255) NOT NULL
);

CREATE TABLE ULTRA_CAD_23.ESTADO_DE_RECLAMO (
	ESTADO_RECLAMO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	RECLAMO_DESCRIPCION NVARCHAR(255) NOT NULL
);

CREATE TABLE ULTRA_CAD_23.OPERADOR (
	OPERADOR_NRO int NOT NULL PRIMARY KEY IDENTITY(1,1),
	OPERADOR_RECLAMO_DNI DECIMAL(18,0) NOT NULL,
	OPERADOR_RECLAMO_NOMBRE NVARCHAR(255) NOT NULL,
	OPERADOR_RECLAMO_APELLIDO NVARCHAR(255) NOT NULL,
	OPERADOR_RECLAMO_TELEFONO DECIMAL(18,0) NOT NULL,
	OPERADOR_RECLAMO_DIRECCION NVARCHAR(255) NOT NULL,
	OPERADOR_RECLAMO_MAIL NVARCHAR(255) NOT NULL,
	OPERADOR_RECLAMO_FECHA_NACIMIENTO DATE
);

CREATE TABLE ULTRA_CAD_23.USUARIO (
	USUARIO_NRO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	USUARIO_NOMBRE NVARCHAR(255) NOT NULL,
	USUARIO_APELLIDO NVARCHAR(255) NOT NULL,
	USUARIO_DNI DECIMAL(18,0) NOT NULL,
	USUARIO_FECHA_REGISTRO DATETIME2(3) NOT NULL,
	USUARIO_TELEFONO DECIMAL(18,0) NOT NULL,
	USUARIO_MAIL NVARCHAR(255) NOT NULL,
	USUARIO_FECHA_NAC DATE NOT NULL
);


CREATE TABLE ULTRA_CAD_23.MEDIO_PAGO (
	MEDIO_PAGO_NRO INT  NOT NULL PRIMARY KEY IDENTITY(1,1),
	MEDIO_PAGO_NRO_TARJETA INT DEFAULT(NULL),
	MEDIO_PAGO_TIPO INT  FOREIGN KEY REFERENCES ULTRA_CAD_23.TIPO_MEDIO_PAGO(TIPO_MEDIO_PAGO_COD),
	MARCA_TARJETA NVARCHAR(100) DEFAULT(NULL),
	USUARIO_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.USUARIO(USUARIO_NRO)
);

CREATE TABLE ULTRA_CAD_23.PAQUETE(
	PAQUETE_COD INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	PAQUETE_TIPO NVARCHAR(50) NOT NULL,
	PAQUETE_ALTO_MAX DECIMAL(18,2) NOT NULL,
	PAQUETE_ANCHO_MAX DECIMAL(18,2) NOT NULL,
	PAQUETE_LARGO_MAX DECIMAL(18,2) NOT NULL,
	PAQUETE_PESO_MAX DECIMAL(18,2)  NOT NULL,
	PAQUETE_PRECIO DECIMAL(18,2) NOT NULL
);

CREATE TABLE ULTRA_CAD_23.ESTADO(
	ESTADO_NRO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	ESTADO_NOMBRE NVARCHAR(255) NOT NULL
);

CREATE TABLE ULTRA_CAD_23.PROVINCIA(
	PROVINCIA_COD INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	PROVINCIA_NOMBRE NVARCHAR(255) NOT NULL
);

CREATE TABLE ULTRA_CAD_23.LOCALIDAD(
	LOCALIDAD_COD INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	LOCALIDAD_NOMBRE NVARCHAR(255) NOT NULL,
	PROVINCIA_COD INT FOREIGN KEY REFERENCES ULTRA_CAD_23.PROVINCIA(PROVINCIA_COD)
);

CREATE TABLE ULTRA_CAD_23.DIRECCION(
	DIRECCION_CODIGO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DIRECCION_USUARIO_NOMBRE NVARCHAR(50) NOT NULL,
	USUARIO_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.USUARIO(USUARIO_NRO),
	DIRECCION NVARCHAR(255) NOT NULL,
	DIRECCION_USUARIO_LOCALIDAD INT FOREIGN KEY REFERENCES ULTRA_CAD_23.LOCALIDAD(LOCALIDAD_COD) NOT NULL
);

CREATE TABLE ULTRA_CAD_23.MOVILIDAD(
	MOVILIDAD_COD INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	MOVILIDAD_NOMBRE NVARCHAR(50) NOT NULL
);

CREATE TABLE ULTRA_CAD_23.REPARTIDOR(
	REPARTIDOR_CODIGO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	REPARTIDOR_NOMBRE NVARCHAR(255) NOT NULL,
	REPARTIDOR_APELLIDO NVARCHAR(255) NOT NULL,
	REPARTIDOR_DNI DECIMAL(18,0) NOT NULL,
	REPARTIDOR_TELEFONO DECIMAL(18,0) NOT NULL,
	REPARTIDOR_DIRECCION NVARCHAR(255) NOT NULL,
	REPARTIDOR_EMAIL NVARCHAR(255) NOT NULL,
	REPARTIDOR_FECHA_NAC DATE NOT NULL,
	REPARTIDOR_TIPO_MOVILIDAD INT REFERENCES ULTRA_CAD_23.MOVILIDAD(MOVILIDAD_COD) NOT NULL,
	REPARTIDOR_LOCALIDAD INT REFERENCES ULTRA_CAD_23.LOCALIDAD(LOCALIDAD_COD) DEFAULT(NULL)
);

CREATE TABLE ULTRA_CAD_23.TIPO_CUPON (
	CUPON_TIPO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	CUPON_TIPO_DESCRIPCION NVARCHAR(255) NOT NULL
);


CREATE TABLE ULTRA_CAD_23.CATEGORIA (
	CATEGORIA_NRO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	CATEGORIA NVARCHAR(50)
);

CREATE TABLE ULTRA_CAD_23.TIPO_LOCAL (
	LOCAL_TIPO_NRO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TIPO_LOCAL_DESCRIPCION NVARCHAR(50) NOT NULL,
	CATEGORIA_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.CATEGORIA(CATEGORIA_NRO)
);

CREATE TABLE ULTRA_CAD_23.LOCALES (
	LOCAL_NRO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	LOCAL_NOMBRE NVARCHAR(100) NOT NULL,
	LOCAL_DIRECCION NVARCHAR(255) NOT NULL,
	LOCAL_LOCALIDAD INT FOREIGN KEY REFERENCES ULTRA_CAD_23.LOCALIDAD(LOCALIDAD_COD) NOT NULL,
	LOCAL_PROVINCIA INT FOREIGN KEY REFERENCES ULTRA_CAD_23.PROVINCIA(PROVINCIA_COD) NOT NULL,
	LOCAL_TIPO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.TIPO_LOCAL(LOCAL_TIPO_NRO) NOT NULL,
);

CREATE TABLE ULTRA_CAD_23.HORARIO(
	HORARIO_NRO INT PRIMARY KEY IDENTITY(1,1),
	LOCAL_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.LOCALES(LOCAL_NRO) NOT NULL,
	HORARIO_LOCAL_DIA NVARCHAR(50) NOT NULL,
	HORARIO_LOCAL_HORA_APERTURA DECIMAL(18,0) NOT NULL,
	HORARIO_LOCAL_HORA_CIERRE DECIMAL(18,0) NOT NULL
)

CREATE TABLE ULTRA_CAD_23.PEDIDO (
	PEDIDO_NRO DECIMAL(18,0) NOT NULL PRIMARY KEY,
	USUARIO_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.USUARIO(USUARIO_NRO),
	MEDIO_PAGO_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.MEDIO_PAGO(MEDIO_PAGO_NRO),
	LOCAL_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.LOCALES(LOCAL_NRO),
	PEDIDO_FECHA  DATETIME NOT NULL,
	PEDIDO_TOTAL_PRODUCTOS DECIMAL(18,2) NOT NULL,
	PEDIDO_PRECIO_ENVIO DECIMAL(18,2) NOT NULL, 
	PEDIDO_TARIFA_SERVICIO DECIMAL(18,2) NOT NULL, 
	PEDIDO_PROPINA DECIMAL(18,2) NOT NULL, 
	PEDIDO_TOTAL_SERVICIO DECIMAL(18,2), 
	PEDIDO_OBSERV NVARCHAR(255) NOT NULL,
	PEDIDO_TOTAL_CUPONES DECIMAL(18,2) NOT NULL,
	PEDIDO_ESTADO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.ESTADO(ESTADO_NRO) NOT NULL,
	PEDIDO_TIEMPO_ESTIMADO_ENTREGA DECIMAL(18,2) NOT NULL,
	PEDIDO_FECHA_ENTREGA DATETIME NOT NULL, 
	PEDIDO_CALIFICACION DECIMAL(18,0) NOT NULL,
	PEDIDO_DIRECCION INT FOREIGN KEY REFERENCES ULTRA_CAD_23.DIRECCION(DIRECCION_CODIGO) NOT NULL,
	REPARTIDOR_CODIGO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.REPARTIDOR(REPARTIDOR_CODIGO) NOT NULL,
);

CREATE TABLE ULTRA_CAD_23.RECLAMO(
	RECLAMO_NRO DECIMAL(18,0) NOT NULL PRIMARY KEY,
	RECLAMO_DESCRIPCION NVARCHAR(255),
	USUARIO_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.USUARIO(USUARIO_NRO),
	PEDIDO_NUMERO DECIMAL(18,0) FOREIGN KEY REFERENCES ULTRA_CAD_23.PEDIDO(PEDIDO_NRO),
	RECLAMO_TIPO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.TIPO_RECLAMO(RECLAMO_COD),
	RECLAMO_FECHA DATETIME NOT NULL,
	OPERADOR_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.OPERADOR(OPERADOR_NRO),
	ESTADO_RECLAMO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.ESTADO_DE_RECLAMO(ESTADO_RECLAMO),
	RECLAMO_SOLUCION NVARCHAR(255) NOT NULL,
	RECLAMO_FECHA_RESOLUCION DATETIME NOT NULL,
	RECLAMO_CALIFICACION DECIMAL(18,0) NOT NULL
);


CREATE TABLE ULTRA_CAD_23.CUPON (
	CUPON_NRO DECIMAL(18,0)  NOT NULL PRIMARY KEY,
	CUPON_MONTO DECIMAL(18,2)  NOT NULL,
	CUPON_FECHA_ALTA DATETIME  NOT NULL,
	CUPON_FECHA_VENCIMIENTO DATETIME  NOT NULL,
	CUPON_TIPO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.TIPO_CUPON(CUPON_TIPO),
);

CREATE TABLE ULTRA_CAD_23.PRODUCTO (
	PRODUCTO_COD NVARCHAR(50) NOT NULL PRIMARY KEY,
	PRODUCTO_NOMBRE NVARCHAR(50) NOT NULL,
	PRODUCTO_DESCRIPCION NVARCHAR(255) NOT NULL,
	PRODUCTO_PRECIO DECIMAL(18,2) NOT NULL,
);

CREATE TABLE ULTRA_CAD_23.LOCAL_PRODUCTO(
	LOCAL_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.LOCALES(LOCAL_NRO),
	PRODUCTO_COD NVARCHAR(50) FOREIGN KEY REFERENCES ULTRA_CAD_23.PRODUCTO(PRODUCTO_COD),
	PRIMARY KEY(LOCAL_NRO, PRODUCTO_COD)
)

CREATE TABLE ULTRA_CAD_23.PEDIDO_DETALLES (
	NRO_ITEM INT NOT NULL,
	PEDIDO_NRO DECIMAL(18,0) FOREIGN KEY references ULTRA_CAD_23.PEDIDO(PEDIDO_NRO),
	PRODUCTO_COD NVARCHAR(50) FOREIGN KEY references ULTRA_CAD_23.PRODUCTO(PRODUCTO_COD),
	PRODUCTO_CANTIDAD DECIMAL(18,0) NOT NULL,
	PRODUCTO_PRECIO DECIMAL(18,2) NOT NULL,
	PRIMARY KEY(NRO_ITEM, PEDIDO_NRO, PRODUCTO_COD) 
);
	
CREATE TABLE ULTRA_CAD_23.ENVIO_DE_MENSAJERIA(
	ENVIO_MENSAJERIA_NRO DECIMAL(18,0) NOT NULL PRIMARY KEY,
	USUARIO_NRO INT NOT NULL FOREIGN KEY REFERENCES ULTRA_CAD_23.USUARIO(USUARIO_NRO),
	ENVIO_MENSAJERIA_FECHA DATETIME NOT NULL,
	ENVIO_MENSAJERIA_DIR_ORIG NVARCHAR(255) NOT NULL,
	ENVIO_MENSAJERIA_DIR_DEST NVARCHAR(255) NOT NULL,
	ENVIO_MENSAJERIA_KM DECIMAL(18,2) NOT NULL,
	PAQUETE_COD INT NOT NULL FOREIGN KEY REFERENCES ULTRA_CAD_23.PAQUETE(PAQUETE_COD),
	ENVIO_MENSAJERIA_VALOR_ASEGURADO DECIMAL(18,2) NOT NULL,
	ENVIO_MENSAJERIA_OBSERV NVARCHAR(255) NOT NULL,
	ENVIO_MENSAJERIA_PRECIO_ENVIO DECIMAL(18,2) NOT NULL,
	ENVIO_MENSAJERIA_PRECIO_SEGURO DECIMAL(18,2) NOT NULL,
	REPARTIDOR_CODIGO INT NOT NULL FOREIGN KEY REFERENCES ULTRA_CAD_23.REPARTIDOR(REPARTIDOR_CODIGO),
	ENVIO_MENSAJERIA_PROPINA DECIMAL(18,2) NOT NULL,
	ENVIO_MENSAJERIA_TOTAL DECIMAL(18,2) NOT NULL,
	ENVIO_MENSAJERIA_ESTADO INT NOT NULL FOREIGN KEY REFERENCES ULTRA_CAD_23.ESTADO(ESTADO_NRO),
	ENVIO_MENSAJERIA_TIEMPO_ESTIMADO decimal(18,2) NOT NULL,
	ENVIO_MENSAJERIA_FECHA_ENTREGA DATETIME NOT NULL,
	ENVIO_MENSAJERIA_CALIFICACION DECIMAL(18,0) NOT NULL,
	ENVIO_MENSAJERIA_LOCALIDAD INT FOREIGN KEY REFERENCES ULTRA_CAD_23.LOCALIDAD(LOCALIDAD_COD)
);

CREATE TABLE ULTRA_CAD_23.CUPON_RECLAMO(
	CUPON_NRO DECIMAL(18,0) FOREIGN KEY REFERENCES ULTRA_CAD_23.CUPON(CUPON_NRO),
	RECLAMO_NRO DECIMAL(18,0) FOREIGN KEY REFERENCES ULTRA_CAD_23.RECLAMO(RECLAMO_NRO),
	PRIMARY KEY (CUPON_NRO, RECLAMO_NRO)
);

CREATE TABLE ULTRA_CAD_23.CUPON_PEDIDO(
	CUPON_NRO DECIMAL(18,0) FOREIGN KEY REFERENCES ULTRA_CAD_23.CUPON(CUPON_NRO),
	PEDIDO_NRO DECIMAL(18,0) FOREIGN KEY REFERENCES ULTRA_CAD_23.PEDIDO(PEDIDO_NRO),
	PRIMARY KEY (CUPON_NRO, PEDIDO_NRO)
);

CREATE TABLE ULTRA_CAD_23.CUPON_USUARIO(
	CUPON_NRO DECIMAL(18,0) FOREIGN KEY REFERENCES ULTRA_CAD_23.CUPON(CUPON_NRO),
	USUARIO_NRO INT FOREIGN KEY REFERENCES ULTRA_CAD_23.USUARIO(USUARIO_NRO),
	PRIMARY KEY(CUPON_NRO, USUARIO_NRO)
);

--INSERTS

INSERT INTO ULTRA_CAD_23.TIPO_MEDIO_PAGO(TIPO_MEDIO_PAGO)
	SELECT DISTINCT MEDIO_PAGO_TIPO FROM gd_esquema.Maestra WHERE MEDIO_PAGO_TIPO IS NOT NULL

INSERT INTO ULTRA_CAD_23.TIPO_RECLAMO(RECLAMO_NOMBRE)
	SELECT DISTINCT RECLAMO_TIPO FROM gd_esquema.Maestra WHERE RECLAMO_TIPO IS NOT NULL

INSERT INTO ULTRA_CAD_23.ESTADO_DE_RECLAMO(RECLAMO_DESCRIPCION)
	SELECT DISTINCT RECLAMO_ESTADO FROM gd_esquema.Maestra WHERE RECLAMO_ESTADO IS NOT NULL

INSERT INTO ULTRA_CAD_23.OPERADOR(OPERADOR_RECLAMO_DNI,OPERADOR_RECLAMO_NOMBRE, OPERADOR_RECLAMO_APELLIDO, OPERADOR_RECLAMO_TELEFONO, OPERADOR_RECLAMO_DIRECCION, OPERADOR_RECLAMO_MAIL, OPERADOR_RECLAMO_FECHA_NACIMIENTO)
	SELECT DISTINCT OPERADOR_RECLAMO_DNI, OPERADOR_RECLAMO_NOMBRE, OPERADOR_RECLAMO_APELLIDO, OPERADOR_RECLAMO_TELEFONO, OPERADOR_RECLAMO_DIRECCION, OPERADOR_RECLAMO_MAIL, OPERADOR_RECLAMO_FECHA_NAC
	FROM gd_esquema.Maestra WHERE OPERADOR_RECLAMO_DNI IS NOT NULL

INSERT INTO ULTRA_CAD_23.USUARIO (USUARIO_NOMBRE, USUARIO_APELLIDO, USUARIO_DNI, USUARIO_FECHA_REGISTRO, USUARIO_TELEFONO, USUARIO_MAIL, USUARIO_FECHA_NAC) 
	SELECT DISTINCT USUARIO_NOMBRE, USUARIO_APELLIDO, USUARIO_DNI, USUARIO_FECHA_REGISTRO, USUARIO_TELEFONO, USUARIO_MAIL, USUARIO_FECHA_NAC 
	FROM gd_esquema.Maestra WHERE USUARIO_DNI IS NOT NULL

INSERT INTO ULTRA_CAD_23.MEDIO_PAGO(MEDIO_PAGO_NRO_TARJETA, MEDIO_PAGO_TIPO, MARCA_TARJETA, USUARIO_NRO)
	SELECT DISTINCT MEDIO_PAGO_NRO_TARJETA, TIPO_MEDIO_PAGO_COD, MARCA_TARJETA, USUARIO_NRO
	FROM gd_esquema.Maestra M 
	JOIN ULTRA_CAD_23.TIPO_MEDIO_PAGO T ON (M.MEDIO_PAGO_TIPO = T.TIPO_MEDIO_PAGO) 
	JOIN ULTRA_CAD_23.USUARIO U ON (M.USUARIO_DNI = U.USUARIO_DNI)
	WHERE NOT(MEDIO_PAGO_TIPO = 'Efectivo') AND MEDIO_PAGO_TIPO IS NOT NULL

INSERT INTO ULTRA_CAD_23.MEDIO_PAGO(MEDIO_PAGO_TIPO, USUARIO_NRO)
	SELECT DISTINCT TIPO_MEDIO_PAGO_COD, USUARIO_NRO
	FROM gd_esquema.Maestra M 
	JOIN ULTRA_CAD_23.TIPO_MEDIO_PAGO T ON (M.MEDIO_PAGO_TIPO = T.TIPO_MEDIO_PAGO) 
	JOIN ULTRA_CAD_23.USUARIO U ON (M.USUARIO_DNI = U.USUARIO_DNI)
	WHERE MEDIO_PAGO_TIPO = 'Efectivo'

INSERT INTO ULTRA_CAD_23.PAQUETE(PAQUETE_TIPO, PAQUETE_ALTO_MAX, PAQUETE_ANCHO_MAX,PAQUETE_LARGO_MAX, PAQUETE_PESO_MAX, PAQUETE_PRECIO)
SELECT DISTINCT PAQUETE_TIPO, PAQUETE_ALTO_MAX, PAQUETE_ANCHO_MAX,PAQUETE_LARGO_MAX, PAQUETE_PESO_MAX, PAQUETE_TIPO_PRECIO
FROM gd_esquema.Maestra WHERE PAQUETE_TIPO IS NOT NULL

INSERT INTO ULTRA_CAD_23.ESTADO(ESTADO_NOMBRE)
(SELECT DISTINCT ENVIO_MENSAJERIA_ESTADO
FROM gd_esquema.Maestra WHERE ENVIO_MENSAJERIA_ESTADO IS NOT NULL
UNION
SELECT DISTINCT PEDIDO_ESTADO FROM gd_esquema.Maestra WHERE PEDIDO_ESTADO IS NOT NULL)

INSERT INTO ULTRA_CAD_23.PROVINCIA(PROVINCIA_NOMBRE)
(SELECT DISTINCT ENVIO_MENSAJERIA_PROVINCIA 
FROM gd_esquema.Maestra WHERE ENVIO_MENSAJERIA_PROVINCIA IS NOT NULL
UNION
SELECT DISTINCT LOCAL_PROVINCIA
FROM gd_esquema.Maestra WHERE LOCAL_PROVINCIA IS NOT NULL
UNION
SELECT DISTINCT DIRECCION_USUARIO_PROVINCIA
FROM gd_esquema.Maestra WHERE DIRECCION_USUARIO_PROVINCIA IS NOT NULL)

INSERT INTO ULTRA_CAD_23.LOCALIDAD(LOCALIDAD_NOMBRE, PROVINCIA_COD)
(SELECT DISTINCT ENVIO_MENSAJERIA_LOCALIDAD, PROVINCIA_COD
FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.PROVINCIA P ON P.PROVINCIA_NOMBRE = M.ENVIO_MENSAJERIA_PROVINCIA
	WHERE ENVIO_MENSAJERIA_LOCALIDAD IS NOT NULL AND ENVIO_MENSAJERIA_PROVINCIA IS NOT NULL
UNION
SELECT DISTINCT LOCAL_LOCALIDAD, PROVINCIA_COD
FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.PROVINCIA P ON (P.PROVINCIA_NOMBRE = M.LOCAL_PROVINCIA) 
	WHERE LOCAL_LOCALIDAD IS NOT NULL AND LOCAL_PROVINCIA IS NOT NULL
UNION
SELECT DISTINCT DIRECCION_USUARIO_LOCALIDAD, PROVINCIA_COD
FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.PROVINCIA P ON (P.PROVINCIA_NOMBRE = M.DIRECCION_USUARIO_PROVINCIA)
	WHERE DIRECCION_USUARIO_LOCALIDAD IS NOT NULL AND DIRECCION_USUARIO_PROVINCIA IS NOT NULL)

INSERT INTO ULTRA_CAD_23.DIRECCION(DIRECCION_USUARIO_NOMBRE, USUARIO_NRO,DIRECCION, DIRECCION_USUARIO_LOCALIDAD)
	SELECT DISTINCT DIRECCION_USUARIO_NOMBRE, USUARIO_NRO, DIRECCION_USUARIO_DIRECCION, L.LOCALIDAD_COD
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.USUARIO U ON (M.USUARIO_DNI = U.USUARIO_DNI) 
	JOIN ULTRA_CAD_23.LOCALIDAD L ON (L.LOCALIDAD_NOMBRE = M.DIRECCION_USUARIO_LOCALIDAD)
	WHERE DIRECCION_USUARIO_NOMBRE IS NOT NULL

INSERT INTO ULTRA_CAD_23.MOVILIDAD(MOVILIDAD_NOMBRE)
SELECT DISTINCT REPARTIDOR_TIPO_MOVILIDAD
FROM gd_esquema.Maestra WHERE REPARTIDOR_TIPO_MOVILIDAD IS NOT NULL

INSERT INTO ULTRA_CAD_23.REPARTIDOR(REPARTIDOR_NOMBRE, REPARTIDOR_APELLIDO, REPARTIDOR_DNI, REPARTIDOR_TELEFONO, REPARTIDOR_DIRECCION, 
	REPARTIDOR_EMAIL, REPARTIDOR_FECHA_NAC, REPARTIDOR_TIPO_MOVILIDAD)
	SELECT DISTINCT REPARTIDOR_NOMBRE, REPARTIDOR_APELLIDO, REPARTIDOR_DNI, REPARTIDOR_TELEFONO, REPARTIDOR_DIRECION, 
	REPARTIDOR_EMAIL, REPARTIDOR_FECHA_NAC, MOVILIDAD_COD
	FROM gd_esquema.Maestra E JOIN ULTRA_CAD_23.MOVILIDAD M ON M.MOVILIDAD_NOMBRE = E.REPARTIDOR_TIPO_MOVILIDAD
	WHERE REPARTIDOR_DNI IS NOT NULL

INSERT INTO ULTRA_CAD_23.TIPO_CUPON (CUPON_TIPO_DESCRIPCION)
(SELECT DISTINCT CUPON_TIPO FROM gd_esquema.Maestra WHERE CUPON_TIPO IS NOT NULL
UNION
SELECT DISTINCT CUPON_RECLAMO_TIPO FROM gd_esquema.Maestra WHERE CUPON_RECLAMO_TIPO IS NOT NULL
)

INSERT INTO ULTRA_CAD_23.TIPO_LOCAL
SELECT DISTINCT LOCAL_TIPO, NULL FROM gd_esquema.Maestra WHERE LOCAL_TIPO IS NOT NULL

--LOCALES (NECESITA LOCALIDADES Y TIPO_LOCAL)

INSERT INTO ULTRA_CAD_23.LOCALES
SELECT DISTINCT
	LOCAL_NOMBRE,
	LOCAL_DIRECCION,
	U.LOCALIDAD_COD,
	U.PROVINCIA_COD,
	T.LOCAL_TIPO_NRO
	FROM gd_esquema.Maestra M
	JOIN ULTRA_CAD_23.LOCALIDAD U ON (M.LOCAL_LOCALIDAD = U.LOCALIDAD_NOMBRE)
	JOIN ULTRA_CAD_23.PROVINCIA P ON (U.PROVINCIA_COD = P.PROVINCIA_COD and P.PROVINCIA_NOMBRE = M.LOCAL_PROVINCIA)
	JOIN ULTRA_CAD_23.TIPO_LOCAL T ON (M.LOCAL_TIPO = T.TIPO_LOCAL_DESCRIPCION)
	WHERE LOCAL_NOMBRE IS NOT NULL ORDER BY LOCAL_NOMBRE

INSERT INTO ULTRA_CAD_23.HORARIO
SELECT DISTINCT L.LOCAL_NRO, HORARIO_LOCAL_DIA, M.HORARIO_LOCAL_HORA_APERTURA, M.HORARIO_LOCAL_HORA_CIERRE 
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.LOCALES L ON (M.LOCAL_NOMBRE=L.LOCAL_NOMBRE) 
	WHERE M.LOCAL_NOMBRE IS NOT NULL ORDER BY L.LOCAL_NRO, M.HORARIO_LOCAL_DIA

INSERT INTO ULTRA_CAD_23.PEDIDO 
SELECT DISTINCT
	PEDIDO_NRO, U.USUARIO_NRO, X.MEDIO_PAGO_NRO, L.LOCAL_NRO, PEDIDO_FECHA, PEDIDO_TOTAL_PRODUCTOS, PEDIDO_PRECIO_ENVIO, PEDIDO_TARIFA_SERVICIO, 
	PEDIDO_PROPINA, PEDIDO_TOTAL_SERVICIO, PEDIDO_OBSERV, PEDIDO_TOTAL_CUPONES, E.ESTADO_NRO,
	PEDIDO_TIEMPO_ESTIMADO_ENTREGA, PEDIDO_FECHA_ENTREGA, PEDIDO_CALIFICACION, D.DIRECCION_CODIGO, R.REPARTIDOR_CODIGO
	FROM gd_esquema.Maestra M 
	JOIN ULTRA_CAD_23.USUARIO U ON (U.USUARIO_DNI = M.USUARIO_DNI)
	JOIN ULTRA_CAD_23.TIPO_MEDIO_PAGO Y ON (Y.TIPO_MEDIO_PAGO = M.MEDIO_PAGO_TIPO)
	JOIN ULTRA_CAD_23.MEDIO_PAGO X ON (X.USUARIO_NRO = U.USUARIO_NRO AND X.MEDIO_PAGO_TIPO = Y.TIPO_MEDIO_PAGO_COD)
	JOIN ULTRA_CAD_23.REPARTIDOR R ON (R.REPARTIDOR_DNI=M.REPARTIDOR_DNI) 
	JOIN ULTRA_CAD_23.LOCALES L ON (L.LOCAL_NOMBRE = M.LOCAL_NOMBRE)
	JOIN ULTRA_CAD_23.ESTADO E ON (E.ESTADO_NOMBRE = M.PEDIDO_ESTADO)
	JOIN ULTRA_CAD_23.PROVINCIA P ON (P.PROVINCIA_NOMBRE = M.DIRECCION_USUARIO_PROVINCIA)
	JOIN ULTRA_CAD_23.DIRECCION D ON (D.DIRECCION = M.DIRECCION_USUARIO_DIRECCION AND D.USUARIO_NRO = U.USUARIO_NRO)
	JOIN ULTRA_CAD_23.LOCALIDAD K ON (K.PROVINCIA_COD = P.PROVINCIA_COD AND K.LOCALIDAD_COD = D.DIRECCION_USUARIO_LOCALIDAD)
	WHERE PEDIDO_NRO IS NOT NULL

INSERT INTO ULTRA_CAD_23.RECLAMO(RECLAMO_NRO,RECLAMO_DESCRIPCION,USUARIO_NRO, PEDIDO_NUMERO, RECLAMO_TIPO, RECLAMO_FECHA, OPERADOR_NRO, ESTADO_RECLAMO, RECLAMO_SOLUCION, RECLAMO_FECHA_RESOLUCION, RECLAMO_CALIFICACION)
	SELECT DISTINCT 
	RECLAMO_NRO, M.RECLAMO_DESCRIPCION, U.USUARIO_NRO, PEDIDO_NRO, 
	T.RECLAMO_COD, RECLAMO_FECHA, OPERADOR_NRO, ESTADO_RECLAMO, 
	RECLAMO_SOLUCION, RECLAMO_FECHA_SOLUCION, RECLAMO_CALIFICACION
	FROM gd_esquema.Maestra M 
	JOIN ULTRA_CAD_23.USUARIO U ON (M.USUARIO_DNI = U.USUARIO_DNI) 
	JOIN ULTRA_CAD_23.OPERADOR O ON (M.OPERADOR_RECLAMO_DNI = O.OPERADOR_RECLAMO_DNI AND M.OPERADOR_RECLAMO_MAIL = O.OPERADOR_RECLAMO_MAIL) 
	JOIN ULTRA_CAD_23.ESTADO_DE_RECLAMO E ON (M.RECLAMO_ESTADO = E.RECLAMO_DESCRIPCION)
	JOIN ULTRA_CAD_23.TIPO_RECLAMO T ON (T.RECLAMO_NOMBRE = M.RECLAMO_TIPO)
	WHERE M.RECLAMO_NRO IS NOT NULL ORDER BY M.RECLAMO_NRO

-----------------------------------------------------------------------------------------------------------------------------------
INSERT INTO ULTRA_CAD_23.CUPON
SELECT * FROM 
(SELECT DISTINCT
	CUPON_NRO,
	CUPON_MONTO,
	CUPON_FECHA_ALTA,
	CUPON_FECHA_VENCIMIENTO,
	T.CUPON_TIPO
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.TIPO_CUPON T ON (M.CUPON_TIPO = T.CUPON_TIPO_DESCRIPCION)
	WHERE  CUPON_NRO IS NOT NULL AND CUPON_RECLAMO_NRO IS NULL
UNION
SELECT DISTINCT
	CUPON_RECLAMO_NRO,
	CUPON_RECLAMO_MONTO,
	CUPON_RECLAMO_FECHA_ALTA,
	CUPON_RECLAMO_FECHA_VENCIMIENTO,
	T.CUPON_TIPO
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.TIPO_CUPON T ON (M.CUPON_RECLAMO_TIPO = T.CUPON_TIPO_DESCRIPCION)
	WHERE CUPON_RECLAMO_NRO IS NOT NULL AND CUPON_NRO IS NULL
) CUPONES ORDER BY 1 ASC

INSERT INTO ULTRA_CAD_23.CUPON_USUARIO
select * from (
SELECT DISTINCT CUPON_NRO, U.USUARIO_NRO 
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.USUARIO U ON (U.USUARIO_DNI = M.USUARIO_DNI) WHERE CUPON_NRO IS NOT NULL
UNION 
SELECT DISTINCT CUPON_RECLAMO_NRO, U.USUARIO_NRO 
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.USUARIO U ON (U.USUARIO_DNI = M.USUARIO_DNI) WHERE CUPON_RECLAMO_NRO IS NOT NULL) cuponUsuario
ORDER BY 1

INSERT INTO ULTRA_CAD_23.CUPON_RECLAMO
SELECT DISTINCT CUPON_RECLAMO_NRO, R.RECLAMO_NRO 
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.RECLAMO R ON (R.RECLAMO_NRO=M.RECLAMO_NRO) WHERE CUPON_RECLAMO_NRO IS NOT NULL ORDER BY 1

INSERT INTO CUPON_PEDIDO
SELECT DISTINCT CUPON_NRO, P.PEDIDO_NRO 
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.PEDIDO P ON (P.PEDIDO_NRO=M.PEDIDO_NRO) WHERE M.PEDIDO_NRO IS NOT NULL AND CUPON_NRO IS NOT NULL ORDER BY 1

--------------------------------------------------------------------------------------------------------------------------

INSERT INTO ULTRA_CAD_23.PRODUCTO 
SELECT DISTINCT 
	PRODUCTO_LOCAL_CODIGO,
	PRODUCTO_LOCAL_NOMBRE,
	PRODUCTO_LOCAL_DESCRIPCION,
	PRODUCTO_LOCAL_PRECIO
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_LOCAL_CODIGO IS NOT NULL ORDER BY PRODUCTO_LOCAL_CODIGO

INSERT INTO ULTRA_CAD_23.LOCAL_PRODUCTO
SELECT DISTINCT L.LOCAL_NRO, PRODUCTO_LOCAL_CODIGO FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.LOCALES L ON 
	(M.LOCAL_NOMBRE = L.LOCAL_NOMBRE)
WHERE PRODUCTO_LOCAL_CODIGO IS NOT NULL ORDER BY L.LOCAL_NRO, PRODUCTO_LOCAL_CODIGO

	DECLARE cursorDetalle CURSOR FOR 
	SELECT DISTINCT
		PEDIDO_NRO,
		PRODUCTO_LOCAL_CODIGO,
		PRODUCTO_CANTIDAD,
		PRODUCTO_LOCAL_PRECIO
		FROM gd_esquema.Maestra 
		WHERE PEDIDO_NRO IS NOT NULL AND PRODUCTO_LOCAL_CODIGO IS NOT NULL 
		ORDER BY PEDIDO_NRO, PRODUCTO_LOCAL_CODIGO
	OPEN cursorDetalle 

	DECLARE @ITEM INT, @PEDIDO_NRO int, @PRODUCTO_LOCAL_CODIGO NVARCHAR(50), @PRODUCTO_CANTIDAD DECIMAL(18,0), @PRODUCTO_LOCAL_PRECIO DECIMAL(18,2), @AUX int

	FETCH cursorDetalle INTO @PEDIDO_NRO, @PRODUCTO_LOCAL_CODIGO, @PRODUCTO_CANTIDAD, @PRODUCTO_LOCAL_PRECIO

	SET @ITEM = 1
	SET @AUX = @PEDIDO_NRO

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO ULTRA_CAD_23.PEDIDO_DETALLES VALUES (@ITEM, @PEDIDO_NRO, @PRODUCTO_LOCAL_CODIGO, @PRODUCTO_CANTIDAD, @PRODUCTO_LOCAL_PRECIO)
		SET @ITEM = @ITEM + 1
		FETCH cursorDetalle INTO @PEDIDO_NRO, @PRODUCTO_LOCAL_CODIGO, @PRODUCTO_CANTIDAD, @PRODUCTO_LOCAL_PRECIO
		IF(@AUX != @PEDIDO_NRO)
		BEGIN
			SET @ITEM = 1
			SET @AUX = @PEDIDO_NRO
		END
	END

	CLOSE cursorDetalle
	DEALLOCATE cursorDetalle
END

INSERT INTO ULTRA_CAD_23.ENVIO_DE_MENSAJERIA(ENVIO_MENSAJERIA_NRO, U.USUARIO_NRO, ENVIO_MENSAJERIA_FECHA, ENVIO_MENSAJERIA_DIR_ORIG, ENVIO_MENSAJERIA_DIR_DEST, ENVIO_MENSAJERIA_KM, 
		PAQUETE_COD,ENVIO_MENSAJERIA_VALOR_ASEGURADO,ENVIO_MENSAJERIA_OBSERV,ENVIO_MENSAJERIA_PRECIO_ENVIO,ENVIO_MENSAJERIA_PRECIO_SEGURO,REPARTIDOR_CODIGO,
		ENVIO_MENSAJERIA_PROPINA,ENVIO_MENSAJERIA_TOTAL,ENVIO_MENSAJERIA_ESTADO,ENVIO_MENSAJERIA_TIEMPO_ESTIMADO,ENVIO_MENSAJERIA_FECHA_ENTREGA, ENVIO_MENSAJERIA_CALIFICACION, ENVIO_MENSAJERIA_LOCALIDAD)
	SELECT DISTINCT ENVIO_MENSAJERIA_NRO, USUARIO_NRO, ENVIO_MENSAJERIA_FECHA, ENVIO_MENSAJERIA_DIR_ORIG, ENVIO_MENSAJERIA_DIR_DEST, ENVIO_MENSAJERIA_KM, 
		PAQUETE_COD,ENVIO_MENSAJERIA_VALOR_ASEGURADO,ENVIO_MENSAJERIA_OBSERV,ENVIO_MENSAJERIA_PRECIO_ENVIO,ENVIO_MENSAJERIA_PRECIO_SEGURO,REPARTIDOR_CODIGO,
		ENVIO_MENSAJERIA_PROPINA,ENVIO_MENSAJERIA_TOTAL,ESTADO_NRO,ENVIO_MENSAJERIA_TIEMPO_ESTIMADO,ENVIO_MENSAJERIA_FECHA_ENTREGA, ENVIO_MENSAJERIA_CALIFICACION, L.LOCALIDAD_COD
	FROM gd_esquema.Maestra M JOIN ULTRA_CAD_23.USUARIO U ON (U.USUARIO_DNI = M.USUARIO_DNI) JOIN ULTRA_CAD_23.REPARTIDOR R ON (R.REPARTIDOR_DNI = M.REPARTIDOR_DNI) 
		JOIN ULTRA_CAD_23.PAQUETE P ON (P.PAQUETE_TIPO = M.PAQUETE_TIPO) JOIN ULTRA_CAD_23.ESTADO E ON (E.ESTADO_NOMBRE = M.ENVIO_MENSAJERIA_ESTADO) 
		JOIN ULTRA_CAD_23.PROVINCIA V ON (V.PROVINCIA_NOMBRE = M.ENVIO_MENSAJERIA_PROVINCIA)
		JOIN ULTRA_CAD_23.LOCALIDAD L ON (L.LOCALIDAD_NOMBRE = M.ENVIO_MENSAJERIA_LOCALIDAD AND L.PROVINCIA_COD = V.PROVINCIA_COD) 
		WHERE M.ENVIO_MENSAJERIA_NRO IS NOT NULL ORDER BY ENVIO_MENSAJERIA_NRO

GO
EXEC ULTRA_CAD_23.migrarDatos;

