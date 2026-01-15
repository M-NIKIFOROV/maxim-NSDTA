# ============================================================================
# Script: 00_viewingcols_justice.R
# Purpose: Load to view the column names for cleaning
# Output: Script to view column names
# ============================================================================


    library(tidyverse)
    library(here)
    library(readxl)

    getwd() # check working directory

    justice_file <- here("nsdta", "data", "raw", "law_justice",
                     "Copy of Justice Data_with corrected village name 1225.xlsx")

    read_justice_sheet <- function(sheet_num) {
        read_excel(justice_file, sheet = sheet_num, skip = 1, col_types = "text")
    }

    justice_magistrate_raw <- read_justice_sheet(1)
    justice_clerk_raw <- read_justice_sheet(2)
    justice_community_raw <- read_justice_sheet(3)
    justice_police_raw <- read_justice_sheet(4)

   # Create side-by-side comparison
max_cols <- max(
    ncol(justice_magistrate_raw),
    ncol(justice_clerk_raw),
    ncol(justice_community_raw),
    ncol(justice_police_raw)
)

tibble(
    magistrate = c(names(justice_magistrate_raw), rep(NA, max_cols - ncol(justice_magistrate_raw))),
    clerk = c(names(justice_clerk_raw), rep(NA, max_cols - ncol(justice_clerk_raw))),
    community = c(names(justice_community_raw), rep(NA, max_cols - ncol(justice_community_raw))),
    police = c(names(justice_police_raw), rep(NA, max_cols - ncol(justice_police_raw)))
) %>% View()