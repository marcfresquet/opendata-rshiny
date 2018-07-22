data_reader <- function(csv_path) {
  # Read data from a csv file
  df <- read_csv(csv_path)
  # Filter by target columns
  df <- df %>%
    select(target_columns)
  # Return DataFrame
  return(df)
}
