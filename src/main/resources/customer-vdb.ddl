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
CREATE SCHEMA accounts SERVER db1;
CREATE VIRTUAL SCHEMA portfolio;

SET SCHEMA accounts;
IMPORT FOREIGN SCHEMA public FROM SERVER db1 INTO accounts OPTIONS("importer.useFullSchemaName" 'false');

SET SCHEMA portfolio;

CREATE VIEW CustomerZip(id bigint PRIMARY KEY, name string, ssn string, zip string) AS 
    SELECT c.ID as id, c.NAME as name, c.SSN as ssn, a.ZIP as zip 
    FROM accounts.CUSTOMER c LEFT OUTER JOIN accounts.ADDRESS a 
    ON c.ID = a.CUSTOMER_ID;   