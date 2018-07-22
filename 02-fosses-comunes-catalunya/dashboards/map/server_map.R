##############################
### Map Server
##############################

server_map <- function(input, output, session) {
  
  # Reset all filters
  observeEvent(input$resetFilters, {
    reset("filters")
  })
  
  # Filter the data
  data_fosses_filt <- reactive({
    
    data_fos <- data_fosses
    
    #  Filter by municipi
    if (!is.null(input$municipi_filter)) {
      municipi_selected <- format_selectize_input_values(input$municipi_filter)
      data_fos <- data_fos %>% filter(Municipi %in% municipi_selected)
    }
    
    #  Filter by confirmada
    if (input$confirmada_filter != "Mostra tot") {
      data_fos <- data_fos %>% filter(IdCategoria == input$confirmada_filter)
    }
    
    #  Filter by bandol
    if (input$bandol_filter != "Mostra tot") {
      data_fos <- data_fos %>% filter(Bandol == input$bandol_filter)
    }
    
    #  Filter by tipus fossa
    if (input$tipus_fossa_filter != "Mostra tot") {
      data_fos <- data_fos %>% filter(TipusFossa == input$tipus_fossa_filter)
    }
    
    #  Filter by excavades
    if (input$excavades_filter != "Mostra tot") {
      data_fos <- data_fos %>% filter(Excavades == input$excavades_filter)
    }
    
    #  Filter by NumRestes
    if (input$num_restes_filter[1] > 0 || input$num_restes_filter[2] < max(na.omit(data_fos$max_restes))) {
      data_fos <- data_fos %>%
        filter(min_restes >= input$num_restes_filter[1]) %>%
        filter(max_restes <= input$num_restes_filter[2])
    }
    
    # Return results
    data_fos
    
  })
  
  ### Map output
  output$fosses_map <- renderLeaflet({
    
    # Get data and add markers
    data_map <- data_fosses_filt()
    
    # Format labels
    map_labels <- lapply(seq(nrow(data_map)), function(i) {
      paste0( '<p>', data_map[i, "Titol"], '<p></p>Bàndol: ', 
              data_map[i, "Bandol"],'</p><p>Tipus de fossa: ', 
              data_map[i, "TipusFossa"],'</p><p>Nº de restes: ', 
              data_map[i, "NumRestes"],'</p><p>Excavades: ', 
              data_map[i, "Excavades"], '</p>' ) 
    })
    
    # Init leaflet object and and markers with labels
    m <- leaflet() %>%
      addProviderTiles(providers$OpenStreetMap) %>%
      addMarkers(data = data_map, lng = ~X, lat = ~Y,
                 clusterOptions = markerClusterOptions(),
                 label = lapply(map_labels, HTML),
                 popup = ~paste0(
                   as.character(Notes), " ",
                   "<a href =", as.character(Fitxa), "> Més informació. </a>"
                 )
      )
    
    # Zoom if plot a single point
    if (nrow(data_map) == 1) {
      m <- m %>%
        setView(max(data_map$X), max(data_map$Y), zoom = 18)
    }
    
    # Zoom if no points to plot
    if (nrow(data_map) == 0) {
      m <- m %>%
        setView(1, 41, zoom = 8)
    }
    
    # Return leaflet object
    m
    
  })
  
}
