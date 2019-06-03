-- This is simple VDB that connects to a single PostgreSQL database and exposes it 
-- as a Virtual Database.

-- create database  
CREATE DATABASE customer OPTIONS (ANNOTATION 'Customer VDB');
USE DATABASE customer;

-- create translators, translators are identified by name 
-- https://teiid.gitbooks.io/documents/content/reference/Data_Sources.html
CREATE FOREIGN DATA WRAPPER postgresql;
-- create resource adapter (also called as SERVER) is connection object to the external data source
CREATE SERVER db1 TYPE 'NONE' FOREIGN DATA WRAPPER postgresql OPTIONS ("jndi-name" 'db1');

CREATE FOREIGN DATA WRAPPER mysql5;
CREATE SERVER db2 TYPE 'NONE' FOREIGN DATA WRAPPER postgresql OPTIONS ("jndi-name" 'db2');

-- create schema, then import the metadata from the PostgreSQL database
CREATE SCHEMA accountsdb1 SERVER db1;
CREATE SCHEMA accountsdb2 SERVER db2;
CREATE VIRTUAL SCHEMA portfolio;

SET SCHEMA accountsdb1;
IMPORT FOREIGN SCHEMA public FROM SERVER db1 INTO accountsdb1 OPTIONS("importer.useFullSchemaName" 'false', importer.tableTypes 'TABLE');

SET SCHEMA accountsdb2;
IMPORT FOREIGN SCHEMA public FROM SERVER db2 INTO accountsdb2 OPTIONS("importer.useFullSchemaName" 'false', importer.tableTypes 'TABLE');

SET SCHEMA portfolio;

CREATE VIEW CustomerZip(id bigint PRIMARY KEY, name string, ssn string, zip string) AS 
    SELECT c1.ID as id, c1.NAME as name, c1.SSN as ssn, a1.ZIP as zip 
    FROM accountsdb1.CUSTOMER c1 LEFT OUTER JOIN accountsdb1.ADDRESS a1 
    ON c1.ID = a1.CUSTOMER_ID
    UNION 
    SELECT c2.ID as id, c2.NAME as name, c2.SSN as ssn, a2.ZIP as zip 
    FROM accountsdb2.CUSTOMER c2 LEFT OUTER JOIN accountsdb2.ADDRESS a2 
    ON c2.ID = a2.CUSTOMER_ID