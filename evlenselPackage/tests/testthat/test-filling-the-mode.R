library(testthat)
library(readxl)
library(dplyr)
library(openxlsx)  # openxlsx paketini yükleyin

# Test için geçici dosya adları
input_file <- tempfile(fileext = ".xlsx")
output_file <- tempfile(fileext = ".xlsx")

# Test verisi oluşturma
data <- data.frame(
  A = c(1, 2, NA, 4, NA),
  B = c("a", NA, "c", "d", "e")
)
openxlsx::write.xlsx(data, input_file, rowNames = FALSE)

# Test
test_that("fill_na_with_mode correctly fills missing values with mode", {
  fill_na_with_mode(input_file, "A", output_file)

  # Output dosyasını okuma
  cleaned_data <- read_excel(output_file)

  # Beklenen sonuçlar
  expect_equal(sum(is.na(cleaned_data$A)), 0)  # A sütununda eksik değer olmamalı
  expect_equal(table(cleaned_data$A)[which.max(table(cleaned_data$A))], 2)  # A sütununun modu 2 olmalı ve 2 değerinde 2 eksik değer doldurulmuş olmalı
  expect_equal(cleaned_data$B, c("a", NA, "c", "d", "e"))  # B sütunu değişmemiş olmalı
})

# Geçici dosyaları temizleme
unlink(input_file)
unlink(output_file)
