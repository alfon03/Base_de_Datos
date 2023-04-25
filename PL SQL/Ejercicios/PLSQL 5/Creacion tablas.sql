
--Creanción de la base de datos

alter session set "_oracle_script"=TRUE;
create user plsql5 identified by plsql5;
GRANT CONNECT, RESOURCE, DBA TO plsql5;

--Creación de tablas

CREATE TABLE EMP(
  EMPNO     NUMBER(4) primary key,
  ENAME     VARCHAR2(10 BYTE),
  JOB       VARCHAR2(9 BYTE),
  MGR       NUMBER(4),
  HIREDATE  DATE,
  SAL       NUMBER(7,2),
  COMM      NUMBER(7,2),
  DEPTNO    NUMBER(2)
);

CREATE TABLE DEPT(
  DEPTNO  NUMBER(2) primary key,
  DNAME   VARCHAR2(14 BYTE),
  LOC     VARCHAR2(13 BYTE)
);




ALTER TABLE EMP ADD (CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO));

CREATE TABLE BONUS(
  ENAME  VARCHAR2(10 BYTE),
  JOB    VARCHAR2(9 BYTE),
  SAL    NUMBER,
  COMM   NUMBER
);

