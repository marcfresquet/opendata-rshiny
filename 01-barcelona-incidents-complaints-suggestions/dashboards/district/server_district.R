##############################
### District Server
##############################

server_district <- function(input, output, session) {
  
  ### Incidents per districte output
  output$incidents_per_districte <- renderHighchart({
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
  
}
