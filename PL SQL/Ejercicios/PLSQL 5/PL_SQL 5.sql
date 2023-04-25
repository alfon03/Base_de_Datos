

/*Crear un procedimiento que en la tabla emp incremente el salario el 10% a los empleados que
tengan una comisión superior al 5% del salario. */

CREATE OR REPLACE PROCEDURE incrementar_salario
IS
BEGIN
  -- Actualizar los salarios de los empleados que cumplen con la condición
  UPDATE EMP 
  SET SAL = SAL * 1.1 -- Incrementar el salario en un 10%
  WHERE COMM > SAL * 0.05; -- Comisión superior al 5% del salario
  COMMIT; -- Confirmar los cambios en la base de datos
  DBMS_OUTPUT.PUT_LINE('Salarios actualizados exitosamente.'); -- Imprimir un mensaje de éxito
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK; -- Deshacer los cambios en caso de error
    DBMS_OUTPUT.PUT_LINE('Error al actualizar los salarios: ' || SQLERRM); -- Imprimir un mensaje de error
END;

BEGIN
	incrementar_salario;
END;

/*Realiza un procedimiento MostrarMejoresVendedores que muestre los nombres de los dos
vendedores/as con más comisiones.*/

CREATE OR REPLACE PROCEDURE MostrarMejoresVendedores
IS
    CURSOR c_vendedores IS
    	SELECT ENAME, COMM FROM EMP 
    	WHERE COMM IN ( SELECT NVL(SUM(COMM),0) AS total_comision
    					FROM emp
      					GROUP BY ename)
       	ORDER BY COMM DESC;
    nombre1 VARCHAR2(50);
   	comision1 NUMBER(50);
    nombre2 VARCHAR2(50);
    comision2 NUMBER(50);

BEGIN
    -- Abrir el cursor
    OPEN c_vendedores;

    -- Obtener los nombres de los dos vendedores con más comisiones
    FETCH c_vendedores INTO nombre1, comision1, nombre2, comision2;

    -- Mostrar los nombres de los vendedores
    DBMS_OUTPUT.PUT_LINE('Los dos vendedores con más comisiones son: ');
     -- Imprimir los nombres de los dos vendedores con más comisiones
 	DBMS_OUTPUT.PUT_LINE('Primer vendedor con más comisiones: ' || nombre1 || ', Comisión: ' || comision1);
    DBMS_OUTPUT.PUT_LINE('Segundo vendedor con más comisiones: ' || nombre2 || ', Comisión: ' || comision2);

    -- Cerrar el cursor
    CLOSE c_vendedores;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Mostrar un mensaje si no se encuentran datos en el cursor
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos de vendedores.');
    WHEN OTHERS THEN
        -- Mostrar un mensaje de error en caso de que ocurra una excepción
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE MostrarMejoresVendedores
IS
    CURSOR c_vendedores IS
        SELECT ENAME, NVL(COMM, 0) AS COMISION
        FROM EMP
        WHERE COMM IS NOT NULL
        ORDER BY COMM DESC;
    nombre1 VARCHAR2(50);
    comision1 NUMBER(20);
    nombre2 VARCHAR2(50);
    comision2 NUMBER(20);
BEGIN
    -- Abrir el cursor
    OPEN c_vendedores;

    -- Obtener los nombres de los dos vendedores con más comisiones
    FETCH c_vendedores INTO nombre1, comision1;
    FETCH c_vendedores INTO nombre2, comision2;

    -- Mostrar los nombres de los vendedores
    DBMS_OUTPUT.PUT_LINE('Los dos vendedores con más comisiones son: ');

    -- Imprimir los nombres de los dos vendedores con más comisiones
    DBMS_OUTPUT.PUT_LINE('Primer vendedor con más comisiones: ' || nombre1 || ', Comisión: ' || comision1);
    DBMS_OUTPUT.PUT_LINE('Segundo vendedor con más comisiones: ' || nombre2 || ', Comisión: ' || comision2);

    -- Cerrar el cursor
    CLOSE c_vendedores;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Mostrar un mensaje si no se encuentran datos en el cursor
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos de vendedores.');
    WHEN OTHERS THEN
        -- Mostrar un mensaje de error en caso de que ocurra una excepción
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;


BEGIN
	MostrarMejoresVendedores;
END;

/*. Realiza un procedimiento MostrarsodaelpmE que reciba el nombre de un departamento al
revés y muestre los nombres de los empleados de ese departamento. 
 */

CREATE OR REPLACE PROCEDURE PLSQL5.MostrarsodaelpmE (nombre_departamento_reves DEPT.DNAME%TYPE)
IS
    nombre_departamento VARCHAR2(50);
    empleados ENAME%TYPE; --variable para almacenar los nombres de empleados

BEGIN
  -- Invertir la cadena de caracteres del nombre del departamento 
    nombre_departamento := '';
    FOR i IN REVERSE 1..LENGTH(nombre_departamento_reves)
    LOOP
        nombre_departamento := nombre_departamento || SUBSTR(nombre_departamento_reves, i, 1);
    END LOOP;

    -- Buscar los empleados del departamento
    FOR emp IN (SELECT ENAME FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = nombre_departamento))
    LOOP
        empleados := emp.ENAME;
       
        -- Mostrar el nombre del empleado
        DBMS_OUTPUT.PUT_LINE('Empleado: ' || empleados);
    END LOOP;

    -- Mostrar mensaje si no se encuentran empleados en el departamento
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron empleados en el departamento ' || nombre_departamento);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Mostrar mensaje si no se encuentra el departamento
        DBMS_OUTPUT.PUT_LINE('El departamento ' || nombre_departamento || ' no existe.');
    WHEN OTHERS THEN
        -- Mostrar un mensaje de error en caso de que ocurra una excepción
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;

BEGIN
	MostrarsodaelpmE('SELAS');
END;


/*Realiza un procedimiento RecortarSueldos que recorte el sueldo un 20% a los empleados
cuyo nombre empiece por la letra que recibe como parámetro. Trata las excepciones que
consideres necesarias.*/


CREATE OR REPLACE PROCEDURE RecortarSueldos(letra_introducida IN CHAR)
IS
    letra CHAR(1);
    recorte NUMBER := 0.2; -- Factor de recorte (20%)
BEGIN
    -- Convertir la letra a mayúscula
    letra := UPPER(letra_introducida);

    -- Recortar el sueldo de los empleados que empiezan con la letra indicada
    UPDATE EMP
    SET SAL = SAL * (1 - recorte)
    WHERE UPPER(SUBSTR(ENAME, 1, 1)) = letra;

    -- Comprobar si se han actualizado registros
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Se ha recortado el sueldo en un 20% a los empleados cuyos nombres empiezan con la letra ' || letra);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron empleados cuyos nombres empiecen con la letra ' || letra);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;


BEGIN	
	RecortarSueldos('A');
END;


/*Realiza un procedimiento BorrarBecarios que borre a los dos empleados más nuevos de cada
departamento.*/

CREATE OR REPLACE PROCEDURE BorrarBecarios
IS
BEGIN
    -- Utilizar una sentencia DELETE con una subconsulta para borrar a los dos empleados más nuevos de cada departamento
    FOR dept IN (SELECT DEPTNO FROM DEPT) LOOP
        DELETE FROM EMP
        WHERE DEPTNO = dept.DEPTNO
            AND (EMPNO, HIREDATE) IN (
                SELECT EMPNO, HIREDATE
                FROM (
                    SELECT EMPNO, HIREDATE
                    FROM EMP
                    WHERE DEPTNO = dept.DEPTNO
                    ORDER BY HIREDATE DESC
                )
                WHERE ROWNUM <= 2
            );
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Se han borrado los dos empleados más nuevos de cada departamento.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;

BEGIN
	BorrarBecarios;
END;



