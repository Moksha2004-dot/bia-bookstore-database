# BIA Bookstore Database Management System

## Project Overview

This project focuses on designing and developing a relational database for a bookstore.

Our team created a database structure to manage customers, products, orders, vendors, employees, inventory, and deliveries.

We used database design principles, normalization, and SQL to organize the information, reduce data duplication, and maintain data accuracy.

The project also explores how SQL can support bookstore operations and business reporting.

## Project Objectives

- Design a relational database for bookstore operations.
- Identify entities, attributes, and relationships.
- Create an Entity Relationship Diagram (ERD).
- Apply database normalization up to Third Normal Form (3NF).
- Create database tables using SQL.
- Implement primary keys, foreign keys, and constraints.
- Insert, update, and retrieve database records.
- Use SQL queries to support business reporting.
- Understand transaction management and data integrity.

## Tools Used

- SQL
- MySQL

## Database Design

We identified the main entities required to manage bookstore operations.

The database includes the following tables:

- Customer
- Employee
- Vendor
- Product
- Orders
- Order Details
- Delivery
- Cart
- Product Stock
- Vendor Order

These tables are connected through relationships that help organize customer purchases, product inventory, vendor information, and delivery records.

## Database Normalization

We applied normalization principles to organize the database and reduce unnecessary duplication.

### First Normal Form (1NF)

We removed repeating groups and organized the data so that each field contains a single value.

### Second Normal Form (2NF)

We separated information into related tables to remove partial dependencies.

### Third Normal Form (3NF)

We removed transitive dependencies by separating customer, employee, and vendor information into their respective tables.

This process helped us create a more organized database structure and improve data consistency.

## SQL Implementation

SQL was used to create and manage the database tables.

The project covered different SQL operations, including:

### Data Definition Language (DDL)

- Creating database tables.
- Defining primary and foreign keys.
- Establishing relationships between tables.
- Applying constraints to maintain data integrity.

### Data Manipulation Language (DML)

- Inserting new records.
- Updating existing information.
- Deleting records when required.

### Data Query Language (DQL)

- Retrieving records using SELECT.
- Combining related tables using JOIN.
- Grouping records using GROUP BY.
- Performing calculations using aggregate functions.

## Data Integrity and Business Rules

We used database constraints to maintain accurate and consistent information.

These included:

- PRIMARY KEY to uniquely identify records.
- FOREIGN KEY to establish relationships.
- NOT NULL to prevent missing required values.
- CHECK constraints to validate data.
- Referential actions to maintain consistency between related tables.

For example, inventory quantities should not contain negative values.

## Business Reporting Using SQL

The project demonstrates how SQL queries can support business decisions.

### Sales Analysis

Using aggregate functions, sales information can be summarized by order status.

### Customer Analysis

Customer order history can be analyzed to identify customers who have placed multiple orders.

### Delivery Tracking

JOIN operations can connect orders, deliveries, and employee information to support delivery tracking.

These examples show how a relational database can help a bookstore organize its daily operations and retrieve useful information.

## Transaction Management

The project also covers transaction management using SQL.

- COMMIT saves completed database changes.
- ROLLBACK reverses changes when necessary.

Transaction management helps maintain data consistency when performing multiple database operations.

## Project Files

The repository contains the SQL implementation and supporting project documentation.

The SQL script includes the database implementation, while the presentation explains the database design, normalization process, and SQL concepts used in the project.

## Author

Moksha Ramchetty
