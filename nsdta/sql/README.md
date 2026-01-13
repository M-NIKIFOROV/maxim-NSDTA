# SQL Scripts

This directory contains SQL scripts for database schema creation, variable construction, and descriptive statistics.

## Scripts
1. `01_create_schema.sql`: Creates database tables and imports cleaned CSV data
2. `02_variable_construction.sql`: Creates derived variables and views
3. `03_descriptive_statistics.sql`: Generates descriptive statistics views

## Database
- SQLite database: `nsdta_database.db` (created in project root)

## Usage
Execute scripts in order:
```bash
sqlite3 nsdta_database.db < sql/01_create_schema.sql
sqlite3 nsdta_database.db < sql/02_variable_construction.sql
sqlite3 nsdta_database.db < sql/03_descriptive_statistics.sql
```

## Notes
- Scripts should be idempotent (safe to run multiple times)
- Views are recreated when scripts are re-run
