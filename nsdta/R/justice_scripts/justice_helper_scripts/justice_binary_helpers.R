### Binary recode mappings and helper for #C
###
### Pattern:
###   1. Define, for each dataset, a named list mapping variable names
###      to a named integer vector c("label_for_0" = 0L, "label_for_1" = 1L).
###   2. Use recode_labeled_binary(df, binary_map_*) in small wrappers
###      (you said you already added those wrappers as step (3)).


# (1) Mappings: fill these with your actual two-category variables

binary_map_mag_clerk <- list(
  resp_gender = c("2:Female" = 0L, "1:Male" = 1L),
  chairman_gender = c("2:Female" = 0L, "1:Male" = 1L),
  inspector_visit_2024 = c("Nil (0)" = 0L, "2:No" = 0L, "Visits" = 1L, "1:Yes" = 1L),
  spm_visit_2024 = c("Nil (0)" = 0L, "2:No" = 0L, "Visits" = 1L, "1:Yes" = 1L),
  meet_cost_unpaid_officials = c("1:Own money" = 0L, "2:Table fees" = 1L),
  meet_cost_joint_sitting = c("1:Own money" = 0L, "2:Table fees" = 1L),
  meet_cost_transfer = c("1:Own money" = 0L, "2:Table fees" = 1L),
  meet_cost_fuel = c("1:Own money" = 0L, "2:Table fees" = 1L),
  meet_cost_maintenance = c("1:Own money" = 0L, "2:Table fees" = 1L),
  meet_cost_paperwork = c("1:Own money" = 0L, "2:Table fees" = 1L),
)

binary_map_community <- list(
  resp_gender = c("2:Female" = 0L, "1:Male" = 1L),
)

binary_map_police <- list(
  resp_gender = c("2:Female" = 0L, "1:Male" = 1L),
  oic_gender = c("2:Female" = 0L, "1:Male" = 1L),
  toilet_type = c("1:Pit or shore drop latrine" = 0L, "2:Flush" = 1L),
)


# (2) Generic engine: apply labelled binary mappings to a data frame

recode_labeled_binary <- function(df, mapping, unexpected_to_na = TRUE) {
  if (!length(mapping)) return(df)

  for (var_name in names(mapping)) {
    if (!var_name %in% names(df)) next

    levels_vec <- mapping[[var_name]]

    # defend against mis-specified mappings
    if (!all(levels_vec %in% c(0L, 1L))) {
      stop(
        "recode_labeled_binary: mapping for ", var_name,
        " must only contain 0L/1L values."
      )
    }

    zero_labels <- names(levels_vec)[levels_vec == 0L]
    one_labels  <- names(levels_vec)[levels_vec == 1L]

    df[[var_name]] <- dplyr::case_when(
      is.na(df[[var_name]]) ~ NA_integer_,
      df[[var_name]] %in% zero_labels ~ 0L,
      df[[var_name]] %in% one_labels  ~ 1L,
      TRUE ~ if (unexpected_to_na) NA_integer_ else NA_integer_
    )
  }

  df
}

