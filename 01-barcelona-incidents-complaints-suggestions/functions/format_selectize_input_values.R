format_selectize_input_values <- function(input_values) {
  # Remove blank spaces
  input_values <- gsub(" ", "_", input_values)
  # Remove comma
  input_values <- gsub(",", "COMMA", input_values)
  # Remove slash
  input_values <- gsub("/", "SLASH", input_values)
  # Remove apostrophe
  input_values <- gsub("'", "APOSTROPHE", input_values)
  # Parse values
  input_values <- all.vars(parse(text = input_values))
  # Return to original data
  input_values <- gsub("APOSTROPHE", "'", input_values)
  input_values <- gsub("SLASH", "/", input_values)
  input_values <- gsub("COMMA", ",", input_values)
  input_values <- gsub("_", " ", input_values)
  input_values
}
