##############################
### Map Dashboard
##############################

# id
map_dashboard_id = "map_dashboard"

# Sidebar
sidebar_map <- menuItem("Mapa", tabName = map_dashboard_id, icon = icon("dashboard"))

# Body
body_map <- tabItem(tabName = map_dashboard_id,
  fluidRow(
    useShinyjs(),
    column(12,
      wellPanel(
        h3("Filtres"),
        fluidRow(
          column(3, selectizeInput("area_filter", "Àrea", unique(data_barcelona$AREA), multiple = TRUE, options = list(plugins=list('remove_button')))),
          column(3, dateInput("day_filter", "Dia", min=min(data_barcelona$DATA_ALTA), max=max(data_barcelona$DATA_ALTA), value=max(data_barcelona$DATA_ALTA),
                              language="ca", weekstart=1))
        )
      )
    ),
    column(12,
      leafletOutput("events_map", width="100%", height="1000px")
    )
  )
)
