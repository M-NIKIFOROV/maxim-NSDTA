-- ============================================================================
-- Script: 02_variable_construction.sql
-- Purpose: Create derived variables and aggregate measures
-- Database: SQLite
-- ============================================================================

-- Create view with constructed variables for education sector
CREATE VIEW IF NOT EXISTS education_constructed AS
SELECT 
    *
    -- Add derived variables here
    -- Example: , column1 / column2 AS rate
FROM education;

-- Create view with constructed variables for health sector
CREATE VIEW IF NOT EXISTS health_constructed AS
SELECT 
    *
    -- Add derived variables here
FROM health;

-- Create view with constructed variables for law and justice sector
CREATE VIEW IF NOT EXISTS law_justice_constructed AS
SELECT 
    *
    -- Add derived variables here
FROM law_justice;

-- Create combined view for cross-sector analysis
CREATE VIEW IF NOT EXISTS sectors_combined AS
SELECT 
    'education' AS sector,
    id
    -- Add key variables
FROM education
UNION ALL
SELECT 
    'health' AS sector,
    id
    -- Add key variables
FROM health
UNION ALL
SELECT 
    'law_justice' AS sector,
    id
    -- Add key variables
FROM law_justice;
