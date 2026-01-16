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
    justice_file <- here("nsdta", "data", "raw", "law_justice",
                         "Copy of Justice Data_with corrected village name 1225.xlsx")
    
    justice_magistrate_raw <- read_excel(justice_file, sheet = 1, skip = 1, col_types = "text")
    justice_clerk_raw <- read_excel(justice_file, sheet = 2, skip = 1, col_types = "text")
    justice_community_raw <- read_excel(justice_file, sheet = 3, skip = 1, col_types = "text")
    justice_police_raw <- read_excel(justice_file, sheet = 4, skip = 1, col_types = "text")

# ============================================================================
# STEP 1: Remove unhelpful columns
# ============================================================================

# Define columns to remove
    common_remove <- c(2:10, 14:15)  # Columns to remove from ALL datasets
    
    mag_clerk_remove <- c(
        17:19, 22, 44, 65:74, 76, 81, 86, 90, 92, 97, 102, 107, 112, 139, 155:165, 167, 172:176, 178, 197,
        200:201, 203, 206, 209:211, 240:241, 248:249
    )  # Additional columns to remove from magistrate & clerk
    
    community_remove <- c(
        17:19, 25, 36, 38, 66, 69, 71, 73, 75:76, 78:79, 82, 89,
        93, 98, 100, 102, 108:109
    )  # Additional columns to remove from community
    
    police_remove <- c(
        16:17, 21, 66, 68:69, 107, 114, 128, 130:132, 135, 140:141,
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

# ============================================================================
# STEP 2: Rename variables to be simpler
# ============================================================================

    # Load rename helper functions
        source(here("nsdta", "R", "justice_rename_helpers.R"))
    
    # Apply common renames to all datasets
        justice_magistrate <- justice_magistrate %>% rename_common()
        justice_clerk <- justice_clerk %>% rename_common()
        justice_community <- justice_community %>% rename_common()
        justice_police <- justice_police %>% rename_common()

    # Apply specific renames by dataset
        justice_magistrate <- justice_magistrate %>% rename_mag_clerk()
        justice_clerk      <- justice_clerk      %>% rename_mag_clerk()
        justice_community  <- justice_community  %>% rename_community()
        justice_police     <- justice_police     %>% rename_police()

# ============================================================================
# STEP 3: Recode answers
# ============================================================================

# load recoding helper functions
    source(here("nsdta", "R", "justice_recode_functions.R"))



# APPLICATION OF #A
    justice_magistrate <- justice_magistrate %>%
    mutate(interview_date = convert_ymd(interview_date))

    justice_clerk <- justice_clerk %>%
    mutate(interview_date = convert_ymd(interview_date))

    justice_community <- justice_community %>%
    mutate(interview_date = convert_ymd(interview_date))

    justice_police <- justice_police %>%
    mutate(interview_date = convert_ymd(interview_date))
    
    
# APPLICATION OF #B
    # load helpers that read yes/no lists and define apply-functions
    source(here("nsdta", "R", "justice_yesno_helpers.R"))
    # apply to each dataset
    justice_magistrate <- justice_magistrate %>% recode_yesno_mag_clerk()
    justice_clerk     <- justice_clerk     %>% recode_yesno_mag_clerk()
    justice_community <- justice_community %>% recode_yesno_community()
    justice_police    <- justice_police    %>% recode_yesno_police()


# recoding binary variables with (#C)
    # read list of binary columns common to magistrate & clerk
        
    
    

# ============================================================================
# STEP 4: Merge 'other' columns
# ============================================================================

   

# ============================================================================
# Save cleaned data
# ============================================================================

write_csv(justice_magistrate, 
    here("nsdta", "data", "cleaned", "justice_magistrate_clean.csv"))
