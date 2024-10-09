locations = data.frame(
    name = c("snezka", "palava", "komorni_hurka"), latitude = c(50.74, 48.84, 50.10), longitude = c(15.74, 16.64, 12.34))

data = read.csv(paste0("data/", locations[1, ]$name, ".csv"))
data$time = as.Date(data$time)
data$location = as.factor(locations[1, ]$name)
