##############################
### Map Dashboard
##############################

# id
map_dashboard_id = "map_dashboard"

# Sidebar
sidebar_map <- menuItem("Mapa", tabName = map_dashboard_id, icon = icon("globe"))

# Body
body_map <- tabItem(tabName = map_dashboard_id,
  fluidRow(
    useShinyjs()
  )
)
