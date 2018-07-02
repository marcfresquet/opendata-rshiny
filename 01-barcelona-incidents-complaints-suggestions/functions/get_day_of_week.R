day_of_week <- function(date) {
  output_day_of_week <- as.character(factor(
    weekdays(date, TRUE),
    levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"),
    labels = c(1, 2, 3, 4, 5, 6, 7)
  ))
  return(output_day_of_week)
}
