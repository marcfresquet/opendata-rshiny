##############################
### District Server
##############################

server_district <- function(input, output, session) {
  
  ### Incidents per district
  output$incidents_per_district <- renderHighchart({
    # Data
    data <- data_barcelona %>%
      group_by(ANY_DATA_ALTA, DISTRICTE) %>% 
      summarise(n = n()) %>% 
      arrange(desc(n)) %>% 
      filter(!is.na(DISTRICTE))
    # Plot output
    hchart(data, "column", hcaes(x = DISTRICTE, y = n, group = ANY_DATA_ALTA)) %>%
      hc_title(text = "Evolució temporal de les incidències per districte") %>%
      hc_yAxis(title = list(text = "Nombre d'incidències"))
  })
  
  ### Incidents per district and area
  output$incidents_per_district_and_area <- renderHighchart({
    # Data
    data <- data_barcelona
    # Get TOP5 Area
    top5_area <- data %>%
      filter(!is.na(DISTRICTE)) %>%
      group_by(AREA) %>% 
      summarise(n = n()) %>% 
      arrange(desc(n)) %>% 
      top_n(5)
    top5_area <- top5_area$AREA
    data[!data$AREA %in% top5_area,]$AREA <- "Altres"
    # Group data
    data <- data %>%
      group_by(AREA, DISTRICTE) %>% 
      summarise(n = n()) %>% 
      arrange(desc(n)) %>% 
      filter(!is.na(DISTRICTE))
    # Plot output
    hchart(data, "column", hcaes(x = DISTRICTE, y = n, group = AREA)) %>%
      hc_title(text = "Distribució de les incidències per districte") %>%
      hc_yAxis(labels = list(format = "{value}%"), title = list(text = "Percentatge d'incidències per districte (%)")) %>%
      hc_plotOptions(series=list(stacking="percent")) %>%
      hc_tooltip(shared = TRUE, pointFormat = '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>')
  })
  
}
