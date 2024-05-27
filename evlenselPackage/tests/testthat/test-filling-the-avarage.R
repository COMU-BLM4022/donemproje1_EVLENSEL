library(testthat)
library(readxl)
library(dplyr)
library(writexl)

# Test için geçici dosya adları
input_file <- tempfile(fileext = ".xlsx")
output_file <- tempfile(fileext = ".xlsx")

# Test verisi oluşturma
data <- data.frame(
  A = c(1, 2, NA, 4, NA),
  B = c("a", NA, "c", "d", "e")
)
writexl::write_xlsx(data, input_file)

# Test
test_that("fill_na_with_mean correctly fills missing values with mean", {
  fill_na_with_mean(input_file, "A", output_file)

  # Output dosyasını okuma
  cleaned_data <- read_excel(output_file)

  # Beklenen sonuçlar
  expect_equal(sum(is.na(cleaned_data$A)), 0)  # A sütununda eksik değer olmamalı
  expect_equal(round(mean(data$A, na.rm = TRUE)), round(mean(cleaned_data$A, na.rm = TRUE)))  # A sütununun ortalaması değişmemeli
  expect_equal(cleaned_data$B, c("a", NA, "c", "d", "e"))  # B sütunu değişmemiş olmalı
})

# Geçici dosyaları temizleme
unlink(input_file)
unlink(output_file)
