##############################
### EDA Server
##############################

server_eda <- function(input, output, session) {
  
  ### Box output
  output$box_n_rows <- renderValueBox({
    valueBox(prettyNum(nrow(data_barcelona), big.mark = ".", decimal.mark = ","), "Registres totals", icon = icon("bar-chart-o"))
  })
  
  output$box_n_years <- renderValueBox({
    valueBox(length(unique(data_barcelona$ANY_DATA_ALTA)), "Quantitat d'anys de la mostra", icon = icon("calendar"))
  })
  
  # Events per year
  output$events_per_year <- renderHighchart({
    # Data
    data <- data_barcelona %>%
      group_by(TIPUS, ANY_DATA_ALTA) %>%
      summarize(n_contactes = n())
    # Plot output
    hchart(data, "column", hcaes(x = TIPUS, y = n_contactes, group = ANY_DATA_ALTA)) %>%
      hc_title(text = "Evolució temporal dels contactes fets a l'Ajuntament segons el tipus") %>%
      hc_yAxis(title = list(text = "Nombre de contactes"))
  })
  
  # Events per month
  output$events_per_month <- renderHighchart({
    # Data
    data <- data_barcelona %>%
      filter(ANY_DATA_ALTA == 2017) %>%
      group_by(TIPUS, MES_DATA_ALTA) %>%
      summarize(n_contactes = n())
    # Plot output
    hchart(data, "column", hcaes(x = MES_DATA_ALTA, y = n_contactes, group = TIPUS)) %>%
      hc_title(text = "Contactes fets a l'Ajuntament per mes durant l'any 2017") %>%
      hc_yAxis(title = list(text = "Nombre de contactes")) %>% 
      hc_xAxis(title = list(text = NULL), categories=c("", catalan_months)) %>% 
      hc_plotOptions(column = list(stacking = "normal"))
  })
  
  # Events per day of week
  output$events_per_day_of_week <- renderHighchart({
    # Add day of week
    data <- data_barcelona
    data$DAY_OF_WEEK_ALTA <- day_of_week(data$DATA_ALTA)
    # Data
    data <- data %>%
      filter(ANY_DATA_ALTA == 2017) %>%
      group_by(TIPUS, DAY_OF_WEEK_ALTA) %>%
      summarize(n_contactes = n())
    # Plot output
    hchart(data, "column", hcaes(x = DAY_OF_WEEK_ALTA, y = n_contactes, group = TIPUS)) %>%
      hc_title(text = "Contactes fets a l'Ajuntament per dia de la setmana durant l'any 2017") %>%
      hc_yAxis(title = list(text = "Nombre de contactes")) %>% 
      hc_xAxis(title = list(text = NULL), categories=catalan_days_of_week) %>% 
      hc_plotOptions(column = list(stacking = "normal")) %>%
      hc_tooltip(sort=FALSE)
  })
  
}
