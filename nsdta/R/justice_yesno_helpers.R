# Helper functions to read yes/no column lists and apply yes/no/DK recodes

# This script expects that:
#   - the 'here' package is available
#   - recode_yes_no_dk() is already defined (from justice_recode_functions.R)
#   - dplyr is available for mutate/across

# Read lists of yes/no columns from text files
yesno_mag_clerk_cols <- readLines(
  here::here("nsdta", "R", "yesno_mag_clerk_cols.txt")
)

yesno_community_cols <- readLines(
  here::here("nsdta", "R", "yesno_community_cols.txt")
)

yesno_police_cols <- readLines(
  here::here("nsdta", "R", "yesno_police_cols.txt")
)

# Helper to apply yes/no DK recodes to magistrate & clerk columns
recode_yesno_mag_clerk <- function(df) {
  cols <- intersect(yesno_mag_clerk_cols, names(df))

  df %>%
    dplyr::mutate(dplyr::across(dplyr::all_of(cols), recode_yes_no_dk))
}

# Helper to apply yes/no DK recodes to community columns
recode_yesno_community <- function(df) {
  cols <- intersect(yesno_community_cols, names(df))

  df %>%
    dplyr::mutate(dplyr::across(dplyr::all_of(cols), recode_yes_no_dk))
}

# Helper to apply yes/no DK recodes to police columns
recode_yesno_police <- function(df) {
  cols <- intersect(yesno_police_cols, names(df))

  df %>%
    dplyr::mutate(dplyr::across(dplyr::all_of(cols), recode_yes_no_dk))
}
