-- EJERCICIOS -- 

-- 1 --
SELECT aa.idalumno
FROM alumno_asignatura aa 
WHERE aa.idasignatura NOT IN ('150212','130113');

--Correcion
select distinct(idalumno)
from alumno_asignatura
where idalumno not in(select idalumno from alumno_asignatura
					where idasignatura like '150212' or idasignatura like '130113');
-- 2 --
SELECT nombre
FROM asignatura a 
WHERE creditos > 
	(SELECT creditos
	FROM asignatura a2
	WHERE lower(nombre) LIKE 'seguridad vial');
-- 3 --
SELECT idalumno
FROM alumno_asignatura aa 
WHERE idasignatura LIKE '150212'
AND idasignatura LIKE '130113'; 
--CORRECION

select distinct(idalumno)
from alumno_asignatura
where idalumno in (select idalumno from alumno_asignatura where idasignatura=150212)
And idalumno in (select idalumno from alumno_asignatura where idasignatura=130113);

select distinct(idalumno)
from alumno_asignatura
where idalumno in (select idalumno from alumno_asignatura 
			where idasignatura=150212 
			AND idasignatura=130113 )


-- 4 --
SELECT idalumno
FROM alumno_asignatura aa 
WHERE idasignatura LIKE '150212'
OR idasignatura LIKE '130113'; 

--Correccion
select distinct(idalumno)
from alumno_asignatura
where (idasignatura = 130113 and idalumno not in
	(select idalumno from alumno_asignatura 
		where idasignatura=150212))
Or(idasignatura = 150212 and idalumno not in
	(select idalumno from alumno_asignatura 
		where idasignatura=130113));

-- 5 --
SELECT nombre
FROM asignatura a 
WHERE idtitulacion LIKE '130110'
AND costebasico >
	(SELECT avg(nvl(a2.costebasico,0))
	FROM asignatura a2
		WHERE a2.IDTITULACION LIKE '130110');
-- 6 --
SELECT idalumno
FROM alumno_asignatura aa 
WHERE idasignatura NOT LIKE '150212'
AND idasignatura NOT LIKE '130113';

--correcion
SELECT distinct(idalumno)
from alumno_asignatura
where  idalumno not in(SELECT idalumno
						from alumno_asignatura
						where  idasignatura in('150212','130113'));
-- 7 --
SELECT idalumno
FROM alumno_asignatura aa 
WHERE idasignatura LIKE '150212'
AND idasignatura NOT LIKE '130113'; 

--Correcion

select idalumno
from alumno_asignatura
where idasignatura = '150212'
	and idalumno not in(SELECT idalumno
						from alumno_asignatura
						where  idasignatura = '130113');
					
-- 8 --
SELECT nombre 
FROM asignatura a 
WHERE creditos > 
(SELECT creditos
	FROM asignatura a2
	WHERE lower(nombre) LIKE 'seguridad vial');
-- 9 --
SELECT nombre,apellido
FROM persona
WHERE dni NOT IN 
		(SELECT dni 
		FROM profesor p)
AND dni NOT IN
		(SELECT dni
		FROM alumno a); 
-- 10. Mostrar el nombre de las asignaturas que tengan más créditos.  --
select  nombre
from asignatura
where creditos = (select max(creditos)
                from asignatura);
-- 11. Lista de asignaturas en las que no se ha matriculado nadie. 
SELECT a.nombre
FROM alumno_asignatura aa, asignatura a 
WHERE aa.idasignatura(+) = a.idasignatura
AND aa.idasignatura IS null; 

--Subconsulta
select nombre
from asignatura a
where idasignatura not  in(select idasignatura
			  from alumno_asignatura);
-- 12. Ciudades en las que vive algún profesor y también algún alumno. 
SELECT DISTINCT ciudad
FROM persona 
WHERE dni in 
	(SELECT dni
	FROM profesor)
AND dni in 
	(SELECT dni
	FROM alumno);
	
--Correcion
select distinct(p.ciudad)
from persona p, persona p1
where  p.dni in(select dni from alumno)
or p1.dni in(select dni from profesor)
and p.ciudad=p1.ciudad;
