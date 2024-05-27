#' Excel dosyasındaki belirtilen sütunu silen ve sonucu yeni bir Excel dosyasına yazan fonksiyon
#'
#' @param input_file Giriş Excel dosyasının yolu ve adı.
#' @param column_name Silinecek sütunun adı.
#' @param output_file Çıktı olarak yazılacak Excel dosyasının yolu ve adı.
#'
#' @return None
#'
#' @examples
#' delete_column_from_excel("dosya_adi.xlsx", "sütun_adı", "güncellenmiş_veri.xlsx")
#'
#' @import readxl
#' @import dplyr
#' @import writexl
#'
#' @export
delete_column_from_excel <- function(input_file, column_name, output_file) {
  library(readxl)
  library(dplyr)

  # Excel dosyasını okuma
  data <- read_excel(input_file)

  # Belirtilen sütunu veriden silme
  data <- data %>%
    select(-matches(column_name))

  # Güncellenmiş veriyi yeni bir Excel dosyasına yazma
  write_xlsx(data, output_file)
}
