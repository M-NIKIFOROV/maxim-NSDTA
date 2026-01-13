-- ============================================================================
-- Script: 01_create_schema.sql
-- Purpose: Create database schema and import cleaned CSV data
-- Database: SQLite
-- ============================================================================

-- Create education sector table
CREATE TABLE IF NOT EXISTS education (
    id INTEGER PRIMARY KEY,
    -- Add columns based on cleaned data structure
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create health sector table
CREATE TABLE IF NOT EXISTS health (
    id INTEGER PRIMARY KEY,
    -- Add columns based on cleaned data structure
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create law and justice sector table
CREATE TABLE IF NOT EXISTS law_justice (
    id INTEGER PRIMARY KEY,
    -- Add columns based on cleaned data structure
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create metadata table
CREATE TABLE IF NOT EXISTS metadata (
    id INTEGER PRIMARY KEY,
    sector TEXT,
    description TEXT,
    source TEXT,
    last_updated DATE
);

-- Import cleaned CSV data
-- .mode csv
-- .import data/cleaned/education_clean.csv education
-- .import data/cleaned/health_clean.csv health
-- .import data/cleaned/law_justice_clean.csv law_justice
