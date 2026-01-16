# Recoding helper functions for justice data

# A. function to set to ymd format
convert_ymd <- function(date_col) {
  lubridate::ymd(date_col)
}

# B. function to recode yes/no/dk (and variants) to integer 1/0/NA
recode_yes_no_dk <- function(answer_col) {
  # normalise: trim spaces, lower case, drop numeric prefixes like "1:" or "2:"
  cleaned <- tolower(trimws(answer_col))
  cleaned <- sub("^[0-9]+:\\s*", "", cleaned)

  as.integer(
    dplyr::case_when(
      # yes-like answers
      cleaned %in% c("yes", "y") ~ 1,

      # no-like answers
      cleaned %in% c("no", "n") ~ 0,

      # anything else treated as NA
      TRUE ~ NA_real_
    )
  )
}

# C. binary variables to 0/1, with strict checking
recode_binary <- function(answer_col) {
  cleaned <- trimws(answer_col)

  # flag any unexpected non-missing values
  bad <- !is.na(cleaned) & !cleaned %in% c("0", "1", "")
  if (any(bad)) {
    stop(
      "recode_binary: unexpected values: ",
      paste(sort(unique(cleaned[bad])), collapse = ", ")
    )
  }

  as.integer(
    dplyr::case_when(
      cleaned == "1" ~ 1,
      cleaned == "0" ~ 0,
      TRUE ~ NA_real_
    )
  )
}

# D. Likert scale 1-5 to integer, with strict checking
recode_likert_1_5 <- function(answer_col) {
  cleaned <- trimws(answer_col)

  # flag any unexpected non-missing values
  bad <- !is.na(cleaned) & !cleaned %in% c("1", "2", "3", "4", "5", "")
  if (any(bad)) {
    stop(
      "recode_likert_1_5: unexpected values: ",
      paste(sort(unique(cleaned[bad])), collapse = ", ")
    )
  }

  as.integer(
    dplyr::case_when(
      cleaned %in% c("1", "2", "3", "4", "5") ~ as.integer(cleaned),
      TRUE ~ NA_integer_
    )
  )
}

# E. clamp absurd integer values (e.g. ages, years worked, small counts)
#    outside [min_val, max_val] to NA
clip_int_range <- function(x, min_val, max_val) {
  x_int <- suppressWarnings(as.integer(x))

  # flag any non-numeric values that survived earlier cleaning
  bad_non_numeric <- !is.na(x) & is.na(x_int)
  if (any(bad_non_numeric)) {
    stop(
      "clip_int_range: non-numeric values: ",
      paste(sort(unique(x[bad_non_numeric])), collapse = ", ")
    )
  }

  x_int[x_int < min_val | x_int > max_val] <- NA_integer_
  x_int
}

# F. Multiple response columns: split into indicator columns
split_multiresp <- function(answer_col, choices) {
  cleaned <- tolower(trimws(answer_col))

  # create indicator columns for each choice
  indicators <- lapply(choices, function(choice) {
    as.integer(grepl(tolower(choice), cleaned, fixed = TRUE))
  })

  # set column names
  names(indicators) <- paste0("multiresp_", choices)

  tibble::as_tibble(indicators)
}

# G. Standardise common missing-value codes to NA (character-level)
standardise_missing <- function(x, na_strings = c(
  "", " ",
  "dk", "don't know", "dont know", "do not know",
  "refused", "missing", "n/a", "na", "not applicable"
)) {
  x_chr <- tolower(trimws(as.character(x)))

  # treat user-specified missing codes (case-insensitive) as NA
  na_strings <- tolower(trimws(as.character(na_strings)))
  x_chr[x_chr %in% na_strings] <- NA_character_

  x_chr
}

# H. Coerce to numeric safely with strict checking
to_numeric_safe <- function(x, na_strings = c(
  "", " ",
  "dk", "don't know", "dont know", "do not know",
  "refused", "missing", "n/a", "na", "not applicable",
  "999", "888"
)) {
  x_chr <- trimws(as.character(x))

  # first standardise known missing codes to NA
  na_strings <- trimws(as.character(na_strings))
  x_chr[x_chr %in% na_strings] <- NA_character_

  suppressWarnings(x_num <- as.numeric(x_chr))

  # flag any non-missing values that failed to convert
  bad <- !is.na(x_chr) & is.na(x_num)
  if (any(bad)) {
    stop(
      "to_numeric_safe: non-numeric values: ",
      paste(sort(unique(x_chr[bad])), collapse = ", ")
    )
  }

  x_num
}

# I. Clean free-text / label fields (whitespace + optional casing)
clean_text_label <- function(x, to_lower = TRUE) {
  x_chr <- trimws(as.character(x))

  # collapse internal multiple spaces
  x_chr <- stringr::str_squish(x_chr)

  # convert empty strings to NA
  x_chr[x_chr == ""] <- NA_character_

  if (to_lower) {
    x_chr <- tolower(x_chr)
  }

  x_chr
}
