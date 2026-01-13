# ============================================================================
# Script: 04_connect_database.R
# Purpose: Connect to SQLite database and load data for statistical analysis
# ============================================================================

# Load required libraries
library(DBI)
library(RSQLite)
library(tidyverse)

# Set working directory
# setwd("path/to/nsdta")

# Connect to SQLite database
# con <- dbConnect(RSQLite::SQLite(), "nsdta_database.db")

# Load data from database views
# education_data <- dbReadTable(con, "education_constructed")
# health_data <- dbReadTable(con, "health_constructed")
# law_justice_data <- dbReadTable(con, "law_justice_constructed")

# Load descriptive statistics
# education_desc <- dbReadTable(con, "education_descriptives")
# health_desc <- dbReadTable(con, "health_descriptives")
# law_justice_desc <- dbReadTable(con, "law_justice_descriptives")

# Close database connection when done
# dbDisconnect(con)
