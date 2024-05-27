#' Excel dosyasını temizleyip yeni bir dosyaya yazdırma
#'
#' Bu fonksiyon, belirtilen Excel dosyasını okuyarak eksik verileri yönetir,
#' %50'den fazla eksik veri içeren sütunları siler ve %20'den fazla eksik
#' veri içeren sütunları çoğunluk değeri ile doldurarak temizlenmiş veriyi
#' yeni bir Excel dosyasına yazdırır.
#'
#' @param input_file Giriş Excel dosyasının yolu ve adı.
#' @param output_file Çıktı olarak yazılacak temizlenmiş Excel dosyasının yolu ve adı.
#'
#' @return Temizlenmiş veri seti.
#'
#' @examples
#' clean_and_write_excel("dosya_adi.xlsx", "temizlenmis_veri.xlsx")
#'
#' @export
#'
#' @import readxl
#' @import dplyr
#' @import writexl
#'
#' @importFrom utils View
#'
#' @seealso \code{\link{read_excel}}, \code{\link{write_xlsx}}
#'
#' @keywords data manipulation file IO
clean_and_write_excel <- function(input_file, output_file) {

    library(readxl)
    library(dplyr)
    library(writexl)
    data <- read_excel(input_file)


    missing_percentages <- colMeans(is.na(data)) * 100


    cols_to_remove <- names(data)[missing_percentages > 60]


    data_cleaned <- data %>%
      select(-one_of(cols_to_remove))


    for (col in names(data_cleaned)) {
      if (mean(is.na(data_cleaned[[col]])) > 20) {
        data_cleaned[[col]][is.na(data_cleaned[[col]])] <- mode(data_cleaned[[col]], na.rm = TRUE)
      }
    }


    write_xlsx(data_cleaned, output_file)


    View(data_cleaned)



}
