#' Gerekli paketleri yükleme (eğer yüklü değilse) ve kütüphaneleri çağırma
#'
#' Bu fonksiyon, belirtilen paketleri yükler (eğer yüklü değillerse) ve
#' kütüphaneleri çağırır.
#'
#' @export
#' @import readxl dplyr tidyr
load_libraries <- function() {
  required_packages <- c("readxl", "dplyr", "tidyr")

  for (pkg in required_packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      install.packages(pkg, dependencies = TRUE)
    }
  }

  library(readxl)
  library(dplyr)
  library(tidyr)
}

#' Excel dosyasını okuma ve eksik veri analizini yapma
#'
#' Bu fonksiyon, belirtilen Excel dosyasını okur, her bir kolon için eksik
#' veri sayısını ve yüzdesini hesaplar, sonucu daha anlaşılır bir formatta
#' gösterir.
#'
#' @param file_path Excel dosyasının yolunu içeren bir karakter dizisi.
#' @return Eksik veri analizini içeren bir veri çerçevesi.
#' @export
#' @importFrom readxl read_excel
#' @importFrom dplyr summarise across everything
#' @importFrom tidyr pivot_longer
analyze_missing_data <- function(file_path) {
  load_libraries()

  data <- read_excel(file_path)

  missing_data_summary <- data %>%
    summarise(across(everything(),
                     list(
                       Missing_Count = ~ sum(is.na(.)),
                       Missing_Percentage = ~ mean(is.na(.)) * 100
                     ),
                     .names = "{col}_{fn}"))

  missing_data_summary_long <- missing_data_summary %>%
    pivot_longer(cols = contains("_"),
                 names_to = c("Column", ".value"),
                 names_sep = "_")

  return(missing_data_summary_long)
}

