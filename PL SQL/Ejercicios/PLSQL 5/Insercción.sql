
--INSERCCION DE DATOS

INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES ( 
10, 'ACCOUNTING', 'NEW YORK'); 
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES ( 
20, 'RESEARCH', 'DALLAS'); 
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES ( 
30, 'SALES', 'CHICAGO'); 
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES ( 
40, 'OPERATIONS', 'BOSTON'); 

INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7369, 'SMITH', 'CLERK', 7902,  TO_Date( '12/17/1980 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 800, NULL, 20); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7499, 'ALLEN', 'SALESMAN', 7698,  TO_Date( '02/20/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 1600, 300, 30); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7521, 'WARD', 'SALESMAN', 7698,  TO_Date( '02/22/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 1250, 500, 30); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7566, 'JONES', 'MANAGER', 7839,  TO_Date( '04/02/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 2975, NULL, 20); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7654, 'MARTIN', 'SALESMAN', 7698,  TO_Date( '09/28/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 1250, 1400, 30); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7698, 'BLAKE', 'MANAGER', 7839,  TO_Date( '05/01/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 2850, NULL, 30); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7782, 'CLARK', 'MANAGER', 7839,  TO_Date( '06/09/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 2450, NULL, 10); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7788, 'SCOTT', 'ANALYST', 7566,  TO_Date( '04/19/1987 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 3000, NULL, 20); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7839, 'KING', 'PRESIDENT', NULL,  TO_Date( '11/17/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 5000, NULL, 10); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7844, 'TURNER', 'SALESMAN', 7698,  TO_Date( '09/08/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 1500, 0, 30); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7876, 'ADAMS', 'CLERK', 7788,  TO_Date( '05/23/1987 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 1100, NULL, 20); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7900, 'JAMES', 'CLERK', 7698,  TO_Date( '12/03/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 950, NULL, 30); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7902, 'FORD', 'ANALYST', 7566,  TO_Date( '12/03/1981 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 3000, NULL, 20); 
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES ( 
7934, 'MILLER', 'CLERK', 7782,  TO_Date( '01/23/1982 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, 1300, NULL, 10); 


