library(terra)

locations = data.frame(
    name = c("snezka", "palava", "komorni_hurka"), latitude = c(50.74, 48.84, 50.10), longitude = c(15.74, 16.64, 12.34))
variables = c("sd", "t2m")

for (loc in 1:nrow(locations)) {
    location_data = NULL
    for (variable in variables) {
        raster_data = rast("data/era5.nc", subds = variable)
        location_coordinates = matrix(c(locations[loc, ]$longitude, locations[loc, ]$latitude), ncol = 2)
        variable_data = extract(raster_data, location_coordinates, method = "simple")
        variable_data = unlist(variable_data)
        if (variable == "t2m") {
            variable_data = variable_data - 273.15
        } else if (variable == "sd") {
            variable_data = variable_data * 1e3
        }

        if (is.null(location_data)) {
            location_data = data.frame(
                time = seq(from = as.Date("1950-01-01"), by = "month", length.out = length(variable_data)))
        }
        location_data[[variable]] = variable_data
    }
    write.csv(location_data, paste0("data/", locations[loc, ]$name, ".csv"), row.names = FALSE)
}
