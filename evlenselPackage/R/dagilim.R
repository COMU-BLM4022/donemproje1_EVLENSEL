#' Veri setinde belirli bir sütunun dağılım analizini yapar ve görselleştirir.
#'
#' @param file_path Excel dosyasının yolu
#' @param column_name Analiz yapılacak sütunun adı
#'
#' @return NULL
#'
#' @import ggplot2
#' @import readxl
#' @import cowplot
#'
#' @examples
#' # Örnek kullanım:
#' # analyze_distribution("veri.xlsx", "Price")
#'
#' @export
analyze_distribution <- function(file_path, column_name) {

  # Excel dosyasını oku
  data <- readxl::read_excel(file_path)

  # Belirtilen sütunu seç
  column <- data[[column_name]]

  # Histogram çizimi
  hist_plot <- ggplot(data, aes_string(x = column_name)) +
    geom_histogram(binwidth = 1000, fill = "skyblue", color = "black") +
    labs(title = paste("Histogram of", column_name),
         x = column_name, y = "Frequency")

  # Boxplot çizimi
  box_plot <- ggplot(data, aes_string(y = column_name)) +
    geom_boxplot(fill = "lightgreen", color = "black") +
    labs(title = paste("Boxplot of", column_name),
         x = "", y = column_name)

  # Çizimleri yan yana göster
  cowplot::plot_grid(hist_plot, box_plot, ncol = 2)

}
