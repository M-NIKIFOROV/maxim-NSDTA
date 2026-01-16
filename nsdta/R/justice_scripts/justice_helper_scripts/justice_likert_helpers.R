### Likert recode mappings and helper for #D (Likert-style variables)
###
### Pattern:
###   1. Define shared Likert scale templates (label -> integer code).
###   2. For each dataset, map variables to the appropriate template.
###   3. Use recode_likert_labeled(df, likert_map_*) to apply them.


# (1) Shared Likert scale templates

# Language ability (magistrate/clerk, police)
likert_tmpl_speak_local_mag_police <- c(
  "1:Yes, hear and speak"      = 4L,
  "2:Yes, can just hear it"    = 3L,
  "3:Limited understanding"    = 2L,
  "4:Cannot understand"        = 1L
)

# Language ability (community)
likert_tmpl_speak_local_community <- c(
  "1:Hear and speak"           = 4L,
  "2:Can just hear it"         = 3L,
  "3:Limited understanding"    = 2L,
  "4:Cannot understand"        = 1L
)

# Remoteness (6-point)
likert_tmpl_remoteness_6 <- c(
  "1:Highly accessible"        = 6L,
  "2:Accessible"               = 5L,
  "3:Moderately accessible"    = 4L,
  "4:Remote"                   = 3L,
  "5:Very remote"              = 2L,
  "6:Extremely remote"         = 1L
)

# Building state (magistrate/clerk)
likert_tmpl_building_state_4 <- c(
  "1:Functioning but needs to be replaced" = 4L,
  "2:Functioning but needs repairs"        = 3L,
  "3:Not functioning - decrepit"          = 2L,
  "4:Only partly built, incomplete"       = 1L
)

# Generic 4-point functional state (community court/police/barracks)
likert_tmpl_state_4 <- c(
  "1:functional"               = 4L,
  "2:poor"                     = 3L,
  "3:not functional at present"= 2L,
  "4:non-existent"             = 1L
)

# Travel / cost burden (3-point)
likert_tmpl_travel_cost_3 <- c(
  "1:Costs a lot"              = 3L,
  "2:Some costs"               = 2L,
  "3:Does not cost much"       = 1L
)

# Time to police (3-point, community)
likert_tmpl_time_to_police_3 <- c(
  "1:Short walk/close by"               = 3L,
  "2:less than a day walk/many hours"   = 2L,
  "3:more than a day"                   = 1L
)

# Busyness (3-point)
likert_tmpl_busy_3 <- c(
  "1:Usually busy"             = 3L,
  "2:Sometimes busy"           = 2L,
  "3:Not very busy"            = 1L
)

# Community support (4-point)
likert_tmpl_support_4 <- c(
  "1:A lot of support"         = 4L,
  "2:Some support"             = 3L,
  "3:A little support"         = 2L,
  "4:No support"               = 1L
)

# Outcome frequency (4-point: Many / Some / A few / None)
likert_tmpl_outcome_4 <- c(
  "4:Many"                     = 4L,
  "3:Some"                     = 3L,
  "2:A few"                    = 2L,
  "4:None"                     = 1L
)

# Court/police rating (3-point: Always / Sometimes / Never good)
likert_tmpl_good_3 <- c(
  "Always good"                = 3L,
  "Sometimes good"             = 2L,
  "Never good"                 = 1L
)

# Happiness with court (3-point)
likert_tmpl_happy_3 <- c(
  "1:Always happy"             = 3L,
  "2:Sometimes happy"          = 2L,
  "3:Never happy"              = 1L
)

# Personal safety at night (5-point, community)
likert_tmpl_safety_night_5 <- c(
  "5:Very safe"                = 5L,
  "4:Safe"                     = 4L,
  "3:Neutral"                  = 3L,
  "2:Unsafe"                   = 2L,
  "1:Very unsafe"              = 1L
)

# Staff safety (4-point, police)
likert_tmpl_staff_safety_4 <- c(
  "1:Very safe"                = 4L,
  "2:Safe"                     = 3L,
  "4:OK, not safe, not unsafe" = 2L,
  "5:Unsafe"                   = 1L
)

# Proportion of people / respect (5-point, "About half")
likert_tmpl_prop5_about_half <- c(
  "1:All"                      = 5L,
  "2:Most"                     = 4L,
  "3:About half"               = 3L,
  "4:Not many"                 = 2L,
  "5:None"                     = 1L
)

# Proportion of people (5-point, "Half")
likert_tmpl_prop5_half <- c(
  "1:All"                      = 5L,
  "2:Most"                     = 4L,
  "3:Half"                     = 3L,
  "4:Some"                     = 2L,
  "5:Nil"                      = 1L
)

# Need-help frequency (5-point)
likert_tmpl_need_help_5 <- c(
  "1:All the time"             = 5L,
  "2:Often"                    = 4L,
  "3:Sometimes"                = 3L,
  "4:Occasionally"             = 2L,
  "5:Never"                    = 1L
)

# Credit frequency (3-point)
likert_tmpl_credit_3 <- c(
  "1:All the time"             = 3L,
  "2:Sometimes"                = 2L,
  "3:Never"                    = 1L
)

# Availability of resources/equipment (4-point)
likert_tmpl_avail_4 <- c(
  "3:Good provision"           = 4L,
  "2:Adequate provision"       = 3L,
  "1:Poor provision"           = 2L,
  "0:No provision"             = 1L
)


# (2) Mappings: assign variables to templates per dataset

likert_map_mag_clerk <- list(
  speak_local        = likert_tmpl_speak_local_mag_police,
  remoteness         = likert_tmpl_remoteness_6,
  building_state     = likert_tmpl_building_state_4,
  uniform_state      = c(
    "1:Have enough but old, need replacing" = 4L,
    "2:Have enough and not that old"        = 3L,
    "3:Do not have enough"                  = 2L,
    "4:Do not have any"                     = 1L
  ),
  travel_bank_cost   = likert_tmpl_travel_cost_3,
  community_support  = likert_tmpl_support_4,
  outcome_full_court   = likert_tmpl_outcome_4,
  outcome_mediation    = likert_tmpl_outcome_4,
  outcome_refer_police = likert_tmpl_outcome_4,
  outcome_refer_land   = likert_tmpl_outcome_4,
  outcome_refer_district = likert_tmpl_outcome_4,
  outcome_refer_family   = likert_tmpl_outcome_4,
  outcome_refer_church   = likert_tmpl_outcome_4,
  outcome_refer_support  = likert_tmpl_outcome_4
)

likert_map_community <- list(
  justice_remoteness       = likert_tmpl_remoteness_6,
  speak_local              = likert_tmpl_speak_local_community,
  time_to_police           = likert_tmpl_time_to_police_3,
  court_busy               = likert_tmpl_busy_3,
  police_busy              = likert_tmpl_busy_3,
  court_state              = likert_tmpl_state_4,
  police_state             = likert_tmpl_state_4,
  barracks_state           = likert_tmpl_state_4,
  court_rating             = likert_tmpl_good_3,
  court_respect            = likert_tmpl_prop5_about_half,
  happy_with_court         = likert_tmpl_happy_3,
  police_rating            = likert_tmpl_good_3,
  safety_night             = likert_tmpl_safety_night_5,
  community_support_court  = likert_tmpl_support_4,
  community_support_police = likert_tmpl_support_4
)

likert_map_police <- list(
  speak_local          = likert_tmpl_speak_local_mag_police,
  remoteness           = likert_tmpl_remoteness_6,
  staff_safety         = likert_tmpl_staff_safety_4,
  avail_vehicles       = likert_tmpl_avail_4,
  avail_uniforms       = likert_tmpl_avail_4,
  avail_tables         = likert_tmpl_avail_4,
  avail_chairs         = likert_tmpl_avail_4,
  avail_record_books   = likert_tmpl_avail_4,
  avail_stationary     = likert_tmpl_avail_4,
  avail_computers      = likert_tmpl_avail_4,
  avail_firearms       = likert_tmpl_avail_4,
  avail_handcuffs      = likert_tmpl_avail_4,
  avail_vests          = likert_tmpl_avail_4,
  avail_radios         = likert_tmpl_avail_4,
  need_help_callouts          = likert_tmpl_need_help_5,
  need_help_patrols           = likert_tmpl_need_help_5,
  need_help_vehicle           = likert_tmpl_need_help_5,
  need_help_complaint         = likert_tmpl_need_help_5,
  need_help_victim_transport  = likert_tmpl_need_help_5,
  need_help_defendant_transport = likert_tmpl_need_help_5,
  need_help_escort            = likert_tmpl_need_help_5,
  need_help_security          = likert_tmpl_need_help_5,
  need_help_other             = likert_tmpl_need_help_5,
  pop_afford_fees             = likert_tmpl_prop5_half,
  pop_no_access               = likert_tmpl_prop5_half,
  credit_frequency            = likert_tmpl_credit_3,
  travel_bank_cost            = likert_tmpl_travel_cost_3,
  community_support           = likert_tmpl_support_4,
  outcome_warning             = likert_tmpl_outcome_4,
  outcome_mediation           = likert_tmpl_outcome_4,
  outcome_summons             = likert_tmpl_outcome_4,
  outcome_arrest              = likert_tmpl_outcome_4,
  outcome_prosecution         = likert_tmpl_outcome_4,
  outcome_refer_court         = likert_tmpl_outcome_4,
  outcome_refer_family        = likert_tmpl_outcome_4,
  outcome_church              = likert_tmpl_outcome_4,
  outcome_refer_support       = likert_tmpl_outcome_4,
  outcome_no_action           = likert_tmpl_outcome_4,
  outcome_other               = likert_tmpl_outcome_4
)

# (3) Generic engine: apply labelled Likert mappings to a data frame

recode_likert_labeled <- function(df, mapping, unexpected_to_na = TRUE) {
  # If no mappings supplied, just return df unchanged
  if (!length(mapping)) return(df)

  for (var_name in names(mapping)) {
    # Skip if the variable is not present in df
    if (!var_name %in% names(df)) next

    levels_vec <- mapping[[var_name]]

    # Defend against mis-specified mappings: require integer codes
    if (!is.integer(levels_vec)) {
      stop(
        "recode_likert_labeled: mapping for ", var_name,
        " must use integer codes (e.g. 1L, 2L, ...)."
      )
    }

    # Recode: match labels in df to names(levels_vec) and assign integer codes
    df[[var_name]] <- dplyr::case_when(
      is.na(df[[var_name]]) ~ NA_integer_,
      df[[var_name]] %in% names(levels_vec) ~ as.integer(levels_vec[df[[var_name]]]),
      TRUE ~ if (unexpected_to_na) NA_integer_ else NA_integer_
    )
  }

  df
}

# (4) Dataset-specific wrappers used in 03_load_justice.R

recode_likert_mag_clerk <- function(df) {
  recode_likert_labeled(df, likert_map_mag_clerk)
}

recode_likert_community <- function(df) {
  recode_likert_labeled(df, likert_map_community)
}

recode_likert_police <- function(df) {
  recode_likert_labeled(df, likert_map_police)
}
