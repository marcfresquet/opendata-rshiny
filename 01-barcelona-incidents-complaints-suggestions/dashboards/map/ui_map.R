##############################
### Map Dashboard
##############################

# id
map_dashboard_id = "map_dashboard"

# Sidebar
sidebar_map <- menuItem("Mapa", tabName = map_dashboard_id, icon = icon("globe"))

# Widget options
selectizeInput_opts <- list(plugins=list('remove_button'))

# Body
body_map <- tabItem(tabName = map_dashboard_id,
  fluidRow(
    useShinyjs(),
    column(12,
      wellPanel(
        h3("Filtres"),
        fluidRow(
          column(3, selectizeInput("tipus_filter", "Tipus", unique(data_barcelona$TIPUS), multiple = TRUE, options = selectizeInput_opts)),
          column(3, selectizeInput("area_filter", "Àrea", unique(data_barcelona$AREA), multiple = TRUE, options = selectizeInput_opts)),
          column(3, dateRangeInput("day_filter", "Dia",
                              min = min(data_barcelona$DATA_ALTA),
                              max = max(data_barcelona$DATA_ALTA),
                              start = max(data_barcelona$DATA_ALTA) - 7,
                              end = max(data_barcelona$DATA_ALTA),
                              language = "ca",
                              separator = " fins ",
                              weekstart = 1))
        )
      )
    ),
    column(12,
      h5("Fes click a un punt per veure el nom del carrer"),
      withSpinner(leafletOutput("events_map", width="100%", height="1000px"))
    )
  )
)
