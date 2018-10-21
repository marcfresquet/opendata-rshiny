##############################
### Map Dashboard
##############################

# id
map_dashboard_id = "map_dashboard"

# Sidebar
sidebar_map <- menuItem("Mapa d'incidències", tabName = map_dashboard_id, icon = icon("globe"))

# Widget options
selectizeInput_opts <- list(plugins=list('remove_button'))

# Body
body_map <- tabItem(tabName = map_dashboard_id,
  fluidRow(
    useShinyjs(),
    column(6,
      wellPanel(
        h3("Filtres"),
        fluidRow(
          column(12, dateInput("day_filter", "Dia",
                              min = min(data_barcelona$DATA_ALTA),
                              max = max(data_barcelona$DATA_ALTA),
                              value = max(data_barcelona$DATA_ALTA),
                              language = "ca",
                              weekstart = 1)),
          column(12, selectizeInput("area_filter", "Àrea (1 o més)", unique(data_barcelona$AREA), multiple = TRUE, options = selectizeInput_opts))
        )
      )
    ),
    column(6,
      withSpinner(highchartOutput("incidents_per_area"))
    ),
    column(12,
      h5("Fes click a un punt per veure el nom del carrer"),
      withSpinner(leafletOutput("events_map", width="100%", height="1000px"))
    )
  )
)
