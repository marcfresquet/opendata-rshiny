##############################
### Map Server
##############################

server_map <- function(input, output, session) {
  
  # Filter the data
  data_barcelona_filt <- reactive({
    
    data_bcn <- data_barcelona
    
    #  Filter by area (optional filter)
    if (!is.null(input$area_filter)) {
      area_selected <- format_selectize_input_values(input$area_filter)
      data_bcn <- data_bcn %>% filter(AREA %in% area_selected)
    }
    
    #  Filter by day
    data_bcn <- data_bcn %>% filter(DATA_ALTA==input$day_filter)
    
    #  Filter rows with missing loc values
    data_bcn <- data_bcn[!is.na(data_bcn$LATITUD),] 
    
    # Return results
    data_bcn
    
  })
  
  ### Map output
  output$events_map <- renderLeaflet({
    data_map <- data_barcelona_filt()
    m <- leaflet() %>%
      addProviderTiles(providers$OpenStreetMap) %>%
      addMarkers(data = data_map, lng = ~LONGITUD, lat = ~LATITUD,
                 clusterOptions = markerClusterOptions())
    m
  })
  
}
