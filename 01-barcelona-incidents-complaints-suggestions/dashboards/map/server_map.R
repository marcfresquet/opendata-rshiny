##############################
### Map Server
##############################

server_map <- function(input, output, session) {
  
  # Filter the data
  data_barcelona_filt <- reactive({
    
    # Filter by TIPUS incident and day
    data <- data_bcn_with_coords %>%
      filter(DATA_ALTA == input$day_filter) %>%
      filter(TIPUS == "INCIDENCIA")
    
    shiny::validate(need(nrow(data) >= 1, "No hi ha incidències per aquest dia."))
    data
    
  })
  
  # Update selectizeInput for area
  observeEvent(input$day_filter, {
    data <- data_barcelona_filt()
    updateSelectizeInput(session, "area_filter", choices=unique(data$AREA))
  })
  
  ### Incidents per area output
  output$incidents_per_area <- renderHighchart({
    
    data <- data_barcelona_filt() %>%
      group_by(AREA) %>% 
      summarise(n = n()) %>% 
      arrange(desc(n))
    
    hchart(data, "bar", hcaes(x = AREA, y = n)) %>%
      hc_yAxis(title = list(text = "Nº d'incidències"), allowDecimals = FALSE) %>%
      hc_xAxis(title = list(text = "Àrea"))
    
  })
  
  ### Map output
  output$events_map <- renderLeaflet({
    
    # Get data and add markers
    data_map <- data_barcelona_filt()  
    
    #  Filter by area (optional filter)
    if (!is.null(input$area_filter)) {
      area_selected <- format_selectize_input_values(input$area_filter)
      data_map <- data_map %>% filter(AREA %in% area_selected)
    }
    
    shiny::validate(need(nrow(data_map) >= 1, "No hi ha incidències amb aquests filtres"))
    
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
