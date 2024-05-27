#' Excel dosyasındaki belirtilen sütundaki eksik değerleri mod ile doldurarak yeni bir Excel dosyasına yazma
#'
#' @param input_file Giriş Excel dosyasının yolu ve adı.
#' @param column_name Doldurulacak sütunun adı.
#' @param output_file Çıktı olarak yazılacak Excel dosyasının yolu ve adı.
#'
#' @return None
#'
#' @examples
#' fill_na_with_mode("dosya_adi.xlsx", "sütun_adı", "temizlenmis_veri.xlsx")
#'
#' @import readxl
#' @import dplyr
#' @import writexl
#'
#' @export
fill_na_with_mode <- function(input_file, column_name, output_file) {
  library(readxl)
  library(dplyr)

  # Excel dosyasını okuma
  data <- read_excel(input_file)

  # Belirtilen sütundaki eksik değerleri mod ile doldurma
  mode_value <- data %>%
    filter(!is.na(.data[[column_name]])) %>%
    count(.data[[column_name]]) %>%
    arrange(desc(n)) %>%
    slice(1) %>%
    pull(.data[[column_name]])

  # Mod değerini karaktere dönüştürme
  mode_value <- as.character(mode_value)

  # Eksik değerleri mod ile doldurma
  data[[column_name]][is.na(data[[column_name]])] <- mode_value

  # Temizlenmiş veriyi yeni bir Excel dosyasına yazma
  write_xlsx(data, output_file)
}
