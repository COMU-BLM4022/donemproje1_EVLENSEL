#' Eğitilen modeli kullanarak tahmin yapar.
#'
#' @param model Eğitilmiş model nesnesi.
#' @param test_data Test veri seti.
#' @return Tahminler.
#' @export
predict_from_model <- function(model, test_data) {
  # Modelin değerlendirilmesi
  predictions <- predict(model, newdata = test_data)
  rmse <- sqrt(mean((predictions - test_data$Price)^2))
  cat("RMSE: ", rmse, "\n")

  return(predictions)
}
