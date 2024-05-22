library(testthat)
library(evlenselPackage)  # Paketinizin adını buraya ekleyin

# openxlsx paketini yüklüyoruz
if (!requireNamespace("openxlsx", quietly = TRUE)) {
  install.packages("openxlsx")
}

# Test için bir geçici Excel dosyası oluşturalım
temp_excel <- tempfile(fileext = ".xlsx")
data <- data.frame(
  A = c(1, 2, NA, 4),
  B = c("a", NA, "c", "d")
)
openxlsx::write.xlsx(data, temp_excel, rowNames = FALSE)

# Test
test_that("analyze_missing_data correctly analyzes missing data", {
  result <- mydatautils::analyze_missing_data(temp_excel)  # Paketinizin fonksiyonunu çağırın
  expect_equal(nrow(result), 2)  # İki sütun olmalı: Column ve bir değer (Missing_Count veya Missing_Percentage)
  expect_equal(sum(!is.na(result$Column)), 2)  # Column sütunu boş olmamalı
  expect_equal(sum(!is.na(result$Missing_Count)), 2)  # Missing_Count sütunu boş olmamalı
  expect_equal(sum(!is.na(result$Missing_Percentage)), 2)  # Missing_Percentage sütunu boş olmamalı
})

# Geçici dosyayı temizleyelim
unlink(temp_excel)
