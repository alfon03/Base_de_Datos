
--SUBCONSULTAS GESTION

-- 1 -- 
SELECT count(codcli)
FROM facturas
WHERE iva in (SELECT iva FROM facturas
WHERE iva = 16);
-- 2 --
SELECT count(codcli)
FROM facturas
WHERE iva NOT in (SELECT iva FROM facturas
WHERE iva = 16);
SELECT count(codcli)
FROM facturas
WHERE iva in (SELECT iva FROM facturas
WHERE iva = 16);
-- 3 --
SELECT codcli, iva
FROM facturas
WHERE codcli NOT IN ( SELECT codcli FROM facturas WHERE iva != 16)
AND iva IS NOT NULL
GROUP BY codcli,iva;
-- 4 --
SELECT f.fecha
FROM lineas_fac lf , facturas f 
WHERE lf.codfac = f.codfac 
AND precio = (SELECT max(lf2.precio) FROM lineas_fac lf2);
-- 5 --
SELECT COUNT(P.NOMBRE) NUMERO_PUEBLOS
FROM PUEBLOS p
WHERE P.CODPUE NOT IN (SELECT C.CODPUE 
					FROM CLIENTES c);
-- 6 --
SELECT count(a.CODART)
FROM LINEAS_FAC lf ,ARTICULOS a 
WHERE lf.CODART =a.CODART 
AND a.STOCK >20 
AND a.PRECIO >15
AND lf.CODFAC NOT IN (SELECT f2.CODFAC 
					FROM FACTURAS f2
					WHERE EXTRACT(MONTH FROM f2.fecha) BETWEEN 10 AND 12 
					AND EXTRACT(YEAR FROM f2.fecha)=EXTRACT(YEAR FROM sysdate)-1);
-- 7 --
SELECT count(codcli)
FROM facturas c 
WHERE c.CODFAC IN (SELECT f.codcli
					FROM facturas f
					WHERE EXTRACT(YEAR FROM f.fecha) = EXTRACT(YEAR FROM sysdate )-1
					AND (f.iva = 0
					OR f.iva IS NULL));

-- 8 --
SELECT c.codcli,c.nombre
FROM clientes c , facturas f 
WHERE c.codcli = f.codcli 
AND EXTRACT (YEAR FROM f.fecha)  = EXTRACT (YEAR FROM sysdate)-1 
AND EXTRACT (MONTH FROM f.fecha) IN (11,12)
AND f.codfac IN (SELECT lf.codfac
				FROM lineas_fac lf
				WHERE lf.cant + lf.precio > 60.5);
			
--CORRECCION
			
SELECT f.CODCLI 
FROM LINEAS_FAC lf , FACTURAS f 
WHERE lf.CODFAC = f.CODFAC 
AND (lf.PRECIO * lf.CANT) > 60.5
AND EXTRACT (YEAR FROM f.FECHA) = EXTRACT (YEAR FROM sysdate )-1 
AND EXTRACT (MONTH FROM f.FECHA ) = 11
AND f.CODFAC NOT in
					(SELECT f.CODFAC 
					FROM LINEAS_FAC lf , FACTURAS f 
					WHERE lf.CODFAC = f.CODFAC 
					AND EXTRACT (YEAR FROM f.FECHA) = EXTRACT (YEAR FROM sysdate )-1 
					AND EXTRACT (MONTH FROM f.FECHA ) = 12);
				
-- 9 --
SELECT *
FROM (SELECT a.codart, a.descrip, a.precio 
	  FROM articulos a 
	  ORDER BY a.precio DESC)
WHERE rownum <= 10;
-- 10 --

SELECT nombre
FROM   (SELECT p2.nombre, count(c.codcli)
		FROM clientes c , provincias p2, pueblos pu2
		WHERE p2.codpro = pu2.codpro 
		AND pu2.codpue = c.codpue 
		GROUP BY p2.nombre
		ORDER BY count(c.codcli) DESC) 
WHERE rownum=1;

-- 11 -- 
SELECT a.codart, a.descrip
FROM articulos a, lineas_fac lf, facturas f 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac 
AND a.precio > 90.15
AND a.codart IN (SELECT A2.codart
				FROM lineas_fac lf, FACTURAS f2, ARTICULOS a2 
				WHERE F2.CODFAC = LF.CODFAC 
				AND A2.CODART = LF.CODART 
				AND extract(YEAR FROM f2.fecha) = (EXTRACT(YEAR FROM sysdate)-1)
				GROUP BY A2.codart
				HAVING sum(nvl(LF.CANT,0))<10);
-- 12 --
SELECT a.codart, a.descrip 
FROM articulos a 
WHERE a.precio >  (SELECT min(precio)*3000
				 FROM articulos) ;

--Correccion
SELECT a.codart, a.descrip 
FROM articulos a 
WHERE a.precio >= ANY (SELECT (precio)*3000
				 FROM articulos) ;
				
				
-- 13 --
SELECT * FROM (										
	SELECT c.CODCLI, c.NOMBRE, (LF.CANT + LF.LINEA) *LF.PRECIO  as total_facturado
	FROM FACTURAS f, CLIENTES c, LINEAS_FAC lf 
	WHERE c.CODCLI = f.CODCLI AND LF.CODFAC = F.CODFAC)
WHERE ROWNUM=1;

-- 14 --
																		
SELECT a.CODART, a.DESCRIP 
FROM ARTICULOS a
WHERE a.PRECIO > (SELECT AVG(NVL(lf.precio,0)) FROM LINEAS_FAC lf)
AND a.CODART IN (
    SELECT lf.CODART 
    FROM LINEAS_FAC lf, FACTURAS f 
    WHERE F.CODFAC = LF.CODFAC
    GROUP BY lf.CODART 
    HAVING COUNT(DISTINCT f.CODCLI) > 5
);