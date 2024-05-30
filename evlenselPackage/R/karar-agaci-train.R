#' Train a decision tree model to predict Price
#'
#' @param file_path The path to the Excel file containing the dataset.
#' @return A trained decision tree model.
#' @export
#' @examples
#' model <- train("path_to_excel_file.xlsx")

karar_agaci_train <- function(file_path) {
  # Check and install required packages
  required_packages <- c("readxl", "rpart", "here")
  new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
  if(length(new_packages)) install.packages(new_packages)

  # Load the required libraries
  lapply(required_packages, library, character.only = TRUE)

  # Read the Excel file
  data <- read_excel(file_path)

  # Select relevant columns
  data <- data[, c("CouncilArea", "YearBuilt", "BuildingArea", "Landsize", "Car", "Bathroom", "Bedroom2", "Distance", "Price")]

  # Train the decision tree model
  model <- rpart(Price ~ ., data = data, method = "anova")

  return(model)
}
