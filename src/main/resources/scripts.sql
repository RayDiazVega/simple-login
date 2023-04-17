--PUNTO 2

CREATE TABLE PROVINCIAS (
	IDPROVINCIA INT AUTO_INCREMENT PRIMARY KEY,
	DESCRIPCION VARCHAR(100)
);

CREATE TABLE PRODUCTOS (
	IDPRODUCTO VARCHAR(1) PRIMARY KEY,
	DESCRIPCION VARCHAR(100),
	PRECIO DOUBLE
);

CREATE TABLE CLIENTES (
	IDCLIENTE INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(100),
    IDPROVINCIA INT REFERENCES PROVINCIAS(IDPROVINCIA) ON DELETE CASCADE
);

CREATE TABLE COMPRAS(
	IDCOMPRA INT AUTO_INCREMENT PRIMARY KEY,
    IDCLIENTE INT REFERENCES CLIENTES(IDCLIENTE) ON DELETE CASCADE,
    IDPRODUCTO VARCHAR(1) REFERENCES PRODUCTOS(IDPRODUCTO) ON DELETE CASCADE,
    FECHA DATE
);

INSERT INTO PROVINCIAS VALUES
	(1,'Zaragoza'),(2,'Huesca'),(3,'Teruel');

INSERT INTO PRODUCTOS VALUES
	('A','Playmobil',5.00),
	('B','Puzzle',10.25),
	('C','Peonza',3.65);

INSERT INTO CLIENTES VALUES
	(1,'Juan Palomo',1),
	(2,'Armando Ruido',2),
	(3,'Carmelo Cotón',1),
	(4,'Dolores Fuertes',3),
	(5,'Alberto Mate',3);

INSERT INTO COMPRAS VALUES
	(1,1,'C','2022-01-01'),
	(2,2,'B','2022-01-15'),
	(3,2,'C','2022-01-22'),
	(4,4,'A','2022-02-03'),
	(5,3,'A','2022-02-05'),
	(6,1,'B','2022-02-16'),
	(7,1,'B','2022-02-21'),
	(8,4,'A','2022-02-21'),
	(9,5,'C','2022-03-01'),
	(10,3,'A','2022-03-01'),
	(11,3,'C','2022-03-05'),
	(12,2,'B','2022-03-07'),
	(13,2,'B','2022-03-11'),
	(14,1,'A','2022-03-18'),
	(15,1,'C','2022-03-29'),
	(16,5,'B','2022-04-08'),
	(17,5,'C','2022-04-09'),
	(18,4,'C','2022-04-09'),
	(19,1,'A','2022-04-12'),
	(20,2,'A','2022-04-19');

SELECT
	CLI.IDCLIENTE CODIGO_CLIENTE,
	CLI.NOMBRE NOMBRE_CLIENTE,
	PROV.DESCRIPCION PROVINCIA,
	PROD.DESCRIPCION PRODUCTO,
	PROD.PRECIO IMPORTE,
	COMP.FECHA FECHA_VENTA
FROM
	COMPRAS COMP
INNER JOIN CLIENTES CLI ON
	COMP.IDCLIENTE = CLI.IDCLIENTE
INNER JOIN PROVINCIAS PROV ON
	CLI.IDPROVINCIA = PROV.IDPROVINCIA
INNER JOIN PRODUCTOS PROD ON
	COMP.IDPRODUCTO = PROD.IDPRODUCTO;

SELECT
	CLI.IDCLIENTE CODIGO_CLIENTE,
	CLI.NOMBRE NOMBRE_CLIENTE,
	PROV.DESCRIPCION PROVINCIA,
	PROD.DESCRIPCION PRODUCTO,
	PROD.PRECIO IMPORTE,
	COMP.FECHA FECHA_VENTA
FROM
	COMPRAS COMP
INNER JOIN CLIENTES CLI ON
	COMP.IDCLIENTE = CLI.IDCLIENTE
INNER JOIN PROVINCIAS PROV ON
	CLI.IDPROVINCIA = PROV.IDPROVINCIA
INNER JOIN PRODUCTOS PROD ON
	COMP.IDPRODUCTO = PROD.IDPRODUCTO
WHERE
	PROV.DESCRIPCION = 'Teruel';

SELECT
	CLI.IDCLIENTE CODIGO_CLIENTE,
	CLI.NOMBRE NOMBRE_CLIENTE,
	PROV.DESCRIPCION PROVINCIA,
	PROD.DESCRIPCION PRODUCTO,
	PROD.PRECIO IMPORTE,
	COMP.FECHA FECHA_VENTA
FROM
	COMPRAS COMP
INNER JOIN CLIENTES CLI ON
	COMP.IDCLIENTE = CLI.IDCLIENTE
INNER JOIN PROVINCIAS PROV ON
	CLI.IDPROVINCIA = PROV.IDPROVINCIA
INNER JOIN PRODUCTOS PROD ON
	COMP.IDPRODUCTO = PROD.IDPRODUCTO
WHERE
	PROV.DESCRIPCION IN ('Huesca', 'Zaragoza')
	AND COMP.FECHA BETWEEN '2015-01-01' AND '2015-03-31';

SELECT
	CLI.IDCLIENTE CODIGO_CLIENTE,
	PROV.DESCRIPCION PROVINCIA,
	PROD.DESCRIPCION PRODUCTO,
	COUNT(COMP.IDCOMPRA) NUMERO_VENTAS,
	SUM(PROD.PRECIO) IMPORTE_TOTAL
FROM
	COMPRAS COMP
INNER JOIN CLIENTES CLI ON
	COMP.IDCLIENTE = CLI.IDCLIENTE
INNER JOIN PROVINCIAS PROV ON
	CLI.IDPROVINCIA = PROV.IDPROVINCIA
INNER JOIN PRODUCTOS PROD ON
	COMP.IDPRODUCTO = PROD.IDPRODUCTO
GROUP BY
	PROD.DESCRIPCION,
	CLI.IDCLIENTE;

SELECT
	COUNT(COMP.IDCOMPRA) NUMERO_PEONZAS,
	SUM(PROD.PRECIO) IMPORTE_TOTAL
FROM
	COMPRAS COMP
INNER JOIN PRODUCTOS PROD ON
	COMP.IDPRODUCTO = PROD.IDPRODUCTO
WHERE
	PROD.DESCRIPCION = 'Peonza'
	AND COMP.FECHA BETWEEN '2022-03-01' AND '2022-03-31';

SELECT
	CLI.IDCLIENTE CODIGO_CLIENTE,
	CLI.NOMBRE NOMBRE_CLIENTE,
	PROV.DESCRIPCION PROVINCIA,
	MONTH(COMP.FECHA) AS MES,
	COUNT(COMP.IDCOMPRA) NUMERO_VENTAS,
	SUM(PROD.PRECIO) IMPORTE_TOTAL
FROM
	COMPRAS COMP
INNER JOIN CLIENTES CLI ON
	COMP.IDCLIENTE = CLI.IDCLIENTE
INNER JOIN PROVINCIAS PROV ON
	CLI.IDPROVINCIA = PROV.IDPROVINCIA
INNER JOIN PRODUCTOS PROD ON
	COMP.IDPRODUCTO = PROD.IDPRODUCTO
GROUP BY
	MES,
	CLI.IDCLIENTE;

SELECT
	DAY(COMP.FECHA) AS DIA,
	PROD.DESCRIPCION PRODUCTO,
	COUNT(COMP.IDCOMPRA) NUMERO_VENTAS,
	SUM(PROD.PRECIO) IMPORTE_TOTAL
FROM
	COMPRAS COMP
INNER JOIN CLIENTES CLI ON
	COMP.IDCLIENTE = CLI.IDCLIENTE
INNER JOIN PROVINCIAS PROV ON
	CLI.IDPROVINCIA = PROV.IDPROVINCIA
INNER JOIN PRODUCTOS PROD ON
	COMP.IDPRODUCTO = PROD.IDPRODUCTO
GROUP BY
	DIA,
	PRODUCTO;

--PUNTO 3

CREATE TABLE COMPANIAS (
  ID_COMPANIA SERIAL PRIMARY KEY,
  NOMBRE VARCHAR(50) NOT NULL,
  DIRECCION VARCHAR(100) NOT NULL
);

CREATE TABLE GRABACIONES (
  ID_GRABACION SERIAL PRIMARY KEY,
  TITULO VARCHAR(100) NOT NULL,
  CATEGORIA_MUSICAL VARCHAR(50) NOT NULL,
  NUMERO_TEMAS INT NOT NULL,
  DESCRIPCION TEXT,
  ID_COMPANIA INT REFERENCES COMPANIAS(ID_COMPANIA) ON DELETE CASCADE
);

CREATE TABLE FORMATOS (
  ID_FORMATO SERIAL PRIMARY KEY,
  FORMATO VARCHAR(10) NOT NULL
);

CREATE TABLE ESTADOS (
  ID_ESTADO SERIAL PRIMARY KEY,
  ESTADO VARCHAR(10) NOT NULL
);

CREATE TABLE INTERPRETES (
  ID_INTERPRETE SERIAL PRIMARY KEY,
  NOMBRE VARCHAR(100) NOT NULL,
  DESCRIPCION TEXT
);

CREATE TABLE GRABACIONES_INTERPRETES (
  PRIMARY KEY (ID_GRABACION, ID_INTERPRETE),
  ID_GRABACION INT REFERENCES GRABACIONES(ID_GRABACION) ON DELETE CASCADE,
  ID_INTERPRETE INT REFERENCES INTERPRETES(ID_INTERPRETE) ON DELETE CASCADE,
  FECHA_PARTICIPACION DATE NOT NULL
);

CREATE TABLE GRABACIONES_FORMATOS (
  PRIMARY KEY (ID_GRABACION, ID_FORMATO),
  ID_GRABACION INT REFERENCES GRABACIONES(ID_GRABACION) ON DELETE CASCADE,
  ID_FORMATO INT REFERENCES FORMATOS(ID_FORMATO) ON DELETE CASCADE,
  ID_ESTADO INT REFERENCES ESTADOS(ID_ESTADO) ON DELETE CASCADE
);