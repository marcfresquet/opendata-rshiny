data_reader <- function(csv_path) {
  # Read data from a csv file
  df <- read_csv(csv_path)
  # Filter by target columns
  df <- df %>%
    select(target_columns)
  # Filter rows depending on year
  df <- df %>%
    filter(ANY_DATA_ALTA >= min_year)
  # Transform some columns to numeric values
  for (num_col in numeric_columns) {
    df[[num_col]] <- as.numeric(df[[num_col]])
  }
  # Format date
  df$DATA_ALTA <- ymd(paste(df$ANY_DATA_ALTA, df$MES_DATA_ALTA, df$DIA_DATA_ALTA, sep="-"))
  df$DATA_TANCAMENT <- ymd(paste(df$ANY_DATA_TANCAMENT, df$MES_DATA_TANCAMENT, df$DIA_DATA_TANCAMENT, sep="-"))
  # Return DataFrame
  return(df)
}
