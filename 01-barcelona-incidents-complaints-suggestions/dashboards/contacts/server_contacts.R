##############################
### Contacts Server
##############################

server_contacts <- function(input, output, session) {
  
  # Filter the data
  data_barcelona_tipus_filt <- reactive({
    data_barcelona %>% 
      filter(TIPUS == input$tipus_contact_filter) %>%  
      select(TIPUS, AREA, ELEMENT, DETALL, DATA_ALTA, DATA_TANCAMENT)
  })
  
  # Group data function
  group_data <- function(data_filt, gr) {
    # Group and arrange
    data_grouped <- data_filt %>%
      group_by(.dots = gr) %>%
      summarise(n = n()) %>%
      arrange(desc(n))
    n_groups <- nrow(data_grouped)
    # Get top n
    if (nrow(data_grouped) > max_top_n_in_charts) {
      data_grouped_top <- data_grouped[1:max_top_n_in_charts,]
      data_grouped_top <- rbind(data_grouped_top,
                                c("Altres", sum(data_grouped$n) - sum(data_grouped_top$n)))
      storage.mode(data_grouped_top$n) <- "numeric"
    } else {
      data_grouped_top <- data_grouped
    }
    # Prop and return data
    data_grouped_top$percentatge<- round(prop.table(data_grouped_top$n) * 100, 1)
    return(list(data_grouped_top, n_groups))
  }
  
  # Area grouped chart
  output$area_grouped <- renderHighchart({
    data_grouped <- group_data(data_barcelona_tipus_filt(), "AREA")
    hchart(data_grouped[[1]], "column", hcaes(x = AREA, y = percentatge)) %>%
      hc_xAxis(title = list(text = NULL)) %>%
      hc_yAxis(title = list(text = "%"), labels = list(format = "{value}%")) %>% 
      hc_tooltip(pointFormat=paste('<b>{point.y:.1f}%</b>')) %>% 
      hc_title(text = paste("AREA, grups totals:", data_grouped[[2]]))
  })
  
  # Element grouped chart
  output$element_grouped <- renderHighchart({
    data_grouped <- group_data(data_barcelona_tipus_filt(), "ELEMENT")
    hchart(data_grouped[[1]], "column", hcaes(x = ELEMENT, y = percentatge)) %>%
      hc_xAxis(title = list(text = NULL)) %>%
      hc_yAxis(title = list(text = "%"), labels = list(format = "{value}%")) %>% 
      hc_tooltip(pointFormat=paste('<b>{point.y:.1f}%</b>')) %>% 
      hc_title(text = paste("ELEMENT, grups totals:", data_grouped[[2]]))
  })
  
  # Detall grouped chart
  output$detall_grouped <- renderHighchart({
    data_grouped <- group_data(data_barcelona_tipus_filt(), "DETALL")
    hchart(data_grouped[[1]], "column", hcaes(x = DETALL, y = percentatge)) %>%
      hc_xAxis(title = list(text = NULL)) %>%
      hc_yAxis(title = list(text = "%"), labels = list(format = "{value}%")) %>% 
      hc_tooltip(pointFormat=paste('<b>{point.y:.1f}%</b>')) %>% 
      hc_title(text = paste("DETALL, grups totals:", data_grouped[[2]]))
  })
  
}
