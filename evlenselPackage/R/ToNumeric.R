#' Belirli bir Excel dosyasındaki sütunu sayısal veri tipine dönüştürür ve Excel dosyasına geri yazar.
#'
#' @param excel_file Excel dosyasının yolu ve adı
#' @param column_name Dönüştürülecek sütunun adı
#'
#' @return NULL
#'
#' @import readxl
#' @import dplyr
#' @import openxlsx
#'
#' @examples
#' # Örnek kullanım:
#' # convert_and_write_excel("veri.xlsx", "Distance")
#'
#' @export
convert_and_write_excel <- function(excel_file, column_name) {
  library(readxl)
  library(dplyr)
  library(openxlsx)

  # Excel dosyasını oku
  veri <- read_excel(excel_file)

  # Sütunu sayısal veri tipine dönüştür
  veri <- veri %>%
    mutate(!!sym(column_name) := as.numeric(gsub(",", ".", .data[[column_name]])))

  # Veriyi Excel dosyasına geri yaz
  write.xlsx(veri, excel_file, sheetName = "Sheet1", rowNames = FALSE)
}
