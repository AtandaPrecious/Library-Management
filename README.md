# 📚 Library Management System (SQL Project)

## Overview
This project implements a **Library Management Database** in MySQL.  
It supports:
- Book issue & return management
- Automatic updates to availability
- Tracking overdue books & fines
- Branch performance reports
- Member activity reports

## Files
- `schema.sql` → Database tables and relationships  
- `sample_data.sql` → Example dataset for testing  
- `procedures.sql` → Stored procedures for issuing & returning books  
- `reports.sql` → Reporting queries (overdue fines, branch performance, active members)

## Usage
1. Run `schema.sql` to create tables.  
2. Run `sample_data.sql` to load test data.  
3. Run `procedures.sql` to create business logic.  
4. Run `reports.sql` to generate summary tables.  

## Features
- Issue a book (updates availability automatically).  
- Return a book (updates availability + tracks quality).  
- Generate overdue fines at **$0.50/day**.  
- Branch-level performance tracking.  
- Identify active members within the last 6 months.  

## Notes
- All dates use `CURRENT_DATE` for testing.  
- Procedures return simple confirmation messages for integration with UI. 
