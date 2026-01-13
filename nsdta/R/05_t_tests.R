# ============================================================================
# Script: 05_t_tests.R
# Purpose: Conduct t-tests comparing sectors and groups
# Output: Statistical tables in output/tables/
# ============================================================================

# Load required libraries
library(tidyverse)
library(broom)

# Source database connection script
# source("R/04_connect_database.R")

# Example: Two-sample t-test comparing education vs health sector
# t_test_edu_health <- t.test(education_data$variable, health_data$variable)
# tidy_results <- tidy(t_test_edu_health)

# Example: Paired t-test
# t_test_paired <- t.test(before, after, paired = TRUE)

# Example: One-sample t-test
# t_test_one_sample <- t.test(data$variable, mu = 0)

# Save results to CSV
# write.csv(tidy_results, "output/tables/t_test_results.csv", row.names = FALSE)

# Print results summary
# print(t_test_edu_health)
