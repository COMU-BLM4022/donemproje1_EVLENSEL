# tests/testthat/test_clean_and_write_excel.R
library(testthat)
library(readxl)
library(writexl)
library(dplyr)


test_that("clean_and_write_excel removes columns with more than 50% missing values", {
  temp_input <- tempfile(fileext = ".xlsx")
  temp_output <- tempfile(fileext = ".xlsx")

  data <- data.frame(
    A = c(1, NA, 3, NA, 5),
    B = c(6, 7, 8, 9, 10),
    C = c(NA, NA, 13, NA, 15)
  )

  write_xlsx(data, temp_input)
  clean_and_write_excel(temp_input, temp_output)
  cleaned_data <- as.data.frame(read_excel(temp_output))

  expected_data <- data.frame(
    B = c(6, 7, 8, 9, 10)
  )

  class(cleaned_data) <- class(expected_data)

  expect_equal(cleaned_data, expected_data)
})

test_that("clean_and_write_excel fills columns with more than 20% missing values with mode", {
  temp_input <- tempfile(fileext = ".xlsx")
  temp_output <- tempfile(fileext = ".xlsx")

  data <- data.frame(
    A = c(1, 2, 3, 4, 5),
    B = c(6, NA, 6, 9, NA),
    C = c(11, 12, 13, 14, 15)
  )

  write_xlsx(data, temp_input)
  clean_and_write_excel(temp_input, temp_output)
  cleaned_data <- as.data.frame(read_excel(temp_output))

  expected_data <- data.frame(
    A = c(1, 2, 3, 4, 5),
    B = c(6, 6, 6, 9, 6),
    C = c(11, 12, 13, 14, 15)
  )

  class(cleaned_data) <- class(expected_data)

  expect_equal(cleaned_data, expected_data)
})

test_that("clean_and_write_excel handles case with no missing values correctly", {
  temp_input <- tempfile(fileext = ".xlsx")
  temp_output <- tempfile(fileext = ".xlsx")

  data <- data.frame(
    A = c(1, 2, 3, 4, 5),
    B = c(6, 7, 8, 9, 10),
    C = c(11, 12, 13, 14, 15)
  )

  write_xlsx(data, temp_input)
  clean_and_write_excel(temp_input, temp_output)
  cleaned_data <- as.data.frame(read_excel(temp_output))

  expected_data <- data

  class(cleaned_data) <- class(expected_data)

  expect_equal(cleaned_data, expected_data)
})

test_that("clean_and_write_excel handles case with all columns having less than 20% missing values correctly", {
  temp_input <- tempfile(fileext = ".xlsx")
  temp_output <- tempfile(fileext = ".xlsx")

  data <- data.frame(
    A = c(1, 2, 3, 4, 5),
    B = c(6, 7, NA, 9, 10),
    C = c(11, 12, 13, 14, NA)
  )

  write_xlsx(data, temp_input)
  clean_and_write_excel(temp_input, temp_output)
  cleaned_data <- as.data.frame(read_excel(temp_output))

  expected_data <- data.frame(
    A = c(1, 2, 3, 4, 5),
    B = c(6, 7, 6, 9, 10),
    C = c(11, 12, 13, 14, 11)
  )

  class(cleaned_data) <- class(expected_data)

  expect_equal(cleaned_data, expected_data)
})
