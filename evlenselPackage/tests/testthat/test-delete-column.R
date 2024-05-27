# tests/testthat/test_delete_column.R
library(testthat)
library(readxl)
library(writexl)


test_that("delete_column_from_excel works correctly", {
  # Geçici dosya yollarını oluşturma
  temp_input <- tempfile(fileext = ".xlsx")
  temp_output <- tempfile(fileext = ".xlsx")

  # Sahte veri seti oluşturma
  data <- data.frame(
    A = c(1, 2, 3, 4, 5),
    B = c(6, 7, 8, 9, 10),
    C = c(11, 12, 13, 14, 15)
  )

  # Sahte veri setini geçici dosyaya yazma
  write_xlsx(data, temp_input)

  # Fonksiyonu çağırma
  delete_column_from_excel(temp_input, "B", temp_output)

  # Güncellenmiş veri setini okuma ve data.frame'e dönüştürme
  cleaned_data <- as.data.frame(read_excel(temp_output))

  # Beklenen sonucun oluşturulması
  expected_data <- data.frame(
    A = c(1, 2, 3, 4, 5),
    C = c(11, 12, 13, 14, 15)
  )

  # Testler
  expect_equal(cleaned_data, expected_data)
})

test_that("delete_column_from_excel does not affect other columns", {
  # Geçici dosya yollarını oluşturma
  temp_input <- tempfile(fileext = ".xlsx")
  temp_output <- tempfile(fileext = ".xlsx")

  # Sahte veri seti oluşturma
  data <- data.frame(
    X = c("a", "b", "c", "d", "e"),
    Y = c("f", "g", "h", "i", "j"),
    Z = c("k", "l", "m", "n", "o")
  )

  # Sahte veri setini geçici dosyaya yazma
  write_xlsx(data, temp_input)

  # Fonksiyonu çağırma
  delete_column_from_excel(temp_input, "Y", temp_output)

  # Güncellenmiş veri setini okuma ve data.frame'e dönüştürme
  cleaned_data <- as.data.frame(read_excel(temp_output))

  # Beklenen sonucun oluşturulması
  expected_data <- data.frame(
    X = c("a", "b", "c", "d", "e"),
    Z = c("k", "l", "m", "n", "o")
  )

  # Testler
  expect_equal(cleaned_data, expected_data)
})

test_that("delete_column_from_excel handles non-existent columns gracefully", {
  # Geçici dosya yollarını oluşturma
  temp_input <- tempfile(fileext = ".xlsx")
  temp_output <- tempfile(fileext = ".xlsx")

  # Sahte veri seti oluşturma
  data <- data.frame(
    A = c(1, 2, 3, 4, 5),
    B = c(6, 7, 8, 9, 10),
    C = c(11, 12, 13, 14, 15)
  )

  # Sahte veri setini geçici dosyaya yazma
  write_xlsx(data, temp_input)

  # Fonksiyonu çağırma - var olmayan bir sütunu silmeye çalışıyoruz
  delete_column_from_excel(temp_input, "D", temp_output)

  # Güncellenmiş veri setini okuma ve data.frame'e dönüştürme
  cleaned_data <- as.data.frame(read_excel(temp_output))

  # Beklenen sonucun oluşturulması - veri seti orijinaliyle aynı kalmalı
  expected_data <- data

  # Testler
  expect_equal(cleaned_data, expected_data)
})
