library(testthat)
library(dplyr)

# Load your function (assuming it's in a file named analyze_missing_data.R)
library(here)
print(file.path(dirname(getwd())))







# Define a path to your test Excel file (replace with your actual file path)
test_file <- (here:here("melb_data_1.xlsx"))

# Test case: Check if analyze_missing_data handles missing values correctly
test_that("analyze_missing_data handles missing values correctly", {
  # Run the function
  result <- analyze_missing_data(test_file)

  # Check if "Missing_Count" column is present in the result
  expect_true("Missing_Count" %in% colnames(result),
              info = "Missing_Count column should be present")

  # Optionally, you can add more specific checks based on your expected results
  # For example, check if the percentage values are between 0 and 100
  expect_true(all(result$Missing_Percentage >= 0 & result$Missing_Percentage <= 100),
              info = "Percentage values should be between 0 and 100")
})
