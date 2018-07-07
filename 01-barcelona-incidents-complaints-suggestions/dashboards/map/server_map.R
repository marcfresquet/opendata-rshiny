##############################
### Map Server
##############################

server_map <- function(input, output, session) {
  
  # Filter the data
  data_barcelona_filt <- reactive({
    
    data_bcn <- data_barcelona
    
    #  Filter by tipus (optional filter)
    if (!is.null(input$tipus_filter)) {
      tipus_selected <- format_selectize_input_values(input$tipus_filter)
      data_bcn <- data_bcn %>% filter(TIPUS %in% tipus_selected)
    }
    
    #  Filter by area (optional filter)
    if (!is.null(input$area_filter)) {
      area_selected <- format_selectize_input_values(input$area_filter)
      data_bcn <- data_bcn %>% filter(AREA %in% area_selected)
    }
    
    # Filter by day
    data_bcn <- data_bcn %>%
      filter(DATA_ALTA >= input$day_filter[1]) %>%
      filter(DATA_ALTA <= input$day_filter[2])
    
    # Filter rows with missing loc values
    data_bcn <- data_bcn[!is.na(data_bcn$LATITUD),]
    
    # Check nrow
    if (nrow(data_bcn) >= max_points_in_map) {
      data_bcn <- data_bcn[1:max_points_in_map,]
      showNotification(paste0("S'han limitat els punts a ", max_points_in_map,
                              ". Pots escollir una diferència temporal més reduïda."),
                       duration = 10)
    }
    
    # Return results
    data_bcn
    
  })
  
  ### Map output
  output$events_map <- renderLeaflet({
    
    # Get data and add markers
    data_map <- data_barcelona_filt()
    
    # Format labels
    map_labels <- lapply(seq(nrow(data_map)), function(i) {
      paste0( '<p>', data_map[i, "TIPUS"], '<p></p>Àrea: ', 
              data_map[i, "AREA"],'</p><p>Element: ', 
              data_map[i, "ELEMENT"],'</p><p>Detall: ', 
              data_map[i, "DETALL"], '</p>' ) 
    })
    
    # Init leaflet object and and markers with labels
    m <- leaflet() %>%
      addProviderTiles(providers$OpenStreetMap) %>%
      addMarkers(data = data_map, lng = ~LONGITUD, lat = ~LATITUD,
                 clusterOptions = markerClusterOptions(),
                 label = lapply(map_labels, HTML),
                 popup = ~paste0(
                   as.character(TIPUS_VIA), " ",
                   as.character(CARRER), ", ",
                   as.character(NUMERO)
                 )
      )
    
    # Zoom if plot a single point
    if (nrow(data_map) == 1) {
      m <- m %>%
        setView(max(data_map$LONGITUD), max(data_map$LATITUD), zoom = 18)
    }
    
    # Return leaflet object
    m
    
  })
  
}
