#' Calculate correlations between Price column and all other columns in a dataset from an Excel file.
#'
#' This function reads an Excel file, calculates the correlation coefficient between
#' the Price column and all other numeric columns in the dataset, and prints the results.
#'
#' @param excel_file Path to the Excel file.
#' @param price_column The name of the Price column in the Excel file.
#' @return A data frame showing correlations between Price column and other numeric columns.
#' @export
#' @import readxl
#' @examples
#' excel_file <- "path/to/your/excel/file.xlsx"
#' price_column <- "Price"
#' calculate_correlations_with_price_excel(excel_file, price_column)
calculate_correlations_with_price_excel <- function(excel_file, price_column) {
  library(readxl)

  # Read Excel file
  data <- read_excel(excel_file)


  numeric_columns <- sapply(data, is.numeric)


  correlations <- sapply(data[, numeric_columns], function(x) cor(x, data[[price_column]], use = "complete.obs"))
  correlations_df <- data.frame(Column = names(correlations), Correlation = correlations)
  correlations_df <- correlations_df[order(abs(correlations_df$Correlation), decreasing = TRUE), ]


  cat("Correlations with", price_column, ":\n")
  print(correlations_df)


  return(correlations_df)
}
