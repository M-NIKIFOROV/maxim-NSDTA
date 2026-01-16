# ============================================================================
# Script: build_yesno_text_files.R
# Purpose: Detect yes/no/DK variables and write their names to text files
#          for use by 03_load_justice.R
#
# Usage:
#   - Run justice loading/cleaning script up to the end of STEP 2
#     so that the following objects exist in the R session:
#       * justice_magistrate
#       * justice_clerk
#       * justice_community
#       * justice_police
#   - Then source() this file. It will create/update:
#       * nsdta/R/yesno_mag_clerk_cols.txt
#       * nsdta/R/yesno_community_cols.txt
#       * nsdta/R/yesno_police_cols.txt
# ============================================================================

if (!requireNamespace("here", quietly = TRUE)) {
  stop("Package 'here' is required. Please install it before running this script.")
}

# ---------------------------------------------------------------------------
# Helper: detect strict yes/no/DK columns (with optional NA:Not applicable)
# ---------------------------------------------------------------------------

is_yesno_col <- function(x) {
  vals <- tolower(trimws(unique(x)))
  vals <- vals[!is.na(vals) & vals != ""]

  if (length(vals) == 0L) return(FALSE)

  yes_like <- grepl("^1:\\s*yes$", vals)
  no_like  <- grepl("^2:\\s*no$",  vals)
  dk_like  <- grepl("^dk:\\s*(don't know|dont know|do not know)$", vals)
  na_like  <- grepl("^na:\\s*not applicable$", vals)

  # Any value outside these patterns disqualifies the column
# ---------------------------------------------------------------------------
# Fast path: if all three output files already exist, do nothing
# ---------------------------------------------------------------------------

yesno_mag_clerk_path <- here::here("nsdta", "R", "yesno_mag_clerk_cols.txt")
yesno_community_path <- here::here("nsdta", "R", "yesno_community_cols.txt")
yesno_police_path    <- here::here("nsdta", "R", "yesno_police_cols.txt")

if (file.exists(yesno_mag_clerk_path) &&
    file.exists(yesno_community_path) &&
    file.exists(yesno_police_path)) {
  cat("Yes/no column lists already exist; skipping rebuild.\n")
  return(invisible(NULL))
}
  if (any(!(yes_like | no_like | dk_like | na_like))) return(FALSE)

  # Require at least one yes and one no observed to call it a yes/no variable
  any(yes_like) && any(no_like)
}

# ---------------------------------------------------------------------------
# Safety checks: required data frames
# ---------------------------------------------------------------------------

required_dfs <- c("justice_magistrate", "justice_clerk", "justice_community", "justice_police")
missing_dfs <- required_dfs[!vapply(required_dfs, exists, logical(1))]

if (length(missing_dfs) > 0L) {
  stop(
    "The following data frames are missing from the environment: ",
    paste(missing_dfs, collapse = ", "),
    ". Run 03_load_justice.R up to the end of STEP 2 before sourcing this script."
  )
}

# ---------------------------------------------------------------------------
# Magistrate & clerk: intersection of yes/no columns
# ---------------------------------------------------------------------------

mag_yesno_cols   <- names(Filter(is_yesno_col, get("justice_magistrate")))
clerk_yesno_cols <- names(Filter(is_yesno_col, get("justice_clerk")))

yesno_mag_clerk_cols <- sort(intersect(mag_yesno_cols, clerk_yesno_cols))

yesno_mag_clerk_path <- here::here("nsdta", "R", "yesno_mag_clerk_cols.txt")
writeLines(yesno_mag_clerk_cols, yesno_mag_clerk_path)

cat("Written ", length(yesno_mag_clerk_cols), " yes/no columns for magistrate & clerk to ",
    yesno_mag_clerk_path, "\n", sep = "")

# ---------------------------------------------------------------------------
# Community: all detected yes/no columns
# ---------------------------------------------------------------------------

community_yesno_cols <- names(Filter(is_yesno_col, get("justice_community")))
community_yesno_cols <- sort(community_yesno_cols)

yesno_community_path <- here::here("nsdta", "R", "yesno_community_cols.txt")
writeLines(community_yesno_cols, yesno_community_path)

cat("Written ", length(community_yesno_cols), " yes/no columns for community to ",
    yesno_community_path, "\n", sep = "")

# ---------------------------------------------------------------------------
# Police: all detected yes/no columns
# ---------------------------------------------------------------------------

police_yesno_cols <- names(Filter(is_yesno_col, get("justice_police")))
police_yesno_cols <- sort(police_yesno_cols)

yesno_police_path <- here::here("nsdta", "R", "yesno_police_cols.txt")
writeLines(police_yesno_cols, yesno_police_path)

cat("Written ", length(police_yesno_cols), " yes/no columns for police to ",
    yesno_police_path, "\n", sep = "")

cat("\nDone. You can now run STEP 3 in 03_load_justice.R to apply recodes using these lists.\n")
