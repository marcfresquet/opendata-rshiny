format_num_restes <- function(col) {
  extract_num_values <- lapply(col, function(x) {unlist(str_extract_all(x, "\\d+"))})
  min_restes <- as.numeric(unlist(lapply(extract_num_values, function(x) {min(unlist(x))})))
  max_restes <- as.numeric(unlist(lapply(extract_num_values, function(x) {max(unlist(x))})))
  return(list(
    min_restes = min_restes,
    max_restes = max_restes
  ))
}

data_reader <- function(csv_path) {
  # Read data from a csv file
  df <- read_csv(csv_path)
  # Filter by target columns
  df <- df %>%
    select(target_columns)
  # Format NumRestes column
  num_restes <- format_num_restes(df$NumRestes)
  df$min_restes <- num_restes$min_restes
  df$max_restes <- num_restes$max_restes
  # Return DataFrame
  return(df)
}
