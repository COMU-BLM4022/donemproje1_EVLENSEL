library(testthat)
library(readxl)
library(ggplot2)
library(writexl)  # writexl paketini yükleyin

# Test için geçici dosya adı
input_file <- tempfile(fileext = ".xlsx")

# Test verisi oluşturma
data <- data.frame(
  sütun1 = c(1, 2, 3, 4, 5),
  sütun2 = c(10, 20, 30, 40, 50)
)
write_xlsx(data, input_file, col_names = TRUE)  # writexl paketindeki write_xlsx fonksiyonunu kullanın

# Test
test_that("visualize_columns correctly visualizes specified columns", {
  visualize_columns(input_file, "sütun1", "sütun2")
  # Bu satırın otomatik olarak kontrol edilmesi mümkün olmasa da, grafik görüntülenir.
})

# Geçici dosyayı temizleme
unlink(input_file)
