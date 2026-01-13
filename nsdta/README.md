# NSDTA Data Pipeline

A structured data analysis pipeline for sector data analysis using R for data cleaning and statistical inference, with SQLite for data organization and variable construction.

## Project Structure

```
nsdta/
├── data/
│   ├── raw/                    # Raw data files
│   │   ├── education/          # Education sector data
│   │   ├── health/             # Health sector data
│   │   ├── law_justice/        # Law and justice sector data
│   │   └── metadata/           # Data dictionaries and metadata
│   └── cleaned/                # Cleaned CSV files
├── R/                          # R scripts
│   ├── 01_load_clean_education.R
│   ├── 02_load_clean_health.R
│   ├── 03_load_clean_law_justice.R
│   ├── 04_connect_database.R
│   ├── 05_t_tests.R
│   ├── 06_regressions.R
│   └── 07_visualization.R
├── sql/                        # SQL scripts
│   ├── 01_create_schema.sql
│   ├── 02_variable_construction.sql
│   └── 03_descriptive_statistics.sql
├── output/                     # Analysis outputs
│   ├── tables/                 # Statistical tables (CSV)
│   └── figures/                # Plots and visualizations
└── docs/                       # Documentation
```

## Contact
Maxim Nikiforov
maxim.nikiforov@outlook.com or u7925656@anu.edu.au
0413 216 567
