# ============================================================================
# Script: 03_load_justice.R
# Purpose: Load and clean raw law and justice sector data
# Output: Cleaned CSV files in data/cleaned/
# ============================================================================

# Step 0. Set up environment and load libraries
    library(janitor)
    library(tidyverse)
    library(lubridate)
    library(validate)
    library(RSQLite)
    library(DBI)
    library(knitr)
    library(rmarkdown)
    library(here)
    library(readxl)

    getwd() # check working directory

# Load raw data
    justice_file <- here("nsdta", "data", "raw", "law_justice", "as_xlsx",
                         "Copy of Justice Data_with corrected village name 1225.xlsx")
    
    justice_magistrate_raw <- read_excel(justice_file, sheet = 1, skip = 1, col_types = "text")
    justice_clerk_raw <- read_excel(justice_file, sheet = 2, skip = 1, col_types = "text")
    justice_community_raw <- read_excel(justice_file, sheet = 3, skip = 1, col_types = "text")
    justice_police_raw <- read_excel(justice_file, sheet = 4, skip = 1, col_types = "text")

# check no. of cols
tibble(
    dataset = c("magistrate", "clerk", "community", "police"),
    n_cols = c(ncol(justice_magistrate_raw), ncol(justice_clerk_raw), 
               ncol(justice_community_raw), ncol(justice_police_raw))
)

# ============================================================================
# STEP 1: Remove unhelpful columns
# ============================================================================

# Define columns to remove
    common_remove <- c(2:10, 15)  # Columns to remove from ALL datasets
    
    mag_clerk_remove <- c(
        17:19, 22, 44, 65:74, 139, 155:165, 167, 172:176, 178, 197,
        200:201, 203, 206, 209:211, 240:241, 248:249
    )  # Additional columns to remove from magistrate & clerk
    
    community_remove <- c(
        17:19, 25, 36, 38, 66, 69, 71, 73, 75:76, 78:79, 82, 86, 89,
        93, 98, 100, 102, 108:109
    )  # Additional columns to remove from community
    
    police_remove <- c(
        16:17, 21, 39, 66, 68:69, 107, 114, 128, 130:132, 135, 140:141,
        145, 150:151, 155, 160, 165, 170, 182, 194:195, 125, 230, 232:238,
        240:245, 247, 250:251, 262:263, 289, 294, 342, 350:351
    )  # Additional columns to remove from police

# Remove columns from each dataset
    justice_magistrate <- justice_magistrate_raw %>%
        select(-all_of(c(common_remove, mag_clerk_remove)))
    
    justice_clerk <- justice_clerk_raw %>%
        select(-all_of(c(common_remove, mag_clerk_remove)))
    
    justice_community <- justice_community_raw %>%
        select(-all_of(c(common_remove, community_remove)))
    
    justice_police <- justice_police_raw %>%
        select(-all_of(c(common_remove, police_remove)))

# Check no. of cols after removal
tibble(
    dataset = c("magistrate", "clerk", "community", "police"),
    n_cols = c(ncol(justice_magistrate), ncol(justice_clerk), 
               ncol(justice_community), ncol(justice_police))
)

# ============================================================================
# STEP 2: Rename variables to be simpler
# ============================================================================

    justice_magistrate <- justice_magistrate %>%
        rename(
            # new_name = "old_name"
        )

# ============================================================================
# STEP 3: Recode answers
# ============================================================================

    justice_magistrate <- justice_magistrate %>%
        mutate(
            # Recode variables here
        )

# ============================================================================
# STEP 4: Merge 'other' columns
# ============================================================================

    merge_other_columns <- function(df) {
        other_cols <- names(df)[grepl("--OTHER--$", names(df))]
        
        for (other_col in other_cols) {
            base_col <- sub("--OTHER--$", "", other_col)
            
            if (base_col %in% names(df)) {
                df[[base_col]] <- ifelse(
                    !is.na(df[[other_col]]) & df[[other_col]] != "",
                    paste0(df[[base_col]], ": ", df[[other_col]]),
                    df[[base_col]]
                )
            }
        }
        
        df %>% select(-ends_with("--OTHER--"))
    }

    justice_magistrate <- justice_magistrate %>%
        merge_other_columns()

# ============================================================================
# Save cleaned data
# ============================================================================

    write_csv(justice_magistrate, 
              here("nsdta", "data", "cleaned", "justice_magistrate_clean.csv"))

