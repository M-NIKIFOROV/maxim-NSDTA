-- ============================================================================
-- Script: 03_descriptive_statistics.sql
-- Purpose: Generate descriptive statistics for each sector
-- Database: SQLite
-- ============================================================================

-- Descriptive statistics for education sector
CREATE VIEW IF NOT EXISTS education_descriptives AS
SELECT 
    COUNT(*) AS n_observations,
    -- Add summary statistics
    -- AVG(variable) AS mean_variable,
    -- MIN(variable) AS min_variable,
    -- MAX(variable) AS max_variable
    COUNT(*) AS record_count
FROM education;

-- Descriptive statistics for health sector
CREATE VIEW IF NOT EXISTS health_descriptives AS
SELECT 
    COUNT(*) AS n_observations,
    -- Add summary statistics
    COUNT(*) AS record_count
FROM health;

-- Descriptive statistics for law and justice sector
CREATE VIEW IF NOT EXISTS law_justice_descriptives AS
SELECT 
    COUNT(*) AS n_observations,
    -- Add summary statistics
    COUNT(*) AS record_count
FROM law_justice;

-- Cross-sector summary
CREATE VIEW IF NOT EXISTS sector_summary AS
SELECT 
    sector,
    COUNT(*) AS total_records
FROM sectors_combined
GROUP BY sector;
