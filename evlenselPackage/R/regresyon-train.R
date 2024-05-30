#' Veri setini okur, işler ve model eğitir.
#'
#' @param file_path Excel dosyasının yolu.
#' @return Liste içinde model ve test veri seti.
#' @export
train_model <- function(file_path) {

  data <- read_excel(file_path)

  data <- data %>%
    select(Rooms, Bedroom2, Bathroom, Car, Landsize, BuildingArea, YearBuilt, Price) %>%
    mutate_all(as.numeric) %>%
    na.omit()

  # Veri setini train ve test olarak bölmek için caTools paketinden sample.split kullanılıyor
  set.seed(123)
  split <- caTools::sample.split(data$Price, SplitRatio = 0.8)
  train_data <- subset(data, split == TRUE)
  test_data <- subset(data, split == FALSE)

  # Lineer regresyon modeli oluştur
  model <- lm(Price ~ ., data = train_data)

  return(list(model = model, test_data = test_data))
}
