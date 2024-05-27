#' Excel dosyasını ve iki sütun ismini parametre olarak alan ve bu iki sütuna göre görselleştirme yapan fonksiyon
#'
#' @param input_file Giriş Excel dosyasının yolu ve adı.
#' @param column_x X ekseni için kullanılacak sütunun adı.
#' @param column_y Y ekseni için kullanılacak sütunun adı.
#'
#' @return None
#'
#' @examples
#' visualize_columns("veri.xlsx", "sütun1", "sütun2")
#'
#' @import readxl
#' @import ggplot2
#'
#' @export
visualize_columns <- function(input_file, column_x, column_y) {
  library(readxl)
  library(ggplot2)

  # Excel dosyasını okuma
  data <- read_excel(input_file)

  # Veriyi görselleştirme
  p <- ggplot(data, aes_string(x = column_x, y = column_y)) +
    geom_point() +
    labs(x = column_x, y = column_y, title = paste("Scatter plot of", column_x, "vs", column_y)) +
    theme_minimal()

  print(p)
}

# Kullanım örneği:
# visualize_columns("veri.xlsx", "sütun1", "sütun2")
