locations = data.frame(
    name = c("snezka", "palava", "komorni_hurka"), latitude = c(50.74, 48.84, 50.10), longitude = c(15.74, 16.64, 12.34))

data = NULL
for (loc in 1:nrow(locations)) {
    location_data = read.csv(paste0("data/", locations[loc, ]$name, ".csv"))
    location_data$time = as.Date(location_data$time)
    location_data$location = as.factor(locations[loc, ]$name)

    if (is.null(data)) {
        data = location_data
    } else {
        data = rbind(data, location_data)
    }
}

library(data.table)
data = as.data.table(data)
melted_data = melt(data, id.vars = c("time", "location"))

library(ggplot2)
variable_labels = c(t2m = "temperature [°C]", sd = "snow water equivalent [mm]")

current_variable = "t2m"

plot = ggplot(melted_data[variable == current_variable, ], aes(x = time, y = value, colour = location))
plot = plot + scale_y_continuous(name = variable_labels[current_variable])
plot = plot + geom_line()
print(plot)

