#' Belirtilen Excel dosyasındaki bir sütundaki eksik değerleri sütun ortalaması ile doldurarak yeni bir Excel dosyasına yazma
#'
#' @param input_file Giriş Excel dosyasının yolu ve adı.
#' @param column_name Doldurulacak sütunun adı.
#' @param output_file Çıktı olarak yazılacak Excel dosyasının yolu ve adı.
#'
#' @return None
#'
#' @examples
#' fill_na_with_mean("dosya_adi.xlsx", "sütun_adı", "temizlenmis_veri.xlsx")
#'
#' @import readxl
#' @import dplyr
#' @import writexl
#'
#' @export
fill_na_with_mean <- function(input_file, column_name, output_file) {
  library(readxl)
  library(dplyr)
  library(writexl)

  data <- read_excel(input_file)

  mean_value <- mean(data[[column_name]], na.rm = TRUE)
  data[[column_name]][is.na(data[[column_name]])] <- round(mean_value)

  write_xlsx(data, output_file)
}
