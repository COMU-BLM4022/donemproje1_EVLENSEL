#' Predict Price using a trained decision tree model
#'
#' @param model The trained decision tree model.
#' @param new_data A dataframe containing new data for prediction.
#' @return A vector of predicted prices.
#' @export
#' @examples
#' predictions <- predict(model, new_data)

karar_agaci_predict <- function(model, new_data) {
  # Check and install required packages
  required_packages <- c("readxl", "rpart", "here")
  new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
  if(length(new_packages)) install.packages(new_packages)

  # Load the required libraries
  lapply(required_packages, library, character.only = TRUE)

  # Ensure the new_data contains the same columns used for training
  required_columns <- c("CouncilArea", "YearBuilt", "BuildingArea", "Landsize", "Car", "Bathroom", "Bedroom2", "Distance")

  if(!all(required_columns %in% colnames(new_data))) {
    stop("new_data must contain the following columns: ", paste(required_columns, collapse = ", "))
  }

  # Make predictions
  predictions <- predict(model, new_data)

  return(predictions)
}
