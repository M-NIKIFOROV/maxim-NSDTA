# R Scripts

This directory contains R scripts for the data pipeline.

## Script Execution Order

### Phase 1: Data Loading and Cleaning
1. `01_load_clean_education.R`: Clean education sector data
2. `02_load_clean_health.R`: Clean health sector data
3. `03_load_clean_law_justice.R`: Clean law and justice sector data

### Phase 2: SQL Processing
After Phase 1, run SQL scripts to organize data and create variables.

### Phase 3: Statistical Analysis
4. `04_connect_database.R`: Connect to SQLite and load processed data
5. `05_t_tests.R`: Conduct t-tests
6. `06_regressions.R`: Run regression analyses
7. `07_visualization.R`: Create visualizations

## Required Libraries
- tidyverse
- DBI
- RSQLite
- broom
- ggplot2

Install with:
```r
install.packages(c("tidyverse", "DBI", "RSQLite", "broom", "ggplot2"))
```
